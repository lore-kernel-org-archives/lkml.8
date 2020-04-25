Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC12C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E708920728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsECK1eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDYUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:06:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA7C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 13:06:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so6593672pfb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Yi/ozrfc604dzxpf91P4J2wRSTlttwW7lfA1hd4cFTE=;
        b=SsECK1eVuUNextrEQetrXjz9EpduMcFbAimU+HmtD2sL+l/+bvBG04WFOnBOb9unML
         ezWfjJEO0Uq2lxKKyOI1UOKzOgM/SCzIAypBtCD9GW3Q1SYrxIL/pIpPHhfVxqozyv5f
         IsZ97Fns4kLtB5glykKAHb3mM+pvZqu5Vk84xLlFSM+oUnnL64CrkOfwoEllSjn59OHK
         Nf9qdEkaBNhG8G0hWIdm7MZ7CmgF05r/7PLu3reagvDpaYNWDZZVeFVbjwaVlXbmyMAJ
         w+DFHMmhrHsHUoEQ9OVxCHEADQbTil9HQkE6q6P+fVpL0gu49A02u+MgNijmc6UPyLEr
         o5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Yi/ozrfc604dzxpf91P4J2wRSTlttwW7lfA1hd4cFTE=;
        b=JdvukedIGOyvzKfjhDsqIGJayBJVHU5ZR4waX3/Lh4MziBFXHCC64VTA47M6RTpKb5
         mn1V2FGxyDofTFxBjC54zZweWJVjP3k0omUKo11tJRF11bddyHUKtOLt6TSAbj3o4zA6
         rShpyb8JKBbSX+INqiNR8WbVuGtT2qdmixisk0AIfYPSaVAlkao+BPVI7dHQeTOgpeGZ
         eheUJTv1DNfwlOGQVPALbv+qyysy81K9WlFY0V6zDFen3Rp4R+w8+Vtw46nu0cO+AGxk
         ykTPH+grYekkr3uDKcdS3gSohbG+pCKD9zJqthHCqJ/7xPZQigNoUmyAe/jkSetJdlOa
         cOow==
X-Gm-Message-State: AGi0PuYxxHdT+V5xZJVyrFCEnZPji0NrmB/9qO4qgAfdr0O3OM+/pEJo
        9c6jMdr05QRmPhHy+ViFpe4=
X-Google-Smtp-Source: APiQypJ8FDoYYt7ZyHwQ6GTdV0rrFUlx58vnsSX767Pd2Q/SJPTTDHbKFZSTrBjTeZchWm7m7LzAWA==
X-Received: by 2002:a63:e643:: with SMTP id p3mr1098891pgj.332.1587845164896;
        Sat, 25 Apr 2020 13:06:04 -0700 (PDT)
Received: from cslab.localdomain (c-73-222-199-61.hsd1.ca.comcast.net. [73.222.199.61])
        by smtp.gmail.com with ESMTPSA id x63sm8857763pfc.56.2020.04.25.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 13:06:03 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:06:41 -0700
From:   Hill Ma <maahiuzeon@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/reboot/quirks: Add MacBook6,1 reboot quirk
Message-ID: <20200425200641.GA1554@cslab.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MacBook6,1 reboot would hang unless parameter reboot=pci is added.
This makes it automatic.

Same as https://lkml.org/lkml/2020/4/5/221 with a bigger number of recipients.
Applies to next-20200424.

Cc: stable@vger.kernel.org
Signed-off-by: Hill Ma <maahiuzeon@gmail.com>
---
 arch/x86/kernel/reboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3ca43be4f..8b8cebfd3 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -197,6 +197,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook5"),
 		},
 	},
+	{	/* Handle problems with rebooting on Apple MacBook6,1 */
+		.callback = set_pci_reboot,
+		.ident = "Apple MacBook6,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook6,1"),
+		},
+	},
 	{	/* Handle problems with rebooting on Apple MacBookPro5 */
 		.callback = set_pci_reboot,
 		.ident = "Apple MacBookPro5",
-- 
2.26.0

