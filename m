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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4EC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C72076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6nGo2oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgCWKuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:50:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32867 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgCWKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:50:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id c20so9844318lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=siKVSOSU2AuaxCnLGzXMnO9hKgx66VndyuGaKMeNzAk=;
        b=G6nGo2oOHsvAJv17GKLVj/we/ZtSZ5nznKfQGFsZUvB0VOn3+E48g1tAniEG6MbQJZ
         rrvKvQOjOvESLanVYURjrhMorX//raN51ngN7gFqvLotu/J3Bpfm3tWa1GLzg9eUdTwr
         3vyjfUUPciutYkb1atk8VnFy6OP2Kn+bEkh+dDu6hLeFTR4M1G60Sh5YEp0svmCNjikN
         GZht+smbCmDEgUh2xS22ASBe1nev4M1nKPx9THcQYg1YCsc/fjWgZVlbCmkdc5k9W5bq
         BYA+XbwtiTxIzHn25uyyIQnUUDdZwF9QbB3JqIaCCZOj8AmOxsWHHCy9kCLRBJtBGKf8
         LAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=siKVSOSU2AuaxCnLGzXMnO9hKgx66VndyuGaKMeNzAk=;
        b=JaUfEEjj6qo7b6vn0bbzITpzI4hM2hAzwRaTPpOc8x71K5CFHKfQykhbHQeXbdXpF5
         e+QLB4zJTEJFQxpNJzFrg0VcKY14Owm44fLwISlcAswh6zd2BDsFDZBq+MeYu6IE6l1o
         G0u6aa4RANL7dACIu7Jt4/1DJ68GF6xH3sVdrTk6Tag5y4gVd/P4jFuGdYf5cJVXsBaO
         bNQC9/JkFo5Gz2PqDSP7YYMEejb/mQzl+XkiKoFP9go+bXVqx84LevCx8Si26EHeqvAo
         nsqDVUB43vYaGhRGPFQGzHUW2mbthXerppOiKPE7HAdCBpLVzRo/wyffDiwae7ZxZAnH
         7Pow==
X-Gm-Message-State: ANhLgQ24iT+hfgHD+ISbtE/bLNOOww7vVvW8BOQvKG23tvEd62etrTZ2
        J/MRuMYJcArpQSWmM4nWuIW5DQrMxY8=
X-Google-Smtp-Source: ADFU+vuqCztGnSgEvaBbLfIgKv+NmYx+f8L26fTeb1SeELM4AjCd4cDOrJ1+xvWKNWCkk/mTRWYUDw==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr4078302lfb.117.1584960608526;
        Mon, 23 Mar 2020 03:50:08 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id t136sm4144179lff.48.2020.03.23.03.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 03:50:07 -0700 (PDT)
Subject: [RFC PATCH 2/3] vt: Set as preferred console when a non-dummy
 backend, is bound
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <44156595-0eee-58da-4376-fd25b634d21b@gmail.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <611f42ec-194c-a121-bba1-5f0ac8e2109b@gmail.com>
Date:   Mon, 23 Mar 2020 13:50:03 +0300
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

When a machine's device-tree has a "chosen" node with a "stdout-path"
property that specified console is added as the preferred console by
of_console_check via an add_preferred_console call. The property is
quite common in kernel device-tree definitions. As far as I can tell, it
is set to provide a reasonable default value for earlycon, and the
(usually serial) console is set as preferred to avoid output going to
VT's dummy backend instead of a working console.

However, a chosen stdout-path property is included even in device-trees
of systems that are designed to be used with a built-in display, e.g.
several ARM Chromebooks. In these cases where CONFIG_VT_CONSOLE is
enabled and no console argument is given on the kernel commandline, tty0
is still registered (presumably based on the order of of_console_check
and vt's register_console calls) but ends up not being the preferred
console.

As a result, it is possible for early userspace prompts (encryption
passphrase requests, emergency shells) to end up in a console that the
user doesn't expect or even have access to.

This patch tries to set tty0 as the /dev/console whenever a non-dummy
backend tries to register as its default, unless the preferred console
was set from the kernel commandline arguments.

On a Samsung Chromebook Plus (Google Kevin, rk3399-gru-kevin.dts), boot
messages are still visible on the framebuffer without this patch, but it
isn't the preferred console due to the device-tree having a stdout-path
property (from rk3399-gru.dtsi):

	$ sudo dmesg | grep -i "console\|printk"
	[    0.000000] printk: bootconsole [uart0] enabled
	[    0.010232] Console: colour dummy device 80x25
	[    0.015107] printk: console [tty0] enabled
	[    0.019601] printk: bootconsole [uart0] disabled
	[    7.145478] printk: console [ttyS2] enabled
	[    9.316094] Console: switching to colour frame buffer device 300x100

	$ cat /proc/consoles
	ttyS2                -W- (EC p a)    4:66
	tty0                 -WU (E     )    4:7

And on the same machine, with this patch:

	$ sudo dmesg | grep -i "console\|printk"
	[    0.000000] printk: bootconsole [uart0] enabled
	[    0.010257] Console: colour dummy device 80x25
	[    0.015132] printk: console [tty0] enabled
	[    0.019626] printk: bootconsole [uart0] disabled
	[    4.741120] printk: console [ttyS2] enabled
	[    6.779994] Console: switching to colour frame buffer device 300x100
	[    6.836117] printk: switching to console [tty0]

	$ cat /proc/consoles
	tty0                 -WU (EC    )    4:7
	ttyS2                -W- (E  p a)    4:66

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
 drivers/tty/vt/vt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bbc26d73209..0fc462ae8b2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3566,6 +3566,13 @@ static int do_bind_con_driver(const struct consw *csw, int first, int last,
 		pr_cont("to %s\n", desc);
 	}
 
+#ifdef CONFIG_VT_CONSOLE
+	if (!console_set_on_cmdline && deflt && conswitchp != &dummy_con) {
+		add_preferred_console("tty", 0, NULL);
+		update_console_to_preferred();
+	}
+#endif
+
 	retval = 0;
 err:
 	module_put(owner);
-- 
2.26.0.rc2


