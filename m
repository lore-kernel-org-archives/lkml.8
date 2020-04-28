Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20912C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05C5206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uzz6rxf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD1La7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1La6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:30:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB9C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:30:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so10540047pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7mluZ8A4I9xD33tssLfMPlz8TFvmTBj7H//FiLCwMKQ=;
        b=Uzz6rxf2M+0uA0gqifTALGQks4hWRLyGGLFFT02xEl0ZpUVciIXpgIq1gLWPdfAZ5N
         5yy8L64gbdCHAqkLOXIH5OnuIedLJ0Zvhv4fpsYM5iQjhPkeQpNIfXRz1NH0+UW3dx8y
         svQWYO809ihQXo7WeYTtvcjEPZYLHdfasSMCPzy4ko0SYKhoEDGD80hzwFffKVrcwfhC
         14f6c1qi+Xuk4D31slGnBdu3nOYteQ3OBHuc/WX2rWNVW0jfDoIL2mKF9BW41MfZJseD
         HUldHwkxqtRtPIdRaoZgIcOHdCxjGOTYUJvwvRnPM6eSB1zdDNrZ8UQuBshdv3hpvnsC
         H1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7mluZ8A4I9xD33tssLfMPlz8TFvmTBj7H//FiLCwMKQ=;
        b=jCLpRSwOuuF1qqL5dRu8DGemt289FEXFVWsi22ADGuPbAzMECVpo4ch45b7ae07Sbc
         D3XVPpO99sJ/aqouybsAAkKGbpOUPOOtEmQd1lYATAndmxEwO+gmbJHBDOB5Jkaqxrc3
         Gxn3sG/0xixyCiy5/BQuQvcneZ8IIpCs/goCffDerYscL+x9S1cPLfU2GyugCrGp2BLM
         NrKxEARXqLhr8BZhnX3UocxxuRaMYV5criSEg8Mfi/p1cBH7/1PhQ3i2a8oZ7E+KOnxv
         vHerrfsGjcHOpNVOagnkJVpqZt9nffxGm8cwnT36dJ/tmPVxVM3pkLKUgKOlE2VxxjMt
         qGLA==
X-Gm-Message-State: AGi0PuZib4348+BymoepwaSC4gHEJ5OW1uki/u3wsL8wEF1LbgucdwQ1
        wo4oDyD4WvNbcerPvnkstL+c
X-Google-Smtp-Source: APiQypL9Kkbnieket+vePrygfOB6d5NB7/ZBGTCpfca9KeSGImCWXC/JlcXcQDHRS2TXxne/Tg0jMw==
X-Received: by 2002:aa7:94a3:: with SMTP id a3mr29670332pfl.101.1588073457999;
        Tue, 28 Apr 2020 04:30:57 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:816:a859:6d8a:8338:74e:a3d1])
        by smtp.gmail.com with ESMTPSA id y25sm13511710pgc.36.2020.04.28.04.30.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 04:30:57 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:00:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jason Yan <yanaijie@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] pinctrl: remove unused 'pwm37_pins'
Message-ID: <20200428113049.GA5259@Mani-XPS-13-9360>
References: <20200417092112.12303-1-yanaijie@huawei.com>
 <CACRpkdb5Ozz_MKAUDoyOxdnu_NkN72vRu=ZY7j_Lb5uMAiS3SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb5Ozz_MKAUDoyOxdnu_NkN72vRu=ZY7j_Lb5uMAiS3SA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:58:01AM +0200, Linus Walleij wrote:
> On Fri, Apr 17, 2020 at 10:54 AM Jason Yan <yanaijie@huawei.com> wrote:
> 
> > Fix the following gcc warning:
> >
> > drivers/pinctrl/pinctrl-bm1880.c:263:27: warning: ‘pwm37_pins’ defined
> > but not used [-Wunused-const-variable=]
> >  static const unsigned int pwm37_pins[] = { 110 };
> >                            ^~~~~~~~~~
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> I'm sceptic about this. I think PWM37 exists and just need to be
> properly defined.
> 
> Mani will know the right solution to this.
> 

Sorry for missing this thread before. The original patch didn't land in my
inbox.

Anyway the issue is, pwm37 is not added to BM1880_PINCTRL_GRP. So the proper
fix would be to add it.

Jason, will you be able to send a patch for adding it? Otherwise I'll do that.

Thanks,
Mani

> Yours,
> Linus Walleij
