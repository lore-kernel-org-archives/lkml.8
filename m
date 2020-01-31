Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB7C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AE02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lambdal-com.20150623.gappssmtp.com header.i=@lambdal-com.20150623.gappssmtp.com header.b="nVuYxSxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgAaAs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:48:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43372 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgAaAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:48:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so4974900oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UI9RvEusB3HLfppx2RaXwK+iQOqvj0WIhvfkjhSoerE=;
        b=nVuYxSxbh52JB/1tWFlYffvuDUzOy8l3a21exXspge4sh5dS1nEnrryOfPrtsOw41h
         oErWaN/asr2Ouh0c0ot61VLXWm0LEgNiGUF2SkCYjda4vRcNwT0Za47yg4P5vQJeiAFY
         vPbeA8ocXqVkuRk6No/kYOkryokDgULyNdXT8X9CfXA9webzRc9E23LW/6Cm1afu3tWg
         gQIxc8CUBGUUaa8owxsLA58hA3ctgaJnmeAPT4xwMVUtOD2xG+/jo6k5wE48PqYNc3EM
         SHSrXRI87dJPnZSUX6nVLHIGldrBMQ66O9PxH+Z+gDZ7Pv8y2vpfi34gdANOmabon6Do
         v7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UI9RvEusB3HLfppx2RaXwK+iQOqvj0WIhvfkjhSoerE=;
        b=iGyhBESaevQPxyqEdCqew43Z8ChUVwgQAYCNT1JjhH1ilcDy8Gly0PQs20M7fwOPx8
         q2DUwHrx/KFkd8queU2bTh0jNPcA/pXfBoMd9VYrX/iSkAACW5sFRvbjKo9AYpI2NwLg
         jb9/px9WY8X243si9KFMTHqKu/5De+iEZg7+i5xHLZmeHo26lArGpBNnaBvHPCI5kYne
         wovbit+LhA16R2/iEC09llPT63B1OF1g8kEu6nAjfQZ9ZJ+7OrzmRCVmAUnfwQiWg9Kc
         TKU4aennFN/JEOoqzPAh0GDOaORQTuIhyMyo7IbQb0vIdOk7vOxzNxviLWgDZNewrFzq
         vNqA==
X-Gm-Message-State: APjAAAXtxP/VcCIbeQtZ1ExLhQolhSu/MCgA8ffJE7I6s6L5fn4eLjeI
        KGwFmeKj99b9JiOznzGgV6nwWSC6NYQ=
X-Google-Smtp-Source: APXvYqz/eoLk/PsAxTNemT6ablOf/vbwAoHD3A7/9a8jwC76YUjo7peKVXACI2fRd0VuFMbsJD2Mpg==
X-Received: by 2002:a9d:7590:: with SMTP id s16mr5351535otk.89.1580431707637;
        Thu, 30 Jan 2020 16:48:27 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id s26sm2432673otk.43.2020.01.30.16.48.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 16:48:27 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id d62so5569555oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:48:27 -0800 (PST)
X-Received: by 2002:aca:d610:: with SMTP id n16mr4791098oig.108.1580431706938;
 Thu, 30 Jan 2020 16:48:26 -0800 (PST)
MIME-Version: 1.0
From:   Steven Clarkson <sc@lambdal.com>
Date:   Thu, 30 Jan 2020 16:48:16 -0800
X-Gmail-Original-Message-ID: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
Message-ID: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
Subject: [PATCH] x86/boot: Handle malformed SRAT tables during early ACPI parsing
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Cc:     Steven Clarkson <sc@lambdal.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break an infinite loop when early parsing SRAT caused by a subtable with
zero length. Known to affect the ASUS WS X299 SAGE motherboard with
firmware version 1201, which has a large block of zeros in its SRAT table.
The kernel could boot successfully on this board/firmware prior to the
introduction of early parsing this table.

Fixes: 02a3e3cdb7f1 ("x86/boot: Parse SRAT table and count immovable
memory regions")
Signed-off-by: Steven Clarkson <sc@lambdal.com>
---
 arch/x86/boot/compressed/acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 25019d42ae93..1a4479c5edfc 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -394,6 +394,12 @@ int count_immovable_mem_regions(void)

        while (table + sizeof(struct acpi_subtable_header) < table_end) {
                sub_table = (struct acpi_subtable_header *)table;
+
+               if (!sub_table->length) {
+                       debug_putstr("Invalid zero length SRAT subtable.\n");
+                       break;
+               }
+
                if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
                        struct acpi_srat_mem_affinity *ma;

-- 
2.17.1
