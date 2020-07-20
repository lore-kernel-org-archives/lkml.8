Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B8C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFF122CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrwG+gcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGTJOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGTJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E59C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:14:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so9918526pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3MJRQvkP4/KEQ3YX92tLGGCX4xlP9dMdupK8mDNvHRM=;
        b=lrwG+gcqco5EXJEp5+BBTvUvMntRPXvMd7UxLgzRohyP6Ef4S80wXxLB4VfuCt69II
         +yuHAA0b/3RLQ7yXlCVXGFuCVqN5bO/b+FVoOJz7h/P4AgrxGMIMq7SpyZ1VvV2VP90X
         RiO0Vxks+c9Nn6ZnXBjQhbTPL3oKOQgHXKXGavVkyQDdDK86PEnkDhwcRFB/FBV8PTLx
         uoDEUWZoFChv2hYOzc21xkGIjFFUurscKCGq+A6MzYP7pYdkaXzo6n4BY3+XYgGPtnUz
         hfnnpxjgUz8jHXHsiz01zvh8gPupRp+9wBAcvBM2qFsyxPraGH3DyAnESFIvno/lFJ3+
         bi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3MJRQvkP4/KEQ3YX92tLGGCX4xlP9dMdupK8mDNvHRM=;
        b=ZBn/AACyEBei/qv9lnI96O5LEs/pmAfNtg4b7SX+72ccENtUJvJRrR2PIFbixzBDWt
         mG0YZFumYS1xJqzFQfPZWXiShwrShGcMCzXXPtNiDcbtBhH8j2xDvAJcoJvO3eGIYhve
         m924o/8xLQ2rKlc52NeYVw3wcpMMLzSsFtCfPi66hgSEiOZ4boKtlXNAWCvo3znB9Ju4
         NZeLSD18vFQBCqapCFFWzlXiF3kDnFtsfSUFDT2fkx0sMYv8togmqtfY6YLy37soMlD9
         Ixhz9ctyrSplGxAz2fIhZXj6evy+RYgRtjophKG5Sn7MTPzGQCe9aFJX1ZOkRi/xcYCu
         q6NQ==
X-Gm-Message-State: AOAM532LAEjhAVyEwW+qEeaU6RU1eAJTppsvH5kOlsCvYt3u5ioluyOI
        M4IK2/T1u3GZkm0W9J0HrJc=
X-Google-Smtp-Source: ABdhPJwcDdQiYZrT6Xt27ssEBjfGgjZKMTlTJiwCwuzXssXvqjudMzfeGID+NidWCek0wok0LfxCEg==
X-Received: by 2002:a17:90a:e50c:: with SMTP id t12mr22441080pjy.209.1595236492232;
        Mon, 20 Jul 2020 02:14:52 -0700 (PDT)
Received: from DV.bbrouter ([117.242.250.233])
        by smtp.gmail.com with ESMTPSA id w9sm16276548pfq.178.2020.07.20.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:51 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        darshandv10@gmail.com
Subject: [PATCH 2/2] staging: rtl8192e: add proper code indent
Date:   Mon, 20 Jul 2020 14:44:42 +0530
Message-Id: <20200720091442.19532-2-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720091442.19532-1-darshandv10@gmail.com>
References: <20200720091442.19532-1-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the code indent for a conditional statement is
not according to the preferred coding style for
the linux kernel, add code indent as necessary
after a conditional statement.

Signed-off-by: Darshan D V <darshandv10@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index b2af802b9451..b60e2a109ce4 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -337,7 +337,7 @@ static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
 		}
 		if (crypto_aead_setauthsize(data->tfm, CCMP_MIC_LEN) ||
 			crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
-				return -1;
+			return -1;
 	} else if (len == 0) {
 		data->key_set = 0;
 	} else {
-- 
2.17.1

