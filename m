Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E100207D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821940;
	bh=FFacg2LI3B8uvGksofjyggRrq/IHXFJRTIjx2hOCKbk=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=DstXbgsyH1f7zA5U5Cm6ANHKhCsKgjgf704a8sz3DgkFmuCR+iRslod42HBNPzHsh
	 0+IS3gsrXCeeVhpF7t95OoJun0sOa7nEsH0pIRJSmzLOyN/dh6Aa0Ycq469Zt+z8Pp
	 n0+26/4HLonWlF5hHxZarzzZLZhEtn+xaWfCjmJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgE3G67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgE3G4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E07B21582;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=FFacg2LI3B8uvGksofjyggRrq/IHXFJRTIjx2hOCKbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSeiACW7jKJckMfXYs7hm0D7HgGKK6uJJIx/BWBlz2mKsjFUB8brpEgNw2aPu72+P
         6AdsAjHlP766orfgpdh49c7gwk52Z/l8EF6p/xCeQ4dkIDQgesHYjbDM2iV1rgVzrV
         xEMhAsryDjeXOSELuV8JNbCBMJrOpK3rR6M9StZA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hpO-7Q; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/41] media: atomisp: add debug functions for received events
Date:   Sat, 30 May 2020 08:55:34 +0200
Message-Id: <db8cabf423300d3cd9383d81fffb711f1e672d5b.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debugging purposes, it helps to know what event
was actually received.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 5718010a0bf6..f7c3fdd5f670 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -4523,6 +4523,7 @@ int atomisp_css_isr_thread(struct atomisp_device *isp,
 		atomisp_css_temp_pipe_to_pipe_id(asd, &current_event);
 		switch (current_event.event.type) {
 		case IA_CSS_EVENT_TYPE_OUTPUT_FRAME_DONE:
+			dev_dbg(isp->dev, "event: Output frame done");
 			frame_done_found[asd->index] = true;
 			atomisp_buf_done(asd, 0, IA_CSS_BUFFER_TYPE_OUTPUT_FRAME,
 					 current_event.pipe, true, stream_id);
@@ -4531,6 +4532,7 @@ int atomisp_css_isr_thread(struct atomisp_device *isp,
 
 			break;
 		case IA_CSS_EVENT_TYPE_SECOND_OUTPUT_FRAME_DONE:
+			dev_dbg(isp->dev, "event: Second output frame done");
 			frame_done_found[asd->index] = true;
 			atomisp_buf_done(asd, 0, IA_CSS_BUFFER_TYPE_SEC_OUTPUT_FRAME,
 					 current_event.pipe, true, stream_id);
@@ -4539,18 +4541,21 @@ int atomisp_css_isr_thread(struct atomisp_device *isp,
 
 			break;
 		case IA_CSS_EVENT_TYPE_3A_STATISTICS_DONE:
+			dev_dbg(isp->dev, "event: 3A stats frame done");
 			atomisp_buf_done(asd, 0,
 					 IA_CSS_BUFFER_TYPE_3A_STATISTICS,
 					 current_event.pipe,
 					 false, stream_id);
 			break;
 		case IA_CSS_EVENT_TYPE_METADATA_DONE:
+			dev_dbg(isp->dev, "event: metadata frame done");
 			atomisp_buf_done(asd, 0,
 					 IA_CSS_BUFFER_TYPE_METADATA,
 					 current_event.pipe,
 					 false, stream_id);
 			break;
 		case IA_CSS_EVENT_TYPE_VF_OUTPUT_FRAME_DONE:
+			dev_dbg(isp->dev, "event: VF output frame done");
 			atomisp_buf_done(asd, 0,
 					 IA_CSS_BUFFER_TYPE_VF_OUTPUT_FRAME,
 					 current_event.pipe, true, stream_id);
@@ -4559,6 +4564,7 @@ int atomisp_css_isr_thread(struct atomisp_device *isp,
 
 			break;
 		case IA_CSS_EVENT_TYPE_SECOND_VF_OUTPUT_FRAME_DONE:
+			dev_dbg(isp->dev, "event: second VF output frame done");
 			atomisp_buf_done(asd, 0,
 					 IA_CSS_BUFFER_TYPE_SEC_VF_OUTPUT_FRAME,
 					 current_event.pipe, true, stream_id);
@@ -4566,15 +4572,18 @@ int atomisp_css_isr_thread(struct atomisp_device *isp,
 
 			break;
 		case IA_CSS_EVENT_TYPE_DIS_STATISTICS_DONE:
+			dev_dbg(isp->dev, "event: dis stats frame done");
 			atomisp_buf_done(asd, 0,
 					 IA_CSS_BUFFER_TYPE_DIS_STATISTICS,
 					 current_event.pipe,
 					 false, stream_id);
 			break;
 		case IA_CSS_EVENT_TYPE_PIPELINE_DONE:
+			dev_dbg(isp->dev, "event: pipeline done");
 			css_pipe_done[asd->index] = true;
 			break;
 		case IA_CSS_EVENT_TYPE_ACC_STAGE_COMPLETE:
+			dev_dbg(isp->dev, "event: acc stage done");
 			atomisp_acc_done(asd, current_event.event.fw_handle);
 			break;
 		default:
-- 
2.26.2

