Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A52073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el60z4Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCEHWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:22:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37022 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEHWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:22:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so2317803pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GAyfUYq0sKmLPF8vDF/XCVPoO7USaewI35k/Mjvwibo=;
        b=el60z4OtBuL6jyqfuXD9cYmRO2CVRAOHFV+NcKqX3S1+Csn+uCxD548AXj+ej1RZA0
         /vgeBjqv56t4vj438oiIyo4e/JCRacYScUIKVM1aZJsTcA0lI0z4uXLrC5v9K7GssXaO
         scRT00f/d2R0MyHlasaSM5wwvpHcoVSfIkJgUn20/sCKLvmelxu/a3hgrwA6JH5P4+Fp
         ql+Xd+bCpY2P+eaRIQhJyqoYAbN1Bmgnm0jZSQKymjYAKwbDxBeGuNfQ8R/86I//aJyu
         Cuh0XtS63dXg0xd1Z70GVcVglhpb79estxARiXEpJbzQPPKc1n/QBn1BwRxUIiGUutfn
         iVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GAyfUYq0sKmLPF8vDF/XCVPoO7USaewI35k/Mjvwibo=;
        b=iY8RGOwfyk8u4IpDPgA+c8fYM+6O/UWjE/e0OhiaMfvo7BvgXaj/TmEuOjqTRcLdDT
         bXFOAFC2YRdfy5Arb0u5zRp4NbgIMdlILlGJJ6X5P570WkAWJsNbk0eGbvdFXmC7qVxj
         nLu1zW+uYWtrIoDsEbo/lmVoAjheabIkZsA8lHqHEBo3aHZlWfI7Zje2drfiagnYtLXM
         vREcE62H8FH7gyd3iZj05CkqV7KxjF5U+xxmymsEpTbTYFrJDso8cbY2u2zUmgtW6Ynl
         xCDQ9t5tdWLnIeLh9AZIKuZH0gS+wNR/6T+FEoQ91D6Hr2YT3LHgYe0RS7kuFGXs/GBV
         zIDw==
X-Gm-Message-State: ANhLgQ2mZlo1J05aCjGYXEbHLFt43g4fzCAMGJNNPrmzr3YWwIzcBigy
        +EZdJsjBa1yFyuK0m3WReOOeN+nn
X-Google-Smtp-Source: ADFU+vvdBh4PZaZuJaO2XplbPnQhuIlhPLJV8HNSHkRSdV6kpzsZqSblyFFhSLsSBzh8zdGmnQSMTg==
X-Received: by 2002:a63:fc1c:: with SMTP id j28mr6327603pgi.289.1583392951877;
        Wed, 04 Mar 2020 23:22:31 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id d24sm32328579pfq.75.2020.03.04.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 23:22:31 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: speakup: Fix a typo error print for softsynthu device
Date:   Thu,  5 Mar 2020 15:21:51 +0800
Message-Id: <20200305072151.403-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When softsynthu device fails the register, "/dev/softsynthu" should be
printed instead of "/dev/softsynth".

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/speakup/speakup_soft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
index 9d85a3a1af4c..28cedaec6d8a 100644
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -388,7 +388,7 @@ static int softsynth_probe(struct spk_synth *synth)
 	synthu_device.name = "softsynthu";
 	synthu_device.fops = &softsynthu_fops;
 	if (misc_register(&synthu_device)) {
-		pr_warn("Couldn't initialize miscdevice /dev/softsynth.\n");
+		pr_warn("Couldn't initialize miscdevice /dev/softsynthu.\n");
 		return -ENODEV;
 	}
 
-- 
2.17.1

