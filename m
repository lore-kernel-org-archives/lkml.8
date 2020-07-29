Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7508FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4824321744
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="mUlP7Tu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgG2HqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2HqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:46:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:46:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so1188734pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Kc8o8UqCU991Vni3y/o1KBZOM15r81DSmGMs9PY1+8=;
        b=mUlP7Tu9eDU7kLyU4EQLPV0YBwq3/iDMfDoNkfp4mDqI6AhWyl9f3bBrXvbvQUzBd4
         yPX6O9aseFOlKDRrryBXjhogqmYl6lVMsvX8ei01yY78VJ2A7X74T154+EqzRAWoxPVn
         Js/wpcs25VS1jqgPYaMgO2u0A78P16DviwPms9ni6xfjFF3SfCd0GSQZZ0baBEvT0igi
         FkH0WQy9KjvoKPBxBt0DkPKGPaHSk9UL2wRvQt4c1zfKs/NKKv2dbBnL4JfA0yG7Y7nl
         5zUDncrpl9+ucYfGw5o8QIQV90s1Y3GC1gfXyKAQhGgZ9v7O4Os0egHsN5dkgk8K/hn2
         XF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Kc8o8UqCU991Vni3y/o1KBZOM15r81DSmGMs9PY1+8=;
        b=ehzPBzoxWqHDmEmnLdlWX4gjfrUzka28M4TF/IMoOGB2FT5zv9+PBApeXY5ARLUNAc
         eEF1f0nqp04ERw6glr/NNOXyfxRjD73ag7rkcNGEhwhIHj3e/AsAXT99FZ2DbjToOwvO
         Q7vU7uuGNONMn076G422IQ/YbnV2mrds6fTy35JSXQcenxQ8CimIMCBwZ6G+lg+Iw2lm
         7HoHO4zSnyMIHOAlDeFbVcX5ma5yvdaLPqt/S2wfgS5dBRl9vMeIP24GoOhksganRqZr
         h2F9Fe+mh2kqNHHtWZHbP81+lqHqv5YYBXbxGGNMfuEwU2C2bR2uIDSeLP1tFeNIVWgV
         5xsw==
X-Gm-Message-State: AOAM531JX4C3nJtdcwZwyh/7ul3kg7k+PAmRqI050fZHzMUwOJegaB5g
        QN00/9fkD8QlVqQ4xEQa+xvdOw==
X-Google-Smtp-Source: ABdhPJzhgxtOqw+ErBlwCNI6JQ8tLNWtINKyN3jyJYByNMZI9Ab/y1MtsQtE3dc2L689tAVXkn2msQ==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr25244131plt.230.1596008769862;
        Wed, 29 Jul 2020 00:46:09 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id o16sm1424762pfu.188.2020.07.29.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 00:46:09 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, rohitsarkar5398@gmail.com,
        mukadr@gmail.com, straube.linux@gmail.com, pterjan@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH v2] Staging: rtl8712: Fixed a coding sytle issue
Date:   Wed, 29 Jul 2020 13:15:41 +0530
Message-Id: <20200729074541.1972-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728213231.26626-1-b18007@students.iitmandi.ac.in>
References: <20200728213231.26626-1-b18007@students.iitmandi.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed braces for a 'if' condition as it contain only single line &
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
---
Change in -v2:
	-Remove space before ':' in subject .

 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index c6f6ccd060bb..df6ae855f3c1 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -238,9 +238,8 @@ static char *translate_scan(struct _adapter *padapter,
 	/* parsing HT_CAP_IE */
 	p = r8712_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_,
 			 &ht_ielen, pnetwork->network.IELength - 12);
-	if (p && ht_ielen > 0) {
+	if (p && ht_ielen > 0)
 		ht_cap = true;
-	}
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	if (r8712_is_cckratesonly_included(pnetwork->network.rates)) {
-- 
2.25.1

