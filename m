Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9FC3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDFE24677
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPoKimKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgBSSKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35653 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:10:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so1372700ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHRaRIY6VC0lr/bsxS9DFYm2vnnWlx5lRwPcPyEFXY8=;
        b=gPoKimKTfqXeaHb/8TGnGKiKadlA4zsOW1otR4I/sil7LU1xLql4X/Z5B+MFOfsTop
         w/ibtafB1NiWhq7Xv+8ILNm+hTBM7E5IUfN32t5XlIVVJZnNzZudtvHPYZsBq5discGm
         LiJIoaqOEoHn0bJVztnhrUFEPj05q727TXZxPFRHiCZOVpOeq27877/zTFYAKzu2BpGd
         DsfcQMHPnzI39piTrkm80ut5XZ+iY96UV+eMlAofUXDvtjNFZHAEg9M8pXTNOvGpkBNv
         pDB11JGdX4pDVm+AyNGSP4d3Q8pDUUU40G41Spc9gd35dTl7Mgia6V15oP6akiDPas1S
         8cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHRaRIY6VC0lr/bsxS9DFYm2vnnWlx5lRwPcPyEFXY8=;
        b=R8cCgYTt2ogTkopeMBGh/mIR0hjHuVjbj6qX+6+piqOGQCNRPEx0YlmhJPk5eFnrp7
         8HC/3+YgSwELkVICEDVQoPrw8oWQIBlrLepU3AIVJmBTp6QbKrrjjNvmSDm58+XODFEe
         GTU3JHr2fokNUNTjG417GuHDyzJuHb5ei+t+uDiyh0zU0RN+5qEUiTn+PjcKNm69mLip
         CKHETjSfrvM7YD2ZV+KuKj+LypmQjRGPSvaeydTvUgV8QG4alF19RK+nRE3EV8U7yqGU
         v+Sfu45OMmwfc+7+WEQgmpxlvVuveSExYtG3f08m/cFF46KfESUE0etnaNuShV/f5x8b
         AQfg==
X-Gm-Message-State: APjAAAU7bnQFDMFFXe+FYvf4f+OlJtGIPqwnvkJDHkueryWVbSBnOh7D
        tfPuogqyY0+h2C34Wa+35JE=
X-Google-Smtp-Source: APXvYqxvm4JywuwtvNksBuTIyRXNkm+Tp130I25jlGLt/f+T62qAbvOhoYaS6P/K1V7awdKdjw1/Hg==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr16524098lja.152.1582135800094;
        Wed, 19 Feb 2020 10:10:00 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id 14sm183942lfz.47.2020.02.19.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:09:59 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH 2/5] drm/sun4i: tcon: Separate quirks for tcon0 and tcon1 on A20
Date:   Wed, 19 Feb 2020 20:08:55 +0200
Message-Id: <20200219180858.4806-3-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219180858.4806-1-andrey.lebedev@gmail.com>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Lebedev <andrey@lebedev.lt>

Timing controllers on A20 are not equivalent: tcon0 on A20 supports
LVDS output and tcon1 does not. Separate the capabilities by
introducing independent set of quirks for each of the tcons.

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index cc6b05ca2c69..b7234eef3c7b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1508,6 +1508,8 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
+	{ .compatible = "allwinner,sun7i-a20-tcon0", .data = &sun7i_a20_quirks },
+	{ .compatible = "allwinner,sun7i-a20-tcon1", .data = &sun7i_a20_quirks },
 	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
 	{ .compatible = "allwinner,sun8i-a23-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
-- 
2.20.1

