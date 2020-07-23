Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1ED206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/HoggJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGWHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:55:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A37C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:55:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so4185263wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYiA3UwEeiLQemkL/9iQjByUGIB29wIzr9SE8ieESv4=;
        b=U/HoggJKdye7uH+NKT/KmgJSF3B2iQN794CjYp4NyV5DAUziAOxxXKE3wQktPqsfw5
         eYE0rXP3eJGVYU9hAHH/4YdcatzZgHDzR4s/XDdXBHZ9cU3IyLo0gjViev8kLUjfc5oM
         OC/+q3as2EyfLmzKCImYm8yPA1rDdW2TEc642SNg5X6gvG2Zjw2t0nL+p2VugG5HaLBu
         yyXNPUWmKuxRgNoRSIfRDu8ihdiMKWgZ6rRODswvIoTN9Zvg9ZEGePxI3cKHH92mNrOa
         ZPGBZZ9w0rGf/FvxpT6LIp0btCcpr6zmlHuRqR1+SNN5SqB48MS5PibSl6FSWNIuygan
         rd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYiA3UwEeiLQemkL/9iQjByUGIB29wIzr9SE8ieESv4=;
        b=ozX0wSjurHn+U4gyO8CeAuIsa0lQzaFj3ZT3+2nWkpznRJXKjER7lWB4LxM0PkDvRj
         z7EYwg7TsVC6mx9emGiYsiY0QmW5nrp40sMyfjb9CCKoebrd9yqqwDra9SKyheApDrTq
         LY0148u4qsxKI+xOH0YrYOVsq1DK3IDpLcmJisK1ftUCcqQxUjHWd5O/+gUWr6qEANGP
         SibnawNGgPKR6ufp5F0L0zq1Z7qjiEr5GSrurfr02j0Npe5v0dD8w2TEvJzbv6rGJsKP
         jle+K8rr1xKHnvwZ2Ud9HpyzPb0Qbf+PBwHMOFc4JQ/hPUNp76v2SEEEUWKAI4i5IM+z
         H54w==
X-Gm-Message-State: AOAM5323go7uqD2NdQujTLIke7N2tTxg8iLIPkUlCYeEdNgMf0QXudyD
        ueWIlDoFP5fAuWfwKkH5I00=
X-Google-Smtp-Source: ABdhPJyjQBWlA2gbvgFi8dz+i79hfadBVdFwhnb4BvE2LNDd/0B2rXIy1O+EdqgEYBzBk5tIc1+4GA==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr2766059wrq.407.1595490944446;
        Thu, 23 Jul 2020 00:55:44 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-164.178.006.pools.vodafone-ip.de. [178.6.252.164])
        by smtp.gmail.com with ESMTPSA id j75sm2816691wrj.22.2020.07.23.00.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:55:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: cleanup whitespace in declarations
Date:   Thu, 23 Jul 2020 09:52:43 +0200
Message-Id: <20200723075243.21924-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723075243.21924-1-straube.linux@gmail.com>
References: <20200723075243.21924-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in declarations to cleanup whitespace
in rtl8188eu_recv.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
index ab8313cf5bf0..7badfc2e45df 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
@@ -16,10 +16,10 @@
 
 #include <rtl8188e_hal.h>
 
-int	rtw_hal_init_recv_priv(struct adapter *padapter)
+int rtw_hal_init_recv_priv(struct adapter *padapter)
 {
-	struct recv_priv	*precvpriv = &padapter->recvpriv;
-	int	i, res = _SUCCESS;
+	struct recv_priv *precvpriv = &padapter->recvpriv;
+	int i, res = _SUCCESS;
 	struct recv_buf *precvbuf;
 
 	tasklet_init(&precvpriv->recv_tasklet, rtl8188eu_recv_tasklet,
@@ -69,9 +69,9 @@ int	rtw_hal_init_recv_priv(struct adapter *padapter)
 
 void rtw_hal_free_recv_priv(struct adapter *padapter)
 {
-	int	i;
-	struct recv_buf	*precvbuf;
-	struct recv_priv	*precvpriv = &padapter->recvpriv;
+	int i;
+	struct recv_buf *precvbuf;
+	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	precvbuf = precvpriv->precv_buf;
 
-- 
2.27.0

