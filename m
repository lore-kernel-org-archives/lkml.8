Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE83C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED302074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmayaXWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHZW4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgHZW4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 18:56:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B9C061574;
        Wed, 26 Aug 2020 15:56:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v12so1860539lfo.13;
        Wed, 26 Aug 2020 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Dgulwv05jUoieJr+gqcUbQ6wpsVte9CAar23MNPJ7E=;
        b=rmayaXWkWon2jv52c0auSoGgImYxb3cXWfOnKRA4JOfzmQKy9JgRZUW5E61t2ZXFmU
         NDiEf5cfhEwL+1ryqaLPW4Bv8vPhk8u3mD4MP762mnfR8F4Z6KmcJwCkSGndRZ/uhz8z
         aey38Qfael4u/gcoPJlhChRqR5HKWa1mYMhneH/rQpc2zTUiGZl81HaOWtf5TufEpEZc
         r0Wt3DqSSclJZa5RjuQa+D267u4yZ2Tb/1bzM29WPiurojFaB9f8jXz5/BRAPQjKUUXc
         jcU/Mel3qHPZiUPzcMxUi08lh17P3PX6AU2Oi21fFvJWfEuwRnTWY3WM8ziy46/h/PSF
         2VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Dgulwv05jUoieJr+gqcUbQ6wpsVte9CAar23MNPJ7E=;
        b=F8rMQn99Neb73xdkgb2VllQ/f/RR54yl7nF7+g+vh3y2tdxk4/8bi5qXTA6DRhnBHW
         kJvhRZrDaOyrie5xkPdkqsNZ4Zryue8ZkuP9umYIBQn5yhY60OwCCjhfkInp7zm/CW4g
         YJh4+y71md1qt+nDljbpEs71OKx40c47QeKlMz+OGnT4ZT/rkCUKqZXnaKGhEmROci1Y
         N67EWm9bDH8wMvrcDI0fBj8wVCkESyWAqYgKq4MpKsdb/KSxLd583XaoDkCUU3QvtWPv
         FZY/IEJzFiTznr2rXncJsiRExTdGubCQpCvw9i/618OlgeEqWapDawOLrr3rhpZzx/Rx
         5gaA==
X-Gm-Message-State: AOAM5318CEb1+Os8oCc8se8PmqV3rsniIXmzmyQygPhSZdooQihhRLfR
        fnuKb400r+q5hxRLd815fag=
X-Google-Smtp-Source: ABdhPJxIJrPEx4P5UUrtxzsS1aOaGySDzu0RLJFkjjQOlyjUVa6SZkN+2o4/SzbCk2Fw+RtWQj4FWw==
X-Received: by 2002:ac2:598f:: with SMTP id w15mr8514645lfn.216.1598482601018;
        Wed, 26 Aug 2020 15:56:41 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id u28sm49075ljd.39.2020.08.26.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 15:56:40 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ethernet: ravb: constify bb_ops
Date:   Thu, 27 Aug 2020 00:56:04 +0200
Message-Id: <20200826225608.90299-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826225608.90299-1-rikard.falkeborn@gmail.com>
References: <20200826225608.90299-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of bb_ops is to assign its address to the ops field in
the mdiobb_ctrl struct, which is a const pointer. Make it const to allow
the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index df89d09b253e..f684296df871 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -162,7 +162,7 @@ static int ravb_get_mdio_data(struct mdiobb_ctrl *ctrl)
 }
 
 /* MDIO bus control struct */
-static struct mdiobb_ops bb_ops = {
+static const struct mdiobb_ops bb_ops = {
 	.owner = THIS_MODULE,
 	.set_mdc = ravb_set_mdc,
 	.set_mdio_dir = ravb_set_mdio_dir,
-- 
2.28.0

