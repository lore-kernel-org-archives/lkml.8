Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B60920791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHNRxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:53:08 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:60572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728488AbgHNRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:53:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D0B8918011AD1;
        Fri, 14 Aug 2020 17:53:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fact19_1e1571126ffe
X-Filterd-Recvd-Size: 4135
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Aug 2020 17:53:04 +0000 (UTC)
Message-ID: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
Subject: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Fri, 14 Aug 2020 10:53:03 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a print_vma_addr function used several places
that requires KERN_CONT use.

Add a %pv mechanism to avoid the need for KERN_CONT.

An example conversion is arch/x86/kernel/signal.c

from:
	if (show_unhandled_signals && printk_ratelimit()) {
		printk("%s"
		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx",
		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
		       me->comm, me->pid, where, frame,
		       regs->ip, regs->sp, regs->orig_ax);
		print_vma_addr(KERN_CONT " in ", regs->ip);
		pr_cont("\n");
to:
		printk("%s"
		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx in %pv\n",
		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
		       me->comm, me->pid, where, frame,
		       regs->ip, regs->sp, regs->orig_ax, (void *)regs->ip);
---
 lib/vsprintf.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c155769559ab..654402c43f8d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -995,6 +995,12 @@ static const struct printf_spec default_dec_spec = {
 	.precision = -1,
 };
 
+static const struct printf_spec default_hex_spec = {
+	.base = 16,
+	.precision = -1,
+	.flags = SMALL,
+};
+
 static const struct printf_spec default_dec02_spec = {
 	.base = 10,
 	.field_width = 2,
@@ -2089,6 +2095,50 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+static noinline_for_stack
+char *vma_addr(char *buf, char *end, void *ip,
+	       struct printf_spec spec, const char *fmt)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	/*
+	 * we might be running from an atomic context so we cannot sleep
+	 */
+	if (!mmap_read_trylock(mm))
+		return buf;
+
+	vma = find_vma(mm, (unsigned long)ip);
+	if (vma && vma->vm_file) {
+		char *p;
+		struct file *f = vma->vm_file;
+		char *page = (char *)__get_free_page(GFP_NOWAIT);
+
+		if (page) {
+			p = file_path(f, page, PAGE_SIZE);
+			if (IS_ERR(p))
+				p = "?";
+			buf = string(buf, end, kbasename(p), default_str_spec);
+			buf = string_nocheck(buf, end, "[", default_str_spec);
+			buf = pointer_string(buf, end,
+					     (void *)vma->vm_start,
+					     default_hex_spec);
+			buf = string_nocheck(buf, end, "+", default_str_spec);
+			buf = pointer_string(buf, end,
+					     (void *)(vma->vm_end - vma->vm_start),
+					     default_hex_spec);
+			buf = string_nocheck(buf, end, "]", default_str_spec);
+			free_page((unsigned long)page);
+		}
+	}
+	mmap_read_unlock(mm);
+#else
+	buf = string_nocheck(buf, end, "CONFIG_MMU=n", default_str_spec);
+#endif
+	return buf;
+}
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2254,6 +2304,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
 		return va_format(buf, end, ptr, spec, fmt);
+	case 'v':
+		return vma_addr(buf, end, ptr, spec, fmt);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':


