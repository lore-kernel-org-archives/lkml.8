Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AECC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE20D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOpXtW7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBJVmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:42:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55645 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:42:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so341182pjz.5;
        Mon, 10 Feb 2020 13:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=baZ25UtV9sNUw2SLhb00FQ7EOUJi7kFbGcP9gfEfUcI=;
        b=nOpXtW7izojtFRlf1H+RxkZGT7zt/7fSiMLeUWBmDIsZWoeBDuADQQxHykcQjsp85N
         Yjd1r6I6epEU4zmc7T4PIGJWaYwVF+c4+/knkVlGtFd95mBfr2ONabVGjHpzm09k9H/s
         fSHrr4IzR6z66VLVQpD+S2sYB5bjeEnSgVENMutaSYeq11ugZi/zZL6biYyKhLbokYgY
         AxGmX7+InTFCEVE9B/UIYivJX/zzwPeegIsDQtj8czVstwFnyxlyzka2/oDaP/U/NgW8
         eZqZYTvxTIIxHFADpl6P/04e0cDDTvp3sJn4sw+DcCXN1GXVagqBRTsU0FEyE7LrgAvh
         J6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=baZ25UtV9sNUw2SLhb00FQ7EOUJi7kFbGcP9gfEfUcI=;
        b=RfST4n8PxVBdi2aDhjVfr1K6bOzqsYnmfxJM5czslhZtX6tmaU2czM9t3ieisXWNkY
         34hUt21y69pdZcvZSTxI5alJ3skGbwlta8KgXnq75ZAUdVs3EPbZOKptMnZINYJgCeaD
         /DHyK+mbk04L+c0f4+Cbs0W3YtFWPOx+zUuvH/PQm/KLPu2HtCKZpT7aCGo71PLMYbgk
         3OKa7ynzesrv04fSOQCVqrIesvhEupLKRFR2t3FqrEkEHaHXxu5uORmyE0jL4iRw3eiH
         PFzWe+Dz6X4xJ6rUCgPhQR7uSiKqWGQ+ayswvbtjzNqppy6WuZPsxxdnJNNDx1qp5OPg
         uZ9w==
X-Gm-Message-State: APjAAAWCbvb+s91PuFkkNlQSl8Rva5a7mgYdgJdhb23snsB2GFtIBSmh
        em4tyEY60EU31zk0Tkc9Tcw=
X-Google-Smtp-Source: APXvYqxyGRGCmvZR1f8MeKjUMh0H4D2A7oO74ddUsYTmjdOwRI0ME6zWQAZDvOJzmIsqxXTECBZstQ==
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr14655477plj.287.1581370939724;
        Mon, 10 Feb 2020 13:42:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l1sm341398pjb.28.2020.02.10.13.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 13:42:19 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:42:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.5 000/367] 5.5.3-stable review
Message-ID: <20200210214218.GC26242@roeck-us.net>
References: <20200210122423.695146547@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:28:33AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.3 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> Anything received after that time might be too late.
> 

For v5.5.2-369-gd9c695759fb3:

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 397 pass: 397 fail: 0

Guenter
