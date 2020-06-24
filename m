Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C49C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAF42070E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEJJ/Quv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgFXEO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgFXEOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:14:24 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8679C061573;
        Tue, 23 Jun 2020 21:14:24 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i74so722313oib.0;
        Tue, 23 Jun 2020 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iAQq/VsT9CA2FMjizxECc7CCVbLLTCWZ6C+iBuPxAQk=;
        b=BEJJ/QuvCtP+ExowLocVriAO9btn51q64Q1V8RpPwkEtujtjIFyziHzM3tlrjeEpM7
         UcfMGbXo6Sb0DV04Z2UIb3EEHsqssOMWaJybF7JkFDo4waPJqRJmBZLxgCvmWo+WW3Bg
         T8u89lT9vDIjRKqIYyn9rMvAxgXWhpZ1BF5m8Sq1zhRVOoMhGboCH1GzkDrbyj0tULFF
         eIoV6tbwBvdS8uIOFzup/wuLV3MPOx3Za5MtZeM2RthWVmNfkvGLUSGZX+dNZk2FrAWa
         Rxk5yAsxghK881Av3+Ip83f3PKlaJ6N0cjh8gxpj4ZMsOI8vyM7sEOodeP5Un1t0OrrV
         1C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iAQq/VsT9CA2FMjizxECc7CCVbLLTCWZ6C+iBuPxAQk=;
        b=l7HzyIWby4E7NtbBBoiSW0bePpUk/jKga4VwqT2a9uZXB2G+tZZqZT+GKgiSFqu+6Z
         Bw/VKOU3ddKP8jo2Q+k/Kz9M3Bvx6HfUn3IdPugCokAQdV9uYptkgYucHlfHg1PUtF4o
         QOoGyNNcu1JOf2kCaxC6XjxDDmYXzEo7rR00TPtgJSjGuhaZaiZUVvJUvIupQ6BC1ZtL
         Oj059wnZSF0j9O9LVIZaWzkrK+288eKcCOE8ChBJhs07rnmOEv9MZDEMab84VffJNn6Y
         ejU0jbINnT1OhWzwtwK1oX4BVeYFmOvhtlQSsJlMskEjbmrNp/c0o4QOi0f88wzxMoK+
         sH/w==
X-Gm-Message-State: AOAM531Dc1LIjFBjKjY0kMVbcitcAu9CcMuLUe/QDZS5wSfRqbyEobGQ
        f72mWulGK3zfELRYgyNvZHplO0tpfbo=
X-Google-Smtp-Source: ABdhPJw3nel+zYx/Qwj0ApdotZfEiG3kGCmoi773MAAe1tusOXEQSjWYN9ZH8gntDR6HGnEKPGkB+Q==
X-Received: by 2002:a05:6808:254:: with SMTP id m20mr19380196oie.72.1592972064032;
        Tue, 23 Jun 2020 21:14:24 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id p9sm4565957ota.24.2020.06.23.21.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:14:22 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:14:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/314] 5.4.49-rc1 review
Message-ID: <20200624041421.GA2086018@ubuntu-n2-xlarge-x86>
References: <20200623195338.770401005@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:53:15PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.49 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I ran this through my LLVM build tests and saw no regressions compared
to 5.4.47.

Cheers,
Nathan
