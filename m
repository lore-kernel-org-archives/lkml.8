Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC2EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F049207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcZbYO2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgGWXFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGWXFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:05:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00487C0619D3;
        Thu, 23 Jul 2020 16:05:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so3381940plx.6;
        Thu, 23 Jul 2020 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kx8J891apkIa/g8IE/ArV1cGSLaJdXykQLAbT7gapEo=;
        b=UcZbYO2tukUDPc5K2c90M2NirgPVRhjzR9QGQza6coVEV+vD8vN4Nog0ApFFbosbl/
         dG5b8aS8zz20MClvdvI0CFrZioWlWwP97Xda4pr0ydgi7Ambf+atwg9qDes0p60nHnP3
         EiKymcj568OiA+9MakggBgSNRdxny4zwuIq3c8uB7CrfKBPDrVpIjJAw7UH3OZqb7d1C
         uZG8Zi4DBymBaPBJnEzJd1rTJsYAzLXMV4DxhxPJzcqPlDcy2AW68C6rUKhVZS4/WLgq
         GLjn1jUOr2sRmzobipNkiDR7RQxrHq+HSoRIs1TW1Ky2e2hl8m1VcsUQGaLLiswGh4Q4
         gxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kx8J891apkIa/g8IE/ArV1cGSLaJdXykQLAbT7gapEo=;
        b=bWTAPZAsvcpRk536kQBeAY91K/0734yOxNru/0aQz/X5ecfVuCtEf85ZCvK1Du4JzP
         hmz8UvxUMqVtrlznG5UOSSuWIRqw5ATFsSxo6j6KpKxp7Gy2eepAv/t3DcH1IGzGljkM
         dlKhkGz5KvZWy76M5ydPAdMyR+ag/FMYc2KF76AtUOLS5azlRJ4Tz2plaTbP2WuEicz3
         Hk2Cx7rlqwJ1VD91+ste4A53uu7/NsyQiWXiypr6wpu7g633gqIx4ZD4qBwcfMnUMKBK
         XPOUVHxO2uM8DFdVtEEqI5Dc6PadDY6QKBq3MmGSTabim8/QXPUHoqxdlIyxCM81p/Wv
         LZZw==
X-Gm-Message-State: AOAM531bie8X76rgQBFn1QMJ87cbd/WRsfUILzaTitKiutqFky5gXMi3
        +pLa0LOhfEz/BWzCuaFiOy+8R4hJkQc=
X-Google-Smtp-Source: ABdhPJw6b+CjqeczL6p7Kx1ZCNCp9dSoVlVCajK91Ff4+2KvkMLg88KX9mwSw72NK+D3DT3J0d0/xw==
X-Received: by 2002:a17:902:d211:: with SMTP id t17mr5914972ply.106.1595545548328;
        Thu, 23 Jul 2020 16:05:48 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id gn5sm3644742pjb.23.2020.07.23.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:05:47 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 0/3] ARM: dts: aspeed: fixup wedge40 device tree
Date:   Thu, 23 Jul 2020 16:05:36 -0700
Message-Id: <20200723230539.17860-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series update several devices' settings in Facebook Wedge40
device tree.

Patch #1 disables a few i2c controllers as they are not being used at
present.

Patch #2 enables adc device for voltage monitoring.

Patch #3 enables pwm_tacho device for fan control and monitoring.

Tao Ren (3):
  ARM: dts: aspeed: wedge40: disable a few i2c controllers
  ARM: dts: aspeed: wedge40: enable adc device
  ARM: dts: aspeed: wedge40: enable pwm_tacho device

 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.17.1

