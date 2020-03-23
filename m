Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D69C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8676620722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2qCjKD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgCWKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:48:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46809 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgCWKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:48:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id y83so2016223lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=myXNNOjoobSEA/eA0whlQCS4O/6vRCkk1D3R/DCqh+I=;
        b=B2qCjKD/5EObCU6LYmdV2FfqM5/r3TYNz4ixlrgXvaxEo2NHwIjN25YZ3kG63Trq3v
         rRrNTnrmqZu6HgWQbGKhFQ0RV8UbKmCvfy+bIX56+XLRPaBz3GGhVi+Grmebxj/NRjUh
         6BUwBKIW7FeDw8scUykNrWRHYdveW+cVp67RT/pIeKZPVTzi7Zj8CLzLQhTKNxkvqjAx
         1LWUY24Sa3rw90vzOwqCRihoNcf0R/fC5YaTTeB6gnflQO2cEfJI6OJEnEo3wcCfryE6
         GNbB06eFM9qKrWhagHJwP5/my/y9gUve4WJgt4iUTxrCW9ud8B3wPLdDb9d03yPScUHh
         2erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myXNNOjoobSEA/eA0whlQCS4O/6vRCkk1D3R/DCqh+I=;
        b=ONWZE+ZJLKh+n9N374SMzeIyPNMwwulxReXItHmEmNpJvtWYZmp2s0YH9isaQ+p+eN
         0cm61HihG3q7FNsMRRv6DxPf93DGChL6Sq4tBIOjnLPLLP+3kwCFB1xT3AfSfCqLQ3X8
         L+4B/KioHkx8PHBCxHz8+luv4D6ic3lmtXHqQ3Hu4tXota+efHTJUfHX9GKy4wwGss0a
         DqsN2Bgr9HioLzvIeE1W0LMBFSAZWSx0fJUNHaprIyp3DEAekJ4HKnojKTwJxYPz73Iw
         +ax8704UW2Y98zt8MlstZH22De+3B0zxFkebuaicLWGdThFBYhlil2cKFTincVtOTIIC
         eq9g==
X-Gm-Message-State: ANhLgQ1dknJNHcBBmRP0JCHFHQqMjl39GGoDeg0BC91+YzTQCm6vdpLg
        a/HZbX+lhjbaWTuvjx89LDw7H4eOu6Y=
X-Google-Smtp-Source: ADFU+vscSL6yH2OmnTbzM/qR6j1QPbA4Ivlh3SOlk2IlRojZSN6VtN7XeGMrAsu36u7F2x+T77pG2g==
X-Received: by 2002:a19:5019:: with SMTP id e25mr8549651lfb.68.1584960527448;
        Mon, 23 Mar 2020 03:48:47 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id b198sm1611076lfg.11.2020.03.23.03.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 03:48:46 -0700 (PDT)
Subject: [RFC PATCH 1/3] printk: Add function to set console to preferred
 console's driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <44156595-0eee-58da-4376-fd25b634d21b@gmail.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <b6d95636-adf2-254c-b992-7304cfd6b6c3@gmail.com>
Date:   Mon, 23 Mar 2020 13:48:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <44156595-0eee-58da-4376-fd25b634d21b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, add_preferred_console sets a preferred console, but doesn't
actually change /dev/console to match it. That part is handled within
register_device, where a newly registered console driver will be set as
/dev/console if it matches the preferred console.

However, if the relevant driver is already registered, the only way to
set it as /dev/console is by un-registering and re-registering it. An
example is the xenfb_make_preferred_console() function:

	console_lock();
	for_each_console(c) {
		if (!strcmp(c->name, "tty") && c->index == 0)
			break;
	}
	console_unlock();
	if (c) {
		unregister_console(c);
		c->flags |= CON_CONSDEV;
		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
		register_console(c);
	}

The code above was introduced in commit 9e124fe16ff2. In short, it's aim
is to set VT as the preferred console only after a working framebuffer
is registered and thus VT is not the dummy device.

This patch introduces an update_console_to_preferred function that
handles the necessary /dev/console change. With this change, the example
above can be replaced with:

	console_lock();
	add_preferred_console("tty", 0, NULL);
	update_console_to_preferred();
	console_unlock();

More importantly, these two calls can be moved to vt.c in order to bump
its priority when a non-dummy backend for it is introduced, solving that
problem in general.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 56 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 75dd20650fb..4b3fa34be24 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -172,6 +172,7 @@ enum con_flush_mode {
 };
 
 extern int add_preferred_console(char *name, int idx, char *options);
+extern int update_console_to_preferred(void);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
 extern struct console *console_drivers;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad460623454..6b16c973587 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2212,12 +2212,68 @@ __setup("console=", console_setup);
  * be used by arch-specific code either to override the user or more
  * commonly to provide a default console (ie from PROM variables) when
  * the user has not supplied one.
+ *
+ * Preferences set by this function don't take effect until the next
+ * time a matching driver for the preferred console is registered. If a
+ * matching driver was already registered, @update_console_to_preferred
+ * function can be used to set that as the preferred console driver.
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
 	return __add_preferred_console(name, idx, options, NULL, false);
 }
 
+/**
+ * update_console_to_preferred - set console to the preferred console's driver.
+ *
+ * Updates console_drivers and CON_CONSDEV flags so that an already
+ * registered and enabled console driver matching the preferred console
+ * is used as /dev/console.
+ *
+ * Must be called within console_lock();.
+ */
+int update_console_to_preferred(void)
+{
+	struct console_cmdline *c = NULL;
+	struct console *con = NULL;
+	struct console *tmp = NULL;
+
+	if (preferred_console >= 0)
+		c = &console_cmdline[preferred_console];
+
+	if (!c || !c->name[0])
+		return 0;
+
+	for_each_console(con) {
+		if (!con->next || !(con->next->flags & CON_ENABLED))
+			continue;
+		if (strcmp(c->name, con->next->name) != 0)
+			continue;
+		if (con->next->index >= 0 &&
+		    con->next->index != c->index)
+			continue;
+		break;
+	}
+
+	if (!con)
+		return -ENODEV;
+
+	pr_info("switching to console [%s%d]\n",
+		con->next->name, con->next->index);
+
+	tmp = con->next;
+	con->next = con->next->next;
+	tmp->next = console_drivers;
+	console_drivers = tmp;
+
+	if (console_drivers->next)
+		console_drivers->next->flags &= ~CON_CONSDEV;
+	console_drivers->flags |= CON_CONSDEV;
+	has_preferred_console = true;
+
+	return 0;
+}
+
 bool console_suspend_enabled = true;
 EXPORT_SYMBOL(console_suspend_enabled);
 
-- 
2.26.0.rc2

