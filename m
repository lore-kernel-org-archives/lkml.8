Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68358C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5020679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592199790;
	bh=i+KcznjcHmFJXCMts75e4liweyEkr+LWYq1E5sBldjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SpppP7YMz0rn//CLiOizVPlYXHKbPw7vSzGt+GA5gKIeFO6HfpSLWc8p52/VJXWA+
	 UVANLZIVnYPKprAyLMNzHLqKrgoJ1mRXrlQ8LofOnq5DRKnDZlfFncpm0YB2hpVH04
	 CPsJzLMSlRP/Ek7Z+LEJzovOe4MlV96kEhb7DNU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgFOFnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgFOFnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:43:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D627F2070E;
        Mon, 15 Jun 2020 05:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592199787;
        bh=i+KcznjcHmFJXCMts75e4liweyEkr+LWYq1E5sBldjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxWwBhqMMBx3qmznipb/y2csGiLWi1WNhOYFFa/PHNKmaNcxazt6OYtWOn1lZewDg
         JfBfku8IMnhAgVsqaFPIvo+gWvgaScSJp3/C2qX16nQQ596fH1C/76oYZaIFahfVeI
         QIUt08pndiHgPuJWifq4HXp2TkNdpIrsOI3x7DP8=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkhtg-009hQx-Ni; Mon, 15 Jun 2020 07:43:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: atomisp: fix help message for ISP2401 selection
Date:   Mon, 15 Jun 2020 07:43:04 +0200
Message-Id: <52b8bb5c7ebf039b4b7f72f250cbe897a0671b34.1592199777.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <a6fa7016f510f13ed6e31052b8bcf83e4680d899.1592199777.git.mchehab+huawei@kernel.org>
References: <a6fa7016f510f13ed6e31052b8bcf83e4680d899.1592199777.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pretty sure I named this right, but it sounds that I ended
doing something weird maybe while solving some conflict.

So, fix the title of this config var.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index fea06cb0eb48..37577bb72998 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -22,7 +22,7 @@ config VIDEO_ATOMISP
 	  module will be called atomisp
 
 config VIDEO_ATOMISP_ISP2401
-	bool "VIDEO_ATOMISP_ISP2401"
+	bool "Use Intel Atom ISP on Cherrytail/Anniedale (ISP2401)"
 	depends on VIDEO_ATOMISP
 	help
 	  Enable support for Atom ISP2401-based boards.
-- 
2.26.2

