Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE5C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB20B206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgCdXMjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgGOJcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgGOJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E0C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so4689099wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=easFprA1rlXP+l9tcr/n/hbQjfY4p+URdQB+bt/vLVk=;
        b=kgCdXMjbGP82TXbjFkxf/2lpaClvJKN/LS7/ueUYl0t9EesCTDJfExfKSVdPJyLnpI
         mNcg+6XK9vjLQBI0TmsKAlocgw/bqTjmQHBO0KtCWxV1u5kdLAavgH1N/J3AWWNmzmvN
         +zjfJ100UTrvp4EJ/cExnGTPeICQKkKq5igA0enZNlm78zQVXTzpS6ZjnNTZlLxw31S+
         +HXFBE/AsjuKE/OD1e1P8Bs5M0+RG7GdA27HkDiSKQHJ+xI23vDB/wQbucsQJzCFFNvW
         RYobiCqAlVK2T63+0sgwVQU26AvHkqo6Vq0OQ79jEojfAL4V6fsjjUH/KVhlr3WgRwRl
         xewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=easFprA1rlXP+l9tcr/n/hbQjfY4p+URdQB+bt/vLVk=;
        b=hCufuGk1MriAhuHjZa/ddLf5HyjozKXSDtIQycVBR2Ed2GhWWmXlAdj51yfrYFPZ0B
         8Nf2fLF6AYMdBMqQO8yvhvn9hORVJCjc2zgUl5OSsWu/dl88oBO/aCgy0FEB9GCdVFMo
         Dji5CD1pucYnWkftJj1OiejJ0RILIV1BOb9qjQA8tEWP0ekaQ87d7W8BL7x+Lc7TYkZ9
         CWioJdU1iRApw+W5BeCZyle/k0umFT1FFs7iG9+H+pElF/yhCVt8iEl+U5rgRJFOdR7K
         uxzi5a+uk6O0qq1Z8BweXiHyAz1NDWN5hg73OtU/p+iJyBlwUxWMi0g8fxW0gYwKr43z
         8Avw==
X-Gm-Message-State: AOAM5321L3IbdmKZAhNR8uiF3ZN960vRPQxJdz6KMO+ueTNzDBUsulz+
        7d52GBifMrKN/7MR80Q9rhhMYQ==
X-Google-Smtp-Source: ABdhPJwg8dRgDgK/PgoS2WBYF+uhV5nacvXxeFhiZpmGdsw3/hGyoVy0nupsk/XEgqvxhoGTIjI46Q==
X-Received: by 2002:a1c:7d85:: with SMTP id y127mr7961510wmc.181.1594805532762;
        Wed, 15 Jul 2020 02:32:12 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id s203sm2686991wms.32.2020.07.15.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:32:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 0/8] Mop-up left-behind fixes for W=1 warnings in USB
Date:   Wed, 15 Jul 2020 10:32:01 +0100
Message-Id: <20200715093209.3165641-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last of them.

Some have been re-written, others fixed-up.

See the in-patch changelog for the details.

Lee Jones (8):
  usb: dwc2: gadget: Make use of GINTMSK2
  usb: dwc2: gadget: Avoid pointless read of EP control register
  usb: mtu3: mtu3_trace: Function headers are not suitable for kerneldoc
  usb: mtu3: mtu3_trace: Supply missing mtu3_debug.h include file
  usb: class: cdc-wdm: Provide description for usb_cdc_wdm_register()'s
    manage_power arg
  usb: c67x00: c67x00-hcd: Demote obvious misuse of kerneldoc to
    standard comment blocks
  usb: misc: sisusbvga: sisusb_init: Remove genunine unused static const
    arrays
  usb: misc: sisusbvga: Move static const tables out to different
    include file

 drivers/usb/c67x00/c67x00-hcd.c            |   6 +-
 drivers/usb/class/cdc-wdm.c                |   3 +-
 drivers/usb/dwc2/gadget.c                  |   3 +-
 drivers/usb/misc/sisusbvga/sisusb_init.c   |   1 +
 drivers/usb/misc/sisusbvga/sisusb_init.h   | 662 --------------------
 drivers/usb/misc/sisusbvga/sisusb_tables.h | 688 +++++++++++++++++++++
 drivers/usb/mtu3/mtu3_trace.c              |   3 +-
 7 files changed, 697 insertions(+), 669 deletions(-)
 create mode 100644 drivers/usb/misc/sisusbvga/sisusb_tables.h

-- 
2.25.1

