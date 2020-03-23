Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF61C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9D20722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrJZytlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgCWKrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:47:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46721 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgCWKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:47:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id y83so2013571lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=x8g9NcI7xR0HrBsZYLveR9o7NCunM18g76wBVLmnmaQ=;
        b=GrJZytlT/f0w1q5u12Cr7s3ke+MNbxjLKEcVMs+PjSfEoQ93g+0MY4M1IH04M/2+aL
         OBeySUWKEA0iiMhSuNRFpTjcD7EkAV/t/VkiR+Rn/hLfTe7WuxQUCxzNeCZZ0J2h1RBz
         IO3eADoIIDF6Y/FVgblYq45+nVV24s8N2D8re5n23rW6YXc0I7t1YqLtAWcfSlHaqR3A
         fqB1D2GPRSyKw+ouToWNkAXjD0Ba2lZK1LmRv+0cH1fDnmIz1wtZ7wAqe25zF8/WgmHF
         LaQ3ehLhnn209vvG4WzB7fZMVGMwwxppRf33ob71zPK/U796iwb/94RdYDr5uXuLWykp
         D7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=x8g9NcI7xR0HrBsZYLveR9o7NCunM18g76wBVLmnmaQ=;
        b=d0sN801JWNcKMARF6dIFMtWPcc3XVxgfhR9WP3hcZ9ojdwpCotLGOoxpJCw3ne4tpX
         WxfM9RHSn9lbOc4lKID3QTYp9OXd9VY7/EJV6KCijr7MOS+zPlEdqf1gRQk51APXqQiR
         d0M6BlXZFKyf/YXJOljC63VtNuvGi7UAKFwUq6xND/qGeKkffMC/0JDtvebKBTv5FMSS
         +0j5OWYE7OFy1QsrM5jbUToF1H8PcUV2JIud/srBLPX+BdVMBUnf6HMwGH/9ZlESSvm1
         39n0UvJIuzZ5MiApjPJkWt/0WRihb+ZagXNS4jZsESZ2TPKhfMEkdX7p8yCn3eDpNt2k
         GTpg==
X-Gm-Message-State: ANhLgQ34TmoJvpg+LN9COUIx48vlNBaURFBcu0efJeM0HaYEak9MfLrJ
        QwHdJo/4uDc/mewVn6JlSts=
X-Google-Smtp-Source: ADFU+vuGwb3VQs5e+PkVltDpAXIs3fxGpY/piv1b7kDK8jnzofa2w9le2gqVOiWYIDiKEzoGyJ4++w==
X-Received: by 2002:a19:ac42:: with SMTP id r2mr12730779lfc.38.1584960458842;
        Mon, 23 Mar 2020 03:47:38 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id y20sm625998ljy.100.2020.03.23.03.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 03:47:38 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [RFC PATCH 0/3] Prefer working VT console over SPCR and device-tree
 chosen stdout-path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <44156595-0eee-58da-4376-fd25b634d21b@gmail.com>
Date:   Mon, 23 Mar 2020 13:47:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently experienced some trouble with setting up an encrypted-root
system, my Chromebook Plus (rk3399-gru-kevin, ARM64) would appear to
hang where it should have asked for an encryption passphrase; and I
eventually figured out that the kernel preferred the serial port
(inaccessible to me) over the built-in working display/keyboard and was
probably asking there.

Running plymouth in the initramfs solves that specific problem, but
both the documentation and tty-related kconfig descriptions imply that
/dev/console should be tty0 if graphics are working, CONFIG_VT_CONSOLE
is enabled and no explicit console argument is given in the kernel
commandline.

This patchset tries to ensure that VT is preferred in those conditions
even in the presence of firmware-mandated serial consoles. These should
be applicable onto next-20200323 without conflicts (also onto v5.6-rc7
with --3way minus the references to a "has_preferred_console" var).

More discussion due to or about the console confusion on ARM64:
- My Debian bug report about the initramfs prompts [0]
- Fedora test issue arising from ARM64 QEMU machines having SPCR [1]
- Debian-installer discussion on what to do with multiple consoles [2]

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=952452
[1] https://bugzilla.redhat.com/show_bug.cgi?id=1661288
[2] https://lists.debian.org/debian-boot/2019/01/msg00184.html

Alper Nebi Yasak (3):
  printk: Add function to set console to preferred console's driver
  vt: Set as preferred console when a non-dummy backend is bound
  printk: Preset tty0 as a pseudo-preferred console

 drivers/tty/vt/vt.c     |  7 +++++
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 68 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

-- 
2.26.0.rc2

