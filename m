Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED01C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27892083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y+UE5guH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgETAIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgETAHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:07:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B4FC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so437375pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+DomKPOv1yE5ESFBkQ8ud9ihgskj98nGfYMrpZrFiM=;
        b=Y+UE5guHV5/L0b0srWJiFebv61WLr8NQyvWXiq7/hoWAmuxvU+BiDdDJstV5EiD1wJ
         jtu7ikRXv0voVZPUKIDXZ7B7+tHOxVVlnNeUvCM/Q0Ce+G5B13h9o6rVJt8WGvgF7/0Q
         BbaJzcfEifhz+nObg1SXlEOSOOWuHpsiW1WhnO0L4NTEEVNW2BL9GTRhlxu2tyPiX25O
         BrImsHgtj5OTLVzqFOZAAjyeAnX9aFuPMpHhuKwhu/Su44sd9e2AeFx/Ow2ydEaiuWDp
         xEGKbFTyn0UaHKZzDlbLToadjznoL506wIT+MoMugLhhFH9pc4+RS+Cgha3wi1Gr1lTu
         JkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+DomKPOv1yE5ESFBkQ8ud9ihgskj98nGfYMrpZrFiM=;
        b=cCEItkTADDroOTi0DJDq1p1XfDiyyF+0CGEJRm/dJ1XiYnMmqVH5mWp7vrcQtrEbLu
         A+UbNMDCANRy+/SboKOIvtxQzKzbY3+zQvi3HxH56WIdAifFgodrgjAWSqGr4+K1/3ST
         dtI9ixyp2CX4kovfxIgSygZfMLXtz9HN1tFMzCjcSoX2ZtBBCYfe0on7pPAa5pWHmCB7
         rTwVQPU8383XfAVnwlwYlyPsuRDdAB9LiseUjpNce94kZ29GxzvDT+JuvDXxAE4gfdsA
         d4Gj/1tpYafokrd8iVX7jdNiO0BTNVfD4EyhyUyyAumyN/mYmfw6tRTv9psSTuh5tGyX
         ANgQ==
X-Gm-Message-State: AOAM533oj/SGweeTu1mK/pdu40RhFyIfm47J7aC11fljEZrFZ/4uh8ot
        MT4NeFGl7mnUfDyxWmwSp9s0/g==
X-Google-Smtp-Source: ABdhPJwE9FiCv3g5zVYgc8Z9qAKSS+WbDh+SIgfGNnxYbx9qLd+gBy+NviN0qWa6eFC+ZUcHtHRuVQ==
X-Received: by 2002:a17:90b:3c7:: with SMTP id go7mr2258358pjb.67.1589933274893;
        Tue, 19 May 2020 17:07:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z6sm502190pfb.87.2020.05.19.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 17:07:54 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] arm64: meson-sm1: add support for Hardkernel ODROID-C4
Date:   Tue, 19 May 2020 17:07:48 -0700
Message-Id: <158993320300.34448.14860271730266890592.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506080702.6645-1-narmstrong@baylibre.com>
References: <20200506080702.6645-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 10:07:00 +0200, Neil Armstrong wrote:
> This serie adds support for the Hardkernel Odroid-C4 single board computer.
> 
> The Odroid-C4 is the Odroid-C2 successor with same form factor, but using
> a modern Amlogic S905X3 (SM1) SoC and 4x USB3 ports.
> 
> Fully functionnal:
> - USB2+USB3
> - USB2 OTG
> - eMMC
> - SDCard
> - HDMI
> - DVFS
> - Gigabit Ethernet with RTL8211F PHY
> - ADC
> - Debug UART
> - Infrared Receiver
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: amlogic: add odroid-c4 bindings
      commit: 838f0905aaeefce443eca124b27e6474e6862aa3
[2/2] arm64: dts: meson-sm1: add support for Hardkernel ODROID-C4
      commit: 326e57518b0dc8789d78e59563afbb3f4107e6e1

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
