Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281B2207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVQtiUgb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSlmzFZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHSX0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:26:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSX0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:35 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597879593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRBjhZhhrhF0UYQCJzJiLHsoinXyh5/zkxgKSxesxYI=;
        b=FVQtiUgbmgNIeF5Y88dn7FVed06p2FoDFa98u2Gz7TrEcdvq5oRAxvKVA+Rm7uLLP6HPNa
        4ewn1RTEF8u4P9Pv9LVU/BDwPhKj999I65a4yrDnPpFLkoUR+SAZVvwODpxB8j7nGqXUwp
        SXK07tm+b+jUGQxg9DcJvvlAlM9NNrdpfYXp0O/gkPhBrouWgwkWoTmYm3ch3Hlsv9+a+q
        /RrPQ5+0eT0D4TzMD5sOHdBBcTaWmDZaHO5qs30acveT6qlrfA0ipCZiu7rVzgd0HPVDDy
        Tpv9rYl6axSDwMdYP2fxs64bRakePrieRtH3se6+7WYIBXoh2mzHkrVwAtS8Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597879593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRBjhZhhrhF0UYQCJzJiLHsoinXyh5/zkxgKSxesxYI=;
        b=YSlmzFZYLthA5TkrkAuDlKTzvkzqYsPUYyDpmBt/2ISELE8Giv4qlcFnQ3GoGB1SysvtFz
        /s/OvT6G2JhQs4Dw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] printk: implement pr_cont_t
Date:   Thu, 20 Aug 2020 01:32:28 +0206
Message-Id: <20200819232632.13418-2-john.ogness@linutronix.de>
In-Reply-To: <20200819232632.13418-1-john.ogness@linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a new buffering mechanism for pr_cont messages.

Old mechanism syntax:

    printk(KERN_INFO "text");
    printk(KERN_CONT " continued");
    printk(KERN_CONT "\n");

New mechanism syntax:

    pr_cont_t c;

    pr_cont_begin(&c, KERN_INFO "text");
    pr_cont_append(&c, " continued");
    pr_cont_end(&c);

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h |  19 ++++++
 kernel/printk/printk.c | 137 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 34c1a7be3e01..4d9ce18e4afa 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -380,6 +380,25 @@ extern int kptr_restrict;
 #define pr_cont(fmt, ...) \
 	printk(KERN_CONT fmt, ##__VA_ARGS__)
 
+/* opaque handle for continuous printk messages */
+typedef struct {
+	u8	index;
+	u8	loglevel;
+	u16	text_len;
+} pr_cont_t;
+
+/* initialize handle, provide loglevel and initial message text */
+int pr_cont_begin(pr_cont_t *c, const char *fmt, ...);
+
+/* append message text */
+int pr_cont_append(pr_cont_t *c, const char *fmt, ...);
+
+/* flush message to kernel buffer */
+void pr_cont_flush(pr_cont_t *c);
+
+/* flush message to kernel buffer, cleanup handle */
+void pr_cont_end(pr_cont_t *c);
+
 /**
  * pr_devel - Print a debug-level message conditionally
  * @fmt: format string
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad8d1dfe5fbe..10113e7ea350 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3495,3 +3495,140 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
+
+#define CONT_LINE_MAX LOG_LINE_MAX
+#define CONT_BUF_COUNT 10
+static char cont_buf[CONT_BUF_COUNT][CONT_LINE_MAX];
+static DECLARE_BITMAP(cont_buf_map, CONT_BUF_COUNT);
+
+static int get_cont_buf(void)
+{
+	int bit;
+
+	do {
+		bit = find_first_zero_bit(cont_buf_map, CONT_BUF_COUNT);
+		if (bit == CONT_BUF_COUNT)
+			break;
+	} while (test_and_set_bit(bit, cont_buf_map));
+
+	return bit;
+}
+
+static void put_cont_buf(int index)
+{
+	if (WARN_ON(index >= CONT_BUF_COUNT))
+		return;
+	if (WARN_ON(!test_bit(index, cont_buf_map)))
+		return;
+	clear_bit(index, cont_buf_map);
+}
+
+/* alloc buffer, get loglevel, setup initial text */
+int pr_cont_begin(pr_cont_t *c, const char *fmt, ...)
+{
+	int kern_level;
+	va_list args;
+	char *text;
+
+	c->index = get_cont_buf();
+	if (c->index == CONT_BUF_COUNT) {
+		/* Fallback to printk parts individually. */
+		int text_len;
+
+		va_start(args, fmt);
+		text_len = vprintk(fmt, args);
+		va_end(args);
+		return text_len;
+	}
+
+	text = &cont_buf[c->index][0];
+
+	va_start(args, fmt);
+	c->text_len = vscnprintf(text, CONT_LINE_MAX, fmt, args);
+	va_end(args);
+
+	c->loglevel = default_message_loglevel;
+	while (c->text_len > 1 &&
+	       (kern_level = printk_get_level(text)) != 0) {
+		switch (kern_level) {
+		case '0' ... '7':
+			c->loglevel = kern_level - '0';
+			break;
+		}
+
+		c->text_len -= 2;
+		memmove(text, text + 2, c->text_len);
+	}
+
+	return c->text_len;
+}
+
+/* printk existing buffer, reset buffer */
+void pr_cont_flush(pr_cont_t *c)
+{
+	char *text;
+
+	if (c->index == CONT_BUF_COUNT || !c->text_len)
+		return;
+
+	text = &cont_buf[c->index][0];
+
+	printk("%c%c%s\n", KERN_SOH_ASCII, c->loglevel + '0', text);
+
+	c->text_len = 0;
+}
+
+/* printk existing buffer, free buffer */
+void pr_cont_end(pr_cont_t *c)
+{
+	if (c->index == CONT_BUF_COUNT)
+		return;
+
+	pr_cont_flush(c);
+	put_cont_buf(c->index);
+	c->index = CONT_BUF_COUNT;
+}
+
+/* append to buffer */
+int pr_cont_append(pr_cont_t *c, const char *fmt, ...)
+{
+	va_list args_copy;
+	va_list args;
+	int text_len;
+	char *text;
+
+	if (c->index == CONT_BUF_COUNT) {
+		/* Fallback to printk parts individually. */
+		va_start(args, fmt);
+		text_len = vprintk(fmt, args);
+		va_end(args);
+		return text_len;
+	}
+
+	text = &cont_buf[c->index][0];
+
+	/* Try to append directly. */
+	va_start(args, fmt);
+	va_copy(args_copy, args);
+	text_len = vsnprintf(text + c->text_len, CONT_LINE_MAX - c->text_len, fmt, args);
+	va_end(args);
+
+	if (text_len >= CONT_LINE_MAX - c->text_len) {
+		/*
+		 * Not enough space remaining. Set the overwritten terminator,
+		 * Flush any existing parts and start with a clean buffer.
+		 * The loglevel is preserved.
+		 */
+
+		text[c->text_len] = 0;
+		pr_cont_flush(c);
+
+		va_start(args_copy, fmt);
+		c->text_len = vscnprintf(text, CONT_LINE_MAX, fmt, args_copy);
+		va_end(args_copy);
+		return c->text_len;
+	}
+
+	c->text_len += text_len;
+	return text_len;
+}
-- 
2.20.1

