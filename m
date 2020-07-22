Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A644BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA29206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aN4DaK5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgGVLBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGVLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:01:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA029C0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:01:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so1098585pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/lw3L2a4O6r9+8ujRDSrWE8Z9WKk+Ix5MhB5UaF3Ks=;
        b=aN4DaK5g7tWRGugpRFhlfT++AV0FJ8hMycQ9kLmkaj60XmSafduW25uhNXH0KnV51F
         WX3ihi0uM/2v2OF2mQHwStLtfEVWDQvHpPNsCqPD06MeNEEi6+NW/MhFXp2fwac1p2DM
         b0o497LMfLuWrsNP00dg2El5fpfYEP3vCfrm7QrvyXqOxd2ve4KIohTc6w8zRLluvEDA
         xicNg/Eiv7fYfUHR9pymJTPTgZeHpV34XaOVFDHrRZSDyGwgUz9+nFdnLDI2woKug1F8
         6JY+KXSoAjjyJ6ZKy6MK6QmQEb6ashgCZP9qSSmRxAmAmNvckfOtkuzZVw3LKU9ti2K6
         GdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/lw3L2a4O6r9+8ujRDSrWE8Z9WKk+Ix5MhB5UaF3Ks=;
        b=TTdkWj+IUrIfvkVv+EoJoNZid5YGfO7z9vlvDKG4MIn64lNywJREZBgp8RNAcBixNC
         KGGeDxDT0YZw67VCf1U49H6chHWGEM4Q44/tE37C2JK8EENw/gF+z4LhYvDe/RYfAI99
         cuUw4FCfhyxANGbjcPHDtUo8QrarRg2UKQW4iK98mJnjySZtFRlJXErPqGVCN84qxSv6
         xrGTI49x9I+m0aDikx56NiO1CbwQpkNldxunmnXdF5peamwzOe5bWzMuNf1/nf9OPKNa
         sTThDnoSeXejCeCN34YJ4XN6gkDNzZtma1rZoEa4JxG3lfsClC1JEtTR1quTP2ES1mOM
         92og==
X-Gm-Message-State: AOAM532d/XvCAiyl0qhYkpa1/D3J9tH7OCxxMNFf0CuQ46UAxPLHlXXg
        fVYBeHSaCqupC/a1GnvoBGIKnUTPblI=
X-Google-Smtp-Source: ABdhPJxRpXIIC0VKbI6quRIEHj6Nui9ulEJ5hOugSp6d9DYf8+st0/Z1rRVcorJnkX/hgDOcMLEe1A==
X-Received: by 2002:a17:90a:f206:: with SMTP id bs6mr9533822pjb.48.1595415673141;
        Wed, 22 Jul 2020 04:01:13 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:0:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id d190sm23074673pfd.199.2020.07.22.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 04:01:12 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2] af_key: pfkey_dump needs parameter validation
Date:   Wed, 22 Jul 2020 04:00:53 -0700
Message-Id: <20200722110059.1264115-1-salyzyn@android.com>
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
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
v2: Added Fixes tag

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

