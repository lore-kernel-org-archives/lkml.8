Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83176C3B184
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CBC20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUSGqIUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBJGgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:36:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35708 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBJGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:36:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2424388plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 22:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4T1sUZ5d5/lE7jdAROdnSabgnZhFUdcqE+KF1UFLYs=;
        b=gUSGqIUwzyoakxw3TkxBU5Ql7F+G+0GnrYl+v4e4+nJTwIC+CnFaeoDOvD5toFci+W
         7eFCHr2zwz9WiHq/IMGHoATS1LQ4FE5zhdc301dfx/vlTkZ/20ULmJnWcdNdj/trPMAg
         QH0wTrs8BbzERklKZUiY9UAF9H4mF3x6x2EY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4T1sUZ5d5/lE7jdAROdnSabgnZhFUdcqE+KF1UFLYs=;
        b=oj8YAohX9TF19qPrEJ2HHp6gXc9OFvltyLaflOw8IPihpNnw0yxkYtAN3KWCbbvm1I
         w3F7uMt2oGrDHq53hd4WUY06QFhyVeVp3Xnw2pUdwlKPPBXELpccFlHoE2Pcf3ScOsvS
         GKGR6oeJfPPw2mkwCOi41Gh7QRNIzs9GSlY/RPKYOrE++/nRkb+U5YPfKGm1ogBqZQ/E
         sRRrKuSKpKG/2Phd+4vEbuCOrDCHDsQhCUDbQDlEAaoz7JK+q1fDZBT1mWfmE2HW8NDG
         bQRcIasl7YypKLw3YeyEySj3hyc6bkt0Ub78GNrPvWjdP+oRPrFcpGRFp5NgRYtG2kax
         0vNA==
X-Gm-Message-State: APjAAAWdJqMhdyY8Wg+pv3Bmpcg0wQuaUXDcL1xkktTpKnm5VoANHAtr
        mD1CT+RF9B7kM7HmlCQfSmWFoA==
X-Google-Smtp-Source: APXvYqyXUem1drftBReu+mmxe6pn4dX7A8nVAJDHrAsQ3zKM8+P+ZWpWg9JrY64PTKd9Jf7tGph2BA==
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr18701198pjs.21.1581316595020;
        Sun, 09 Feb 2020 22:36:35 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id f15sm11070041pgj.30.2020.02.09.22.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 22:36:34 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v7 5/5] media: mtk-mdp: Use correct aliases name
Date:   Mon, 10 Feb 2020 14:35:24 +0800
Message-Id: <20200210063523.133333-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200210063523.133333-1-hsinyi@chromium.org>
References: <20200210063523.133333-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aliases property name must include only lowercase and '-'. Fix in dts
and driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 9afe8161a8c0..0c4788af78dd 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -15,10 +15,10 @@
 
 
 static const char * const mtk_mdp_comp_stem[MTK_MDP_COMP_TYPE_MAX] = {
-	"mdp_rdma",
-	"mdp_rsz",
-	"mdp_wdma",
-	"mdp_wrot",
+	"mdp-rdma",
+	"mdp-rsz",
+	"mdp-wdma",
+	"mdp-wrot",
 };
 
 struct mtk_mdp_comp_match {
-- 
2.25.0.225.g125e21ebc7-goog

