Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4213CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF4B2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLgPTrIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgHYJHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgHYJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:07:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:07:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so12910438ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=R2igtUTe6ca/hUHWdf0bI4jAc/haNY0v5lGYgfFGdns=;
        b=dLgPTrIJGhuQWXM+7JSjKuyvpxoXkGYcoynhB10kT+H0r0QtLaRRiY28e5zhdeSjXP
         GyMheEdxCKNKEgac6fNqE5sG53/j/+1aU9+4/qG7b406UyQfVuj1dkcOl3w0q7Zv62Ud
         W7OiRZhmXHijkSojJayAtOpBKahC29Io64u7EEWbSfv4byMnb+NBO2NCy6P5g0sJLcjt
         f1a9DznhPOBZ80zPac16EyzV2n48lGkTnZ7CRPpL2iOIOiWBR29duSVxEvkO+N2DIHkS
         8IxdC8aDpij3NhQEnW4wSFSr5jE9F/3y7inp61izHSvObBYHy4Q/bPIfbrb4e+Pfoi4N
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R2igtUTe6ca/hUHWdf0bI4jAc/haNY0v5lGYgfFGdns=;
        b=GebzHp2cjR85UC5Kl2cAszGAyGbplKZCrpfFdy9OeiXGc3gojAz4VFaQ5Vkj6HIIik
         OUpM63POUdTPqrCDWKWm2RbwCh1rdFNsb9J7YYM0Bg+CRAvJZ8cLMGLX1ByUEunwl6gU
         pORInsWLukZ/mw1m2XzRXOVth9AKrTsvlF3iUblV2pYUAwrTtdOOELqXgjSuWCc0YbRl
         SuVd1BmsVu+G+Hde6+YGFNLxTD2tPGcCStfH0KY2D3wXYYcG/ApjhZcykno8kcND7XFM
         S4DzlcrF46MYxcEawYXBdlSnMR3weQfpHJRlzRmk2zEfT9RtboPZggxHsJBPs/CyPWC8
         g7Iw==
X-Gm-Message-State: AOAM531GmwSS8gbDEGa9Z0LV7yRMRCyCldq/vV+Jtw8LW5PR/wiELePT
        IyzZljR+Tl95BYcRgmldU3z2iQ==
X-Google-Smtp-Source: ABdhPJxFYx/s/P4sJxz0pfeLbxteEgbM4dyeiPbGa5kiHV2pJDbiNFP71P4rGwhgizb6p+SKItjCcQ==
X-Received: by 2002:a2e:8798:: with SMTP id n24mr4008947lji.217.1598346438261;
        Tue, 25 Aug 2020 02:07:18 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id n29sm2897455lfi.9.2020.08.25.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 02:07:17 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:07:15 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [GIT PULL] tee subsystem pin_user_pages for v5.10
Message-ID: <20200825090715.GA2370775@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch converting the tee subsystem to use
pin_user_pages() instead of get_user_pages().

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.10

for you to fetch changes up to 4300cd6374a5192a2c8122a4a48ed647bdcb0214:

  tee: convert get_user_pages() --> pin_user_pages() (2020-08-25 11:01:06 +0200)

----------------------------------------------------------------
Converts tee subsystem to use pin_user_pages() instead of get_user_pages()

----------------------------------------------------------------
John Hubbard (1):
      tee: convert get_user_pages() --> pin_user_pages()

 drivers/tee/tee_shm.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)
