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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41660C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057C82076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdVyJBL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgCWKu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:50:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37321 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgCWKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:50:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so14023402ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9tNy9xYbDdOC07CHf7H4ZkCbKHWeUnDdMW9CfCVCkY=;
        b=bdVyJBL359733WGvtU7Gof3j1/tutWr7jojcWw8wXUmNPOuLG7Hr563TWG8poB1U5U
         xUVWVNWAz8/ChLwTngd8zi2Cfb9DT1RmMpNDrqfdF6H5cXf35C+3gOGZpsoMGME2J3Mp
         JhUavNjXK2+gC4dHuct1aCXROrYOZEmKTFMPbSbRRfhPY/erbp78N+kosI7kczs0+Qml
         f56C0Icn43kk4UuuvObeRpH0ScxZsCHIfXWWycdaKJ1jNTfl8L24YBeXH9Vi2a3ZIV96
         N/xbr5/YMVNbX4HF5inRVM+Y0mkGUdcThY7SG9mi2CVHP/tjw3uDD9J9Buv8gnisr/pV
         kATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9tNy9xYbDdOC07CHf7H4ZkCbKHWeUnDdMW9CfCVCkY=;
        b=LNxeMypAAB05/kxUuoEs/Wya4ruCvtlM1+NPLs3GJJjE+tKKBMCUMJ3ZbjZV4y8/16
         vi0fr8Zy8d33zS4VzD+9oR+IYbWZOaeXEu8NlQC3DbsQay0NRAbYyV3N1EZmWhSEB7R+
         9MsW69bu+kx9OHxQXDW12jCAAu6sEwuteNWI1MRMwBMEaAfvCiP137o0MVf2SwF66GxR
         5r7+UFVikOBgUTkN0oi+fBzBGdIg9ImbndWAW+SLnsZfHBhAOX/OHKBFCfTe4s3i816E
         mmqCCRW7mL6n6j2kfeBXJhKboJtgFBl3jo6uxy84CBavGHEDgXh7QunJuCNkTXHPJoqH
         kQbQ==
X-Gm-Message-State: ANhLgQ1TIitE9EU41nGFTD1itFGOWNNc4UXdQ2i146FPAhuDtD2sWNPo
        1dGJ15woTSxksBiWgxKuSpQ=
X-Google-Smtp-Source: ADFU+vsKiSgepWD3zBk0d7FCKh222LKCe+KoUW/BqEQdIfjFcQps3p3ZMq9+T5sKfUjBP3ucTMZcwg==
X-Received: by 2002:a2e:b896:: with SMTP id r22mr9541559ljp.43.1584960655907;
        Mon, 23 Mar 2020 03:50:55 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id h25sm8240959ljg.31.2020.03.23.03.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 03:50:55 -0700 (PDT)
Subject: [RFC PATCH 3/3] printk: Preset tty0 as a pseudo-preferred console
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <44156595-0eee-58da-4376-fd25b634d21b@gmail.com>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <2d6ab3dc-3571-2d27-b763-84c21e38ae2e@gmail.com>
Date:   Mon, 23 Mar 2020 13:50:49 +0300
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

The ACPI SPCR (Serial Port Console Redirection) table from a machine's
firmware can specify a serial console which can be used for earlycon.
However, in at least ARM64 systems the same device is also set up as the
preferred console.  Presumably due to the order of acpi_parse_spcr and
VT's register_device calls, setting the specified console as the
preferred one can prevent registering VT as a console.

This might look appropriate for machines which do not have or need
working graphics and whose users most likely have access to a serial
port. However, the use of SPCR tables may not be limited these. For
example, ARM64 QEMU virtual machines include a SPCR table regardless of
the existence of a graphics output or even the nonexistence of a serial
console. Or server hardware which has a SPCR table can be repurposed
into a workstation with the addition of a graphics card. As a result,
boot messages and early userspace prompts can go to an unexpected
console.

This patch presets tty0 as a pseudo-preferred console at compile-time to
ensure that CONFIG_VT_CONSOLE always results in the VT console getting
registered. With this, VT can get registered, these other consoles are
preferred when VT is a dummy, but we can also bump up VTs preference
when working graphics are available.

Without this patch, an ARM64 QEMU virtual machine has roughly the
following order of console events and consoles:

	$ sudo dmesg | grep -i "console\|printk"
	[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
	[    0.000000] printk: bootconsole [pl11] enabled
	[    0.004890] Console: colour dummy device 80x25
	[    0.412252] printk: console [ttyAMA0] enabled
	[    0.416173] printk: bootconsole [pl11] disabled
	[    3.940510] Console: switching to colour frame buffer device 128x48

	$ cat /proc/consoles
	ttyAMA0              -W- (EC   a)  204:64

In addition, boot messages aren't printed to the framebuffer (as tty0 is
not registered). With this patch, boot messages are visible on the
framebuffer and the information above becomes:

	$ sudo dmesg | grep -i "console\|printk"
	[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
	[    0.000000] printk: bootconsole [pl11] enabled
	[    0.002768] Console: colour dummy device 80x25
	[    0.004371] printk: console [tty0] enabled
	[    0.380166] printk: console [ttyAMA0] enabled
	[    0.387337] printk: bootconsole [pl11] disabled
	[    4.695030] Console: switching to colour frame buffer device 128x48
	[    4.709759] printk: switching to console [tty0]

	$ cat /proc/consoles
	tty0                 -WU (EC p  )    4:7
	ttyAMA0              -W- (E    a)  204:64

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
 kernel/printk/printk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6b16c973587..4b05779ab69 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -277,7 +277,19 @@ static struct console *exclusive_console;
 
 #define MAX_CMDLINECONSOLES 8
 
+/*
+ * The preferred_console and has_preferred_console variables are
+ * intentionally not modified to reflect this so that the first
+ * registered console is still used as the preferred console.
+ */
+#ifdef CONFIG_VT_CONSOLE
+static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES] = {
+	[0].name = "tty",
+	[0].index = 0,
+};
+#elif
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
+#endif
 
 static int preferred_console = -1;
 static bool has_preferred_console;
-- 
2.26.0.rc2


