Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF38C20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056433;
	bh=UdzejyWsDBPMjXSSMGmD0Jnx1RXgE8AeB/YtqrrkjwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D1a5cKOXJ5ywOosmr/g/2NBKqEqYwgT6RETdKLZwBWlgJxTkcjKxnaQTB1hcOIAYO
	 p1H8DjPOzGPE11D8lnsqIpKddlk71Et0Enx2OgXKmxuo9gq/fJkxjT9JulHyvpcNf5
	 X44CfaqghN0wNk5q/3blWk48oLXXqP8X+BViUkkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgCXN1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbgCXN1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:27:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D1E20775;
        Tue, 24 Mar 2020 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056428;
        bh=UdzejyWsDBPMjXSSMGmD0Jnx1RXgE8AeB/YtqrrkjwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk7xqSj47ivRQbUIAK4RTM0EW3gjBP42oi4E8KXX4M7knHYmfej/IK1AywehOa18U
         +ti/pBijcOUpOQeMUFVwIIJ9aMcMmBz/1dS6p43tsSSeeo0LXaZ+I2ltPT+T8I+yI0
         sD4m+8R3MuxKROJ4DxepxlMnH22xGNF7Q9FDxRwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 5.5 113/119] drm/bridge: dw-hdmi: fix AVI frame colorimetry
Date:   Tue, 24 Mar 2020 14:11:38 +0100
Message-Id: <20200324130818.958669958@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
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
@@ -1624,28 +1624,34 @@ static void hdmi_config_AVI(struct dw_hd
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


