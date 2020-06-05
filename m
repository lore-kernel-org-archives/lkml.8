Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19969C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFEB208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366696;
	bh=hCp+UEeqYjKYqN+3gTuNUumIVLo+f5c4+lJh9k/oLaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lIzKO3cSx4+plmnt2HNO6ez1kfudsoNURwubglB2EkpmFRySfXvwkmGkjG46Ec07b
	 yt1uLrcFT+WV4AlNGBgX8CGxHdW+Kq/NYnCtZmOen9EFpprzTruiebAYHrJ9u3v3+b
	 ArALmMV5q4ggWOz9C2zvspoODbf8p1Q3SR6Q2YuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFEOSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgFEOSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:18:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E8A208A7;
        Fri,  5 Jun 2020 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366680;
        bh=hCp+UEeqYjKYqN+3gTuNUumIVLo+f5c4+lJh9k/oLaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpxGJeS/agAoIXEmBfPL5R6AN9yi4mPCovgtXBFD8f9kSWqHBZVA8anNfwnpzyOFl
         HOA3CW0wjhSR87vdVsAjMrUQUN3dS7PGfRx55TL4aTOkIL08UBopaWp24D5rDIBPgg
         +NXv6y/0DIywRAZIIFMCOZofdPo5vSTrUovh7QL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 10/38] media: Revert "staging: imgu: Address a compiler warning on alignment"
Date:   Fri,  5 Jun 2020 16:14:53 +0200
Message-Id: <20200605140253.184736449@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 81d1adeb52c97fbe097e8c94e36c3eb702cdb110 upstream.

This reverts commit c9d52c114a9fcc61c30512c7f810247a9f2812af.

The patch being reverted changed the memory layout of struct
ipu3_uapi_acc_param. Revert it, and address the compiler warning issues in
further patches.

Fixes: commit c9d52c114a9f ("media: staging: imgu: Address a compiler warning on alignment")
Reported-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Bingbu Cao <bingbu.cao@intel.com>
Cc: stable@vger.kernel.org # for v5.3 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/ipu3/include/intel-ipu3.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/media/ipu3/include/intel-ipu3.h
+++ b/drivers/staging/media/ipu3/include/intel-ipu3.h
@@ -2472,7 +2472,7 @@ struct ipu3_uapi_acc_param {
 	struct ipu3_uapi_yuvp1_yds_config yds2 __attribute__((aligned(32)));
 	struct ipu3_uapi_yuvp2_tcc_static_config tcc __attribute__((aligned(32)));
 	struct ipu3_uapi_anr_config anr;
-	struct ipu3_uapi_awb_fr_config_s awb_fr __attribute__((aligned(32)));
+	struct ipu3_uapi_awb_fr_config_s awb_fr;
 	struct ipu3_uapi_ae_config ae;
 	struct ipu3_uapi_af_config_s af;
 	struct ipu3_uapi_awb_config awb;


