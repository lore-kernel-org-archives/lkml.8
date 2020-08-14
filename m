Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF78C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8691420771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nolgDExN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHNLla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgHNLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E10C061358
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so8228981wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeO60JjEAZIznFwCMtV3AvBpAyOLH6PI1v4S2BhJUMA=;
        b=nolgDExN35FECbtrc24iEOWD7RfDFbN8/TyWWnFUzFMH/xO9mu7Nx8VxkSOUxZDULJ
         WGtlSG/PDFbzGNGDQbtk37OWXP2S8NlrnczKNWWX1Rp11tOTaKMr8jmJn2Tp9AxFa8x5
         Oc0CB7UC9jLXzkDoS9S/jhqeG1SI6YhRci7mzdkLktsLCcKnAkDq8xM6OHK6C7iiFpX6
         FEc7OMpKW3nIeV2eQIISAbcrO2IQySwJ7FxzcV/ZMz7H0jGfCQrl2DJYPGuPZ0GXsZgh
         DPIGoyUgvcv4UhZYpJKMOfxieIZNxKPh1GWlgN+EFC+jADmNhJkaN4qSa12o0EDc8/+l
         Ml+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeO60JjEAZIznFwCMtV3AvBpAyOLH6PI1v4S2BhJUMA=;
        b=CAH+/ylMMjlDwGZsI7qm4KCjyftcCd5dmXknPSU8jPpS9ljYPs15vgOklNYwQzqDtx
         1pqrAN4DiwbOY566oUSuEzEei7hy+KCKNCOtd1VJC8Q9ueGqa7Fst+HfIZ6+wNf/8a/y
         vgEiu6ztMpjBOSMgHCl+H3meGZDBw0YGRKJropax0ir5KRGABDsE8naRXND6N36fH7LL
         CGC/uQ9WCCUT86Hnytmvi4PWYcCPF04K2eJuwXU4V6OX7n81pqKIIH5mg30zB36Yi9IZ
         9fOyNRNIBj4PafiyM6E8z1fvf5IDjqE1lq3CGwgFbyHf4p7Zhp3V3szLwu7pntHf0N61
         5ZpQ==
X-Gm-Message-State: AOAM532fwKPtrH9E/DX/k4qMVLY/Fa5oJnaGhj4DLweR2tJqNwBoQM05
        mtFKz3diBLjqMTX4aMLcX6ntVg==
X-Google-Smtp-Source: ABdhPJw299VOAGaSIY6uYBiim4ZDaSskjd0OAiF9SHdEIKBvr+q3l9ynAWL4wwQ+nQuFxdawXEC6Dg==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr2167015wml.73.1597405213070;
        Fri, 14 Aug 2020 04:40:13 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        netdev@vger.kernel.org
Subject: [PATCH 21/30] net: fddi: skfp: smt: Place definition of 'smt_pdef' under same stipulations as its use
Date:   Fri, 14 Aug 2020 12:39:24 +0100
Message-Id: <20200814113933.1903438-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'smt_pdef' is only used if LITTLE_ENDIAN is set, so only
define it if this is the case.

Fixes the following W=1 kernel build warning(s):

 drivers/net/fddi/skfp/smt.c:1572:3: warning: ‘smt_pdef’ defined but not used [-Wunused-const-variable=]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/fddi/skfp/smt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
index b8c59d803ce68..a151d336b9046 100644
--- a/drivers/net/fddi/skfp/smt.c
+++ b/drivers/net/fddi/skfp/smt.c
@@ -1561,7 +1561,7 @@ u_long smt_get_tid(struct s_smc *smc)
 	return tid & 0x3fffffffL;
 }
 
-
+#ifdef	LITTLE_ENDIAN
 /*
  * table of parameter lengths
  */
@@ -1641,6 +1641,7 @@ static const struct smt_pdef {
 } ;
 
 #define N_SMT_PLEN	ARRAY_SIZE(smt_pdef)
+#endif
 
 int smt_check_para(struct s_smc *smc, struct smt_header	*sm,
 		   const u_short list[])
-- 
2.25.1

