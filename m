Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED8C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAofa0p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBCNIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:08:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52300 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBCNIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:08:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so15838451wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=alT0mD61PM/IBFgvStBHZhsIUV9279dnSKZ61XBI5jc=;
        b=QAofa0p/RCZbmlHj1/ajk8aQlfSuCRHsGbBuB7d0L/5nmPL2cSQmk5x0jzmBv2rtHc
         9K9xgTe8kvO1MFMtTXbEXm17D7JRgPDp7DoiNhjabcAFpLBgl4fu/yXIH2SGU4X1YmRv
         VQ1bQTGBuKsWEo5ygsBJQC/8x/7DpjSqp948eW8M9bUBVOU3mT4K5WFZ3MTjBk45fEHt
         rr1jcKfIg7oFBswqjwtUYXqZ3g9khU7CfZ7tS+78diopV3r94i6ZDC9rrykco+cC1hmQ
         gbl57v/oNhXMwg4kmIWv3FNnquL306AABnKGLNb9qLxqC4JG1Q2bhj+OonijmWfp7Ow0
         anRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=alT0mD61PM/IBFgvStBHZhsIUV9279dnSKZ61XBI5jc=;
        b=cs6wG/tBRpfylBDYDpZwdUT9pX1rINaeZ02ubGTDVhFvZ89kq47HzNMvvhohU8t5eW
         u2JhcK5IqlIXjczRYyFTL3Sybknupl5/Ori1F353LtDrHSrcTymG1oi+ltE4QEVgByB0
         ABYzh+pNnBbtBd/pqwruFrGVSZqrnu001vY5BmC/3xBErJMxdvEC58x5k8Iy7ppuHspK
         8Df0o8OKd6GoSFRcKle/J77xsyxwWh78pJO5hCpso5+sMDNJtzjeMfk8eLhf9GflwduL
         uf7fqN5azECHrZqnTKxvHbwlA5rR47xO3SHPPIYijMDykbqaGdbdlgLcJ90BcB7s1bOy
         vMHQ==
X-Gm-Message-State: APjAAAU+caZd/SDLZwkJgWkibJG0/NzbC2DbZq1v8M4krgwoAl7Hvk9g
        Yovgqf+Y/tumdlJBjzlUHtutarhwQ/4=
X-Google-Smtp-Source: APXvYqxRDDIB56mxJPWmdntUgFbEZe5KInVP02xvy63yxMievqtnO/73UkPd3xJQ8IiCwptj6W+Xsw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr29548970wmb.150.1580735315452;
        Mon, 03 Feb 2020 05:08:35 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id m21sm23917657wmi.27.2020.02.03.05.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:08:34 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:08:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.6
Message-ID: <20200203130849.GC15069@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.6

for you to fetch changes up to 7af43a76695db71a57203793fb9dd3c81a5783b1:

  backlight: qcom-wled: Fix unsigned comparison to zero (2020-01-23 07:53:12 +0000)

----------------------------------------------------------------
 - Fix-ups
   - Remove superfluous code; ams369fg06
   - Convert over to GPIO descriptor (gpiod); bd6107

 - Bug Fixes
   - Fix unsigned comparison to less than zero; qcom-wled

----------------------------------------------------------------
Chen Zhou (1):
      backlight: qcom-wled: Fix unsigned comparison to zero

Linus Walleij (2):
      backlight: ams369fg06: Drop GPIO include
      backlight: bd6107: Convert to use GPIO descriptor

 drivers/video/backlight/ams369fg06.c |  1 -
 drivers/video/backlight/bd6107.c     | 24 ++++++++++++++++--------
 drivers/video/backlight/qcom-wled.c  |  4 ++--
 include/linux/platform_data/bd6107.h |  1 -
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
