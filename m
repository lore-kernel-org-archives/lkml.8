Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17008C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA7920774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXhmlUEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHNR25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgHNR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:45 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE2C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:45 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id c186so3411540wmd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pcjdii+vI+eVQZmrwdTthlIVK/0Kn69OYG7nvUYx2MA=;
        b=TXhmlUEHDRckSGvHoUR2RSs3GBYIjhjy7m4nTmMXexkRfXA10vAJF6k5mECttOVnch
         kWUNho/tQga+95V9quRaVvU2VA8tG+7jMFVkGyUBQY9IyzZa75akJ7KpZlkAAfAlJYGy
         9JReDVTXFMsstYkUaHpGqABQvdI3wJJVIJ0ANXr3yySqFVvp2DHUWCY/Hu7wfxbjH4iN
         jGJOjRzFpPTo0QeOKwthIK7eGCPn3KUf7vr2zk0qvprLlMAEba02C65//Gs6IkzaUUtj
         UA7PrI3d/hYvXOSbHNATESa3jeaLrMwpkIfmvpzy3TzaNjRNMnkjbCDxMssa59fC/pMj
         vfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pcjdii+vI+eVQZmrwdTthlIVK/0Kn69OYG7nvUYx2MA=;
        b=aqHXTuSaFGPL0Avs0gSP5x5w2c+F4it4yl/VHtAkoe1/hnlEz+WwzADjhS70VHaOIn
         bfAC11aIBk5UtV+TQ9gy/OkXBxeFkwVc2hi2+bSyjTTNbwpwDZsSeMuoUR9NauiswSyW
         1RyEkEw1zEHy/J1SWhkSpRM6qaCXhA8Y1HZ4RTT8dsf2Qa8ii0eLAnpWq04cnrVdhPdh
         CgNXd0j41Ca0OUJkyAwM+tGPLAXytlMvSN3iUqJVF4yARSN0A6T4c2PzlKJk/FQ0Cbxw
         AOae/fiKH/GtQUB3dcMoX1nezxT05AENLOmGqrgc8UosVGPE/+83K02iuInLJZvbC0fT
         Eqew==
X-Gm-Message-State: AOAM5304JINsFVPRakNRDiDFsVlPGyDRfJAzpCZ9uoYe79mvSEFmBV/N
        U0sGW/8g47AETdIfR45bB2nBYAdRs3XKrhbw
X-Google-Smtp-Source: ABdhPJwGtKOUaM9cDXGccXYrlTX/mHgBIiWRUSJFoL3akBtuqei2t6t2Xj/3Q/TY5PmNwmQ5jMza6h7dr+dQTGY+
X-Received: by 2002:a1c:6083:: with SMTP id u125mr3397670wmb.161.1597426123818;
 Fri, 14 Aug 2020 10:28:43 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:16 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <8cea9310fa8d55775ec137e5df4d8bb654bc24fe.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 34/35] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN is now ready, enable the configuration option.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 70a7880d5145..0d95d8391d0f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -131,6 +131,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.28.0.220.ged08abb693-goog

