Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C68C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416562071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585763138;
	bh=rZPZXjTAMDwe5Cky3FeT9r7yAafZIOkFwvPk3a6wdUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Twq/u1xDXeetX8byuw4eraA/fno6kQ6FE0K+2sMEznMbu7pM/iHxNRsJZslyqGX5F
	 +fg5IecyV2u4rnG86kUulE8U+g8+3DBdSC+kmx+3J5mXXf1HDTiU7huTEarmA3v0Ms
	 67jY3CPoaHkLXIuKOKSFXmmx+hVMvgjCMtVQv8oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgDARph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:45:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50493 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbgDARpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:45:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id t128so673166wma.0;
        Wed, 01 Apr 2020 10:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwqDTvsisPwfePCehfqr6A88g6Iv1ZMZQoZxC5C+jkQ=;
        b=AhP9xt+tFIItFgOSVdMrHojPCTwCvdlJp1g6h8sqHMr8jxj6SOaDxm+vQfCBqb9rWq
         WLcJ85un5JpW69ES4eMihXsuJqN+dfvUjUOGv3tSOz8NG+e9Ir6ZaPZ6LM5ZydqHdG4o
         9Yasr9+RWD8vlAzihcwx1Amo63Bko6VDSdszamRBqzT4NgwqC4rfpPiSE3ZyMye1Q0ax
         R9dXQc8TxufuKmN1WK9Z5/VyYM0N8QVUFQVsqlU2HIcPYUIHPSUhEMtbMbOCpUkK4RgB
         WFPc0UTT4GG9M+raqHb6l7k2XAhKUpYrbWeZtmN2ul4rwyY3hq9JBXv/6IJ7QtrQz2kM
         0boA==
X-Gm-Message-State: AGi0PuZqvmisjwkbJ3PLO2lt1JkmVEoy5is6FJxuH7QtOTBIuEeYCRxl
        VcFz3vs9FM52ZFBDPNFk0Rmy4pAU
X-Google-Smtp-Source: APiQypLeUEHvXYR2K3Q/4pSafCxa25hrl6/8SYqqEtMpnqTrGOVzbzKiNNFirdcEgOYfWPNvD2uz1Q==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr212700wme.90.1585763134625;
        Wed, 01 Apr 2020 10:45:34 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id d18sm3998416wrn.9.2020.04.01.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 10:45:33 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:45:31 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: linux-next: build failure after merge of the hyperv tree
Message-ID: <20200401174531.by77tjkc2w33fplw@debian>
References: <20200331172335.2f71021b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331172335.2f71021b@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:23:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hyperv tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "panic_on_oops" [drivers/hv/hv_vmbus.ko] undefined!
> 
> Caused by commit
> 
>   a6a5aa4b0179 ("x86/Hyper-V: Report crash data in die() when panic_on_oops is set")
> 
> I have reverted that commit for today.

I will remove that patch from hyperv-next. I have been busy with other
things on Monday and Tuesday, so sorry for not paying close attention.

Wei.

> 
> -- 
> Cheers,
> Stephen Rothwell


