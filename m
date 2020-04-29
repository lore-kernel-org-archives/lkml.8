Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A1C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA9B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsOjpN1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgD2OFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728252AbgD2OE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:04:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B01C03C1AD;
        Wed, 29 Apr 2020 07:04:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so797006pjb.0;
        Wed, 29 Apr 2020 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPBcF2FfVrezCkVfVS9t9YAyzwd55biPfb+yY0wk6dM=;
        b=GsOjpN1zvwchxs+kCyvjZX2MaVWUeJryAHPmK1unK9NmIqnKALLXavIPFrmkQusm1G
         oHDNI98LHHXUCXWVY9syUFo+KPG5IkgjRbTMSc2X7pyV2FYOsQJSByekFP+Cz3MbLT0j
         xVVkqS/3lFlKVME2drwyPeEUAYoTV8/XXUp4yadDYBCDNXvSqUzdOYDQikSjsmXJV3Vq
         2lsdWSvsfSUxQSJs03ivC6x9Gd0lh28MR5Q5T6jnE1RFwXX9cFMZ2IniBl2MVeWUHzHT
         HX+TweJgKHjiL3ZnHj7EvpRIfJ0OntRWz+m0zTJu+eV6Bezr0WakRmb8BDACABCZxaGY
         Zw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPBcF2FfVrezCkVfVS9t9YAyzwd55biPfb+yY0wk6dM=;
        b=lRNd/mXOy8LTcLiXq14KRNc7EOOJmiqR7lnNef8PIeuSz9R4Fqg6gFvm3oq/QNjRIn
         lY2RTPpRtY+ioq6Cbhzha4JFbKsF6SYGigZe9IKvX3RlEwkUteY86eBV5x1LL+uZlDPb
         YDWXlkJtIoagodI8NWdgZhj2d7aIQJ3ZraVjDqJ3cp7Nn5+2V4LEwfgVeI6Y8VBC0b2f
         cETasQ2reIRmfG41y58rIVjoJO5KjXg4KyOtpIgoZ2UrXeK4PKk00nbpV2S01rwJ6iVP
         buxrawyis7wolTABH48GlNyhb2IfH1Rv99lfc1oXe7RjUIPE8XX7mAFVBH4xgEuD9Cwb
         3VOQ==
X-Gm-Message-State: AGi0PuYdHnOtEP913Jh7V7M84yeaAShbCbFqzGK46W2BjjSy+w2Rm8zq
        fMYi9xvt3cn1Tdch97d7mOI=
X-Google-Smtp-Source: APiQypJrj6CYBAGv6JQcBo3iaVeKuV3x8Klx1zkIA40m7qU+79jkW8GBnBvQgxmAP7Ju+HtXFL8FFA==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr35057358pla.30.1588169096697;
        Wed, 29 Apr 2020 07:04:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm1174756pfb.146.2020.04.29.07.04.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 07:04:56 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:04:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/131] 4.19.119-rc1 review
Message-ID: <20200429140454.GA8469@roeck-us.net>
References: <20200428182224.822179290@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 08:23:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.119 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Apr 2020 18:20:45 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 418 pass: 418 fail: 0

Guenter
