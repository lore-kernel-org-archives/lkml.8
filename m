Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21DDC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A561D20786
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgCPOxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbgCPOxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:53:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76FE1AD72;
        Mon, 16 Mar 2020 14:53:22 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
To:     Michal Hocko <mhocko@kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312092531.GU23944@dhcp22.suse.cz>
 <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312132642.GW23944@dhcp22.suse.cz>
Message-ID: <4ea2e014-17ea-6d1e-a6cd-775fb6550cd2@suse.cz>
Date:   Mon, 16 Mar 2020 15:53:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312132642.GW23944@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 2:26 PM, Michal Hocko wrote:
> On Thu 12-03-20 12:54:19, Ivan Teterevkov wrote:
>> 
>> Absolutely agree, the semantics of the vm_swappiness is perplexing.
>> Moreover, the same get_scan_count treats vm_swappiness and cgroups
>> memory.swappiness differently, in particular, 0 disables the memcg swap.
>> 
>> Certainly, the patch adds some additional exposure to a parameter that
>> is not trivial to tackle but it's already getting created with a magic
>> number which is also confusing. Is there any harm to be done by the patch
>> considering the already existing sysctl interface to that knob?
> 
> Like any other config option/kernel parameter. It is adding the the
> overall config space size problem and unless this is really needed I
> would rather not make it worse.

Setting the vm_swappiness specific case aside, I wonder if if would be
useful to be able to emulate any sysctl with a kernel parameter,
i.e. boot the kernel with sysctl.vm.swappiness=X
There are already some options that provide kernel parameter as well
as sysctl, why not just support all.
Quick and dirty proof of concept:

----8<-----
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa84493f23..62ae963a5c0c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -206,6 +206,7 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+int process_sysctl_arg(char *param, char *val, const char *unused, void *arg);
 
 extern struct ctl_table sysctl_mount_point[];
 
diff --git a/init/main.c b/init/main.c
index ee4947af823f..c1544ff4ec5b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1345,6 +1345,23 @@ void __weak free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
+static void do_sysctl_args(void)
+{
+	size_t len = strlen(saved_command_line) + 1;
+	char *command_line;
+
+	command_line = kzalloc(len, GFP_KERNEL);
+	if (!command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	strcpy(command_line, saved_command_line);
+
+	parse_args("Setting sysctl args", command_line,
+		   NULL, 0, -1, -1, NULL, process_sysctl_arg);
+
+	kfree(command_line);
+}
+
 static int __ref kernel_init(void *unused)
 {
 	int ret;
@@ -1367,6 +1384,8 @@ static int __ref kernel_init(void *unused)
 
 	rcu_end_inkernel_boot();
 
+	do_sysctl_args();
+
 	if (ramdisk_execute_command) {
 		ret = run_init_process(ramdisk_execute_command);
 		if (!ret)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..5b3b520d29a8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1980,6 +1980,66 @@ int __init sysctl_init(void)
 	return 0;
 }
 
+int process_sysctl_arg(char *param, char *val,
+			       const char *unused, void *arg)
+{
+	size_t count;
+	char *tmp;
+	int err;
+	loff_t ppos = 0;
+	struct ctl_table *base, *child = NULL, *found = NULL;
+
+	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
+		return 0;
+
+	param += (sizeof("sysctl.") - 1);
+
+	pr_notice("sysctl: %s=%s", param, val);
+
+	tmp = strchr(param, '.');
+	if (!tmp) {
+		pr_notice("invalid sysctl param '%s' on command line", param);
+		return 0;
+	}
+
+	*tmp = '\0';
+
+	for (base = &sysctl_base_table[0]; base->procname != 0; base++) {
+		if (strcmp(param, base->procname) == 0) {
+			child = base->child;
+			break;
+		}
+	}
+
+	if (!child) {
+		pr_notice("unknown sysctl prefix '%s' on command line", param);
+		return 0;
+	}
+
+	tmp++;
+
+	for (; child->procname != 0; child++) {
+		if (strcmp(tmp, child->procname) == 0) {
+			found = child;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_notice("unknown sysctl param '%s.%s' on command line", param, tmp);
+		return 0;
+	}
+
+	count = strlen(val);
+	err = found->proc_handler(found, 1, val, &count, &ppos);
+
+	if (err)
+		pr_notice("error %d setting sysctl '%s.%s' from command line",
+				err, param, tmp);
+
+	return 0;
+}
+
 #endif /* CONFIG_SYSCTL */
 
 /*
-- 
2.25.1




