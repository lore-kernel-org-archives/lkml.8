Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D878C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71260246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6FcKlKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgB0QwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:52:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39151 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgB0QwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:52:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id n30so2608761lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4kXB7FgTmsEGGbvV7uWwCTMrQxdsKT8tnVYNGq8AnCA=;
        b=F6FcKlKKFxpwyeXYMTixXUSJtDtGrVwip31cUGRv9wwTcq0ataMnomX0ntj7BD3cS5
         peBIyQSJxbzuqyk8q7OE4XLGFwlTxOBAIOtl0hmEbYnYnW/879Djtt0UnsRLg2lLiey/
         WMRaYAq6xRshNGqqQZUfqXEMez+ojtVtRKDBCghhusYpq32C5KZ2KH38xzhaYx/ahFpz
         i1S9ppCLWvJ+hOj5mPjAfqNYFc3s8tWPuenSVyOcoRMbXT5bd+i8+Zf0aT0V9wAh8Jsn
         lFOvfqWmT4kk/2ifrHOGlvJ7XLgxeXxFNxOgJW377B7fH0a8ABO1f9gnB4iQgFqBjGtO
         7mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4kXB7FgTmsEGGbvV7uWwCTMrQxdsKT8tnVYNGq8AnCA=;
        b=OTGqPl++yVFWGQ8pmXCz3BwbDvzwYvWg5qedCrBuqW6XF0pdjT2akdT0fPd193HoRs
         xpQF2JAQ8EBatqNTYQ74EZmnFbZCoAkLKXem2DK7458mKHHZUoMAYgSQSPGDvPZubOYy
         Lwy2kCs3iosDRgoDRqXjUXKQJgxNTB1Vq+3VxWh0PNhDFw/IJN2RlgMh44Z4My0RThZl
         eGVzopoUTELtELR2r7s91Pzdb0LrMnLuNEi0DVzwPDMyD4B2oEi2As2m5xOgmHWzwW0r
         c+KHzMI1Tt4bBKguU2Y6NYffkXoC7JVRKtBtN67LQFyuc5mDbJUl5xBelO2SwQiGhyMr
         ZOsQ==
X-Gm-Message-State: ANhLgQ1bTsYx5S+YK8nkMN4ICQ1qEnI+4JDJIussCtRyrp73H/M+xYxS
        GPX5lIsrg/6Nu7KIA29SG3yGoA==
X-Google-Smtp-Source: ADFU+vsgBkVQD0dLBecTfEbF03CrLYtLtKVzW7GOc6eWIzGL7RcvC5sthhgOlU9YtJ3O57BeRs1mGw==
X-Received: by 2002:a05:6512:692:: with SMTP id t18mr170820lfe.212.1582822328230;
        Thu, 27 Feb 2020 08:52:08 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id m14sm3129755lfk.7.2020.02.27.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:52:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:52:05 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, Rijo Thomas <Rijo-john.Thomas@amd.com>
Subject: [GIT PULL] amdtee driver fix for v5.6
Message-ID: <20200227165205.GA7926@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix for a memory leak in one of the error
paths of amdtee_open_session()

Thanks,
Jens


The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-amdtee-fix-for-5.6

for you to fetch changes up to b83685bceedbeed33a6adc2d0579a011708d2b18:

  tee: amdtee: fix memory leak in amdtee_open_session() (2020-02-27 16:22:05 +0100)

----------------------------------------------------------------
Fix AMDTEE memory leak in amdtee_open_session()

----------------------------------------------------------------
Dan Carpenter (1):
      tee: amdtee: fix memory leak in amdtee_open_session()

 drivers/tee/amdtee/core.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)
