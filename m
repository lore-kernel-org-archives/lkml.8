Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53764C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA3820736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrx+Fp7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgELNMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:12:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78087C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:12:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d21so5881623ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=x4QoL4i05TKgWMM+1LyVNxxvylPGStkJzsuQ89LMgxY=;
        b=nrx+Fp7aDIIrY8QwnIUjLXbVoFDDUNd1LNLjAe+DfecmbGEsTwFruBhXNCZnlXABfA
         aJmA8E7KF2xlVlaoBKDXfwaPYyis+K+tuKVTB3DWNrdwihxqR0FHN9Jlkg+n2F2f3PCY
         Ng5LMqqw/sRBn0AjHq9DV3MfAk+ysNWzu9HxkDNVeJBVHls6fls/Yi9ugmQ1ZV4KgQc0
         aedgSyBB1dyisuVNIiH3nA3Ofi76vzDRrBb7mHoBypTPflCdg3bfaQVXOcgU4qrwxct7
         nG4N6qfK7ZaZAjqOZs0xp1FzMemIjvA/K/++8wEuwa/7M7/OJF/f8aYFzUg3s1hLqq0M
         R3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=x4QoL4i05TKgWMM+1LyVNxxvylPGStkJzsuQ89LMgxY=;
        b=nJ2DR6Vp8RyVyejAUfEoPagz2DG5rXOn0sVOEsyPjON12Saxh5JkReH7n6yDXZOXF+
         MUaWQutWduxd2Ih2Kaf1W+u5IUFVdHgmlprumJlft+awvJsMhGl9Vx9/IQWdmGZqRqmw
         faU9IX2POP82l3XJkuf4x5zDKoES8XMu6KXzLbBQLBfOQZdmhqq2qRWAlhH8V6qhbzOI
         gpmcGlZtxrLk6vDrPh0n3KVttxPwcqkjlGxCf2I/b7fRfMAhyXN2jR/chaQXO84LJSvS
         I84Nub4KXBj1KMZWc5ucS++cTYiAYM/Yq0hAi7wYrMgxwf7jvh04IJMnqxG3P/JMzc64
         pPFw==
X-Gm-Message-State: AOAM532hkxzT/eT/YlNrrsdspewLgkS5mrHPEv+aH5Ir5XZmYPHlS2Kj
        wYP2kSB5/4eF2aqAJ/sZ0dA0Hw==
X-Google-Smtp-Source: ABdhPJy0YMoO9u2zm/VACcBRZczdnhx/61vufXkw/2C8CQY/GdstDCr98wXZtYvH5Sihw6HrCM8Yjw==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr14151768ljg.122.1589289165890;
        Tue, 12 May 2020 06:12:45 -0700 (PDT)
Received: from jade (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id j22sm12745293ljh.107.2020.05.12.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:12:45 -0700 (PDT)
Date:   Tue, 12 May 2020 15:12:43 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org,
        Vesa =?utf-8?B?SsOkw6Rza2Vsw6RpbmVu?= 
        <vesa.jaaskelainen@vaisala.com>
Subject: [GIT PULL] tee subsystem client uuid for v5.8
Message-ID: <20200512131243.GA10028@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these patches enabling Global Platform client UUID generation
for the OP-TEE driver.

Thanks,
Jens

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-login-for-5.8

for you to fetch changes up to c5b4312bea5d5e5e3d4f0af640e2ef8a1c1bb167:

  tee: optee: Add support for session login client UUID generation (2020-05-11 14:11:33 +0200)

----------------------------------------------------------------
Adds utility function in TEE subsystem for client UUID generation. This
function is also used in the optee driver.

----------------------------------------------------------------
Vesa Jääskeläinen (2):
      tee: add support for session's client UUID generation
      tee: optee: Add support for session login client UUID generation

 drivers/tee/Kconfig      |   1 +
 drivers/tee/optee/call.c |   6 +-
 drivers/tee/tee_core.c   | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  16 +++++
 4 files changed, 174 insertions(+), 1 deletion(-)
