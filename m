Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AAEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CE620714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592198322;
	bh=SmBoCOl4Wnuz0d7ghbvdA/0fU3k8RB869nGBJjrDXmg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O3+pQJYUxUpfLVwej4UC1qMLPS6vexExNn/xnn+r5jONlmn7m7KTtx9WWrdYBlEUo
	 x++0MpJWujm+B2OqFspw/TyEL8RHqaqAuQw/HY+SSmb44EPBTGH+q9tDWBOo5Hpj5d
	 iCcNHEatVN4frtqVzLzuhgp1w2tdF7wy3zP2pyHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgFOFSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgFOFSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:18:40 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85D7A20707;
        Mon, 15 Jun 2020 05:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592198319;
        bh=SmBoCOl4Wnuz0d7ghbvdA/0fU3k8RB869nGBJjrDXmg=;
        h=From:To:Cc:Subject:Date:From;
        b=sYOFg3cEOJ5pWD25RQ1GJ02d+Y6wFDkqPqmGXR3T9aPsfCJgLLqjn2t9jkD/bBuJE
         KY6fbqiVArgA+pyMq0K0xAzwVtHUVSphcFS+vuEQyAMG/e5+OMx26KigzLwLqSC4Mr
         VC8oUgrh/r8IP6/RC/qg4lwAZWb5sDu+ZY7E7bnk=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkhW0-009bpn-7W; Mon, 15 Jun 2020 07:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: cec: don't use the deprecated help tag
Date:   Mon, 15 Jun 2020 07:18:33 +0200
Message-Id: <d94e7bff13e8a361353360e4cdbf637bfb701bed.1592198305.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According with changeset 3e1ad4054b8d ("doc: don't use deprecated "---help---" markers in target docs"),
We want to get rid of the old ---help--- tag.

There's just the cec/Kconfig file under drivers/media using it.
Replace it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index f75765cb0fc8..fea06cb0eb48 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -15,7 +15,7 @@ config VIDEO_ATOMISP
 	depends on PMIC_OPREGION
 	select IOSF_MBI
 	select VIDEOBUF_VMALLOC
-	---help---
+	help
 	  Say Y here if your platform supports Intel Atom SoC
 	  camera imaging subsystem.
 	  To compile this driver as a module, choose M here: the
-- 
2.26.2

