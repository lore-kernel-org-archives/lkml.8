Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5AC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9A720828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHVx95hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:58:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40087 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:58:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so8646924wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=49MOW3x5Q2EIMR0C2C+zitJNdeJI9n/hJ6NB+GHf350=;
        b=cHVx95hVVTBbNXWIJhYbmieb5ZF/Vh8964RBQFBIRDXC4oLUKdd7Eka9cPJKwogZyy
         zJ5vu8P2G/CDGZYESWgkvbOuz5Q+SrPs04QR621E6OGXiyQE4pVVN2RprD1xgk9SxPJx
         oB8Mkv3BNCzNYuZWzdicoXbOX+7OawL1Lxin3BfTgmj9eZZhz7dzFLvHSwihKlEKT0zX
         F+meIL2ES5QH+/WtP1VChyjIPwW+GHorCRL7qj5SmxJKTfZTAjPeovS21NA/8tedLTZM
         wU1YFtvZdv6mF4BxulYSHcNpCK+Wki0mMgLmd7WphjZ8LuSTx+lcqd3mhVUKhFJDjsIl
         ySPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=49MOW3x5Q2EIMR0C2C+zitJNdeJI9n/hJ6NB+GHf350=;
        b=PVQ1U/tiE3jjLMgwPCqwuJaACEzCSknsgGnveyvam5G96owrWFhUacPC4RgFkLkTu/
         VbhgyKbq3arfGF5ea1n9yrmMxeB0p1Xpwq9n/yU7/cOGznURYjXnyGHA2jka6Lo10Z2u
         UATIqRylgb4ci7kHLnq6HrqQ7FfT1Wj20k4BqxG4IusP0n7O+hmGeKCWWDqrR1/k/GQ8
         P9hqFo6L0R6E35cH10ZspSqNLMNKwJzEODuevhYxB8V1ouw9KqsiNPyJLFonCThM0YHq
         lTnjHGCGtAyW/Cqb7ZA7bJh6TSSBesf9W1Mj0ET2exJUgrNMg1+u5sZ0jswKJHgDXoHf
         D9vA==
X-Gm-Message-State: APjAAAWBIVZ72/ZUaGDaLWqOHHnaLRXhdI6XdMne9M4onLuy7gDedLrC
        7Hffa2VRoMP8vVV2Ij0WZ1Rpyg==
X-Google-Smtp-Source: APXvYqxntMA0/kHe4mhcbaQePDY0JI+9GyfIszoT66eEVLA/snKqiqCvF94JeH7YujAmUCkzQFzxKA==
X-Received: by 2002:a1c:610a:: with SMTP id v10mr14045898wmb.44.1582538291980;
        Mon, 24 Feb 2020 01:58:11 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id e8sm11849943wru.7.2020.02.24.01.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 01:58:11 -0800 (PST)
Date:   Mon, 24 Feb 2020 09:58:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH 2/2] mfd: da9063: Add support for latest DA
 silicon revision
Message-ID: <20200224095842.GJ3494@dell>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <d4bf00408895f8b6d4aadc95e3059e5e3a848566.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4bf00408895f8b6d4aadc95e3059e5e3a848566.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020, Adam Thomson wrote:

> This update adds new regmap tables to support the latest DA silicon
> which will automatically be selected based on the chip and variant
> information read from the device.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/mfd/da9063-i2c.c        | 91 ++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/da9063/core.h |  1 +
>  2 files changed, 82 insertions(+), 10 deletions(-)

Looks fine at first blush:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
