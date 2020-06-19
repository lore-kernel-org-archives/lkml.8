Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C793C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2436B20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="W0oekicR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgFSJ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:56:49 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:19486 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbgFSJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:56:37 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 05:56:36 EDT
Date:   Fri, 19 Jun 2020 09:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592560282; bh=JD5ksyB959H2m2GUQCuGFCnyZN+aYw/SsHdrAfff0/4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=W0oekicRMja5ckgCWoGw248zwfjAl/LEReTiwe0EaBXbWq1w3DhFP0dFFvRBtMS0i
         G2o1qxIik1njOGcowLKwmvc2dzNznsZzroQz9hadI+d3lNVrB1c8YHPyuPzYo++ijs
         z5hcae5MM85cpOXXW4e82N8BY1idpfTLWazTEAZhZ7jY1XT9i/9KdS68StbJXNg/Mj
         tryZrxHGf+OxAJFx73VginjH32IzCxmos7XWZOMnrPBUtO2fDeXwZ5eN6BjlyyGTO2
         fPDp5Rjm3BrMdoXoBfjaWZJvBrW7Nk2/oFmAd5apu+kTQOZiSaHnFNgdlvZhu8wkgz
         bQ2PLotcig2lw==
To:     Jonathan Corbet <corbet@lwn.net>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH] mailmap: add entries for Alexander Lobakin
Message-ID: <5YUtoWlS7NX1N6TxI4ddZ9V-Yx8Bn8wzrEVJqfkTuwEzZjAsJg157goV81xPAU76k84Nis2uBwdHWk4JmYHbvGmd_JcBTk-rZDVpFNPNolU=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My D-Link and Yandex addresses don't exist anymore, map them to my
private box.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index c69d9c734fb5..86eb59ad4c54 100644
--- a/.mailmap
+++ b/.mailmap
@@ -18,6 +18,8 @@ Aleksey Gorelov <aleksey_gorelov@phoenix.com>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@im=
gtec.com>
 Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
 Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
+Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
+Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-=
electrons.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
--=20
2.27.0


