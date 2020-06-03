Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DEDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134AC20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKDJ0CH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCMbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgFCMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:31:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F7C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:31:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n23so2472281ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P9MOihz2dNvs8KZnA010MIHpIN88q045MfnMNo8RW/o=;
        b=cKDJ0CH/AF02dBkES1fgqvnlScibwydiQmc/O6sYnvqocnJJn8D7Dt7BUqJbsXHFOq
         3Dh5EB5u05D+YUsYcdK2/dpz8P58l57wXAVWJcRb+qIKRfzhB1yUJK1hWXTcUY4lbCuG
         USjD327wh1diUNLSkiylOunzvvYK+8hVXWtRTK1+Ul1Zfo3EtpeJBZTM8Z4Oqp98gjBd
         DkWSSTa1qO5cNWMJDug4MRPvXkJ15iRqaEZ7DizskD2LQJKlcCVx4DV6nFhmgQDe10kX
         Xpy2RgMSqATYotfaUQk02ZT1fs/CLkW4WoouCR9LTIlwVpbLTgEVYlT3tpDHo7uZkbM5
         EI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P9MOihz2dNvs8KZnA010MIHpIN88q045MfnMNo8RW/o=;
        b=hQJeRn8OPq5Y7AjBpCHhPS3BpfWcAr/C7AVOlQFuV9u/ugrwIuKDegLsdbqHlzzx7o
         whJcKz7p6lgMspsmzO4fHfNlrZvRpb055MZiFpxaDqPr3ZuUMYDw2uOCmILVwhb90thG
         mxugM9I8PLux1y5WuMjvt+Z6sMkggbOgyRLH6rYgTGawZ+h7UmMjesIUZ3imY1rTLtIo
         uyuFDm7r+uYqJDYDq3eQ+N3ZUSa+9HaKxVvG0Q7OkGfTnpIWoikJk1ZM23cA2LB/Y0dZ
         dCaFGDQWs2MqHZ7Jcihn4PEqwYeJl+WBqx8GVRMv3hiwSbQh2ZvgnHUpkAJRd9lPPyVU
         ML/Q==
X-Gm-Message-State: AOAM531bNzJpaJyAFRYJrw3Ic8QtFbDAAgFFSDM0Em68y1IfZfRInFSn
        TloOac9h+B+JwUb5GyDv3MUKF3Qazt3A9+qc8qHx7Q==
X-Google-Smtp-Source: ABdhPJw8SSAJIyE84pdf0Z6PzkVQ0XCT1269nX2POe1eYPap+iF6PA0W87bqQfgKU2PzWMulWs5QUCll7p5vTFgMEVE=
X-Received: by 2002:a2e:911:: with SMTP id 17mr2041281ljj.411.1591187499787;
 Wed, 03 Jun 2020 05:31:39 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Jun 2020 18:01:28 +0530
Message-ID: <CA+G9fYtCP3d805MpSMq0TGkz2uhHpFLaizP8uHxHzC5jnAc0hQ@mail.gmail.com>
Subject: linux-next: arm64 build failed - aarch64-linux-gnu-ld: cannot find
 ./drivers/firmware/efi/libstub/lib.abuilt-in.a: No such file or directory
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Cc:     ardb@kernel.org, Ingo Molnar <mingo@kernel.org>,
        nivedita@alum.mit.edu, jarkko.sakkinen@linux.intel.com,
        xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 build failed on Linux-next 20200603.

make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- HOSTCC=gcc CC="sccache
aarch64-linux-gnu-gcc" O=build Image
 #
aarch64-linux-gnu-ld: cannot find
./drivers/firmware/efi/libstub/lib.abuilt-in.a: No such file or
directory
 make[1]: *** [/linux/Makefile:1132: vmlinux] Error 1

-- 
Linaro LKFT
https://lkft.linaro.org
