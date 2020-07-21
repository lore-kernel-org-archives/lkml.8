Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F14D20702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8rxVIvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGUOP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:15:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726120AbgGUOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595340925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=p3hi3xrdZQgrcmCmh6VAQFFWaZ++JX8czQmDuqdNFJw=;
        b=E8rxVIvXUjz1pX3hfPcOx2rLyWVHtpwqyeMfxY+kXQ++g9tkaARrx8TxqqKI/EUa5hD8dF
        uyE0C7pDekTnak6o2ZQGcm1liQvWGchYcsHcrcW0hsiRjELsBwm+ZSbDbxJaJAcXu732QD
        qeWo9Id95EGK+QSh8bO2n0KHU1Y6o8c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-6HxB9N8dPRu0gSyo9rAKdw-1; Tue, 21 Jul 2020 10:15:23 -0400
X-MC-Unique: 6HxB9N8dPRu0gSyo9rAKdw-1
Received: by mail-qk1-f197.google.com with SMTP id i3so13886404qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p3hi3xrdZQgrcmCmh6VAQFFWaZ++JX8czQmDuqdNFJw=;
        b=ZMRk1hOw3jks6gKufyEJtU2witCkjQ1GBytPInSjez0nK4nGsLtpgxIEyv/1eYmMpS
         O5bJsSZg1PBBGHl77vy++AngBj4uRczZcCgclJwaaRy83QIqmXtfSyRYFpZIIS2wQchM
         qPNhtEeU0wtkIL5zzBLaRz6dld3vVnYvS74twaELOI0UmNvONlaqkwPf03ooin0PNUJ7
         DsMt7ns3Bzb1U+1h9JwQk0xpYH9G2S95O+37K5VvXmoMAtofC8lUssOL4lVCM0ScxHgo
         gMMOd77eRmXDxoqfNcNuMEFRyErMyk7BpxSqLZwekkKgRdh5mUUKgCduKOz6ZfQV8PIF
         0Shg==
X-Gm-Message-State: AOAM532skntvqHFrAN+tqANdMDR2RxUFyVxNoBceJ7wGW5B0n3FepxmB
        1cz7TIuafkdPTtlyiAavzGGqeafhyDCRS4KPBLuHpQeTVNQ0vafUsH3UFpQIlGKRBPMxqF1l40L
        fvcCRIi3Q70Kj6FG4xQ9wRdBT
X-Received: by 2002:aed:2987:: with SMTP id o7mr29229974qtd.385.1595340923116;
        Tue, 21 Jul 2020 07:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpgbcSLCsIUUg/981LoMyBoE6jzlDFr+8f6gGViXBeoV3rMbiH7sCH6UBnDuUx0P9jhTDOgg==
X-Received: by 2002:aed:2987:: with SMTP id o7mr29229939qtd.385.1595340922836;
        Tue, 21 Jul 2020 07:15:22 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d14sm22474159qti.41.2020.07.21.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:15:22 -0700 (PDT)
From:   trix@redhat.com
To:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        marcel@holtmann.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] KEYS: remove redundant memsets
Date:   Tue, 21 Jul 2020 07:15:16 -0700
Message-Id: <20200721141516.20335-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Reviewing use of memset in keyctrl_pkey.c

keyctl_pkey_params_get prologue code to set params up

	memset(params, 0, sizeof(*params));
	params->encoding = "raw";

keyctl_pkey_params_get_2 and keyctl_pkey_query have the same
prologue and they call keyctl_pkey_params_get.

So remove the prologue from the callers.

In keyctl_pkey_params_get_2, reorder the copy_from_user
of uparams to closer to it's use to ensure that
the keyctrl_pkey_params_get is called first.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/keys/keyctl_pkey.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 931d8dfb4a7f..60b504681388 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -119,12 +119,6 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	struct kernel_pkey_query info;
 	int ret;
 
-	memset(params, 0, sizeof(*params));
-	params->encoding = "raw";
-
-	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
-		return -EFAULT;
-
 	ret = keyctl_pkey_params_get(uparams.key_id, _info, params);
 	if (ret < 0)
 		return ret;
@@ -133,6 +127,9 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
+		return -EFAULT;
+
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 	case KEYCTL_PKEY_DECRYPT:
@@ -166,8 +163,6 @@ long keyctl_pkey_query(key_serial_t id,
 	struct kernel_pkey_query res;
 	long ret;
 
-	memset(&params, 0, sizeof(params));
-
 	ret = keyctl_pkey_params_get(id, _info, &params);
 	if (ret < 0)
 		goto error;
-- 
2.18.1

