Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22935C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D79C205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPZqdlG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbgEMRHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEMRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:07:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E01C061A0C;
        Wed, 13 May 2020 10:07:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so11268697pjb.0;
        Wed, 13 May 2020 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FcmXxK86kTJFAcnJVbE6hTrg4cHLii76Z4EJaZMFyF0=;
        b=XPZqdlG+jXdc0xRKpRpm5SuCk2GC0gvCYwpxp+/KHPUViQ0KQcBFZeZ0CZgrcpoC+D
         N5FPEZMyNxNmb3eYLP9/LNAE+bm9qFoMHYc5WPMwRpKFlrfitCLdLfo8EDiV8pfUTtqO
         /eQ4FD4Rxd3afcNPpr0WoGa4RFIuXdPL/Q9I0BFXlCTKK7s+ZmuZNF9yi6fMjLC3GhAk
         rdzL6czJQdYow/8oRUzm2xADf8e8loaem7JcF1jEONNBwNMVEUddsWNcd6l8FG4LcS2H
         QxbfJPlSQLNqJl0I8msNeoit0w+AHT7AmHam3vkzYEuWId+I1NaPNU73b1ZJSYIOj070
         Dwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FcmXxK86kTJFAcnJVbE6hTrg4cHLii76Z4EJaZMFyF0=;
        b=URl+vM9CnYtJzMIwBvpZT7HCXIJ9+9+zMjVVcCsxXaZ4JXOsV3kGDSS0FDAwVISArn
         OzXRe3RtoUpnNfe8XkzKmqu2ADur5HCPy2E0k3hhmfU3E8aPu6yLnyR4CD5rUpUFOBKl
         2iHBrpJqBYmpiY/eVilS7tTCSk9qdiehTNiORquHWrUakE4LPgVnLGMBardl8sA1nlgw
         RvIvfG8QRDPFmLxik3/lHusFYQdMpvgUuyLftquS67Ab03qaWqau07nMe9o60/z1DdWp
         REXOpGMAsHbyu18I7C8Ng7jYkXdTjtPe2XFcHPWPHUQ2JviqrFuEv69WL/SgN5Q8agWz
         zHvg==
X-Gm-Message-State: AGi0PuYBIr/ZPoj7llE9Gvpe1RouvgssAiUEs2W0tHXwsX2bjdAhkzhZ
        r4bGNZimV5Xehn0EVwrhzhE=
X-Google-Smtp-Source: APiQypI5IZ0L3TUkg2Kyk7PbcZDvwZN+kapDMqMBvoOB/IXlhHZW+VT47jzilgDYTIeywoODGKCHPA==
X-Received: by 2002:a17:90a:2526:: with SMTP id j35mr34866160pje.98.1589389666359;
        Wed, 13 May 2020 10:07:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13sm16291571pje.1.2020.05.13.10.07.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 10:07:45 -0700 (PDT)
Date:   Wed, 13 May 2020 10:07:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] hwmon: da9052: Synchronize access with mfd
Message-ID: <20200513170744.GA133638@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:02:19PM +0200, Sebastian Reichel wrote:
> From: Samu Nuutamo <samu.nuutamo@vincit.fi>
> 
> When tsi-as-adc is configured it is possible for in7[0123]_input read to
> return an incorrect value if a concurrent read to in[456]_input is
> performed. This is caused by a concurrent manipulation of the mux
> channel without proper locking as hwmon and mfd use different locks for
> synchronization.
> 
> Switch hwmon to use the same lock as mfd when accessing the TSI channel.
> 
> Fixes: 4f16cab19a3d5 ("hwmon: da9052: Add support for TSI channel")
> Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
> [rebase to current master, reword commit message slightly]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied.

Thanks,
Guenter
