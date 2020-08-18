Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70159206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNS0Httd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHRS5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHRS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:57:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E9C061389;
        Tue, 18 Aug 2020 11:57:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v16so48494plo.1;
        Tue, 18 Aug 2020 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hv0wrh2UDV8sGlOu+yoYy9+0yg2fCQ5Tx2gwhOUkEp4=;
        b=rNS0Httda08CwH1avgOMZF3I6fQ2IL9sMmTzfdkyCQIL8LyoTLt9sFJJEqKiHq6c0X
         fcSn+zGzgFWFZEZ6xyWNDoE/5lzC/GrkzdztIi6q/BFuXjcyhZl96/9qs0xFfMClLM11
         AY50e2d+FE7lyoI/he+0mMi0sl3QY8UASCWS7J+TiPPCui3JN8yPl+yXFq49XugA9kCr
         qk1GDGvsrrhyEjDaR7HrLSBttgdmjmQ46us+NB2Zp3/WWdip9p9kteMkgxfEU2CBuPVl
         ILpA6wK7iPuDv0nwqOM3isZouXArg3jDMmVAWcAtlvFhA5AfoPm3KztxhqX1JsVAInHr
         SPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hv0wrh2UDV8sGlOu+yoYy9+0yg2fCQ5Tx2gwhOUkEp4=;
        b=J4Cszm72IiOoQsBpe7ROJRdfduP0FiyA2FCxNIolw8AVvMU1KE3WJWsscaWuSHPyoo
         Vha0imeM0yn1LRmq9FsuxVG/F9QPIjo5DFvAfsOE3SpzwmvDtYgNYm1Wq2+GKBoi3clB
         B544YDryCUJmi5Tyoul2EZo9b5AS8XDbhHgmMKU/Fty7NwHBvNCtF09sDR3Yn5+KnZsa
         VOktb+Kx/4pzrXDI17cRh6GNllPb/1l7J7kjg+ZwBVs0EW2T1ZzNWthe5Fci3VA9YfwT
         V7QxmHwbc7KEMqmx47Lfr4CgjOCzjVdrLNmSck3jjGxExftWqAwg/w0UxcaUvzoyRtNw
         l80g==
X-Gm-Message-State: AOAM533k6PipyluRkYfrmyIQBPboz3Frd5Tr9wckk3rvYngM0HDqBEU+
        8DFngbNSBPFU2r9iZ+amxIY=
X-Google-Smtp-Source: ABdhPJwpUgfmP6DK4srwJ1Ecj1Vy7LnlvuajmDvnlEcPubihEcRAlDcYsJgIwEmohBHN2L5lDpMzQQ==
X-Received: by 2002:a17:902:aa91:: with SMTP id d17mr16413273plr.27.1597777061378;
        Tue, 18 Aug 2020 11:57:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1sm25757745pfu.2.2020.08.18.11.57.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Aug 2020 11:57:40 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:57:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.8 000/464] 5.8.2-rc1 review
Message-ID: <20200818185739.GD235171@roeck-us.net>
References: <20200817143833.737102804@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:09:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.2 release.
> There are 464 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 429 pass: 429 fail: 0

Guenter
