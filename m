Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB135C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CB420672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZC9CqbyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgF3G2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgF3G16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:27:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E67C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:27:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so9048037pjc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLo9gWn34oxY8J/ohLJn1cwxm8tKGqTGHLzQqnvI/9s=;
        b=ZC9CqbyPemgUVWTi1ogG0chtstSnPpLx9j7x9lJY+aXbGpRQoMF0xQYCt/I8FK7GsR
         vrcebnckZJZhiemHHok5fIQoC/H78X3+pwJjY1RIwILg5Swg8vEXRQ5po7j8oPWJFH6s
         AOGydT+6StJymBvgF8jhgZK9wUZV5NnHZJ250=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLo9gWn34oxY8J/ohLJn1cwxm8tKGqTGHLzQqnvI/9s=;
        b=uW/cs4lWpyU0KZU6kOZx3xYlei1WvDvzoOkVibPDQfIDxGox622XgqxcYZcVzeYJVr
         odRiLefoJnOYOIXvae28qMvrlg7VdPxMsvbnoFgyqgXzBNzbia+vHCECdmlOCBmrXZET
         +4k/Lzb0J535IhKZrnqoTWRN9is4LkJ58ite9+nb9eLmkQyZZ/kaVui6x/a6amE1IB5K
         oiDSl2CP0CF7x2Qc03OBnL7Knz7J9y9fkiNiOzqHyOIDORGCzdjVJRtB1Ya42suRXh7x
         s0/fwk40HMjNXLh4PNQGARwXjnH52BhxX1+mXYkSa6okYc+JV1ZZuAXQyf6QxQgrnjaE
         kO9g==
X-Gm-Message-State: AOAM5312acDOoiaiWE3YNM9TynmfV87Rdn2Ncg6MzCn3TmZGlMGzAFJD
        nkYARIeynKcIJrSxnl0r2SL2TA==
X-Google-Smtp-Source: ABdhPJzqEeELCaxH4ShNgfLDy3Z0zrZ0tXhBT5akKY7mXJeeLYO76PPIbsZcHg2K+9fLQgWJMSVpPQ==
X-Received: by 2002:a17:90b:1013:: with SMTP id gm19mr8675125pjb.143.1593498477799;
        Mon, 29 Jun 2020 23:27:57 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id d1sm1463366pfq.113.2020.06.29.23.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:27:57 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 4/9] media: add Mediatek's MM21 format
Date:   Tue, 30 Jun 2020 15:27:06 +0900
Message-Id: <20200630062711.4169601-5-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200630062711.4169601-1-acourbot@chromium.org>
References: <20200630062711.4169601-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mediatek's non-compressed 8 bit block video mode. This format is
produced by the MT8183 codec and can be converted to a non-proprietary
format by the MDP3 component.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 02bfef0da76d..612be602bf76 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1398,6 +1398,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_UVC:		descr = "UVC Payload Header Metadata"; break;
 	case V4L2_META_FMT_D4XX:	descr = "Intel D4xx UVC Metadata"; break;
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
+	case V4L2_PIX_FMT_MM21:		descr = "Mediatek 8-bit block format"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 303805438814..a35f65115bca 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -738,6 +738,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y12I     v4l2_fourcc('Y', '1', '2', 'I') /* Greyscale 12-bit L/R interleaved */
 #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
 #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
+#define V4L2_PIX_FMT_MM21     v4l2_fourcc('M', 'M', '2', '1') /* Mediatek 8-bit block mode, two non-contiguous planes */
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
 #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
-- 
2.27.0.212.ge8ba1cc988-goog

