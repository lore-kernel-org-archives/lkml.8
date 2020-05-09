Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C902BC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A730C208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgEIEr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIEr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:47:28 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 May 2020 21:47:28 PDT
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B13BC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 21:47:28 -0700 (PDT)
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0494lRbO018937
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 00:47:27 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0494lM4j002403
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 00:47:27 -0400
Received: by mail-qt1-f199.google.com with SMTP id n22so4369210qtp.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 21:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=CieMS2rA989SLT5WdlqR3SNmJMU/gOjJ8XfYOw251Ak=;
        b=DnhKaWp4dpAc2ZB4pyQpXgONMjv1N/8zgmonRHUXQuN3ggX/hcfo2E3MkSjY/wFt0K
         oXms1FFa1tgXQBddCDpPAJC0ef3/7Qky+MQX4Tt7X7jPCkeXCJAvZdg25mfB70e6t+7O
         RHLlXoklWZK30Sm5LTaDtSHdHT/t2wdeq9lR41LKr30ppKXTlQ+85TyfeauEi+lu0VaX
         z+FfxuTYvVuvnhrkpa3uFxeioor0xo0/eHdwdEq8SD5VYqIKrsJTerK1QEptRPNj6C08
         NIr00DZhEXk3g/2puqLekAH3DRRSJo8t9h42YlCOWOgKEdSqR9+ibkvWf/3wZzQ0h9y5
         7JKw==
X-Gm-Message-State: AGi0PuYZul5AEo8ruT99PuOp9dGlVYw617nXvM6TCuq6YGvU4NI0xFU0
        uUoP4tUYOlsSsWsNoScjJhYwPaFGkM6hJ7IAOxOx22q+VVF55nrS8/LAtGXFWlP70MvRDs0GySZ
        iRJpPHrWnZTqyYPsHsor15MJfSY+9YW+rmWM=
X-Received: by 2002:aed:2765:: with SMTP id n92mr6561187qtd.73.1588999642176;
        Fri, 08 May 2020 21:47:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypKrdwg9wFkSZEGyvIVNHrNxASjnM/WoZIv/+zUsBOK23ts64KQdieyMlQLlRE6tvAKySSZD6A==
X-Received: by 2002:aed:2765:: with SMTP id n92mr6561176qtd.73.1588999641925;
        Fri, 08 May 2020 21:47:21 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d6sm2783247qkj.72.2020.05.08.21.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:47:20 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] bpfilter: document build requirements for bpfilter_umh
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 09 May 2020 00:47:19 -0400
Message-ID: <131136.1588999639@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not intuitively obvious that bpfilter_umh is a statically linked binary.
Mention the toolchain requirement in the Kconfig help, so people
have an easier time figuring out what's needed.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
index fed9290e3b41..0ec6c7958c20 100644
--- a/net/bpfilter/Kconfig
+++ b/net/bpfilter/Kconfig
@@ -13,4 +13,8 @@ config BPFILTER_UMH
 	default m
 	help
 	  This builds bpfilter kernel module with embedded user mode helper
+
+	  Note: your toolchain must support building static binaries, since
+	  rootfs isn't mounted at the time when __init functions are called
+	  and do_execv won't be able to find the elf interpreter.
 endif

