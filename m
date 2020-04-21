Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B509EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C240206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587493885;
	bh=fXssbin9zIkSttxLFOR5QjvayCYH/Me9+2kExgf8kcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MveMFUeNk6Lgivm3Mp5dwahW9+W6Pthvd6VVwIIeWo+juDmt5CNZqox7FjAInxGO5
	 hWcwUxdizoLr3339paJ4vAhueExkoipXgcMVgCF7goNP355TvGTlQJb4MPK/MpSNNv
	 +7O8CHBSDkuXir3dADH+CdmxIn7hoF/zIXGog8+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgDUSbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUSbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:31:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4ADC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:31:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 92so1994692qtg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBz/0wOnTCCmpPszYn+oabaHyLl3HDHXxMJEJ6NS0jU=;
        b=KGOT3oqQ5JlJ1sZn6S5eaH2oN6QjpS5OkaorHZopxJxonMX76fIxNc63JIKVGjUuWs
         lnm3Ggg8i3ckuAWVuj8uDaR0AKWJW3To97ZwKuePpux5ARXxNktDJDIeAo11yxZgeGRi
         dplYCsh2B8OQ8TH3dQCIjKvoQ3CqDsX7JzfzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBz/0wOnTCCmpPszYn+oabaHyLl3HDHXxMJEJ6NS0jU=;
        b=DvzBlabBRcs9jkWZlqYLzh8vYFfxlRiy3m2CZqjLNqn3wzOTJoqcCHD1e+Kz+TaW43
         gfKsMysEOZYY/v0iYQ69e/VToWI8bGzBIPHdtmQ4Si5bzkPWnNqXaszXM5qQcg72lxga
         RHBlO3dmPviZ3CjN2TRq46ZjndLD05V+lgZQ98StwZPmJQBH4SVmWjboYsMM5ENVAxVv
         H/b29/XVwvqOELj779G5NzQz9fwyuTBYUV0it8ebxlPDii4i22kOsobvB61fE/VvmVTu
         KcLqcRTHLtdile6GnVMSuzksQTDGV+bioZJfpML+I7aa9syLw/l6hPzywROjGcCFoZuu
         5Pvw==
X-Gm-Message-State: AGi0PuZ6OmSctw7QI3XYaHwTq62RGUQ2z05QzpGCFMdrkycVRf9kcaKK
        RpOEzt+H45mFaYgp37F7QMG3GQ==
X-Google-Smtp-Source: APiQypId/nvmXqxnXkiHDNZP5gIEIHkE6obQx5jymRKmOarSYMwD/jhz7GKazPIlCz5G2Q20+/4rUg==
X-Received: by 2002:ac8:bca:: with SMTP id p10mr20913254qti.243.1587493883049;
        Tue, 21 Apr 2020 11:31:23 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id x24sm2308038qth.80.2020.04.21.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 11:31:22 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:31:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-ID: <20200421183120.av3yqoaulhyglppy@chatter.i7.local>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-2-kdasu.kdev@gmail.com>
 <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
 <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
 <20200421171558.GE4540@sirena.org.uk>
 <0d91f426-e767-2e69-bcb7-ddc4d7611861@gmail.com>
 <20200421172005.GG4540@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421172005.GG4540@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 06:20:05PM +0100, Mark Brown wrote:
> > Could you provide both links with a market at the front, e.g.:
> 
> > Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> > for-5.7
> > CGIT URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7
> 
> Ask Konstantin to implement it (I'm using b4 ty now) and I might!

You can do this already in the template, if your treename is set to the 
https URL.

----
Applied to

Git:   ${treename} ${branch}
Link:  ${treename}/log/?h=${branch}
----

-K
