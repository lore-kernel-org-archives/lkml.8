Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C95C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59859206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaJM9Pni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgFKCqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKCqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:46:08 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2178C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:46:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so4702832ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSwJBC/C70DEZoNyejL2OpF4sigG1AZYU4LYk1z1c98=;
        b=HaJM9Pnicj9K5t9hjHcLMjrmSXZx+f60pqIst9ZZ7NETX/VkKX+lCnABIjKvubjUBh
         RtIYsrIGk/FPaNDwfTwSWs68E+KSoErzQOUVqW0VSi5tD7KWX60JKyYAlS9jwwDPAFt+
         RGJ2VNagqRm/ZbkdTIB6tDi0crdI5qG3Dnqyku1tlSrquhGStkL/qUf8atvGn935oq0j
         crkn5/0M2ECHGjdn3JbSQlKUARmVH06OtCHdPPzlu5+3wCWqwkcy+2f7Lz+ScPLvgzro
         en78CqevdvD7s1cMMuwVskUB9N6vmaTxNY7WI/K8zZwb3iRq7ERjFB6PK9TQYI0smzTb
         PZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSwJBC/C70DEZoNyejL2OpF4sigG1AZYU4LYk1z1c98=;
        b=hRFpo++M82sBUBmmjvgGGMsK7umcg+eQEVNGuBHj2CouFKEPD0dQGjSIg4sL/Hu1dN
         LCeV/l9YqzG94H3GD3cltzRjiVoQdRo1DNxatjqo9FzEqgzOcNPgPesOoogs5ckS9y+O
         PD0ofNSS1TNFmaNZR/rnK/zKMGRMRdVXiXBae0HvWZNly8cZkon5h/0xfQtAcZYa6oKb
         AxEbEUU2Upg1Wknfa+LzkdoIglJF/sWC60c4oM3TpJNPueLEDqxNu3y9mkPBifN7cs1m
         LsJ5tZ0IV3G6p7OKzlgrKWEIS94Rp3IODfvbnopaCypaLKUrWoaI/yA5+MtwVYDqkhRM
         EL1g==
X-Gm-Message-State: AOAM532p6FpRaPtXdF52hJ1cSTf3WDequzGiZkdWlEGzzGp3ag+bbFYd
        EP5JPq6bBGqkgVjn6csNlFOmI5PKd3GB5QQGPfo=
X-Google-Smtp-Source: ABdhPJwuvQRH49+8qam8fSfIwe6/k8jde63sbEvj1L03wYyIFilyVejglcq1r9XLL+dhvNe+0uXq6DtRjvsISkxNUXU=
X-Received: by 2002:a02:998b:: with SMTP id a11mr1194145jal.117.1591843566867;
 Wed, 10 Jun 2020 19:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200607193023.52344-1-jassisinghbrar@gmail.com>
 <20200610082315.GB2689@bogus> <CABb+yY1T03YLwiFvBykxsAHQ9Kpu=r1nRTuaP3Emf5dP=Upm0g@mail.gmail.com>
 <20200610155629.GA7357@bogus>
In-Reply-To: <20200610155629.GA7357@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 10 Jun 2020 21:45:55 -0500
Message-ID: <CABb+yY0pQYD7DTf=MNpVPB7F2PESiWyTYj=ftRHDPkKMOobRVQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix timeout value for send_message
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:56 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

[I admit you can write bigger posts than me, so I am not going to
write a passionate response to each of your paragraphs.
Let's keep it to the point.]

> > > >       if (xfer->hdr.poll_completion) {
> > > > -             ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > > > +             ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
> > > >
> > >
> > > This is unacceptable delay for schedutil fast_switch. So no for this one.
> > >
> > Increasing timeout does not increase latency.
>
> Agreed, but worst case you may be stuck here for 500ms which is not
> acceptable.
>
Not acceptable to who, you or the kernel? :)    Now that you said you
are fixing the scmi's fast_switch implementation.

Even though I don't think 500ms would ruin our lives, but ok, I will
make it 30ms - same as you did in the 'else' block. And drop the other
change.

Thanks.
