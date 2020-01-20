Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E441BC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4D02077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNgc40bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgATItE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:49:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:49:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so28585361wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lxugTqd5gx4s0FvVRSPm+5otlIxwWK1Pj17RAfoBOS4=;
        b=JNgc40bl0G/QHlFAX7ZtfW5yBwLXYxJ/vsPFyciEnFpiFzYjhVOBK0Tu0Nw56qLXrF
         s9Fy8zsOy6Tk78ielbCEgz0i+XiH3sv5x69H6Yy0WXdizvGbGg1caE0RdxxflLNNabkD
         rcmnp8bHMTMDM4r4ubum4hpIZzTrNmEfMigiMNeeeXcTkVmFlPc6SqPPsGIA0u5bG6XK
         qo5AU2ltXN/XPCkMpzB4ySRrWXSwT6Aj/7j9CqW8ZBKHHy6RJxTPZQqok/axcdXjHXxb
         w6TByw+GQq9rskEZyG1JQLaI7zi+kAu9BGCtaMHu7IXwR+jleeTCC6xVJupnigWoXR3T
         knRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lxugTqd5gx4s0FvVRSPm+5otlIxwWK1Pj17RAfoBOS4=;
        b=CxdiyhLsCs9WbJK2Voxgl5yFVElZfHf93smLPgrEdFX0L00MLI9ZVUUrEXCiAInNRv
         KLc2v7xDWfYs2Fv/Du+AnLUBHUN/wWIlC4meNy07m+K8WmSABYhZva7Udt1PECbdLkYO
         qtEgjdnYsoindjX6s0JN+aVfPfMw5Pl8/wrdOsTRbHggAovxQlIqmTyMZJI4Pf4XMAoj
         xQIRK1ehS5YPrq2FQyOtnIFU9t1LDYSCmjmPiIublATNnWitXHTahbbeVaCRmobHWLwP
         DrsuQHN4z04BqBJjz5iWNbsMlQN1EoehaVa1er88PbT36R4LFrq3jjij3pLcS36poK8a
         4c8w==
X-Gm-Message-State: APjAAAWM1P0QpYT8C6I+B8peROQt3hktKApZHVwV1Z0fbadUTypgnouq
        osez7rEi6rdHCZZbdZTJEeuyuw==
X-Google-Smtp-Source: APXvYqx2RJrI4RQGXHHZQOVf6Uwexmpsyu0RtvPRcO9+u34yaNc221koOFIDxVYnabwCKzmfcBesWA==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr17901121wrs.276.1579510141773;
        Mon, 20 Jan 2020 00:49:01 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id y6sm45296009wrl.17.2020.01.20.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:49:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:49:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/5] mfd: rn5t618: mark ADC control register volatile
Message-ID: <20200120084917.GY15507@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
 <20200117215926.15194-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117215926.15194-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Andreas Kemnade wrote:

> There is a bit which gets cleared after conversion.
> 
> Fixes: 9bb9e29c78f8 ("mfd: Add Ricoh RN5T618 PMIC core driver")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
