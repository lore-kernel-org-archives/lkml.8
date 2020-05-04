Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F8C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F6E24954
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBeK7PzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbgEDSK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731782AbgEDSKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:10:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:10:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so10622810ljb.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jH+RQvZfWBPL/mnizZmaNYP9xWO1o6rOJMbxjkZZp1Y=;
        b=SBeK7PzPMOpDCOs2i7PNkBs8r0xKcDyF4T0FljvZO3+rcPXW+xALMNyHnpbMGR2Mp+
         BOGAUC0BngtM1Sc3+8gB2CGzVbqWYnZj7Je3GQbgFY47HhQG5W5TwfcwoAuO4UjxldVW
         XOukAtZCowxX1uxJSYCR+fT04fEtjlK6OTuO5kfJFz366tMUTXykOho+1I4C3hQaxKZV
         4hRPebyWpqxjDgctSOfny5fyasF+UDceKh/3tQkkkNXwuJ+rkZf9vvhAJMJT/rOQqQgR
         dr8yOKpVrkiNpedov7iLfJyrcNPxcAxhOeP1H+/3frWIlRXQS+QYlC2gsXrQn2zWCPiU
         RgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jH+RQvZfWBPL/mnizZmaNYP9xWO1o6rOJMbxjkZZp1Y=;
        b=WfVeZJ0C8cegacYGraGuq6pebzamKtoQCGfOaMhm9UYgKJxxEn1K//BtC2K92KygVn
         rQLMRIQTFTBqirhDIK37jZtJzGUCuLZftTpcqPKsLcKK5b5R8v+no6YUNLXQkvd+Uoj3
         PTrLVZaYCOCr42Gur3QaKll12aaz2uc5srIImCpT4oxoj/d17PIDzjEfAsoINK6vfMSS
         TQzgAeXJRHtNVjgsna2b6mZELb25wKJrDa9T4sec70O6fMvzRJ+4uYkOIX4dqitKhFgC
         nSMpYiAc0b9wm8xPOOvkW0nwo9nvuf2yxFXeYjmnxVJzWVuOOOoBW/J/GVFNs3rjky53
         NqaA==
X-Gm-Message-State: AGi0Pua8l2MgYYRrQhX3IfwxM+DwPKypsRU5bh1lmLmolitnEoln8Qt4
        MANzlw7QYuHfAhogioXhp5Y1fI9aoOc=
X-Google-Smtp-Source: APiQypL9nfuj0aaNVAUWhXrgQd1rcEGy36iBc3lcKQE8pRbx02DEqi3yEWxDJIwhUg02VG3TXcj55A==
X-Received: by 2002:a2e:5847:: with SMTP id x7mr10967982ljd.61.1588615851911;
        Mon, 04 May 2020 11:10:51 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id a13sm8775284ljm.25.2020.05.04.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:10:51 -0700 (PDT)
Date:   Mon, 4 May 2020 20:10:49 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
Subject: [GIT PULL] tee subsystem work for v5.8
Message-ID: <20200504181049.GA10860@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these small tee subsystem patches.

Thanks,
Jens

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-for-5.8

for you to fetch changes up to 104edb94cc4b3101bab33161cd861de13e85610b:

  tee: add private login method for kernel clients (2020-04-20 16:18:14 +0200)

----------------------------------------------------------------
TEE subsystem work
- Reserve GlobalPlatform implementation defined logon method range
- Add support to register kernel memory with TEE to allow TEE bus drivers
  to register memory references.

----------------------------------------------------------------
Sumit Garg (2):
      tee: enable support to register kernel memory
      tee: add private login method for kernel clients

 drivers/tee/tee_core.c   |  7 +++++++
 drivers/tee/tee_shm.c    | 28 +++++++++++++++++++++++++---
 include/linux/tee_drv.h  |  1 +
 include/uapi/linux/tee.h |  9 +++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)
