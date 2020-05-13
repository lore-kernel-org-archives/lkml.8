Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF664C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238FE205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsyUIgSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbgEMREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEMREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:04:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9BFC061A0C;
        Wed, 13 May 2020 10:04:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f23so23908pgj.4;
        Wed, 13 May 2020 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fT6HyV/h1wCZ25VWqp80kgjA4HTLZqSUdDpVlFinpGU=;
        b=hsyUIgSVbYq0g+akorqUEZ2JwJb8hwv6xt/6sj+7clfu4Un0I0wcls2dhcpd7L+WyZ
         f8XUzJCB5KqWw63lLQwBISeSdaiUqNk9/cTkAEWfLHdqCKl+Ne9SjQn4oZMeG5sgQbgc
         nqtXQXuJyVbvNY5vHw1fUYQq2MUeC5DiTYWwwYqn0p5H2JGhF2Vjv64ZXJQoWQ3haRrZ
         Qz1XI13dHEQd5BTJ1v7yrl1b7mYiSuZ0pjcr7OwblvxQDgsCffD0MucIl+uG7hInteLO
         j/d0qPHcuxL/TczLcSEaS5vsPY4IENrKOkuoCsXrvHzRM1dYBRO34SMSAwpQdYMfSWfy
         09iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fT6HyV/h1wCZ25VWqp80kgjA4HTLZqSUdDpVlFinpGU=;
        b=AA/YyPTqr6VwaP8jzVY30WFoPViSS4ftOzwhAFCtUuUbFWZc1m2x+mdIjxC5pKOMGS
         Vcnjb06YpRNfSGtn08SSGFlxRUCE9M9tV412O6DTXcfePeo8tb/lBq5Uz1MzT+Sjx/cQ
         rEl9nRL9vfKW4LBEawtP0gEVtx3v9HghRCp0fTRL1Yi1E2JZEDcth+p4jdL/GkLOp1H8
         7+Mu/0ZtoiJWAXPlvGX/E44HwvdfcxyYmphQ+OEtq409B2tRS4wreUjxvG9Q6ta9ad4s
         zGx+4cYTBVzy8wFGV9oKtuEf+UMyaZ1dA1BBzu/77FjZr3G+BJjFFzrI7zJ3hINjCZbc
         LjxQ==
X-Gm-Message-State: AOAM5338qzEcToexhuZkAZ7t7/vckqElWF1Sgg9nM9fjLgQofQzIN1ve
        5MQGKb0RYEOCVu3FENk1bMs=
X-Google-Smtp-Source: ABdhPJznMQHOd0mXc62iuRknY93cdjrjtkwjSgU0KXb5UZ35zpCpqfpVtJPBz6RS2Hotm8rtEpApwA==
X-Received: by 2002:a62:1a49:: with SMTP id a70mr250920pfa.63.1589389453905;
        Wed, 13 May 2020 10:04:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14sm99017pfj.90.2020.05.13.10.04.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 10:04:13 -0700 (PDT)
Date:   Wed, 13 May 2020 10:04:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.6 000/118] 5.6.13-rc1 review
Message-ID: <20200513170412.GC224971@roeck-us.net>
References: <20200513094417.618129545@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:43:39AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.13 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2020 09:41:20 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Guenter
