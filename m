Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFFC34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623DD20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mpzvqg/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgBSOJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:09:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41322 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBSOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:09:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so680433wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JGM4RkGLLaFSnOa8BB7mpJxXjjdhB1y60VVHn0z+pew=;
        b=Mpzvqg/96O9XJBO85GyCDhcffXGgrF/cgk8f5H5ZJk7Y41L8HvATVViR+s7K7uYugG
         jnUa5V4C6Uo/tifu3SpQ33EaMvqAdIMI7XGdrXXzuXDC+T/+lJnklL11ZeWsSoXJJ6gd
         Sm7xGWklY8BXnqZErW0CMpEkc6DoKr4LhUZ4pZ/kKNJ3RzR3Wqa85PEtbSSjiUM8C+zt
         lJ6nyu47+IQClRYQm4PF0c3LtrJOS+3idB95HRsCcyA7e+Dkicaawh2TWDB74UXMzVxl
         JgpiFZqDJlwYGKPLNZqJorJ89HOlg8cjDjon5Ax048MGuK2esCQFeQdmQ2OV+1l3CtHu
         kAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JGM4RkGLLaFSnOa8BB7mpJxXjjdhB1y60VVHn0z+pew=;
        b=gAXNrKJpDcjLf2Y6pfKKUX6YwySuGr60JEaAj0I3ZoHUy08HXJGfNE9EqFRHy/2Bn9
         q2gW3ZCvHAnz16Hatv9Cr9olqp92cfEBf/JWDhaJCJoKtPpr2iRyVPD5nJS/mUD5Almb
         UifZaQDLdVZZ2dRug8dIxdJ9rT4cdh44c5e2ekm2LtPYh1i6yeSNdn53XXR16NEHwQA3
         /kv95HdmoiQqBb5bzYyjyjhEPNTXrGhmz3e6uAqqzRNbpt9IEBpwfuUwcL0kSC5F6+O5
         6lyFsKEfmlF/deJBRDyIPjbifL3oPQ3C6kRXIvfDn/YmkKlmKgvl8dkCxZNGH/s3dwtn
         idJw==
X-Gm-Message-State: APjAAAV9HWTyzbI9swqwuF6YAKSQQTU59tXXIgNQB5YInFfvsNed17uq
        TH5BbiFm6tyyGlsQTvYtLbFYDEA2AqY=
X-Google-Smtp-Source: APXvYqxdRLIszlOHZfFNWUcmLYHcGMqKeshhz0KZ8IRyyt0eY3GIsphQUgWiNOeTQCQJGiephQmV6g==
X-Received: by 2002:adf:db84:: with SMTP id u4mr36805190wri.317.1582121352765;
        Wed, 19 Feb 2020 06:09:12 -0800 (PST)
Received: from robin.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b11sm3302343wrx.89.2020.02.19.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:09:12 -0800 (PST)
From:   Phong LE <ple@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Phong LE <ple@baylibre.com>
Subject: [PATCH] regmap: wrong descriptions in regmap_range_cfg
Date:   Wed, 19 Feb 2020 15:09:06 +0100
Message-Id: <20200219140906.29180-1-ple@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap selector_mask and selector_shift descriptions

Signed-off-by: Phong LE <ple@baylibre.com>
---
 include/linux/regmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f0a092a1a96d..40b07168fd8e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -461,8 +461,8 @@ struct regmap_config {
  * @range_max: Address of the highest register in virtual range.
  *
  * @selector_reg: Register with selector field.
- * @selector_mask: Bit shift for selector value.
- * @selector_shift: Bit mask for selector value.
+ * @selector_mask: Bit mask for selector value.
+ * @selector_shift: Bit shift for selector value.
  *
  * @window_start: Address of first (lowest) register in data window.
  * @window_len: Number of registers in data window.
-- 
2.17.1

