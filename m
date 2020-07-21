Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D654C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0232065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="IPtVjYH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGUNYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgGUNYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:24:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5AC0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:24:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so10266195plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgx4z/DNiLcnwiVMTxlKfTLr89BUcZAmWBACQY4L4M0=;
        b=IPtVjYH+4Nl8qj0o4aNFzWOBc8gf/CsNkxwtrKnuV97gpBAP4vQDUvLkQhnl/IymTK
         qyrj6NZsozQP5Wh/LB1GqxnSVUNnrZSRjmS0UNg0wdO+LwaSWuPW/IrZzsUVvFijySMZ
         AJrAX6iI9Y9L+5VfYYMwZwp54BEJS6i+9oEXI4QN7H5MtWV12OoJ3+Z+X3K8yi17KoAS
         M1NbO1LfhHiuyYXkMhpV5eaJX6WcjB0wIR9BmSOT9vE+4WxTdBTQQPnK9ACUaw/iQCSz
         EtkaRQ4W3XJ/ZjhPgeDdmPyNX4RCtriRD4ABulFJj0/ngeXIVCqyb+NoojM9cEuXXZ22
         38vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgx4z/DNiLcnwiVMTxlKfTLr89BUcZAmWBACQY4L4M0=;
        b=dfFfcKB4l9xvKA5YMfWQmUuLAMY+pw3Ycogb0neydXoTJlgqCa2bJq8WCtMdyj2aN5
         H6QbHuDdAelORl82I6OW42TDFzr/wr/tOXg5BAWIQ6X2/tACunxMzqB2Li0ivQr+5PJT
         7BW/4UZoqywBWiiNvMDy9V0hX3aBJ7yGMam+iorEuMlml0fV0pxTaUwFCBD4ql+rLZL1
         QeZmOFIrjgRFNtChTAeyOSmvmllLyXIFGKjM3BV+htAeo5tV0I/3YLZzfh6Dl1e30pFD
         komHn6QcJ/QLqe0plVQPKrf9CpxmkpMMTKDAjg3ejU/Dw0JKkmBrmxqouBwqKMgY6NNh
         Tsag==
X-Gm-Message-State: AOAM533xfTyKXtiWwlyLn+V77Y1a+66GLE4m2QqzYeF02AbTajrssEoB
        Q5Y8Yyv1T+qXEvZkwaKpFJ3mBmj07WQ=
X-Google-Smtp-Source: ABdhPJwfgpV2BR8t4aLZkOMHXUhOw8u41DWYuFc0TKpk2ua8/asby494f33+AMKBrt2W09ZFdEDGyA==
X-Received: by 2002:a17:90a:a78b:: with SMTP id f11mr4608489pjq.42.1595337847865;
        Tue, 21 Jul 2020 06:24:07 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:0:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id c207sm20291090pfb.159.2020.07.21.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 06:24:07 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: af_key: pfkey_dump needs parameter validation
Date:   Tue, 21 Jul 2020 06:23:54 -0700
Message-Id: <20200721132358.966099-1-salyzyn@android.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pfkey_dump() dplen and splen can both be specified to access the
xfrm_address_t structure out of bounds in__xfrm_state_filter_match()
when it calls addr_match() with the indexes.  Return EINVAL if either
are out of range.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
Should be back ported to the stable queues because this is a out of
bounds access.

 net/key/af_key.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index b67ed3a8486c..dd2a684879de 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1849,6 +1849,13 @@ static int pfkey_dump(struct sock *sk, struct sk_buff *skb, const struct sadb_ms
 	if (ext_hdrs[SADB_X_EXT_FILTER - 1]) {
 		struct sadb_x_filter *xfilter = ext_hdrs[SADB_X_EXT_FILTER - 1];
 
+		if ((xfilter->sadb_x_filter_splen >=
+			(sizeof(xfrm_address_t) << 3)) ||
+		    (xfilter->sadb_x_filter_dplen >=
+			(sizeof(xfrm_address_t) << 3))) {
+			mutex_unlock(&pfk->dump_lock);
+			return -EINVAL;
+		}
 		filter = kmalloc(sizeof(*filter), GFP_KERNEL);
 		if (filter == NULL) {
 			mutex_unlock(&pfk->dump_lock);
-- 
2.28.0.rc0.105.gf9edc3c819-goog

