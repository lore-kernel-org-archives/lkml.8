Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17221C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCE02076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwAi6Gdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgGQTF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:05:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47754 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727978AbgGQTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595012753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QA04z49XQxRpsbQtr5ADLmijNDZoNbT33TpqwbOswEA=;
        b=QwAi6GdhyOKd5pVegToESPBTVpgfeDu0qXJFgurV5v7tw/qFfwZrXt1Dds1xDlVXbKhHVn
        hEInuVRuMa7fnBd6roCa1JKGvAh99tBzYd9mz4x5FTvByP6h1kcQ+fd2Ux3SdRnh7JY6uL
        HKcRpC6GMQ9Nml9/MUvk+e1mofF2NjA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-3gQw-uaoM3W0qwUX7qEACw-1; Fri, 17 Jul 2020 15:05:52 -0400
X-MC-Unique: 3gQw-uaoM3W0qwUX7qEACw-1
Received: by mail-ej1-f69.google.com with SMTP id h26so6359286ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QA04z49XQxRpsbQtr5ADLmijNDZoNbT33TpqwbOswEA=;
        b=PYg5x/PjZJKTaQg2Fy3sZo8W5P8GLO2m1e4wYUNeXaVTDJc6JxBRayTIKYmvyNKT5n
         i3NTlpr8sTflQtBVDjbRtOho8f8oBK6rY6/XM5TpfOsPhaArhjJ6s6Ok2EA7n7tbWdEz
         cmdjxOTMDTonH7M/wR7Hel75skZiHZ4ENcva+x1kNdu7ntcoR+20koLUUuLv9dz8Bnkv
         /Z5Spuai7NEa/vptY1VxAOg+/qX61DlUc3UT9+PEPLXXv26bJv+VycWs346ZdufXiHtz
         wVd7tFXEm5TcEcfDIH42X8o+sfVHSimbUS6UvtYelq7a7JL5Vxcwz3T/5qEGN6kI0sST
         slKA==
X-Gm-Message-State: AOAM5337P3smJUtQi0zJRzGS0642WkWU3vghREqoCZiBBBJmCtFvkLt/
        tfJPeLv0lecSVsxNJh2RYHspAmUNMCvXGLZmKCTbWLeMLEirxBVNNDgbyjPHpbL2iFY2os1wr6R
        UpEOoOc9/PtrrxnGwI9sQtsWy
X-Received: by 2002:a17:906:a449:: with SMTP id cb9mr9659944ejb.115.1595012750737;
        Fri, 17 Jul 2020 12:05:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxawMnEihhU00mwwY2KMXzPnp583S5oS9vU4nqqnr6E/4WlXYRDH2z1ZDUEgvDfZKxqw/acwg==
X-Received: by 2002:a17:906:a449:: with SMTP id cb9mr9659924ejb.115.1595012750517;
        Fri, 17 Jul 2020 12:05:50 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:482c:9537:40:83ba])
        by smtp.gmail.com with ESMTPSA id 92sm9030732edg.78.2020.07.17.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:05:49 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-acpi@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lyude Paul <lyude@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics laptops
Date:   Fri, 17 Jul 2020 21:05:47 +0200
Message-Id: <20200717190547.648604-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to figure out what systems are actually affected and right now I
don't see a good way of removing those...

But I'd like to see thos getting removed and drivers fixed instead (which
happened at least for nouveau).

And as mentioned before, I prefer people working on fixing issues instead
of spending time to add firmware level workarounds which are hard to know
to which systems they apply to, hard to remove and basically a big huge
pain to work with.
In the end I have no idea how to even figure out what systems are affected
and which not by this, so I have no idea how to even verify we can safely
remove this (which just means those are impossible to remove unless we risk
breaking systems, which again makes those supper annoying to deal with).

Also from the comments it's hard to get what those bits really do. Are they
just preventing runtime pm or do the devices are powered down when booting?
I am sure it's the former, still...

Please, don't do this again.

For now, those workaround prevent power savings on systems those workaround
applies to, which might be any so those should get removed asap and if
new issues arrise removing those please do a proper bug report and we can
look into it and come up with a proper fix (and keep this patch out until
we resolve all of those).

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
CC: Lyude Paul <lyude@redhat.com>
CC: linux-kernel@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: nouveau@lists.freedesktop.org
---
 drivers/acpi/osi.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 9f68538091384..d4405e1ca9b97 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
-	/*
-	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
-	 * cards as RTD3 is not supported by drivers now.  Systems with NVidia
-	 * cards will hang without RTD3 disabled.
-	 *
-	 * Once NVidia drivers officially support RTD3, this _OSI strings can
-	 * be removed if both new and old graphics cards are supported.
-	 */
-	{"Linux-Dell-Video", true},
-	/*
-	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
-	 * audio device which is turned off for power-saving in Windows OS.
-	 * This power management feature observed on some Lenovo Thinkpad
-	 * systems which will not be able to output audio via HDMI without
-	 * a BIOS workaround.
-	 */
-	{"Linux-Lenovo-NV-HDMI-Audio", true},
-	/*
-	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
-	 * output video directly to external monitors on HP Inc. mobile
-	 * workstations as Nvidia and AMD VGA drivers provide limited
-	 * hybrid graphics supports.
-	 */
-	{"Linux-HPI-Hybrid-Graphics", true},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-- 
2.26.2

