Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D8C3F2D9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4564D20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eT32cH2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgCDJqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:46:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41080 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgCDJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:46:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so1525739wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHnQOzGdFrVkFN29YmNoJ6y3xRwiRImTrAI7kP+q5eE=;
        b=eT32cH2S+sqJDu16l+Y5KrGz4wnnrlyDsAljAAik8I9LeolYrMDcY9DFASWqwWM+/g
         Lli1ZZAhe4/aRZc8PBE8BE8c6rRDFFvaXmtli4bSpQIHeWRXAjOUpCscwm6NZnsVbIUX
         rRyxM2XTZGi03F3Sk4eIRihiOQ/xFIUY8fsWUXNHWP4Dv+sO3tKfgM6nuR0EGv6Klvyj
         8CIKyO+JxZVmxU4Sa0yOCUd842c/0OD7afa5E4FM+sETraGPEXgKXXsyKvakCyTw+MPk
         Run/apuF7ZFdNTYYPasWwWbw61lsRSjzy2syUcOCj5VHEC2GVrYuiyrZr8pOwO1cEsD1
         GFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHnQOzGdFrVkFN29YmNoJ6y3xRwiRImTrAI7kP+q5eE=;
        b=uYxEcjqP6Wtw3djcAmzNkHCS8GcdWk1loTb/eY738mpaAfgbn96Lq/LW6dmTbidFJX
         q+4HevbOHt5CqFTTEeqLeFZbwnqFft/b3WJUdn9fdDOW/pCOWsEK8exlb3RRdJzNEGvg
         ljLKQazIL1CYS0zFuZpH2IaxQOuihY/M586LYlO5K7do5G1/DDvu+JtS4duE3+vBHBC4
         xTGWCXtA0xBDVe7YPApCH3AIbmMTal7CPXsZERIUoU00h8Wmu2FDq5IgEkymM0dYE583
         4QO/ODSrguqdiDOEUyQTg+IRFlaaWBW8t8xcQBHOU5BQIV8UEkSelinfUPzOrf5f8cew
         sP/w==
X-Gm-Message-State: ANhLgQ0ZDHcMWBKVcfDYstcwQDJE3vcIYC4c92ZSzb9SrxmCSbujA3FY
        MvoCklxYNV0whjZLN2OSguyiQg==
X-Google-Smtp-Source: ADFU+vsPK/68PKvrRYwKwPe4Nmth7JStS2Jlge4g++U2zJ+05n1N4FZ6j/3tCC1axxX9S98POi/fzw==
X-Received: by 2002:adf:8294:: with SMTP id 20mr3389356wrc.175.1583315196049;
        Wed, 04 Mar 2020 01:46:36 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b10sm38696107wrw.61.2020.03.04.01.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 01:46:35 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v7 4/5] media: meson: vdec: add VP9 input support
Date:   Wed,  4 Mar 2020 10:46:24 +0100
Message-Id: <20200304094625.2257-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304094625.2257-1-narmstrong@baylibre.com>
References: <20200304094625.2257-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

Amlogic VP9 decoder requires an additional 16-byte payload before every
frame header.

The source buffer is updated in-place, then given to the Parser FIFO DMA.

The FIFO DMA copies the blocks into the 16MiB parser ring buffer, then parses
and copies the slice into the decoder "workspace".

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 150 +++++++++++++++++++-
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index adc5c1e81a4c..db7022707ff8 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -52,6 +52,7 @@
 #define PARSER_VIDEO_HOLE	0x90
 
 #define SEARCH_PATTERN_LEN	512
+#define VP9_HEADER_SIZE		16
 
 static DECLARE_WAIT_QUEUE_HEAD(wq);
 static int search_done;
@@ -74,14 +75,121 @@ static irqreturn_t esparser_isr(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * VP9 frame headers need to be appended by a 16-byte long
+ * Amlogic custom header
+ */
+static int vp9_update_header(struct amvdec_core *core, struct vb2_buffer *buf)
+{
+	u8 *dp;
+	u8 marker;
+	int dsize;
+	int num_frames, cur_frame;
+	int cur_mag, mag, mag_ptr;
+	int frame_size[8], tot_frame_size[8];
+	int total_datasize = 0;
+	int new_frame_size;
+	unsigned char *old_header = NULL;
+
+	dp = (uint8_t *)vb2_plane_vaddr(buf, 0);
+	dsize = vb2_get_plane_payload(buf, 0);
+
+	if (dsize == vb2_plane_size(buf, 0)) {
+		dev_warn(core->dev, "%s: unable to update header\n", __func__);
+		return 0;
+	}
+
+	marker = dp[dsize - 1];
+	if ((marker & 0xe0) == 0xc0) {
+		num_frames = (marker & 0x7) + 1;
+		mag = ((marker >> 3) & 0x3) + 1;
+		mag_ptr = dsize - mag * num_frames - 2;
+		if (dp[mag_ptr] != marker)
+			return 0;
+
+		mag_ptr++;
+		for (cur_frame = 0; cur_frame < num_frames; cur_frame++) {
+			frame_size[cur_frame] = 0;
+			for (cur_mag = 0; cur_mag < mag; cur_mag++) {
+				frame_size[cur_frame] |=
+					(dp[mag_ptr] << (cur_mag * 8));
+				mag_ptr++;
+			}
+			if (cur_frame == 0)
+				tot_frame_size[cur_frame] =
+					frame_size[cur_frame];
+			else
+				tot_frame_size[cur_frame] =
+					tot_frame_size[cur_frame - 1] +
+					frame_size[cur_frame];
+			total_datasize += frame_size[cur_frame];
+		}
+	} else {
+		num_frames = 1;
+		frame_size[0] = dsize;
+		tot_frame_size[0] = dsize;
+		total_datasize = dsize;
+	}
+
+	new_frame_size = total_datasize + num_frames * VP9_HEADER_SIZE;
+
+	if (new_frame_size >= vb2_plane_size(buf, 0)) {
+		dev_warn(core->dev, "%s: unable to update header\n", __func__);
+		return 0;
+	}
+
+	for (cur_frame = num_frames - 1; cur_frame >= 0; cur_frame--) {
+		int framesize = frame_size[cur_frame];
+		int framesize_header = framesize + 4;
+		int oldframeoff = tot_frame_size[cur_frame] - framesize;
+		int outheaderoff =  oldframeoff + cur_frame * VP9_HEADER_SIZE;
+		u8 *fdata = dp + outheaderoff;
+		u8 *old_framedata = dp + oldframeoff;
+
+		memmove(fdata + VP9_HEADER_SIZE, old_framedata, framesize);
+
+		fdata[0] = (framesize_header >> 24) & 0xff;
+		fdata[1] = (framesize_header >> 16) & 0xff;
+		fdata[2] = (framesize_header >> 8) & 0xff;
+		fdata[3] = (framesize_header >> 0) & 0xff;
+		fdata[4] = ((framesize_header >> 24) & 0xff) ^ 0xff;
+		fdata[5] = ((framesize_header >> 16) & 0xff) ^ 0xff;
+		fdata[6] = ((framesize_header >> 8) & 0xff) ^ 0xff;
+		fdata[7] = ((framesize_header >> 0) & 0xff) ^ 0xff;
+		fdata[8] = 0;
+		fdata[9] = 0;
+		fdata[10] = 0;
+		fdata[11] = 1;
+		fdata[12] = 'A';
+		fdata[13] = 'M';
+		fdata[14] = 'L';
+		fdata[15] = 'V';
+
+		if (!old_header) {
+			/* nothing */
+		} else if (old_header > fdata + 16 + framesize) {
+			dev_dbg(core->dev, "%s: data has gaps, setting to 0\n",
+				__func__);
+			memset(fdata + 16 + framesize, 0,
+			       (old_header - fdata + 16 + framesize));
+		} else if (old_header < fdata + 16 + framesize) {
+			dev_err(core->dev, "%s: data overwritten\n", __func__);
+		}
+		old_header = fdata;
+	}
+
+	return new_frame_size;
+}
+
 /* Pad the packet to at least 4KiB bytes otherwise the VDEC unit won't trigger
  * ISRs.
  * Also append a start code 000001ff at the end to trigger
  * the ESPARSER interrupt.
  */
-static u32 esparser_pad_start_code(struct amvdec_core *core, struct vb2_buffer *vb)
+static u32 esparser_pad_start_code(struct amvdec_core *core,
+				   struct vb2_buffer *vb,
+				   u32 payload_size)
 {
-	u32 payload_size = vb2_get_plane_payload(vb, 0);
 	u32 pad_size = 0;
 	u8 *vaddr = vb2_plane_vaddr(vb, 0);
 
@@ -186,13 +294,35 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	int ret;
 	struct vb2_buffer *vb = &vbuf->vb2_buf;
 	struct amvdec_core *core = sess->core;
+	struct amvdec_codec_ops *codec_ops = sess->fmt_out->codec_ops;
 	u32 payload_size = vb2_get_plane_payload(vb, 0);
 	dma_addr_t phy = vb2_dma_contig_plane_dma_addr(vb, 0);
+	u32 num_dst_bufs = 0;
 	u32 offset;
 	u32 pad_size;
 
-	if (esparser_vififo_get_free_space(sess) < payload_size)
+	/*
+	 * When max ref frame is held by VP9, this should be -= 3 to prevent a
+	 * shortage of CAPTURE buffers on the decoder side.
+	 * For the future, a good enhancement of the way this is handled could
+	 * be to notify new capture buffers to the decoding modules, so that
+	 * they could pause when there is no capture buffer available and
+	 * resume on this notification.
+	 */
+	if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9) {
+		if (codec_ops->num_pending_bufs)
+			num_dst_bufs = codec_ops->num_pending_bufs(sess);
+
+		num_dst_bufs += v4l2_m2m_num_dst_bufs_ready(sess->m2m_ctx);
+		if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9)
+			num_dst_bufs -= 3;
+
+		if (esparser_vififo_get_free_space(sess) < payload_size ||
+		    atomic_read(&sess->esparser_queued_bufs) >= num_dst_bufs)
+			return -EAGAIN;
+	} else if (esparser_vififo_get_free_space(sess) < payload_size) {
 		return -EAGAIN;
+	}
 
 	v4l2_m2m_src_buf_remove_by_buf(sess->m2m_ctx, vbuf);
 
@@ -206,7 +336,19 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 	vbuf->field = V4L2_FIELD_NONE;
 	vbuf->sequence = sess->sequence_out++;
 
-	pad_size = esparser_pad_start_code(core, vb);
+	if (sess->fmt_out->pixfmt == V4L2_PIX_FMT_VP9) {
+		payload_size = vp9_update_header(core, vb);
+
+		/* If unable to alter buffer to add headers */
+		if (payload_size == 0) {
+			amvdec_remove_ts(sess, vb->timestamp);
+			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+
+			return 0;
+		}
+	}
+
+	pad_size = esparser_pad_start_code(core, vb, payload_size);
 	ret = esparser_write_data(core, phy, payload_size + pad_size);
 
 	if (ret <= 0) {
-- 
2.22.0

