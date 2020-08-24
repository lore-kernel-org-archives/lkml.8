Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4142C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4623B2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="I66bgMI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHXLXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:23:21 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:41410 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHXLXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:23:12 -0400
Date:   Mon, 24 Aug 2020 11:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1598268179; bh=yrg1J0Lts+eTmxcxiXjhYz4fa26vjELxzM3mrkKWEmk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=I66bgMI2BwYC4u2e1VH9nPsG9POat19/wdhH6Q3lI35jf/FZDf1PDyJibi2K5L/NS
         BqRNobb+x5W+fDu6mPMuXjGCM2RJI29Q3Gfc3+1A2Yxpgg5IM+lQRgIbYOih4zKyDA
         hg2ZOpl549Qq5lnH4YUAoFhOqIkTBd9/fRaziMTGt7PGF4awLtCEacpKssnoXpADbR
         8BQ+GWPFj0/1ky/K245c6CsHPVQqKcCnC4E8nCTwRBowqczs/17Qh2hZ0FY5nFR1l+
         SSOS99140ki+DbRpSqiESYkDfL2+QQWjWQDvUbcNXFIcHxER6eYLw5ZWw+yRkujg3/
         EgVVqznnpHZkQ==
To:     linux-kernel@vger.kernel.org
From:   Mark Starovoytov <mstarovo@pm.me>
Cc:     Mark Starovoytov <mstarovo@pm.me>
Reply-To: Mark Starovoytov <mstarovo@pm.me>
Subject: [PATCH] mailmap: add entry for <mstarovoitov@marvell.com>
Message-ID: <20200824112221.19182-1-mstarovo@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the address to my private mail, because my Marvell account has been sus=
pended.

Signed-off-by: Mark Starovoytov <mstarovo@pm.me>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 332c7833057f..4cf029cff065 100644
--- a/.mailmap
+++ b/.mailmap
@@ -191,6 +191,7 @@ Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.c=
om>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Mark Brown <broonie@sirena.org.uk>
+Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
--=20
2.17.1


