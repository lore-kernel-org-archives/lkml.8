Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10A5208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGBHul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:50:41 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:5992 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726442AbgGBHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:50:40 -0400
X-Greylist: delayed 4459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2020 03:50:30 EDT
X-ASG-Debug-ID: 1593671754-0e4088066844b7e0009-xx1T2L
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by bsf01.didichuxing.com with ESMTP id whIWS6vDUo2V86ws; Thu, 02 Jul 2020 14:36:04 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jul
 2020 13:21:16 +0800
Date:   Thu, 2 Jul 2020 13:20:43 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] proc: add support detach proccess's autogroup
Message-ID: <20200702052039.GA2824@192.168.3.9>
X-ASG-Orig-Subj: [RFC PATCH] proc: add support detach proccess's autogroup
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1593671764
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2274
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0206
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FUZZY_VPILL
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82922
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 FUZZY_VPILL            BODY: Attempt to obfuscate words in spam
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since setid will create a autogroup for that process, there is no
way to detach a process from that autogroup, this patch add a new interface
to detach a process from its autogroup. You can write anything to
/proc/<pid>/autogroup_detach to do that.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 fs/proc/base.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d86c0afc8a85..a210cab8b52d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1541,6 +1541,55 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
 	.release	= single_release,
 };
 
+static int sched_autogroup_detach_show(struct seq_file *m, void *v)
+{
+	struct inode *inode = m->private;
+
+	seq_printf(m, "write any data to detach this task from a autogroup\n");
+
+	return 0;
+}
+
+static int sched_autogroup_detach_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = single_open(filp, sched_autogroup_detach_show, NULL);
+	if (!ret) {
+		struct seq_file *m = filp->private_data;
+
+		m->private = inode;
+	}
+	return ret;
+}
+
+static ssize_t
+sched_autogroup_detach_write(struct file *file, const char __user *buf,
+	    size_t count, loff_t *offset)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *p;
+	int ret;
+
+	p = get_proc_task(inode);
+	if (!p)
+		return -ESRCH;
+
+	sched_autogroup_detach(p);
+
+	put_task_struct(p);
+
+	return count;
+}
+
+static const struct file_operations proc_pid_sched_autogroup_detach_operations = {
+	.open		= sched_autogroup_detach_open,
+	.read		= seq_read,
+	.write		= sched_autogroup_detach_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 #endif /* CONFIG_SCHED_AUTOGROUP */
 
 #ifdef CONFIG_TIME_NS
@@ -3161,6 +3210,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
+	REG("autogroup_detach",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_detach_operations),
 #endif
 #ifdef CONFIG_TIME_NS
 	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
-- 
2.14.1

