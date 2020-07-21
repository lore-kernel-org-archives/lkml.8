Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDA42073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vmm.dev header.i=@vmm.dev header.b="fy7L/4Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgGUQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGUQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:13:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D6C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:13:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so10467167ple.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmm.dev; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDitsdDHDoETDTxDKluPrWhU2D8DE6u8BnPSmRmrGh4=;
        b=fy7L/4Re2TIFmm12k2i3bXju6ZZlkbEA1354CbMIGv3i6xktgqXThaI1n9+yLvVeEO
         C6XotX0xy43lCHKadVKvJu6as164ENvY1aZYC+Yyk6hrIbMWtMK5qbbY/oAzlC1QJc/Q
         8TrLwbEZwu3d5Il0QNTGzHqDr1Wi7ruxTjCJbyOBHnxKClmMl1qVy2GQASFp3s9u8YP4
         VSo4vbTiSmKkp48DBE9pCIvmYDvC2JPmk5mrF9XSkbyYnR9veMcyfz8PlL4ZXKXSqov7
         yfHhV8BL0GsYeU64KxJy8smQviZ1pKkO7sM+BGXTVcqsJVnmyRO6wSLGb235TJ1J3hxc
         UCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDitsdDHDoETDTxDKluPrWhU2D8DE6u8BnPSmRmrGh4=;
        b=GGxd7rqwEeFz2iflQ8RZytXLVyDVUHNwI06D67aThunPeyADkm0dp2VYJGJgjZYLRN
         CTl3THIlfbdHb+kC4CVuZlOqR5PLzhsUbkN5ACSLUdTlLxuyJda7CJQre6jx0i4bhccW
         abloiEZctz5n0qeesNXblMfMKCp6rLu5AtaH+qmRC3HxO4U9vD89latyV7pNEaBCbn89
         h+nBjW6c55qV6N9f6bWC0CRt3EUjO3SqBUToQlmbBDDyAXJm88MmJ0IthSNfPnKyyENi
         M2NH8umySw9VF193JObdPZpOkubFqlu/FO0apImvsabHmGdzWTraQTLW7TIJ2j5Dusnr
         wVXA==
X-Gm-Message-State: AOAM532SreAgr+WdzjFFJq0SG3n0bE437xJCmBBXjfvZfK15sBXkcic0
        zr3pumcRGDCXqQKv1ziZZtj8MA==
X-Google-Smtp-Source: ABdhPJz/4Rls+u9+PMZSs3OFi3HIkImvb038W2RxX4ZvHHXgVr6fOs32UJtvHWbBcLF6bDLtkM4tvg==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11mr17341190plo.123.1595347980879;
        Tue, 21 Jul 2020 09:13:00 -0700 (PDT)
Received: from ip-172-31-28-103.ap-northeast-1.compute.internal (ec2-18-183-109-148.ap-northeast-1.compute.amazonaws.com. [18.183.109.148])
        by smtp.gmail.com with ESMTPSA id y80sm20467763pfb.165.2020.07.21.09.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:13:00 -0700 (PDT)
From:   Hayato Ohhashi <o8@vmm.dev>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Hayato Ohhashi <o8@vmm.dev>
Subject: [PATCH] x86/xen/time: set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()
Date:   Tue, 21 Jul 2020 16:12:31 +0000
Message-Id: <20200721161231.6019-1-o8@vmm.dev>
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the TSC frequency is known from the pvclock page,
the TSC frequency does not need to be recalibrated.
We can avoid recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.

Signed-off-by: Hayato Ohhashi <o8@vmm.dev>
---
 arch/x86/xen/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index c8897aad13cd..91f5b330dcc6 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -39,6 +39,7 @@ static unsigned long xen_tsc_khz(void)
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(info);
 }
 
-- 
2.23.3

