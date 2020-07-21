Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB510C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9120720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qt3KHO5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgGUVOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgGUVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:14:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE39C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so64580pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oSUWq982rBlWRI7hOTohIn18y5KqsT4lbUPrCubS9rQ=;
        b=Qt3KHO5lvvUtQ8imVFOJ2VhAHOnvuWrMPARwSJIhErVMtjHNHMP5M58cIfz/ydEO3b
         N8xJ6iroaX2XUBw+nW75h1JxrT0xcFO4rM4GGxT7PAtvL8GWT+6Yac0aO1mgkDSn7+YX
         redNFf1wwK4hKomJtf+QYgF8/WFKRQFzX0RlPrYYMx9X1PdVztVvmiV38Zh2VpIw7NGy
         nREPu12wtWIThP59O6Tza0z4xgsHIsButqmIlRK7WclqPsQCRBL3SZYFc0Y++V59JbUb
         CUQEx5/xboqbc242yoVwbC6nDqv0hBljzLPz9BcwTSKLY/G+4AhD62tWPRwhPfYGFONa
         hKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSUWq982rBlWRI7hOTohIn18y5KqsT4lbUPrCubS9rQ=;
        b=R7ljKvZMoq6T3jKP/VazlbRSx02tq31+WBQfl9eCYJYXWjzl3DCqmwaYsvmHNTGC12
         DoZ7/0yR0vcFf13R7HUJfdYfMER0XkcewFSLwvMRZRP3JwFHWMU2htovGICtbKPjYcmd
         M1XlZ36TPTqVp1MctiJYhbl1vYLt7Jnld0zJVpMFX1dbhVt7q4e17ih5bfwusRUt6s1g
         lXrydkY0qB9qf3s7qClyfQGN8vUIxilI3P+YxO2chWuc/k77y5LUW56P0paUy7Z0FCGQ
         mpVoMi8KutQ7Bbfal+fG6ltVnxTpsO/jIlMJ/L7jgNdIbi+HHSixIozaruPUrO6EP5s+
         0NYw==
X-Gm-Message-State: AOAM531hfkgW/XyXLaMdAfrlqEiiWgAKQ+r2dj5s1ougmBF9UQvn1EPS
        X3JDqK8OhyfJx6VlLcyZpvRj19waR1t4tQ==
X-Google-Smtp-Source: ABdhPJyQntzppnYI6sfe3fXSIfegwAdBnN0ZD8OF2gPFZ9fMv/PTK9G75ha/vG9as5mIrSCMEF0NMg==
X-Received: by 2002:a62:2b85:: with SMTP id r127mr24357616pfr.239.1595366089357;
        Tue, 21 Jul 2020 14:14:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id cv7sm3966952pjb.9.2020.07.21.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:14:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson: update spifc node name on Khadas VIM3/VIM3L
Date:   Tue, 21 Jul 2020 14:14:44 -0700
Message-Id: <159536607959.30777.2083924894013034325.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200718054505.4165-1-christianshewitt@gmail.com>
References: <20200718054505.4165-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 05:45:05 +0000, Christian Hewitt wrote:
> The VIM3/VIM3L Boards use w25q128 not w25q32 - this is a cosmetic change
> only - the device probes fine with the current device-tree.

Applied, thanks!

[1/1] arm64: dts: meson: update spifc node name on Khadas VIM3/VIM3L
      commit: d57c69ca6d4ab890e8edac5c8e10c7c2b54d500c

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
