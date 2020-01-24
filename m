Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A762C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3062087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NYq7FezC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392032AbgAXUJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:09:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32959 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgAXUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:09:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so2000728lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+eDZ1ZIHATZsT+z13u9M4co0FtT4EjyFv0GIZvJISY=;
        b=NYq7FezCj3bEtWKiAwW0HHg3flWJlqCVvwfn1Mlk3mbrLER/rFs1QVNVVhjMNE4j8W
         Vku2OLV7Klv36CsubYyfWCMINn/dZb/AXsbqFcvO0UrgIcysQ8tndAuBA1YPte9ykgJi
         yFbpMYNCxt8Vkvck1zVQZUFme2y+QUl+PFVlHLZxhkOFat18liv0+smQpn6tWSxFpFyo
         wgiyjWzj/z0+9cOpv2t9D4vguwiC6ENUSt5Yht+bybSV0l05BxtMpCaWTiIuCvcSnkzF
         qNC6T4DLEbzqA0zOc3Bn7vKk6uWv0yeq3ZRclwwb+yZBk9Xgix+004TLjvIaGGCu6BXB
         fWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+eDZ1ZIHATZsT+z13u9M4co0FtT4EjyFv0GIZvJISY=;
        b=qTsWNzZD06c+eq/z97+B/QWh2zFq1cW5pSdLmuKJg4VZHoR6+y1giWv9b3OOVJmpB6
         cHCmucnzd/9NLLFWK9tpYK5wMn/EgKeu3BlxXijFtcgjZaIwEzOTgIjSb6GWJ5lxXWXW
         8NhkP5k8daGpQKhlViXT4AzfyUVfQpu9dv5npJ8qKX/8qSgb5Zr2aTgpZJTmEYWYaPDB
         KfbXOcXrpTxN9F0J+5pIdqvvR6Mtme9kdyXTyrToyc7zXxEHsipEZvEfdim3BUY8OBy6
         ZQjm8Njpe0yNZmHV9TNuMAmKUW1bCNZ3mhyCHhfFufmcwJPafJ67UiGsn6ADC4N391wm
         Y5vg==
X-Gm-Message-State: APjAAAVEuOqP/cYqbzCm1xmMfBzKHMf5GPu3TrrYlfbvqWRGIkKbdnxg
        f6TkHslSuCjdHSWlM7TVwf3pmQ==
X-Google-Smtp-Source: APXvYqzpZY1+H9hrD3gFt4xRhhyreKvMSPQqX/A+26P1WtqQZoMeISzeAooVglpoeDg1xh/Aj3B6kw==
X-Received: by 2002:ac2:5a48:: with SMTP id r8mr2255355lfn.179.1579896575099;
        Fri, 24 Jan 2020 12:09:35 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z11sm3604246ljc.97.2020.01.24.12.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 12:09:33 -0800 (PST)
Date:   Fri, 24 Jan 2020 12:08:11 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        t-kristo@ti.com, vkoul@kernel.org, alexandre.belloni@bootlin.com,
        arnd@arndb.de, soc@kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Texas Instruments UDMA driver
Message-ID: <20200124200811.ytgs66cg5qpugi5c@localhost>
References: <20200124092359.12429-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124092359.12429-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 11:23:59AM +0200, Peter Ujfalusi wrote:
> The UDMA driver is used on K3 platforms (am654 and j721e).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> The drivers for UDMA are already in linu-next and the DT patches are going to be
> also heading for 5.6.
> The only missing piece is to enable the drivers in defconfig so clients can use
> the DMA.

Hi Peter,

We normally like to see new options turned on after the driver/option has been
merged, so send this during or right after the merge window when that happens,
please.

I also see that this is statically enabling this driver -- we try to keep as
many drivers as possible as modules to avoid the static kernel from growing too
large. Would that be a suitable approach here, or is the driver needed to reach
rootfs for further module loading?


Thanks,

-Olof
