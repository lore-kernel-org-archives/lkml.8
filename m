Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D1C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E771C22B48
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SON/w4A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGSMJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:09:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C146C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 05:09:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so7396144ply.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=waaFEyASoWnWz0hncm83MVo/prywlRuPGaFhcYp4GOA=;
        b=SON/w4A8Es2f0mcuQKoPL0s1NUtu7MvBfFwBMTqZqVOnnHotMiT2t36Yu1OYqWJ3PT
         xwRjquH80haAuewOjGpcP07FzIsD6hxdtfmDF4HoDPq7qSZPbpP9KeOhW9IC6CUa7sCo
         HYhz3+3COLTsdgUI71tAMKpq53va3HVhBucgkMf+HQvISpZ2sZEOaIj3tIH0GI4VG+pj
         k9rpVS52qjS+FMTPcw5kjI6ecCsQZpHDoJlRVUTBwhZXZF8I7V5BMHSiZ3ik1ygER5XQ
         j0L3S7ao3tvGldydm1+fpH2xiHAeDW1dbAJyPkm/Uh66hmbITnq26xdV8wAPhIX7N/Ob
         kLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=waaFEyASoWnWz0hncm83MVo/prywlRuPGaFhcYp4GOA=;
        b=ACFA5wnF6t0fC4oh5fNYM05c+cSg0uYwNED6IvL+X8WwAg7yQ90EwbjwXSUrUy985s
         dnka3fiPj4L2NrdQPY7VX0Wx6eXVvpsImNGTCOxR1Dd87SUKM6BKMrkRfVh0xxWtL0/H
         ZXPjA73tLkD5yEDvV+77TXGiVIaKsGTl2GBvlFGHIRXn+ItyQ5QMqJf03Nt+lld9LfkH
         hom9QIpVtzj1nR/Kkxl0ljkS3Zet3wCQz7QWBs5zm/Ng/YrDepcHUXHDwKpR6uhzwqJx
         1CGXe/mMM69EMqW/9aeefJl10cMHOGt99gZeHWRQvQdppvFpqLz/KPzlRqt8AeCI9AKX
         KeiQ==
X-Gm-Message-State: AOAM531luJ9Vw0d/JoGxoNLtJqc5lcmwQC8CtIF42IBMKoeLzCNePtkH
        vP8HZ6jitsyheEibrnOLGKg=
X-Google-Smtp-Source: ABdhPJwV2sUmRqRrC5Enn2z0bbgffY+V/Hh8BbBC6YLGM33LZRWsvcglVu/yfS0W1D6g87JIAWhbMg==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr11830158plb.57.1595160568595;
        Sun, 19 Jul 2020 05:09:28 -0700 (PDT)
Received: from DV.bbrouter ([117.242.250.233])
        by smtp.gmail.com with ESMTPSA id z11sm13258466pfk.46.2020.07.19.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 05:09:28 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        darshandv10@gmail.com
Subject: [PATCH 2/2] staging: rtl8192e: add proper code indent
Date:   Sun, 19 Jul 2020 17:39:18 +0530
Message-Id: <20200719120918.17862-2-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719120918.17862-1-darshandv10@gmail.com>
References: <20200719120918.17862-1-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtllib_crypt_ccmp.c:

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

