Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112962076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGSPlVHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgFAXSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFAXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:18:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798CCC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 16:18:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f16so2921988ybp.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m13wCjxvuAss7NYvH083DUgqdGzlzjUJaqo6EGXo6l8=;
        b=hGSPlVHMPFqP8l1gdyaycFTDNYeJq+dmve4OcRx0o+NeFXjZUheZXksaQ3egykT3/V
         y3TrMe5GShycYHLIG9qR1qiVRi7FAG/jm43g8+Ud2xrrKhyEfB4RKkxmvPirR5YEKEDZ
         ZETulQIHcmg24tf9rxwGMM7FbhCEyAx78T7pYUbp+woYvGe0RFIl3qSPbmvVSpXfKVCc
         Tghecr2RnKGgHCBnF88MYyD2bMpevoM/xqi5YP+CqERPdo96+ROU7B14cSkX/GKFXAC/
         06Xdutj2ar9pRf2+dnMQTRlul7bsHDMZ7dWvbohS19s78wWY/19IxeUhRQTS4s5V5a2s
         pn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m13wCjxvuAss7NYvH083DUgqdGzlzjUJaqo6EGXo6l8=;
        b=kPvO6Frax3UHYN+gQDsKerUtDFUq1YIZmwLGClr6Wg4NWnsjpB2N8K59LYDJ8YeMEO
         TDjxUMjTllHCV5Ns8qbHX9SdbvlABegn1NLBhskPFarv5Yc4MDn4FfLI0E8MHyxHyyBu
         dOXikERQiTPn/4iSHlsK3bO7zkrO7BhKVZERRK1Raii8aRtpqNHSmI0CWA//i/D3xnZj
         w/cYY6/NDUFXLk2cQJIzpMBTYYiKz/axEMlapsFds+ZVVYBFHVdYLKDdSDtrmSlkLiC6
         +ReL1BORnocdapRrtgjgH6ElcFkss9rTdQlEv8Gv0rwE9Nwm+umwGC6qhrRTDaj5CuSH
         hufQ==
X-Gm-Message-State: AOAM532OlPmeQ2vQc+eDmIElAGEj8m5drGU+TmSrfMnI5fUmQreS2t70
        NjxlyAaBEnMe81dych2sSO42s9zIDMYD2tBzyAU=
X-Google-Smtp-Source: ABdhPJwdKP/WIyb9zDhrdkpb/1aIfGh8Qv+dbXIL0nNPDlwjoNFg5jPiVanp/p5l0pHmiW9OMy1EYfxKlHO/6B0TWDI=
X-Received: by 2002:a25:d28d:: with SMTP id j135mr34423503ybg.208.1591053497544;
 Mon, 01 Jun 2020 16:18:17 -0700 (PDT)
Date:   Mon,  1 Jun 2020 16:18:05 -0700
In-Reply-To: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
Message-Id: <20200601231805.207441-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, dvyukov@google.com,
        glider@google.com, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        ndesaulniers@google.com, pcc@google.com, rjw@rjwysocki.net,
        will@kernel.org, stable@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will reported UBSAN warnings:
UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6

Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
can avoid this by using the compiler builtin, __builtin_offsetof.

The non-kernel runtime of UBSAN would print:
runtime error: member access within null pointer of type
for this macro.

Link: https://lore.kernel.org/lkml/20200521100952.GA5360@willie-the-truck/
Cc: stable@vger.kernel.org
Reported-by: Will Deacon <will@kernel.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4defed58ea33..04359c70b198 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -508,7 +508,7 @@ typedef u64 acpi_integer;
 
 #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
-#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
+#define ACPI_OFFSET(d, f)               __builtin_offsetof(d, f)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
-- 
2.27.0.rc2.251.g90737beb825-goog

