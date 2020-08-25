Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E50BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F2320715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRLhhKcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHYTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:21:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB13FC061574;
        Tue, 25 Aug 2020 12:21:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z18so33682pjr.2;
        Tue, 25 Aug 2020 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y75gKhcilsbbEQww/t3R7TElbNjrIA2Y4Gg2JbEZ2dg=;
        b=JRLhhKcpjYbaREvwlyz5UQ+YH6RLFch6ei7Cxubifq54g+Sh51rdEWRMSO+bIWXa3m
         H1gS0z/BLNvBtOENyNOVQ8qW8zF1FCwEsTIpc3Zxglr7Igl8m9GrV//2/VAr4pyoXzAC
         GIEKznSBFKy1TL0plDv2tpUEZEcYyEnmRyQL4kZ/X6K2zyvcSlm5OAc0Ognx7oHKm4Hc
         uGqm9T22vDOYmkKPvH2abEN/hY31DruYr+pN3ecOT9aESnSKzOu0rtNl3p9IpWIJ5Kja
         V93CQjkmv4dJrtF1ryVAbaCskueLF2PMwy9r6CEVCv8rcHf694oBM5XmxsTqjGo3wyjJ
         Utng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y75gKhcilsbbEQww/t3R7TElbNjrIA2Y4Gg2JbEZ2dg=;
        b=RZ93inJjDtcbuZM7P+ysswWYvVG7HcWcUVxJgikCA4k+d9nc+wfQq8I24MRFjNNTuT
         OHDoBCWZAicstfzrHoDK6rtmqhS4rR8Na1Qy1JQ6RJxagYIq75lPluFGOC114aZR/ztl
         lIrfdJZAY7kn4C70+pkoWI2t2CThhLK2UiH8UIyNEz0YkflKveOzwsbNGQJlPgCbLwx7
         frtOVVDlv9N9NpfXDt2UUulSwEpPWWTgIpzeDlrctqBAcmVf1k8OtqrBzVRGKQVxIgvw
         gpPOhgeJ51gg+sxuU33N/0zCVnOkjAdeg3X0QhdTgkUnVtvuSjDWrMgeDkftlRV/UvAb
         XXqQ==
X-Gm-Message-State: AOAM532gdI99mdBDzh0mrqtAZJ8Y8iq+5Yp2Ci9X0GvsbuCDQ420NhQl
        YXkbN2WVicmjBUXBV9Kuu3o=
X-Google-Smtp-Source: ABdhPJw+2SN64vh95LsGwRC3QmnMi9Rdcs/LGCdn3hAym3qWeDPahWTKPV0QGcBBZl7nsdtTU3EoRA==
X-Received: by 2002:a17:90a:4586:: with SMTP id v6mr2595801pjg.152.1598383273396;
        Tue, 25 Aug 2020 12:21:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g129sm8987pfb.33.2020.08.25.12.21.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 12:21:13 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:21:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/109] 5.4.61-rc2 review
Message-ID: <20200825192112.GE36661@roeck-us.net>
References: <20200824164737.830839404@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824164737.830839404@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:48:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.61 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Aug 2020 16:47:07 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
