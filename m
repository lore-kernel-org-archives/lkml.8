Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22893208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055696;
	bh=9MyP09lInuYYCCuLVQuLk8NyqGwyOb0YNhhwtr6SHHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d6pZFgpO+EnPIbTGNaVFuXmCabGxOwlnpOwmSFBBp0LfyvNzPIDzg0045+3MEa8xp
	 6xtQdOsN7OfH7w+qDafBNRhbZiIdHrLb8nQ6a5iNWhL8uL/xBVPP3mGyG5d1hAYgEC
	 cdUyjkyBzM54LL6DYoip2cKxDX8uN5VEVhLG7X1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgCXNOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgCXNOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:14:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B06208D5;
        Tue, 24 Mar 2020 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055688;
        bh=9MyP09lInuYYCCuLVQuLk8NyqGwyOb0YNhhwtr6SHHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddJ34pTH6BzltgrUgdMAuyKSENwDHJAMfEvLY5MYkCqq339zqIdDVLrR8M5Hyjm9Q
         XQfql6QiVC0T7oD9jlyPG9UmsoB5nDKlHH3gvoeLedm4DsRz5DyHL+jse++d/61d+u
         /sdhGW6G33o4LON1Pf7fVl85Qavz4HKVlhT0o4wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 4.19 63/65] drm/bridge: dw-hdmi: fix AVI frame colorimetry
Date:   Tue, 24 Mar 2020 14:11:24 +0100
Message-Id: <20200324130804.757125906@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

commit e8dca30f7118461d47e1c3510d0e31b277439151 upstream.

CTA-861-F explicitly states that for RGB colorspace colorimetry should
be set to "none". Fix that.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Fixes: def23aa7e982 ("drm: bridge: dw-hdmi: Switch to V4L bus format and encodings")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20200304232512.51616-2-jernej.skrabec@siol.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |   46 ++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1364,28 +1364,34 @@ static void hdmi_config_AVI(struct dw_hd
 		frame.colorspace = HDMI_COLORSPACE_RGB;
 
 	/* Set up colorimetry */
-	switch (hdmi->hdmi_data.enc_out_encoding) {
-	case V4L2_YCBCR_ENC_601:
-		if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV601)
-			frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
-		else
+	if (!hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
+		switch (hdmi->hdmi_data.enc_out_encoding) {
+		case V4L2_YCBCR_ENC_601:
+			if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV601)
+				frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
+			else
+				frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
+			frame.extended_colorimetry =
+					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
+			break;
+		case V4L2_YCBCR_ENC_709:
+			if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV709)
+				frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
+			else
+				frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
+			frame.extended_colorimetry =
+					HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
+			break;
+		default: /* Carries no data */
 			frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
+			frame.extended_colorimetry =
+					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
+			break;
+		}
+	} else {
+		frame.colorimetry = HDMI_COLORIMETRY_NONE;
 		frame.extended_colorimetry =
-				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
-		break;
-	case V4L2_YCBCR_ENC_709:
-		if (hdmi->hdmi_data.enc_in_encoding == V4L2_YCBCR_ENC_XV709)
-			frame.colorimetry = HDMI_COLORIMETRY_EXTENDED;
-		else
-			frame.colorimetry = HDMI_COLORIMETRY_ITU_709;
-		frame.extended_colorimetry =
-				HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
-		break;
-	default: /* Carries no data */
-		frame.colorimetry = HDMI_COLORIMETRY_ITU_601;
-		frame.extended_colorimetry =
-				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
-		break;
+			HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 	}
 
 	frame.scan_mode = HDMI_SCAN_MODE_NONE;


