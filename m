Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11532C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCDA2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMCV0kwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA1ByW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:54:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46666 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA1ByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:54:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so4446832pll.13;
        Mon, 27 Jan 2020 17:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1ZMMwelLf0A5wvuZj2x68zePfxAq2fUXhD1Zlvefv7Y=;
        b=IMCV0kwEhLFtqutPkJoXbViyl3w7xBFWsjPH9LRk1eSZEDxFU+qs04YB1NuSl1GJY4
         OqExxvsOXGJO53LAWvbkaDdFYzUDDL8Q+X+/v+oSWVN8xHwG8Sr2amcUUIqLPxgte1uS
         wqpEUn2XG7Hh2mzFMC5TUonmyjgSuROS8yaTYlkQ0PakyV5iMft6t6F984i9sg6l3UKB
         n4FycKWpp1tCgK9Oh7cJMoAsJbvPQJDsDv4IZPtdLF6+3/8ceNI1MpkhSsI60El2Fipq
         jIKaOevJAk1CL1fOgHV7Q5CyhOfoDtrp7oAc1qn3y/doQ6JYx5UO1G+AIIUET+FDPB7+
         n+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ZMMwelLf0A5wvuZj2x68zePfxAq2fUXhD1Zlvefv7Y=;
        b=cxhxIkLroE+tQYAjIzQJWUh4rQT3fzfHgcw5k5dmkfdZwvAUC4eDCPioMEWYksno6w
         E253efisCcBYOAoc1Hx9VkDPO2KVsJHC7x/f8WjduNWZyp2MACiUlpo7oWbDwirtH/Rv
         GWbR5u6EjRJngLVb30uC7lS/kT59b38hkTo+iiwTtYeFhHRGGJv4CsjzoWYDxv1b7QH+
         GmjZO4Y4fEH70KMhkFC7SA2nvrixrQGrpwp8kuk2ZO5QoWE/C8TAQ5HUqfIzK/X6f63L
         yTPF14a3u8zaOXZyNavvMdTv6P7FSyUNdCjeJc2s6VK9KqiBjyTQL6Op/jpOt+BHRxRh
         AdIw==
X-Gm-Message-State: APjAAAX/PuuEPscJf/9tyUjHqXAZGUTGdJ8bdQsGSeEMI1/N4i2Llu2X
        ocMcgOVIPTocz8KD1XKOncoc45rD
X-Google-Smtp-Source: APXvYqzSCLsgdu+thMaqEiaZLIgj4vYPC2rYGh4W/mehpz0fI9OBBI2eSwUmj0peH72azDJW1dMcQQ==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr20998616ply.303.1580176461737;
        Mon, 27 Jan 2020 17:54:21 -0800 (PST)
Received: from localhost.localdomain ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id j17sm17393234pfa.28.2020.01.27.17.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 17:54:21 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-vger@kernel.org
Cc:     stable@vger.kernel.org, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, sashal@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable-4.9] Documentation: Document arm64 kpti control
Date:   Mon, 27 Jan 2020 17:54:14 -0800
Message-Id: <20200128015415.2276-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

commit de19055564c8f8f9d366f8db3395836da0b2176c upstream

For a while Arm64 has been capable of force enabling
or disabling the kpti mitigations. Lets make sure the
documentation reflects that.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
[florian: patch the correct file]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1bc12619bedd..b2d2f4539a3f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1965,6 +1965,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			kmemcheck=2 (one-shot mode)
 			Default: 2 (one-shot mode)
 
+	kpti=		[ARM64] Control page table isolation of user
+			and kernel address spaces.
+			Default: enabled on cores which need mitigation.
+			0: force disabled
+			1: force enabled
+
 	kstack=N	[X86] Print N words from the kernel stack
 			in oops dumps.
 
-- 
2.17.1

