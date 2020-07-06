Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86130C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6309F2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6m4FfX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgGFNfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbgGFNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75139C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so40630091wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AX8kUBEDyEZkkrAQRSTc56qB4suyJ5w028cqL1Y9nI=;
        b=X6m4FfX9HVkIRr8hUC5SaedwmejM6tHKMtWNuYYdOU9/56+ZZC56eTIFTX8DjtS4ei
         zSEhErkoaN6DfMdi+KsFgHeCmraKSYyUDTDBvwE/NCDhuOL2MzmazL5R1kxb0lRkL57E
         0VCH1foQu1eLxq00OzM0aq/zolR4GeCqxx9kPmH0iG1YSvxUN+IFUnR+g7vO2/B1H963
         +qy2O46U+JBmheOcj0HsXB/yrv+qOhS2qFnevyOLLYNtUuzADE+5fNDvPnKj35lP87aG
         DkkfR99J7Nsi0YY/wEHEgayT1PyA0037NW+/sIVocVBF9dVaHhoNijkk9NzyIV3eTstA
         gKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AX8kUBEDyEZkkrAQRSTc56qB4suyJ5w028cqL1Y9nI=;
        b=K50g+tTzgmVD54yZEkAc+kJTk8jMGw2IETQnzU5zzyiZM9Dsvg62cb9ZdYEZxK064t
         oU+XzTHCWsGntG14XTFv4+wYa244y2Xq/Ho2iuPYwfgwkC3qM5fVutZdf63gqD+174n9
         dFcZffs7qq8xeAU69Ltk92S3qxAc9GqP3fJhmqQMymgOrFTpQjXJjjMN16WRAYg9edfV
         Eo4KRmNylCidgVdRvM41ttNjIa30X6bh6agyc+vC0RJjGABEv4WJITaK0eSvOz13VhFE
         6CS9sSq7eH88g3lUBK/8s3mHMSnkpkIHtXhX3w6l2fMNN7nOvX3zH8rFMk6kIdYU2Onu
         sbwQ==
X-Gm-Message-State: AOAM531Hhb4v7NwMo4rhjeR9zepCGmaEDAFrdd+4Rbv2seTViyZEGbqy
        H1e59i5HpR9M7Yg123CPFMlNYg==
X-Google-Smtp-Source: ABdhPJy/vW4eBdtZFwh7RKJcvlKpAd8CeAoqiMJQAacobWRvOb+MQ1KwteySTGzaqMrxvN2XhuOPgg==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr39594381wmb.113.1594042446244;
        Mon, 06 Jul 2020 06:34:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yuan-Hsin Chen <yhchen@faraday-tech.com>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Po-Yu Chuang <ratbert.chuang@gmail.com>
Subject: [PATCH 18/32] usb: host: fotg210-hcd: Remove unused variable 'hcc_params'
Date:   Mon,  6 Jul 2020 14:33:27 +0100
Message-Id: <20200706133341.476881-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result is actually read into fotg210->caps->hcc_params.  No
need to popuate an unused varible with the unchecked return value
from fotg210_readl().

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/fotg210-hcd.c: In function ‘fotg210_run’:
 drivers/usb/host/fotg210-hcd.c:5013:6: warning: variable ‘hcc_params’ set but not used [-Wunused-but-set-variable]
 5013 | u32 hcc_params;
 | ^~~~~~~~~~

Cc: Yuan-Hsin Chen <yhchen@faraday-tech.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Po-Yu Chuang <ratbert.chuang@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/fotg210-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index f967adf2d8dfc..51dbbb0e768bc 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5010,7 +5010,6 @@ static int fotg210_run(struct usb_hcd *hcd)
 {
 	struct fotg210_hcd *fotg210 = hcd_to_fotg210(hcd);
 	u32 temp;
-	u32 hcc_params;
 
 	hcd->uses_new_polling = 1;
 
@@ -5033,7 +5032,7 @@ static int fotg210_run(struct usb_hcd *hcd)
 	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
 	 * host side drivers though.
 	 */
-	hcc_params = fotg210_readl(fotg210, &fotg210->caps->hcc_params);
+	fotg210_readl(fotg210, &fotg210->caps->hcc_params);
 
 	/*
 	 * Philips, Intel, and maybe others need CMD_RUN before the
-- 
2.25.1

