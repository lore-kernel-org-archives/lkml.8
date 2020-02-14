Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB58FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3270206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="Wm9qOazS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbgBNRwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:52:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50744 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388661AbgBNP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so4053483pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cISYdBXk2YHE0Hv5QeEUFIegtZb+aZP3D0K2PcFOxv0=;
        b=Wm9qOazSsBZqOW7bBRLJEkqORGDUsQVeYt23qm28055nc0seZE/6WvXTJ4ukn44RRS
         4sSlU44l7wArk/bgum3DqF5VvVRIzFSECMBntydVeAEtu9Wrj9Vqw0qnFJ5ngo+/u6IE
         wY3Q3qkaW6DOsmktiKfHxZSFzB54Z36SD8n+bQu88+CVA9TMr8q+gI5KNQSiE/CDWHew
         FO/GChYLjoOevw9YhiDOlQKk9r4cchbIe4BHKZuOBoXBKzOJPxdtLFfU3Q0XhJVe9hXT
         KUJNehz7NNMcSIqxbYBlqhBX2lXhwW4btQqe5UA9eB41aXFQ9iisFJNMM/dW7fvUET3o
         4BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cISYdBXk2YHE0Hv5QeEUFIegtZb+aZP3D0K2PcFOxv0=;
        b=IXP0pPfYjCQwl5sF2x7GE/uz5cnT5Ey5Er8S6/PQMYe4J4oRNB3MOMtCTb5A2oQF+h
         /KU3LwSZpFsSd8yEN0K0egvufl6jv6ZzMKhnlQnc6sdcihGzxSi1CK7LQqnS5oBM/94n
         3WQvsPhqGC79W0yDJuFg90yC/yzCTvN3Zm6YMln+Rj8objLbmh472CDzy/u89LLZwrHa
         C2noMfDQAvqeIm7xJosqdxvAzBG4dUegAzwK9Ywq9S0M4kIr/pMT6Qro24bLL3hzOztO
         wZl3nWCw6rSWa6k57bH0cGRF1oMGXjuDv+frzttnyQJSb3wMsDHjsyXPheQPdJgXvDTX
         Oaqw==
X-Gm-Message-State: APjAAAVrZrZM2MnfGwiQmf3CRVOsZLP/4Uje0YO1zjAdFgS36Sm88MBK
        DoLQz3OA3zPlkV3liVQas1Vt+w==
X-Google-Smtp-Source: APXvYqxwlJ0m6uM/kOjvrdm0keDywJW1dC1Cj1dLQ436kTE9gW8qeoO/r+EEjwjLZXI4sbqhe3ZUFg==
X-Received: by 2002:a17:902:7c02:: with SMTP id x2mr4126952pll.60.1581695921762;
        Fri, 14 Feb 2020 07:58:41 -0800 (PST)
Received: from debian ([122.164.201.151])
        by smtp.gmail.com with ESMTPSA id t11sm7016598pjo.21.2020.02.14.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:58:41 -0800 (PST)
Date:   Fri, 14 Feb 2020 21:28:34 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.5 000/120] 5.5.4-stable review
Message-ID: <20200214155834.GA6389@debian>
References: <20200213151901.039700531@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:19:56AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.4 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2020 15:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.
> 

hello,

compiled and booted 5.5.4-rc1+ . No new errors according to "dmesg -l err"


--
software engineer
rajagiri school of engineering and technology
