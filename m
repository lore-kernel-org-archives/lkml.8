Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC38C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B74920708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WMSBNI+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEFPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:50:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgEFPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:50:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Flnco076239;
        Wed, 6 May 2020 15:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=R6Jr3ckmzUF/i0gaJhqPnI4DJl+xMsIk8W2RRjXtnNk=;
 b=WMSBNI+QkBZdJiYl7ybSGH3yC6BareJGRXZEzE/iXGW6HStX1wEzAHkq9gEmkCgCzUt8
 tVzP5bWIUgcSjgVlt7cx983QgO3uWmAeTrmkQSTgNKx5NRsbodu1RkfgXIp7QSYLSH9U
 4nrf6sY9B1qEfxFtBdlj9aUCb9SCPx714i0u7YoWS7j3r4xJBG8/Z1axlDGUHQYYJJDf
 8QQYc/mXx/WBGkL+ld+Q8PruK8T8L3AhL9jbBPJhznMwFEscs6Ffr1uCfAOHyQJCePdn
 6eUziPyG7S3DkmtiW4iLlSoTBUO2lCHZvwUpgR1PKUgYPnrUKTfAX0Ue/unv+7iGoeKt eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gnb114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:48:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FfTQq170371;
        Wed, 6 May 2020 15:48:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnjuxem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:48:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046FmnRD018410;
        Wed, 6 May 2020 15:48:49 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 08:48:49 -0700
Subject: Re: [patch V4 part 1 16/36] kprobes: Support __kprobes blacklist in
 modules
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.678201813@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <98d22df9-a96b-0217-6be1-78fcf19f9d3f@oracle.com>
Date:   Wed, 6 May 2020 17:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.678201813@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Support __kprobes attribute for blacklist functions in modules.  The
> __kprobes attribute functions are stored in .kprobes.text section.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/158523418821.24735.15379873028352411526.stgit@devnote2
> 
> ---
>   include/linux/module.h |    4 ++++
>   kernel/kprobes.c       |   42 ++++++++++++++++++++++++++++++++++++++++++
>   kernel/module.c        |    4 ++++
>   3 files changed, 50 insertions(+)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -489,6 +489,10 @@ struct module {
>   	unsigned int num_ftrace_callsites;
>   	unsigned long *ftrace_callsites;
>   #endif
> +#ifdef CONFIG_KPROBES
> +	void *kprobes_text_start;
> +	unsigned int kprobes_text_size;
> +#endif
>   
>   #ifdef CONFIG_LIVEPATCH
>   	bool klp; /* Is this a livepatch module? */
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2179,6 +2179,19 @@ int kprobe_add_area_blacklist(unsigned l
>   	return 0;
>   }
>   
> +/* Remove all symbols in given area from kprobe blacklist */
> +static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> +{
> +	struct kprobe_blacklist_entry *ent, *n;
> +
> +	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> +		if (ent->start_addr < start || ent->start_addr >= end)
> +			continue;
> +		list_del(&ent->list);
> +		kfree(ent);
> +	}
> +}
> +
>   int __init __weak arch_populate_kprobe_blacklist(void)
>   {
>   	return 0;
> @@ -2215,6 +2228,28 @@ static int __init populate_kprobe_blackl
>   	return ret ? : arch_populate_kprobe_blacklist();
>   }
>   
> +static void add_module_kprobe_blacklist(struct module *mod)
> +{
> +	unsigned long start, end;
> +
> +	start = (unsigned long)mod->kprobes_text_start;
> +	if (start) {
> +		end = start + mod->kprobes_text_size;
> +		kprobe_add_area_blacklist(start, end);
> +	}
> +}
> +
> +static void remove_module_kprobe_blacklist(struct module *mod)
> +{
> +	unsigned long start, end;
> +
> +	start = (unsigned long)mod->kprobes_text_start;
> +	if (start) {
> +		end = start + mod->kprobes_text_size;
> +		kprobe_remove_area_blacklist(start, end);
> +	}
> +}
> +
>   /* Module notifier call back, checking kprobes on the module */
>   static int kprobes_module_callback(struct notifier_block *nb,
>   				   unsigned long val, void *data)
> @@ -2225,6 +2260,11 @@ static int kprobes_module_callback(struc
>   	unsigned int i;
>   	int checkcore = (val == MODULE_STATE_GOING);
>   
> +	if (val == MODULE_STATE_COMING) {
> +		mutex_lock(&kprobe_mutex);
> +		add_module_kprobe_blacklist(mod);
> +		mutex_unlock(&kprobe_mutex);
> +	}
>   	if (val != MODULE_STATE_GOING && val != MODULE_STATE_LIVE)
>   		return NOTIFY_DONE;
>   
> @@ -2255,6 +2295,8 @@ static int kprobes_module_callback(struc
>   				kill_kprobe(p);
>   			}
>   	}
> +	if (val == MODULE_STATE_GOING)
> +		remove_module_kprobe_blacklist(mod);
>   	mutex_unlock(&kprobe_mutex);
>   	return NOTIFY_DONE;
>   }
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3194,6 +3194,10 @@ static int find_module_sections(struct m
>   					    sizeof(*mod->ei_funcs),
>   					    &mod->num_ei_funcs);
>   #endif
> +#ifdef CONFIG_KPROBES
> +	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
> +						&mod->kprobes_text_size);
> +#endif
>   	mod->extable = section_objs(info, "__ex_table",
>   				    sizeof(*mod->extable), &mod->num_exentries);
>   
> 
