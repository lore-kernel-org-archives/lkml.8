Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFC5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358AF20759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKrvWcYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHHMeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgHHMeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:34:13 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0AFC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 05:34:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id t7so3733057otp.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=A3gmvFXEauCOQAUYz5ux5ZsOqQgVpNrWl8KKgTYtSrY=;
        b=YKrvWcYqxLLVUeNKRUmysl/PP4VnAZJXjjuYBmqHf0iN7ntO+CthSUg7XMd4E3vbo9
         +ZRsu42B5Dt26VXNB5WaI0929KJqX7ckHyn/LCyfTLnnAfGWQoR7CLf+MXqMhpfjlstr
         S9eLJVfiMphBuH61Xyp8n0/7/OQYaE4bRqyVr0sT0BAW8xtYjXSTnvtjpOkXYPlT9nfc
         dPM7VMHwOwVll+0J9N1ps67Nc/oJvFnTm23CgGkZNd+ij/cjLUYd9KPGAzWL/uYBI8b8
         hJ/IGIwKI26ttW461k0dje98nDjOd2tvR1NLxFvz++/r7NfRf7opLKfSGVf8A9UDOoOE
         IRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=A3gmvFXEauCOQAUYz5ux5ZsOqQgVpNrWl8KKgTYtSrY=;
        b=k9HyUFsG5KnjCCln9OOMsfGs78DipWtq53Z1ku7kIlFLj0PqlqQNz6TbKhPpJTFCxf
         a2x+CGkGGB2en9SYmtNbgCAB0lV6bXE7+0R0Oh+yjaGg/LZuzE0sS93ZsE8eDBNFzbBe
         gJNSRjHGTNOX8Kxs89XC+prXej4VWG/1jBEBT0JEj4B8U7lNgQdDgXqrVfNLOvIs06bn
         4zL2gs35aI4dpsn0bVOXTxeelTYhE565YnyoUNrtQPL0chH3RlF/YBVT5PgbM6UPJ1Bd
         T7HCUBMAeThlb+e5xRCidtYqYgJ7xH0LhPb5rfL5upDhlAB5if3Tpf/g1CZrvHYz9pxu
         QQGQ==
X-Gm-Message-State: AOAM532a2yHcvyVaJfMDI08Ss3uQ7WvZ4tIrGk/dhtyZwX5B3+wad69v
        MabuDufYs2x6D1HoaPAOLA==
X-Google-Smtp-Source: ABdhPJxwmyJaEDiiyDiYCuGnfhyhJU3JahQ/dPa2y2D7GBS6c6tbWt/2MhHkmFr0vl5R+ipvQIQdYA==
X-Received: by 2002:a9d:685a:: with SMTP id c26mr10738027oto.244.1596890051335;
        Sat, 08 Aug 2020 05:34:11 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id j129sm2404780oib.20.2020.08.08.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 05:34:09 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4020:c830:eb8b:ec92])
        by serve.minyard.net (Postfix) with ESMTPSA id BE0EA18055B;
        Sat,  8 Aug 2020 12:34:08 +0000 (UTC)
Date:   Sat, 8 Aug 2020 07:34:07 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.9
Message-ID: <20200808123407.GP2842@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a5dc8300df75e8b8384b4c82225f1e4a0b4d9b55:

  scripts/decode_stacktrace: warn when modpath is needed but is unset (2020-06-15 15:37:24 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.9-1

for you to fetch changes up to 634b06def11cf7ecf6282c79735f08004e323983:

  ipmi/watchdog: add missing newlines when printing parameters by sysfs (2020-07-21 06:29:15 -0500)

----------------------------------------------------------------
Minor cleanups to the IPMI driver for 5.9

Nothing of any major consequence.  Duplicate code, some missing \n's in
sysfs files, some documentation and comment changes.

-corey

----------------------------------------------------------------
Jing Xiangfeng (1):
      ipmi: remve duplicate code in __ipmi_bmc_register()

Misono Tomohiro (2):
      Doc: driver-api: ipmi: Add description of alerts_broken module param
      ipmi: ssif: Remove finished TODO comment about SMBus alert

Xiongfeng Wang (1):
      ipmi/watchdog: add missing newlines when printing parameters by sysfs

 Documentation/driver-api/ipmi.rst   | 4 ++++
 drivers/char/ipmi/ipmi_msghandler.c | 2 --
 drivers/char/ipmi/ipmi_ssif.c       | 5 -----
 drivers/char/ipmi/ipmi_watchdog.c   | 9 +++++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

