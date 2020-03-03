Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22411C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB93D215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4m4K8Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCCGwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:52:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44320 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgCCGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:52:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so961266pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 22:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uN72wLEDvwlBRCICos4EhVBwO6gbBBFN6vJE7pQ2WOk=;
        b=U4m4K8Iw9bAuO9WWHp0Vg4j6awd+MPpCjS5FDUij+lsMesZjNwYVKd+uBjUY5Xthr4
         yJ5Qhnaea6ekz/F4NKU+Ale+QxqkMBfhPIx8jE9T8RHAQGyzuKwmN2UELjS/XLkvdDte
         KNSkv6CRGZzDNtyRbSeQzSKIuld+rKYqn1Jxl8UjSuryBRkeVrjazEv9Fem+HAxm749E
         UKerqe643Q2ZNkLwlys/Pm2FEV02u3Kl07ei/fz6neug80g3RjLZB6X9lQHThuiA9cxJ
         UWb2ywKq8VgElp7eIklsDq9fvs0IwXRbFMSBEzcrRUXMX54GvQzJjvh9w6SVFZcesrhO
         9TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uN72wLEDvwlBRCICos4EhVBwO6gbBBFN6vJE7pQ2WOk=;
        b=cSpMLfYjCCVEpUS0rh2FLHnmfdggTAFOaZfUDzxWS78kgDGC6vbhKFltmdVzG5GwFo
         FKNIE1qbvayTGjKOh7jyPbClHt0rJ576skGDKyqA/A5U9CbB2tZ9rpRQkH84yk1YuFqG
         I6ZUgpwOp1AKTU+U8UGBGZttDraqB6/1ee/1jx79qMPiQw5ZPvw4ImUCNXOa62u3IpYM
         os8gv3KsdJKNNSg8ALE2WVfU1U0mDQSSl35vIceHEak3QmRzUz62pDUWo0ZvFdIB/YDb
         nIDjriLkBKIFtloOZ1Em4tbUohipoKCnRuuu/hs5fijcQAHyA8GNTSTa5c1SXLuC6Kq7
         2n6Q==
X-Gm-Message-State: ANhLgQ0kCCpoM6AT1j/xbxJFwlQjGi0+suhNqPxi5sv8rCK28FGrdONW
        +k3Y5HjYUJaNBF2iMQ99+PIHg/qe
X-Google-Smtp-Source: ADFU+vv8HFhSmpiZrdShaIugSli7Bo77oMZ2MWH1IxWfg2RFVazBtza9QrsYyp1tKhjQJNk7PU1osA==
X-Received: by 2002:a62:c144:: with SMTP id i65mr1718852pfg.260.1583218372707;
        Mon, 02 Mar 2020 22:52:52 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id t11sm22780754pgi.15.2020.03.02.22.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:52:52 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        zhenzhong.duan@gmail.com, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/2] x86/boot/KASLR: Fix unused variable warning
Date:   Tue,  3 Mar 2020 14:52:10 +0800
Message-Id: <20200303065210.1279-3-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303065210.1279-1-zhenzhong.duan@gmail.com>
References: <20200303065210.1279-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
If any of the two macros is undefined, below warning triggers during
build, fix it by moving 'i' in the guard.

arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]

Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..62bc46684581 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -695,7 +695,6 @@ static bool process_mem_region(struct mem_vector *region,
 			       unsigned long long minimum,
 			       unsigned long long image_size)
 {
-	int i;
 	/*
 	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
 	 * use @region directly.
@@ -711,6 +710,7 @@ static bool process_mem_region(struct mem_vector *region,
 	}
 
 #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
+	int i;
 	/*
 	 * If immovable memory found, filter the intersection between
 	 * immovable memory and @region.
-- 
2.17.1

