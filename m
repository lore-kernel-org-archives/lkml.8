Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A1C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809372067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wEJSeMZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGMTDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:03:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so304354pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuh9r/vcKnoP4S8jfRWymeU60PiF7dA7Uo0nDY5Yimo=;
        b=wEJSeMZ/nR4O1K1ZmVe9XVOvetEoZZQw9MW1YNjeALTQXRCwAjXzL0cvq64nWSxAiv
         Que0no4WeuEAPO6SWZ+dWDqNdJ1T2f94cCJQ7n/muZhqLWymNTV9INnyumLNOCYvZ9UU
         F5DGMXddGxBHVQNz4BCHX6f2DgpkD6Ve8tsxbGNW/3vaLfDcE/98IfHUeJV/rjGRQjtf
         4b4k7dOqazt59+UBEls8u179WhkJgELPZYG2GwdsKHJ8YuCiFAJL8+2epC3wk4JTssq7
         5xMwu2OMrofrRMZdOLSEmy6zFE/GJAyGv1OKSN6vwWKxZGy0Aq2xbc8rJ24FMg4KO45J
         nLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuh9r/vcKnoP4S8jfRWymeU60PiF7dA7Uo0nDY5Yimo=;
        b=Cq9rzz0RybawIJt5J83nu6tIp03rruBuZFLLzvILfbhDK0YWTLeuomtUV7aNoee4oS
         3J5Ui+UxnWdRDkLLI/qYgOLa1z2nB6puOIlEQAUylcHaHxhF9WL3Js+TxnaXMwEroI+3
         xZSvMTan4NGj/bgtm8QLcYdVf0h+2dfYN5S/aYTtzwO7ZGO4U9sWbtDr4v5zvgQWDfbZ
         fiqj/mmQTT6Fqyhj6EjF1hUlLkPRo+8lHXfcD+K46Ic/gHcTpWCISsTk5SCR2clyqAJa
         Cp9TxlhKPDpf7C2CcmWb/FiGkYTi9iMDk5X/RDthAEYHqddwF/dabTYWV+Y7Q0C2BEiz
         Fexw==
X-Gm-Message-State: AOAM530lWvWfMFWtrV7ZMClWGr6qEXOk1RM5aUAaZXXWCE9g+vetl/Bk
        vHeZ3hjFNuDwS94VOvdqyu7upQ==
X-Google-Smtp-Source: ABdhPJxD+16ysBInyxc4PodHD/kcp1NFQSeNXqDpN/mFByIa6Gtuci4hSt90tC/fPtjLrzKIVb2cTA==
X-Received: by 2002:a17:90a:1a83:: with SMTP id p3mr753530pjp.113.1594667014734;
        Mon, 13 Jul 2020 12:03:34 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d37sm14020809pgd.18.2020.07.13.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:03:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: dts: wire up the power domains on Meson8/8b/8m2
Date:   Mon, 13 Jul 2020 12:03:30 -0700
Message-Id: <159466696385.22745.1661245266792495941.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
References: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 18:10:07 +0200, Martin Blumenstingl wrote:
> Now that the meson-ee-pwrc driver has gained support for the power
> domains on Meson8/Meson8b/Meson8m2 we can add it to the corresponding
> .dtsi files.
> 
> So far this doesn't fix (or break) anything for me (probably because all
> vendor u-boots are enabling the Ethernet power domains unconditionally).
> But at least it's one preparation step which is needed for video output
> in the future.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: meson8: add power domain controller
      commit: aecc72b14d11327804f7ca1fc76ca88a22cc1136
[2/3] ARM: dts: meson8m2: add resets for the power domain controller
      commit: c5d3d3cf00d5ed74359e71f7b5d003cf34ba014c
[3/3] ARM: dts: meson8b: add power domain controller
      commit: 9960cacbaeb1ccc1b2d9840cadb18844d48a337b

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
