Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3225820855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtJbpWpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgHFS6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:58:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC699C061574;
        Thu,  6 Aug 2020 11:58:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so25615697pfu.1;
        Thu, 06 Aug 2020 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUhmwo8Hux53SBawPwS31icEteRHFlSr9MmAdBFy7rY=;
        b=mtJbpWpZUhl3/tBO2bBHlgHT9PtU/DTjx1GAJ0n5HRZE/uOy1yL3NrvpuGbb20qLuB
         NIKActYrE/SjCM+dtc81RXU3CAy2eDV+T7g+NtjDb4zDmcboaFNwuEZwgLuu9g+bOCEU
         qeeCSdGwL/Q051ifgF61ppobD834RCdFuFxzlklGbIpQouG3Kn2+NgcvIPe2+227SeQS
         z7vActZS3JTqADmtklWNIZtx1YBeP0BUloIhMMi7IskCpqHiJQq7U63Mi99ADY5RbRjC
         xZGdtS7ooC6hI9HjltVidzruckn3waz+RXxb4AB/7B8SZE1FoSIuNGJSXwoS3+ugWaNZ
         FlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUhmwo8Hux53SBawPwS31icEteRHFlSr9MmAdBFy7rY=;
        b=QKxI2rKseeLKKVZIf6t9/WPOqy9M0FgHWPufCs8jLjsPWVQ7ecFsDYxUdNaGX6b9PQ
         y6YgvZCZ4WmQryPiDPDv3TDzh5Kptz3fi+n47nxBg+Ykaeltl3bIXYDZ6V2X4weKTObA
         Ea90wPGYYJviXTONqGJmi/qRTem623hexYyiRZUGUixcUl0pHRnc2aEDY9k/zLm0YB46
         mpaSv5XjZIY4ZacYwHNlezHSNaJU+F6X2pZs9dN4zbyBB1Bzew8en76aW9yCgrGk/+AP
         4fdsyL1tPRnpLRg4vTmenR2lAdSZztJXmWDIKdkbzmfi8L3xzZXfveRqFqI13/2xOQq7
         Fhaw==
X-Gm-Message-State: AOAM532PPiX99zyKTl/DoQ31zhGbn3vzpTgWYuDn/EENMEj2NrO0NQLE
        n+k2c6Ow+2KHwjU8nRr61O0=
X-Google-Smtp-Source: ABdhPJz6qRXvo5087EKzn585nVKDIZYzt7cxe/uZ8rfLEGIiTxxMxp/LeFz1dig5VP6uThR3OPXf3w==
X-Received: by 2002:a65:6289:: with SMTP id f9mr8419638pgv.272.1596740298374;
        Thu, 06 Aug 2020 11:58:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 35sm7324831pgt.56.2020.08.06.11.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 11:58:17 -0700 (PDT)
Date:   Thu, 6 Aug 2020 11:58:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 0/9] 5.4.57-rc1 review
Message-ID: <20200806185816.GC236944@roeck-us.net>
References: <20200805153507.053638231@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805153507.053638231@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:52:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.57 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Aug 2020 15:34:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 429 pass: 429 fail: 0

Guenter
