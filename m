Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58AE21734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6nm8z1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAVARG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:17:06 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54669 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAVARG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:17:06 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so2193378pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mjGh2rwq9I3yBu9wgudpicRsuc9hY6/QsJSVCCsHLPM=;
        b=B6nm8z1qqVez+oK+7yTJg6sszlYC6O9kGXtD5kpfkQk4qprMXwbCnzzyrMZ8b8VVx3
         SHIkF9fmKCI0p/graxqyCJRTBihfEu//EO1/xJEcZjUSgKMnTJuQLcW6BZjAMKuUZ+Jp
         pE5+i3MEJk3lQKsPBbCwM3FJ4eCbwBAClDdfcNMqcnGo9kiuCxzQu9FcJzyVkfcU0z97
         gDwCHMFjaBf3tvXU4QUSQCklUtXkVlZimYkHOsFKJZNraUM1fcb6jFVOdXbg0fDKE/7A
         OkBfHAPAH+QLZKROd1JavsL4P8fV9e7QF/OjVY34cciN6Cs6Y9sm1fa1ZCaqzSvW9PRt
         HYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjGh2rwq9I3yBu9wgudpicRsuc9hY6/QsJSVCCsHLPM=;
        b=eSLAh4DdT9Vo9fcZ7cQNbVW13ieFIrC64QicvzoB4KpJZdyss86exHS+taY6HU3lVE
         sfu0KachloxsQe7jQfwYs0LN2xNpCUA4+RO+N16ua6obF0Kv6DpYMRQr0gBIM/LiAw+T
         R5f1uc2EZOCsytXIJijxx0yRE6gFOlBXPQYfzGHXbNzUj/Rjh3gUhkLLLxBuTdYZ9/eS
         V3T+fyJ6xWLL0GpHpI09j67MtFOWH8LgUWXfauQXW0Dl9DaOhImLclu/NJCzlGaycn0m
         E/FtJ/uQ07Q6x20KVjAnuNy8ovOw6WcHIoR3tDIRb8aFC3f5ZXDkbBJxiG1a+xuplSlR
         cgNg==
X-Gm-Message-State: APjAAAWgQWUQcX1lGeIjWopVVgGPN4xZlBxXP1EIPtmzR9MCKcvDSL7T
        7iy4z8KiUFXA0c4Ln/tyXLYdcw==
X-Google-Smtp-Source: APXvYqww213yTfxwe2vax3fLM8dUAmMVmaR3lFSYn8kc8oBNqMcgFYUTNCt8/44plN/68lG27aYtAg==
X-Received: by 2002:a17:902:9a90:: with SMTP id w16mr7975360plp.93.1579652225779;
        Tue, 21 Jan 2020 16:17:05 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q8sm43284302pgg.92.2020.01.21.16.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 16:17:05 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:17:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     ohad@wizery.com, baohua@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] Some improvements for SIRF hwspinlock
Message-ID: <20200122001703.GD14744@builder>
References: <cover.1578453662.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578453662.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 19:23 PST 2020, Baolin Wang wrote:

> This patch set did some improvements for the SIRF hwspinlock driver,
> including changing to use devm_xxx APIs and removing some redundant
> pm runtime functions.
> 

Thanks for resending the three series' Baolin! I've applied this as
well.

Regards,
Bjorn

> Baolin Wang (3):
>   hwspinlock: sirf: Change to use devm_platform_ioremap_resource()
>   hwspinlock: sirf: Remove redundant PM runtime functions
>   hwspinlock: sirf: Use devm_hwspin_lock_register() to register hwlock
>     controller
> 
>  drivers/hwspinlock/sirf_hwspinlock.c |   46 ++++++----------------------------
>  1 file changed, 7 insertions(+), 39 deletions(-)
> 
> -- 
> 1.7.9.5
> 
