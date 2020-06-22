Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A673C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001912333B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLtcaxvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgFVF0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 01:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgFVF0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:26:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24654C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 22:26:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u128so7645486pgu.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PibIzypzYm0DSxdOFYsn66RwYSvLZcWKD346u4vPX1c=;
        b=JLtcaxvrPrQB5/Omucrl9OnBKrwOoxLl/wdiEP8MRQBJZaooI68S+2+A4cdMTuPsUO
         UHoMcJK79nbRLMSmL1uUToz5EWC3wbv2H9sBA3mPe1jt3I1E65j0/nU82g4zO8lrA8+L
         W2xbdDVz7+uoDgbnmMHuUo9aJB8ppxzee22G4ACent0fOEa99LnZ6kamrGpVAcakKaof
         ls1hDpUnRmxa771Ub8rbhyaJ/DE5I2ePJwQDT29RDFwLnFP0tlPD0jFICm9kOmJ8BvfO
         OVvNhWPwcaXbBDVe2bThvf9FAKrWnSN+0NBteT4uV3BfJOZuuF+I5F6I08TzgCaVmeO9
         kj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PibIzypzYm0DSxdOFYsn66RwYSvLZcWKD346u4vPX1c=;
        b=BSWPN02dsxYqR1uWZRYnP/QG5KXLyoQb698xJftzuUNdYqavMg0Wq+w9HdDTxhQhtt
         iy/EE5jke5/rnXTI3XjwGqCMMtXmwnhRg1psEsg0C1vg3+6HC3a31lhWEl/YksqaUdpq
         BtO1UJzSNc0nuSHv67Sp0d4vdkwQhlo2rP35FZ170XuhjRJqvbP6dIZCMiRRMALnOaqK
         X0xO6hUIL36djWfo3rzlRvk5cwEXGDtxOxNLtquq+HTiJHxwU504yeBBZnnur3aB9vTC
         81a3NvKeCOs4MWFS/rIjGxeOyubs+Fa8cSzgOlTYAIw/piockuDi6kyQF+/STqmE+7Xe
         xhAQ==
X-Gm-Message-State: AOAM530f9pXFDoZSRYJx2Owhif6fDwOA49lhwOfhhgd3L0AI/TWQPeQd
        FBUm/QZ6RuzawVKSlGd/cA/7uHrE
X-Google-Smtp-Source: ABdhPJz6qKdkGqfxGYx/Xesffl3UhLH6wRwMVW9VpG1HPKt1wcVsF7zEPirneZWDRqKqT67nTkxjsw==
X-Received: by 2002:aa7:9e50:: with SMTP id z16mr17816268pfq.118.1592803573536;
        Sun, 21 Jun 2020 22:26:13 -0700 (PDT)
Received: from ?IPv6:2601:1c0:6280:3f0::19c2? ([2601:1c0:6280:3f0::19c2])
        by smtp.gmail.com with ESMTPSA id b24sm3791922pgn.8.2020.06.21.22.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 22:26:12 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
From:   Randy Dunlap <rd.dunlab@gmail.com>
Subject: [PATCH -next] lib/test_bits: add MODULE_LICENSE()
Message-ID: <dfc74524-0789-2827-4eff-476ddab65699@gmail.com>
Date:   Sun, 21 Jun 2020 22:26:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rd.dunlap@gmail.com>

Add MODULE_LICENSE() to prevent build warning:

WARNING: modpost: missing MODULE_LICENSE() in lib/test_bits.o

Signed-off-by: Randy Dunlap <rd.dunlap@gmail.com>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_bits.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20200621.orig/lib/test_bits.c
+++ linux-next-20200621/lib/test_bits.c
@@ -71,3 +71,5 @@ static struct kunit_suite bits_test_suit
     .test_cases = bits_test_cases,
 };
 kunit_test_suite(bits_test_suite);
+
+MODULE_LICENSE("GPL");

