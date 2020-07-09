Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B502206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9qCUAoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIFOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIFOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:14:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0300DC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 22:14:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so572341pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AJEVZrrvjIfn5YUzdpUMzevksrWHyxA6xbb26wGqyOo=;
        b=X9qCUAoHrOV6HeIp+2+rp+HaqkAFkgbVspzAMoxgQ2Ja9uH4hZLyRNIfPB2SJ57Xx8
         5BSCDd3qlVb/QWaC46gc8zsDSi+im/P9f3yW+sKXg1G5YJJNvEIcKmq1uJNc/vUwvJkg
         UJIGTRJ2vpcYctQpZNiwWR/Ok2z54kcjOejnIU6ZP16q2pKQkBO5HGCDvqBWJWAdPoKv
         V+2iIJCB5+rmmW0qyWLMng3u8joNjpeH4/A0EArWNDsnaSqit/V1vCCOGE32+ld2e8Sc
         I+aUtkGrf483fSnw2UgJpybO/GbDgef7xtK+/QITVUJHg+v7rn+VYdeCtfgV68xR3dzB
         uCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AJEVZrrvjIfn5YUzdpUMzevksrWHyxA6xbb26wGqyOo=;
        b=oDf5Qv4jb0wI6j9MM/Hx9264oCcNvrpg7KxfjKA+PCs2Cn2p5KInTy3qZ2bY+705Hc
         3CJ+lTUJTMWstWudkLZNHX0z45SxiX34zYI/fRzAdYybWg7lBXT07Vw2uzcQ+8EWnUX6
         vYim10get3/t5La+VafstmVKKG3EJGWs9tC+i7Vv6UTD59xnatKrR54kIp6nFfDi4M/w
         MTkOswKNgTjcf/Q7XoyMXuOHs0rZenRCYiehVNhuzkEEKr4FxBpZIiwEGW8KL85/5Y5c
         MsaK9cwU+EZNrwsyxBesIOyopLtOJO4utdllcZo1yf0+wv8RofVZ0a7+f24dPVbSMGcR
         y9sw==
X-Gm-Message-State: AOAM5316sZDtEtAr1ivTYgmmqZPAKkrk7avYFLBwngXfDbhClZKE+X9o
        C9hV0ClGNZFaokqI0N9Ldowdaqbm
X-Google-Smtp-Source: ABdhPJwx6qFRUmTfSv+8Ok14MN5s3FWtmwSnG7th4B45orGla5K/eSE2WBX+TWUdAhTjbbKvSobw3g==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr13033913pju.65.1594271644832;
        Wed, 08 Jul 2020 22:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:67:5b9:5dec:e971:4cde:a128])
        by smtp.gmail.com with ESMTPSA id y17sm1292412pfe.30.2020.07.08.22.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 22:14:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>
Subject: [PATCH] arm64: Add missing sentinel to erratum_1463225
Date:   Wed,  8 Jul 2020 22:13:40 -0700
Message-Id: <20200709051345.14544-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the erratum_1463225 array was introduced a sentinel at the end was
missing thus causing a KASAN: global-out-of-bounds in
is_affected_midr_range_list on arm64 error.

Link: https://lore.kernel.org/linux-arm-kernel/CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com/
Fixes: a9e821b89daa ("arm64: Add KRYO4XX gold CPU cores to erratum list 1463225 and 1418040")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/cpu_errata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8e302dc093d0..79728bfb5351 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -782,6 +782,7 @@ static const struct midr_range erratum_1463225[] = {
 	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 1),
 	/* Kryo4xx Gold (rcpe to rfpf) => (r0p0 to r3p1) */
 	MIDR_RANGE(MIDR_QCOM_KRYO_4XX_GOLD, 0xc, 0xe, 0xf, 0xf),
+	{},
 };
 #endif
 
-- 
2.17.1

