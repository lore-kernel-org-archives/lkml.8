Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0464C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5F9206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fARYP1yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgGVRIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbgGVRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64BC0619DC;
        Wed, 22 Jul 2020 10:08:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so4781169wmc.1;
        Wed, 22 Jul 2020 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mj2d0jlZHTrTuhnFNCC1PkNjdWcEHuG1YHIYu31J1mI=;
        b=fARYP1yxhLR7Wx3So2ItMo9bgxIUxzOu2IYsDAmgR2uypbp/Rb0dx9rzKOe+0eknHF
         EB31Ayz5u36CmiAQEfZ4Sob4bSBNZF3010b09opdwt7S+1KyLmg5+lpBJP54BgexHjWe
         HyujqJCaxBt9WTqTJFoBjermvsoNaDwIzXpOedlbHxqSbpgH07jFOMy/fAYxwVqLIK7m
         5q54HdymeuYuC4uSXV8yv9/GtFxtvFNto8ov5xNMgkSIkeySvHAgSbszYKhTKEbzF6lo
         FmYC5+gOM5DmHKNtY3C3T7JjShmlh6tfe5Tmw/EvQTso58+ndzdrrL/jdVkn5FCHC7pZ
         5h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mj2d0jlZHTrTuhnFNCC1PkNjdWcEHuG1YHIYu31J1mI=;
        b=jA3/hDy7uOhUU3d0ruGAXLtpeIvQDB4We88d9WEwW2kM2wju4GA9CBvlVqEey0RLwO
         2OBfN0BSwdtDn2Pew+UmsZPScDTj7uNCH9/KjLlHEeK++UJSsnZiBUhOKc7h8aDL68PI
         J7QuMuaVUkS0+g60I6Qxyq1YQAg18n6GrILLg39zrBIitEnfLjuliRdcHJ5KdgeP8oAB
         cgmMV6gOHSzRhxRHXK80GRpUOkRvaIOmyo7BQjuP0VvhjZnj/3cwg58rttTMiNVIJAYe
         UKahhYxeqdXF2lUmI4A/ugIdc4knU2fUHI9yX0leclYHDMngF1gQKPn2SOUDmH6mpiAx
         GRhA==
X-Gm-Message-State: AOAM531a+pxyuwT8iG0mScxiTU2yEwhtNqBZmxLFBlQ8uSzGuEqAYIdz
        +7+ww6g+wulfHODguZk/b9Z2xRZy
X-Google-Smtp-Source: ABdhPJyUtjPjtTc2vJEa6UaxSVqCi95SwQq/fUq7rR10npA0rpc7puaE+RzXGePMIwq2cd+ozKS5nw==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr548766wmi.94.1595437689204;
        Wed, 22 Jul 2020 10:08:09 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:08 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 5/7] usb: bdc: driver runs out of buffer descriptors on large ADB transfers
Date:   Wed, 22 Jul 2020 13:07:44 -0400
Message-Id: <20200722170746.5222-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version v1.0.40 of the Android host ADB software increased maximum
transfer sizes from 256K to 1M. Since the STB ADB gadget driver
requests only 16K at a time, the BDC driver ran out of buffer
descriptors (BDs) if the queuing happens faster than the incoming
16K transfers. This issue is fixed by doubling the number of BDs
that can be queued so that the entire 1M request can be queued
without running out of buffers.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 6e1e881dc51e..ac75e25c3b6a 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -44,7 +44,7 @@
 #define NUM_SR_ENTRIES	64
 
 /* Num of bds per table */
-#define NUM_BDS_PER_TABLE	32
+#define NUM_BDS_PER_TABLE	64
 
 /* Num of tables in bd list for control,bulk and Int ep */
 #define NUM_TABLES	2
-- 
2.17.1

