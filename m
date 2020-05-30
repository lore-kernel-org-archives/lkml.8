Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C94C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E032074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590867134;
	bh=nPPEFTEoPeltOuIbbwGrfLQREdX3vxT8M+MdAaDzvrM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NEQJ+bTxuQXh1kHS5V1uoOKtW5mIwNOpZK7DjuqjNjoxYCnMCkaWIzx5DqXyRb2/m
	 KzKeSxauvUzhiXms6h6QR84WzLK3+tZ21+1LCSLqBXlp6piTKrWMmzIGBFoOIqef5J
	 h7RtyQATI08v93/GyXtCvmGWtaMAwuXQG3Gv3S0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgE3TcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 15:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgE3TcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 15:32:12 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9EA207D0;
        Sat, 30 May 2020 19:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590867131;
        bh=nPPEFTEoPeltOuIbbwGrfLQREdX3vxT8M+MdAaDzvrM=;
        h=From:To:Cc:Subject:Date:From;
        b=C5IUTglmakBURX5TJw5/FhNXC2W6mZqbltd3gb+JYUyI0ka0IwmLZMZoeWpgBB2xu
         Jhr38FdI6lkqtL8QjxbfxLioilUbXOWzfReFG78y6Vi00rm3wm2cAuKmy5dyyNb2OA
         2e9x2O3NWi28r3nw4v0oqp/9riirY3hkA3pSKEdA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jf7DF-003LJ5-85; Sat, 30 May 2020 21:32:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jeremy Sowden <jeremy@azazel.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, devel@driverdev.osuosl.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] A couple additional patches for atomisp
Date:   Sat, 30 May 2020 21:32:06 +0200
Message-Id: <cover.1590866796.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 was sent by Arnd already, but, while it improved stack usage with
clang, it broke compilation with gcc ;-(

Each compiler seems to have different issues with different types of
struct initalizers, so we ended needing some discussions in order to find
something that would work for both.

So, the new version works fine with both compilers.

While here, I noticed a file that has nothing but comments. The second
patch gets rid of it.

Arnd Bergmann (1):
  staging: media: atomisp: fix stack overflow in init_pipe_defaults()

Mauro Carvalho Chehab (1):
  media: atomisp: get rid of sh_css_pipe.c

 drivers/staging/media/atomisp/Makefile        |  1 -
 .../media/atomisp/pci/ia_css_frame_public.h   |  6 ++---
 .../staging/media/atomisp/pci/ia_css_pipe.h   | 15 ++++-------
 .../media/atomisp/pci/ia_css_pipe_public.h    |  6 ++---
 .../staging/media/atomisp/pci/ia_css_types.h  |  6 ++---
 .../sdis/common/ia_css_sdis_common_types.h    |  9 +++----
 .../runtime/binary/interface/ia_css_binary.h  |  3 +--
 .../pipeline/interface/ia_css_pipeline.h      |  3 +--
 .../pci/runtime/pipeline/src/pipeline.c       | 13 ++++++---
 drivers/staging/media/atomisp/pci/sh_css.c    | 27 +++++++++++++------
 .../staging/media/atomisp/pci/sh_css_pipe.c   | 17 ------------
 11 files changed, 46 insertions(+), 60 deletions(-)
 delete mode 100644 drivers/staging/media/atomisp/pci/sh_css_pipe.c

-- 
2.26.2


