Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D5AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE89C2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVileoi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIAKSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:18:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4EC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:18:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b19so804377lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ef8FM3fZiqNvJvHo58pBjnwUlM9KEzscD9rQlYx0eGc=;
        b=AVileoi2SrjN6mIUNrV8sPg2X2abCs8HR3te4781sHRVVsaLcQVCanoNIqwvUfSOLN
         ZMFDv4OHiNT7lUrIk1fY5CvW6OY5echHoPdU+jYs3LZz40juVlsPW/I5KrJ+JGX6y7vN
         O5uVNgcRUzQPrVE4iysRStYBT1F2+sxMxMcjCsKSipfxdGV6cxNGS+YuTu/uZthLgzOK
         sBVrFUFWACo36XQf+7f2+Qwh6e533aZ9czCb97a0TcCiRxmO/68Is3YX9u77yXLUzgCm
         JlLYXpsmvdQ4ar9DPhTWI5Di9FmLBs0DTwVzkAmcgrmsvFgMoVYjizC23BfBV48W65FF
         aLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ef8FM3fZiqNvJvHo58pBjnwUlM9KEzscD9rQlYx0eGc=;
        b=dBqrCBgFboGPMiKPupHC6G4NClwbi6bIezRWjfZKe5KCz3vBaj+Iah8kSY4ZNI2Kl+
         b379y8GggihhNr+4KbURIeVYBZgcy92XY8OCCr3kc6RqwiKtnIkErPEZfmOHsI7qY25f
         YoFg3BcrouDklZczq3n1qndQCmFWgzscOqMnQ8+b7E8TAtI7xwWVKJcjCaN3rfcT2awU
         j9TFtjwyO+2WWAaAZxLkrZ4ZEi7wvQ580u2PVeke5HJgYIhRiAnBmy+o0OBoGG/L0c8s
         ZmMY/aFF4cyQDw4fDvFBmVwTptIcCVnqd9Kfc6n5fN2VjIB17z8lmNDrDoVxmblGmiQk
         QLeg==
X-Gm-Message-State: AOAM532x8blrfRNRHfqq6gz3aCWHl2O3SX/6bjgT1hgPUt/BKvXB7LJC
        q0wMj1fBypF9bh9DzR/n8gtOCw==
X-Google-Smtp-Source: ABdhPJxjEWIk/C8X/TOVakCtirf3E75tDpiV+SA+pviVGJb32xUUqhskxZGFr9wtDaWAv89UXQCehA==
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr237739ljm.170.1598955488658;
        Tue, 01 Sep 2020 03:18:08 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id r11sm180316lji.104.2020.09.01.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:18:08 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:18:06 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Jorge Ramirez-Ortiz <jorge@foundries.io>
Subject: [GIT PULL] optee i2c fix for v5.10
Message-ID: <20200901101806.GA3286324@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch fixing a build issue in the previous OP-TEE
I2C patch. The test IS_REACHABLE(CONFIG_I2C) is used instead of
IS_ENABLED(CONFIG_I2C) to see if the I2C functions are available from
the OP-TEE driver.

If you rather have the patches squashed feel free to do so.

Thanks,
Jens

The following changes since commit c05210ab975771e161427eb47696b869d820bdaf:

  drivers: optee: allow op-tee to access devices on the i2c bus (2020-08-21 11:41:45 +0200)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-i2c-fix-for-v5.10

for you to fetch changes up to 539f8fc253ece5501fdea1a6aa227d0618374111:

  drivers: optee: fix i2c build issue (2020-09-01 12:03:16 +0200)

----------------------------------------------------------------
Make sure I2C functions used in OP-TEE are reachable with IS_REACHABLE()

----------------------------------------------------------------
Jorge Ramirez-Ortiz (1):
      drivers: optee: fix i2c build issue

 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
