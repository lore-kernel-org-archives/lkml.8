Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74305C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42751206D5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itKnjINO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAYK4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:56:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38067 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAYK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:56:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so5480981ljh.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SqbTjTM9cGAQLtR9udXUrVET7VibCzWALJm9pHODcU4=;
        b=itKnjINOtfV/SlWBtsrVX+t0CqGRyh2YEz8ddbmAeOh/WSTFwY4y6Rtzx8uNBD097v
         86kOFQLXBudCkEtN05tIk7kFdgJ2pvqebsWfbeHomXyATmRlhh2AuzQLcpidz1JtuHLD
         tmllQ7xolnvwL7Ml7MJDDJ3oFx+7jEANC2j8y7P7crUUI2/td4wXQWwqP1uUM3V2Da5W
         dQBj7SN73HMJLFhg74RzYTUDhZORPcg4XGO+nClmZriHILPzjsaIOm1TW2dEOJHQM3G5
         2hgmqQFShEqr3IGg4SslsvEpDTaFOKEWRxkO4lb01ocLQMLI/aChBuEqWAfROx/NDxxH
         p6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SqbTjTM9cGAQLtR9udXUrVET7VibCzWALJm9pHODcU4=;
        b=e6u/Yqnoz/aNhBJnthvt/wSCqSOtPnxcy+K6Dkhf4VaF4h8X0MQJNzFWYjPgWq7zUs
         z1qxDubCvikXkMP6YwNOuuRrQWdsuk6Xy13KmjrN7I1D5OQtc20abTdzR97tUbpSxbnL
         la0purC7g4UjgMC4pONyAyO1HLvpzkg776Ry+8DAsrhOXwzyaUMzYooW6ogQAqY4uLcM
         VkuySDvjVxJaPRX5UQP/eOoRwjV3p9e5AYslYhrSlm3dfk6E10LkWrRo+k3yYgKHKzem
         ylSqDB053C+IVDKE/HcOOD5zNFPOJfaHoAzbZWwrHaFkCS4+Wo60NUo0R5HaVJv7E0Mq
         UonA==
X-Gm-Message-State: APjAAAX8veCEubCanaI/O4k1IgObMhjEI0vQcq890cdTBDcRUkxKUUnr
        Xcuxf2hBgqewCZXfTOVvagQYpWFtONEpKtaMQRU94w==
X-Google-Smtp-Source: APXvYqzcNibH5Fa8yhxwhQS5HqJwewF7GHTIcPvOKjg0p+55AdnHXaIqsA1B5JSLx+ifwZsMDZMMI6VZOQ81qugFysM=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr4706282ljq.258.1579949768067;
 Sat, 25 Jan 2020 02:56:08 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Jan 2020 11:55:57 +0100
Message-ID: <CACRpkdZ746gURHOeNf3Wj3_7BVHtxjd9Hz2n7QTmqxEroZ0N7A@mail.gmail.com>
Subject: [GIT PULL] pin control fix for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boyan Ding <boyan.j.ding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a hopefully last pin control fix for the v5.5
series fixing up interrupts on the Sunrisepoint.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.5-5

for you to fetch changes up to 319d5cce728cd70897a1306591a252258fc1428d:

  Merge tag 'intel-pinctrl-v5.5-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes
(2020-01-17 09:07:26 +0100)

----------------------------------------------------------------
A single fix for the Intel Sunrisepoint pin controller
that makes the interrupts work properly on it.

----------------------------------------------------------------
Boyan Ding (1):
      pinctrl: sunrisepoint: Add missing Interrupt Status register offset

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.5-3' of
git://git.kernel.org/.../pinctrl/intel into fixes

 drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 1 +
 1 file changed, 1 insertion(+)
