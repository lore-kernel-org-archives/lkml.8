Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90721C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C7207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3CY6lFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHTUBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgHTUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:01:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2678C061385;
        Thu, 20 Aug 2020 13:01:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so1657521pgb.4;
        Thu, 20 Aug 2020 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+miwv8LAMr5TFIhqp9pUhs9myJFHfbcZ0KOW5GLjaQ=;
        b=D3CY6lFhRxSll8o41pCjala4TvvYO3mfWYyXoH6CHFC6b024EWDhqMywhjSR8skodQ
         ery6oobLSO+AQXZzGQ3FlY6BQkOnwl9BBXnqZyUGGOykRwtAelgyvez4zUve6o2pnhNX
         XDJPuERV/i1b/RO6D2eqGkTtLLOYN4ju9MRNK8N+0pNJOaMbZdTIipXFuVAYNHHe5kG0
         CTndAbLa8i9OkqqRLjLv3zyriQIRmDe5HYQIDmb2P/HbAc6ZcODF/YWtA19QqvkQI2DD
         nzcqahxt4onOr1jA8/lDxUsDtHabRmKYWT5xC/DQIX7comSujF1F56nLPZ5laNaJeWX+
         giOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+miwv8LAMr5TFIhqp9pUhs9myJFHfbcZ0KOW5GLjaQ=;
        b=Hi35zN80wFGnjPxmbIipm2izbeMBgx45z6LSbX0YYHlmuTCKXhTYrzHd/NgDbIBPOO
         WDuMaeZ137zK6YxMZPSJyIG+qUsNLVM3xVhVxGhQmcPCYBAfSvG4Om1ucU5Gtzqa6g5W
         dEhQLYEzchSRk6GzD9sxQpHSbuAnGuJd8F/zEyVEcK5GuJ1kKF5+fOEtZIQDXxrQ2n9D
         RJbCvb7r/01LSb10YSGyGMadJKqTJQXQBTzUXmKTmXD4rFPjgs+uEFhpbT6LifN2Du+C
         AwdpEZ6+2wgXHa/ecR3ts5v/PqDuxrbTeXgABQV2UvbY5PPSOMF6BymhcvP3dI7//q34
         j6sA==
X-Gm-Message-State: AOAM533YQYLKGvyY7KdbNB3+hxe1T27mDeJPi94vKzsOvcvzJXN+5Imn
        /tKkK4BmGcU0z2Abdq65q0Y=
X-Google-Smtp-Source: ABdhPJxKxG/PPWqlLnI+QurhdIUycK59OyOk8X3EcAaavkqEeGU+2MohjLrqPpmS9J5XCZ3RaTYx8Q==
X-Received: by 2002:a63:cc17:: with SMTP id x23mr293746pgf.19.1597953693195;
        Thu, 20 Aug 2020 13:01:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y20sm3687790pfn.183.2020.08.20.13.01.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 13:01:32 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:01:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/149] 4.4.233-rc1 review
Message-ID: <20200820200131.GA84616@roeck-us.net>
References: <20200820092125.688850368@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:21:17AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.233 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 09:21:01 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 169 pass: 169 fail: 0
Qemu test results:
	total: 332 pass: 332 fail: 0

Guenter
