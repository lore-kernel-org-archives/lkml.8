Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F251C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FF32076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XH/o0H7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgEOK7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgEOK67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:58:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC5AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:58:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so2180048wmu.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0WmKLG9AhFHe1sx7/xWBbs910NkW2ou4PIf9/zvdZk=;
        b=XH/o0H7oM78CWsMava6ImC+pDI6hF6ua9+7a+QgMxesqt0yvnk3qtmKK2Kdbnpgwn5
         syN/+CbKjm6nWhTD4kIjUoLCKKDl0DlXsbkO5IvT0Ng63b17fu0k70ArZyIFneeBaLRz
         raNSACI6WrwfkYHp+NLgayYvdjKyhhOPIG/9EnB9PD4u3xxQQz7jOb2yARtaUaugtPMx
         f2om0EoHE2cV01n/1IlqoPq1I3NpnCfjdh4Irg94n2vsLyaQthwX7TH58GQap8aIibHq
         HX/YAdJj4EJ54cR/YtNxaqTu/khLe/vqabq3I08duZ21GmKhMeAnn0qbb3oOZpPG1tZJ
         FCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0WmKLG9AhFHe1sx7/xWBbs910NkW2ou4PIf9/zvdZk=;
        b=Of+9NH+TZQU6RfGp5N0PZOsW6bFMUDJt1PjvzNWM6adQN02VlA3CXv2eSEMfPSWWww
         NX/m6TlqV1ZAdmJ7eJAb5Y07AbWY2WRC7uubiLNqA5CjbO/zsNWDUlYZBFC+BYRrhyDk
         lit4spbTXSYuox6X9Os/s2gGdo8cYwujFuW7yin1Pl7EQfCbHODJluFyFbEa5Z2qAUae
         p5Jcmp8sTLHE/79QQACgdQPPWJ3pkTlW24VXHvlnlR7yHnFlkkvKjaU1fIwWpL2Bi51P
         aPnsMOzW/824CnF+KNDKNzn75810SnNVk1ffDpchklVsNz0MoJhXx5SQAWa6Na218ZWR
         7cQQ==
X-Gm-Message-State: AOAM531gZATlcsbDLRvQVMrK6d/73J5cftNt5fsPb5hD2MiAN6WVMAvs
        3/22+cdSzs3v3KkzRpml/+Ijg7BnSEM=
X-Google-Smtp-Source: ABdhPJyFi+//KaD2VusD1LXgNbdSGbxHqdar1dGWec/TaEPF0FrbkPG38tGqXW8/K5EnBa5mk9BeqA==
X-Received: by 2002:a7b:ca53:: with SMTP id m19mr3574570wml.182.1589540335813;
        Fri, 15 May 2020 03:58:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id x184sm3090403wmg.38.2020.05.15.03.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:58:55 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 01/14] arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
Date:   Fri, 15 May 2020 11:58:28 +0100
Message-Id: <20200515105841.73532-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__hyp_call_panic_nvhe contains inline assembly which did not declare
its dependency on the __hyp_panic_string symbol.

The static-declared string has previously been kept alive because of a use in
__hyp_call_panic_vhe. Fix this in preparation for separating the source files
between VHE and nVHE when the two users land in two different compilation
units. The static variable otherwise gets dropped when compiling the nVHE
source file, causing an undefined symbol linker error later.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 8a1e81a400e0..7a7c08029d81 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -836,7 +836,7 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
 	 * making sure it is a kernel address and not a PC-relative
 	 * reference.
 	 */
-	asm volatile("ldr %0, =__hyp_panic_string" : "=r" (str_va));
+	asm volatile("ldr %0, =%1" : "=r" (str_va) : "S" (__hyp_panic_string));
 
 	__hyp_do_panic(str_va,
 		       spsr, elr,
-- 
2.26.2

