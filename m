Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C9120702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQJmNzfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405006AbgFYNZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404904AbgFYNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:25:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB4BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:25:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g7so2730398qvx.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJ3/Mq7vJPR+x6UGF9hjTyfpV3MClmGOAkmC+A8dGsw=;
        b=pQJmNzfdvlcRM9JVSyrhj/oMZG+i5rKFtQq0Qk9xomMbXD4rG2HGCs3tTvWJcyL+RN
         ZhGROVilEALNcyrN9LSGS5UdAfOqt6qLQDa+hwg1ZjTpHmo32ZeyiluZYd8456eFq9/Q
         tHQ3iuAIBpWP/6vRX46jGq8rB88Y31toNEHItwoPsnzBvp8KkrBBj8vqpm6KVdxTixEh
         bFCGJAbi7DbaOyORsDIx7TrVgkkQ7pkGj5UuXCmF989fgpDKrZSRqSE0fdZrHA1P8Gep
         UcLJVLh0WiULO1XE9yriSgaF9HadZjvra1NcPPECoadhGzSVi4pNzkMCdad8QKZQ0qsT
         kbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJ3/Mq7vJPR+x6UGF9hjTyfpV3MClmGOAkmC+A8dGsw=;
        b=Vsd5Kwfg8cxiOpxJ7bZXblUCYNP9iGq7vGAzroxh94B8MAc1Qryoj2eCreeP9hGYOF
         fU4eTfcDWhNJsRCD3rrzII81WSfAenOvp+13kvAChndYk7iymQi2+yLsA1glgdQy5rIw
         yCa5VtDBvMFqHz+MvaLyh84t/ZWmzpJj9ULTVS8pOGuznu976L9AaKDMENArPyfwdUZN
         CcQI+mP543cAlu8NSqxrNsssBxXENITF3GGoavR//5dAlRxESVKbL6OArQAFH3iZxuBx
         fM0MGvflnDbJXQiwuSeK3UVtJfMjw1NdfHNmb052AFjV8OCdIEx6Rr5PWv5cWbu5JwTC
         bETg==
X-Gm-Message-State: AOAM530HZn9uRlNq/Nw24hhwgjNqMasTrL/8lxxV2gUuTLGXjhuV6oCW
        jp1mCQEJW46OMsoDByA+IET7KFwJYM+l2Q==
X-Google-Smtp-Source: ABdhPJyCApRXjFEu8aKC07g6xSI7imbJE7s5oeq7Fsp/i/5IUsQLbIKz8y4K+ZaiWjwtdwlCv+YA7g==
X-Received: by 2002:a0c:eccd:: with SMTP id o13mr37073576qvq.49.1593091545506;
        Thu, 25 Jun 2020 06:25:45 -0700 (PDT)
Received: from mooncell.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id t35sm412107qth.79.2020.06.25.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:25:44 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH] staging: gasket: Convert symbolic permission to octal
Date:   Thu, 25 Jun 2020 09:25:13 -0400
Message-Id: <20200625132513.10805-1-brookebasile@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing checkpatch WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 drivers/staging/gasket/gasket_sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
index ab5aa351d555..eb0fd3b0490f 100644
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
 
 #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
 	{                                                                      \
-		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
+		.attr = __ATTR(_name, 0444, _show_function, NULL),	       \
 		.data.attr_type = _attr_type                                   \
 	}
 
-- 
2.27.0

