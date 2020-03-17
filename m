Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE84DC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F9A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LtZPNzC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCQU4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:56:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54571 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:56:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so824336wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E11XKxa+99XAxvsaAYOAf6rfWCpejdmI/dGXHU0ftc4=;
        b=LtZPNzC6b/uYz7/iUpiw4siGA1/q7YWPE+zfz3twoBvPQpx87qtHSALZBiZeL12ZLB
         Imh6HbyxUGSl9PaF8mzSd8TqKqBVGmyAsUnwY4seGnW1QDV+7QM1PLV4RnQPyIevWQms
         vOdKcRPlc295M1IIdcx2FS6vWg5JFGnE5Ynt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E11XKxa+99XAxvsaAYOAf6rfWCpejdmI/dGXHU0ftc4=;
        b=HZ+UCIvwqJmjLDo+DtC69f6pVCXil+itepSFGvqoFufyJlIJzpYYPVVUNdIL+OELue
         SA8QanPA/gKOiO9voTqXNBjalDj4OS1TlgWavu/foWdi1ddkpsa93VRve6cNlZqlPFuQ
         kgDP0KG84wGmop05Ib/TVUzy7Q3isX3Fvugx0N+kDlZoqtmxxpX+e2DjhBFWQ95ArWRl
         ugne3EZDPs3/jWIjrSF6198vknt+5xvChBWMTOxgTF84COmT4UwZ1DGAhwWLeYlHW2Ya
         CR3zgS2Nam3RUMzYRMqY2Nq5TFKYjz7OfrZHVKmtQcp60UEu7766sfPbedSvuLIK/vsP
         g0Wg==
X-Gm-Message-State: ANhLgQ0T5lyQ2qSTVmB6Jfz3fl0277vCaY4bLAJCjP2NtpVwNuRXVdCv
        fduzYODAswmB9mbwZaLSNKRuUtU5BdOfQOHB
X-Google-Smtp-Source: ADFU+vuxLqsX9OOC+HCC5UGSBRT3kQGp9W/anxdsF8DdeGYqstJOLR7/CQB+Sbpa2yhBPeKJsCDERA==
X-Received: by 2002:a05:600c:14d5:: with SMTP id i21mr894439wmh.82.1584478609782;
        Tue, 17 Mar 2020 13:56:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a73sm703837wme.47.2020.03.17.13.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:56:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Joe Perches <joe@perches.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] MAINTAINERS: Better regex for dma_buf|fence|resv
Date:   Tue, 17 Mar 2020 21:56:43 +0100
Message-Id: <20200317205643.1028398-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're getting some random other stuff that we're not really interested
in, so match only word boundaries. Also avoid the capture group while
at it.

Suggested by Joe Perches.

Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: Joe Perches <joe@perches.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
v2: No single quotes in MAINTAINERS (Joe)
v3: Fix typo in commit message (Sam)
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3005be638c2c..ed6088a01bfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5025,7 +5025,7 @@ F:	include/linux/dma-buf*
 F:	include/linux/reservation.h
 F:	include/linux/*fence.h
 F:	Documentation/driver-api/dma-buf.rst
-K:	dma_(buf|fence|resv)
+K:	\bdma_(?:buf|fence|resv)\b
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DMA-BUF HEAPS FRAMEWORK
-- 
2.25.1

