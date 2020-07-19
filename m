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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267FC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EBC207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfgJKpx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgGSK4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:56:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F92CC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 03:56:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so8690199pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hML1tWez8CnYkrgIciu2FQh/UfjOCl9KNyXr6NyJ9Vg=;
        b=QfgJKpx/653RJOZAtofIhq+3M93kxjphvEa5lkAKbjRT9N0VaPxRg66kQ9c/cnE1IE
         quou9H/FoOfeFvcLMnOHcay+H9nntRZtcYQjS7hIse9EyC2ZNXsqAyFsEI5pI0lMRWCR
         L9V9FI+yHiNZI/LNtfcJYArfjEdkpyfdXeRdZl+dYzkjENRUurmJ5jNWkwqX+l6NFagz
         wyz8fB7SLYRCxlCDCWCMfFCVpsFSZHFxEvf/CIt3YMnLjrQa9hGPZCSTQazuUP7SPTcp
         bbvNgWKXpJAnCiAvNmPDVAHOTjc9ioShBJ4M2S6rSdQjWxAcEJ9/tbs1V4Fj2IYQOIMc
         Jctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hML1tWez8CnYkrgIciu2FQh/UfjOCl9KNyXr6NyJ9Vg=;
        b=gApRJNqbt0cI0LQks8Q48ydZAgtG1Obl35d/e447koQXu9ZVoP0ySkYubGqgwqCf6E
         DcpZ4qmi13MCpXC1m7u4cgH6aeCryT5T2SVb0g5vhjKhhmhdxD0j+0gwpfa3hPQYoTOs
         iTC4W7osE6fDRjVAElKNrl1i27F3MsfXKLyDRgP4GFrrSrB+l26On21D2rvT5Q1Ii7JN
         uZ/bRDaVF9C9XlUd2HX6ZJ/lbz7CtF5aQzMqPvSIO8A+nb2f2UuDPiNBPkzc4HyrlAsq
         PFNxobPPBd7+whMhfxLgds96eUU9YjooJ2OiZN+lc484TL+f+PT/bwMTnIJM61ETgJOU
         3qeA==
X-Gm-Message-State: AOAM5318rhFzGD2vkyZrmd1vLPzNjk5wvZ05b6ZRXX/p/QcIJfvIhYPZ
        V3SluGPNFyKBvQXbREdNvkI=
X-Google-Smtp-Source: ABdhPJwagQHr9yxy9RMxSYJoO/fsqCb1qMIuArwDbp1b6U0Xx8VqCgVxvAn5gF1pZyzo3wX4pg0qcw==
X-Received: by 2002:a17:90a:7483:: with SMTP id p3mr18307351pjk.64.1595156167867;
        Sun, 19 Jul 2020 03:56:07 -0700 (PDT)
Received: from DV.bbrouter ([117.242.250.233])
        by smtp.gmail.com with ESMTPSA id o26sm13299253pfp.219.2020.07.19.03.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 03:56:07 -0700 (PDT)
From:   Darshan D V <darshandv10@gmail.com>
To:     gregkh@linuxfoundation.org, yuehaibing@huawei.com, ardb@kernel.org,
        contact@christina-quast.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        darshandv10@gmail.com
Subject: [PATCH 2/2] staging: rtl8192e: Fixed a coding style warning
Date:   Sun, 19 Jul 2020 16:25:57 +0530
Message-Id: <20200719105557.12605-2-darshandv10@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719105557.12605-1-darshandv10@gmail.com>
References: <20200719092236.GB171181@kroah.com>
 <20200719105557.12605-1-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    rtllib_crypt_ccmp.c: Fixed the warning - suspect code indent for
    conditional statements on line #338

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

