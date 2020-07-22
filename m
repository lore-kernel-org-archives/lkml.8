Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB7DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778C02064C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvGgedDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgGVNqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:46:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732639AbgGVNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595425580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LoVB2XkV/JmhdiMIi0eaHtAvVvJ9iBBJWs8+jEnq95c=;
        b=TvGgedDOacKeexhXymoKk5NCekvnSO1pxj30YTEOD6lPwH5tGOU+5OHeQBKGxRN9UP6wcZ
        O5FEMhnATlmxn9L9jGJuO7EXI3h4kw/jrgjNks9m10XKOCb8nkjdCrJeUn8NqEsxtUpHFq
        Ai9Ht8IQ/DOWeTxPIt7c/kETrb347R0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Tp0_8Cp0MMCu388gSIIg9Q-1; Wed, 22 Jul 2020 09:46:16 -0400
X-MC-Unique: Tp0_8Cp0MMCu388gSIIg9Q-1
Received: by mail-qv1-f72.google.com with SMTP id s2so1448162qvn.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LoVB2XkV/JmhdiMIi0eaHtAvVvJ9iBBJWs8+jEnq95c=;
        b=kqBF/jDpUDoQ7rgfBsXlYSIUnHdX8xXlyNZF5tFUjclH3Cs86fetuTeVBY/9B8+nk7
         SOYlXTsOaM4Zfk8EOmb13M6TUd+RO7t8piEfET6pHIJXOA8uDZam0eCH+vTvbyx9ifcq
         oDISO2gflWykeART2mZ9i1XX6vzqEWAMT5BFyguUvOhVYZrRq3gX4Dr0DVuyHqgxi8Ep
         VCRhYbQNTEPhA+V015bUrRTHEXe7PraMnx/qwLP6jXh8kzsR3PIsJQgo5B5iJ+pIUCfh
         wBQg47HNMEygWNU2+8ohD/KaoVqEPMllpTtN1D99ae0c9ui8Emgq/EN/geowDegbKcZR
         FKTQ==
X-Gm-Message-State: AOAM530FndBTOy09Z5VFf21dUV7f+Cnhu/55mqABTW0ezxnBZ8BMw6yS
        dN97WFqKhvuOkxuL6oZLhmFQg2G41Sk2xMAcmdEH/HW+4qTgzjL61QLLF3nJmGM3nb/o6NjijEC
        Xcj5IPjFUSRb54aMPZ/hDzFm/
X-Received: by 2002:ac8:32b8:: with SMTP id z53mr33969613qta.273.1595425576162;
        Wed, 22 Jul 2020 06:46:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfMEnBBaM6DsbbxBJ4uPRNyr603IgCTG7siQlW6XbNWY2+gJiK+tOAp3D+vg0UJYKefzEXRQ==
X-Received: by 2002:ac8:32b8:: with SMTP id z53mr33969597qta.273.1595425575967;
        Wed, 22 Jul 2020 06:46:15 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w28sm4803247qkw.92.2020.07.22.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 06:46:15 -0700 (PDT)
From:   trix@redhat.com
To:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        marcel@holtmann.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] KEYS: remove redundant memset
Date:   Wed, 22 Jul 2020 06:46:10 -0700
Message-Id: <20200722134610.31947-1-trix@redhat.com>
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

keyctl_pkey_query has the same prologue
and calls keyctl_pkey_params_get.

So remove the prologue.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")

Signed-off-by: Tom Rix <trix@redhat.com>
---
v1: remove change to keyctl_pkey_params_get_2

 security/keys/keyctl_pkey.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 931d8dfb4a7f..5de0d599a274 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -166,8 +166,6 @@ long keyctl_pkey_query(key_serial_t id,
 	struct kernel_pkey_query res;
 	long ret;
 
-	memset(&params, 0, sizeof(params));
-
 	ret = keyctl_pkey_params_get(id, _info, &params);
 	if (ret < 0)
 		goto error;
-- 
2.18.1

