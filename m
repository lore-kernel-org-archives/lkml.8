Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AD5C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFA924673
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smXbxu60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgARI0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:26:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35332 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgARI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:26:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so24552794edv.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 00:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WPf1TKOeIof3ZCntE6oJKJZguEEyWXsiQTtgtGkEzMM=;
        b=smXbxu60jgmDcmpPhk5Hz270NiIv4E/fUlphH/pz2oUmikPZ7qgBrST86QYHpjKPF7
         hdZmR5cRyI/d2uEkbrhoReP5it5vBDFFkkXvGmCx3Z8p08Grmc5SJbT7FbYKkd2+lSRM
         R6zw1hGgfM1KezAZTLg6pUvjKTSlK4AyZ3huQKXpE5Ge/xMvVvM6IB94txSxiDq8T32B
         6x2VzxF1vSPMBFVOg0Fn4f37jbdIfPvavl1REXn72/rhKNSyDGZPZEkNa6ckQ26iAbyV
         //3r2VRBveB5Bm18WH6PDZ+ygMk6qzpJ7kcoThsjrT6/fZYDpg1raKefLdUcsg44A5un
         CSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WPf1TKOeIof3ZCntE6oJKJZguEEyWXsiQTtgtGkEzMM=;
        b=OnT/k93My1GlNuCcAMrIPHFWOjdcU+P4hS4JUo/NDJf9D5xyeh2fQfAeUMlJqpYjAE
         jMwRgEmaoxX91gtO8r77mzzC72aEVSP3t/q//lk4Xj5yagldPn7YNUpLIF5kBXEsMNJh
         S3iKAHxAXrB9uBU2ZeG4M7BXxnY3GtK3fm3Ih6mtvR6bRpWhMSwCcNxC+Vo7l4iE9SNq
         PVQmxprrW/4+vMk4+NeY86sTBHNK/YH8El4Jl/tnFFq/wEaw8mdp9D5NMEk7JwU5nn43
         g0/EkJs0CB2/2J45fWW2awi7BBnd6LUhdvBqGNFoqitkJpO8Dk48JoyiuyHt3GZuIwFe
         dpZQ==
X-Gm-Message-State: APjAAAW9q47O9ZpTcw60KRo/kPH5qsIxCX030O+IOVq5pDTG72WVeOj+
        5MtgSygZcEyJAYrLnNMIN2g=
X-Google-Smtp-Source: APXvYqwpnS1rTQfCeWUo2+YczSaKkeGrzT1fv4/t6Ckjt0frUMivsRc8FXzbe97o4QFpqx/qy4E3bg==
X-Received: by 2002:aa7:d1d1:: with SMTP id g17mr8244460edp.185.1579335961919;
        Sat, 18 Jan 2020 00:26:01 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2db9:c700:3cc3:417f:c7f9:1bb2])
        by smtp.gmail.com with ESMTPSA id x3sm1046479edr.72.2020.01.18.00.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:26:01 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH SECOND-RESEND] MAINTAINERS: mark simple firmware interface (SFI) obsolete
Date:   Sat, 18 Jan 2020 09:25:45 +0100
Message-Id: <20200118082545.23464-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown has not been active in this part since around 2010 and
confirmed that he is not maintaining this part of the kernel sources
anymore and the git log suggests that nobody is actively maintaining it.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

Len Brown expects no further systems to be shipped with SFI, so we can
mark it obsolete and schedule it for deletion.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thomas, please pick this _reworked_ patch now. thanks.

v1: https://lore.kernel.org/patchwork/patch/1033696/
  - got Acked-by: Len Brown <len.brown@intel.com>
 
v2:
  - also change status to Obsolete

v2-resend:
  - applies cleanly to v5.3-rc5 and next-20190823

v3:
  - simply remove Len Brown and do not try to find a possible
    replacement, as Thomas requested.

v3-resend:
  - applies cleanly on v5.5-rc1, current master (e31736d9fae8) and
    next-20191213

v3-second-resend:
  - applies cleanly on v5.5-rc6 and next-20200117 

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4017e6b760be..fe82a0deb8cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15044,11 +15044,8 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.rst
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
-S:	Supported
+S:	Obsolete
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
 F:	include/linux/sfi*.h
-- 
2.17.1

