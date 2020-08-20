Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A9AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04516207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LU18Zw2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHTNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgHTM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:58:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7825C061388
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so1510901wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCjIPpaJfayHhXIqbXAAfMExGhce6Cm5F89REM3R1U0=;
        b=LU18Zw2Mo6zCN9DJWkCsqXp4H565UtUP2k69oaoX8bH2UNEtAJ6L6CFzY0ICqHlTjm
         ZNyN/TKFwtwFDiMz7R7Zjz8Zsndy47pxlH/aK4F+vSyCgceG+sBv/cpcNqkNKsQlJpuP
         UgG04n4F+PfIVRESEMO2QhUeiOz09ZjPfMLR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCjIPpaJfayHhXIqbXAAfMExGhce6Cm5F89REM3R1U0=;
        b=QRJ8186mHX1NyfmpmG9yisqjFaYcbPCBq5JyuGbBoYBqzqjGUo2zyqOZS9hijjnpqj
         1NyNd77BVcOZGFXwsmcbLl4Fs3Met5yJRBLmmQJJo3zHyuG1X3Zr3V8FL3ycN3DP41wy
         REEq8uccvpGWq9QVHRLQm+27/106i9VbAobW1iB5xfnWiNRiatl5bknuLbD7CBhobRpq
         yzxTxzOjco2yI6whBKuAE46xoBttCnkih+/C9pIWvYPlqUc9/0ga8kvhsx6Db5ov6kJA
         YXBLCwORmT237tFom14+n+N0pOuqCqQym4YwGy9gv5xyrE3aSOPZobr5Ex2w9pr6gJHk
         TM1w==
X-Gm-Message-State: AOAM531bTactHhE4CCu9Lhl34R2eQVoKJbyvuA6wfoK+mvz3WDb/gvUU
        IXP+Nw+qOvYSzBMBQ5kR3qj41bUYcLO5cLWv
X-Google-Smtp-Source: ABdhPJzFeQpDI7ZUKZvzzMkjStrT2UwRfn8F9nsNPSXgchIqOP9BiV9Huk+moA+VZ3LTbVE6D2/l6Q==
X-Received: by 2002:a1c:4104:: with SMTP id o4mr3411522wma.101.1597928311239;
        Thu, 20 Aug 2020 05:58:31 -0700 (PDT)
Received: from tfiga.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o66sm4517760wmb.27.2020.08.20.05.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:58:30 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho hehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?Pawe=C5=82=20O=C5=9Bciak?= <posciak@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pawel Osciak <pawel@osciak.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH 2/3] MAINTAINERS: Remove Kyungmin from the maintainers list of videobuf2
Date:   Thu, 20 Aug 2020 12:58:24 +0000
Message-Id: <20200820125825.224788-3-tfiga@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200820125825.224788-1-tfiga@chromium.org>
References: <20200820125825.224788-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to [1], there has been no email posted from him to the
linux-media mailing list since Feb 2013.

Note: The linked archive seems to lack messages newer than the middle of
2019, but it is the only archive that offers search by name. A manual
look through the messages after that time confirms the observation.

[1] https://www.mail-archive.com/search?a=1&l=linux-media%40vger.kernel.org&haswords=&x=7&y=20&from=Kyungmin+Park&subject=&datewithin=1d&date=&notwords=&o=newest

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8623365ad0d5..e756cd4751ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18300,7 +18300,6 @@ VIDEOBUF2 FRAMEWORK
 M:	Tomasz Figa <tfiga@chromium.org>
 M:	Pawel Osciak <pawel@osciak.com>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
-M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/common/videobuf2/*
-- 
2.28.0.220.ged08abb693-goog

