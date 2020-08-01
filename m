Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FBA205CB
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRZSSnrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHAO0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgHAO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 10:26:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B570AC061756
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 07:26:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s16so20009806ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yJ7LO/KWn3KV/WgsxRJ7hw2ck7TTCFfaXw9IbubmYAA=;
        b=BRZSSnrbn2XHe9dJtOysuyNb4Stjvzcuq6gbBjGmtK4+qRv3HSF5UBbnG7v+vV8noL
         44RTeX1k4eHVjWFH+Gmj/R9q061Fxb/oq+/VjM8OohBe6E7SH0NFpSOtLsyqnne6JEFk
         VxVOuKIHDoTfX9R4eil9ZOtES1mH2e0aQQ59qVQ3QwtoULlLc981eTAM07eDR+TIRPDV
         u0qcPM186A+Uusg3lLP6KGR5QBb4Y+UNi99tw9SWGbu/6gmRZvyTqfXZ/y4g+CZyeAq7
         w2keoWodm066iLP0VbEMHlAnFosIyXroqL2lBmbUflT75pH23SVk+WYs0r4G+EFsKCCk
         GzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yJ7LO/KWn3KV/WgsxRJ7hw2ck7TTCFfaXw9IbubmYAA=;
        b=P2hWJok8M7ewZlz69Bq6HjaKh/M1Yzr32gb+YoTD/RaEDpq44O/wxfbEpo3iZqcpqn
         HpRwncekeJMT2PJ9cW3wXrTxffda7dXQTKLaKDFo/JiYz9LTiwASAmI30dC0e81+/rNZ
         dWxaqnTCDIDQh5pa1koP+2hWwnFI0xfb8/8YWlYTO8Fso2ybUlvo6yUGGMETKZkEKpZR
         XTtJo3zkvEsK+wFeaM85AkALZtrrgZwrgfBfF9Uiqsp87wwlBXtnQwqKtJf3vkGan/qa
         6WRgyUhf51cvjZCkBvrYo8Cbric97Xvp9xzttETOkADGNZwWaZsgDXLGirE/JWuSW6U+
         J6kA==
X-Gm-Message-State: AOAM532S72a9FtgeZ90P+TrVIXdL2gszUz8Zzsmp7HkedRGO6SEGyQaj
        r06bSO8h+hLpdfiVZbILCY9nZKka76KoB80UpU+MUw==
X-Google-Smtp-Source: ABdhPJwxy6+eJv8meeF/Nw2r0qDlmYST+HPE7SBbRIryhCo2xEQI9/laUYvdLxXaPnOhvgS4DYS1bf/PptZZXQDVWbY=
X-Received: by 2002:a2e:6a17:: with SMTP id f23mr3688902ljc.338.1596291961747;
 Sat, 01 Aug 2020 07:26:01 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Aug 2020 16:25:50 +0200
Message-ID: <CACRpkdaiGkpOv3fr4+PKdTiQr0jbjhMUkYo+OnHuC9yqJVvQzA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a last minute pin control fix to the Qualcomm driver.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.8-4

for you to fetch changes up to c3c0c2e18d943ec4a84162ac679970b592555a4a:

  pinctrl: qcom: Handle broken/missing PDC dual edge IRQs on sc7180
(2020-07-16 15:41:41 +0200)

----------------------------------------------------------------
A single patch to the Qualcomm driver fixing missing dual
edge PCH interrupts.

----------------------------------------------------------------
Douglas Anderson (1):
      pinctrl: qcom: Handle broken/missing PDC dual edge IRQs on sc7180

 drivers/pinctrl/qcom/Kconfig          |  2 +
 drivers/pinctrl/qcom/pinctrl-msm.c    | 74 ++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h    |  4 ++
 drivers/pinctrl/qcom/pinctrl-sc7180.c |  1 +
 4 files changed, 79 insertions(+), 2 deletions(-)
