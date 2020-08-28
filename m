Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514BC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C3A20C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/VF9fDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgH1IUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1IUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:20:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF22C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:20:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so420277ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XoNbJpm4P1EPH7VszYEAVkALAmWg4i39Cb3QU+BohCY=;
        b=T/VF9fDfNkSFCnL6sbsWLW8HUZ2AcZ5W+HrL8aZZG4KsMOlaHgyDrvbrn9DbYW6bOJ
         jGcbvDviF5ABD+rvj4Tcj8gmHa4YmfpZWWwg9mDJvluLfMNIIkT69lGUd20yieI5WUHI
         BT1RMs2aE15ZKLoCokqIUzSDWX8WuWHmX9MkOIdZUz7UMDm7ZNYxpJENKUm933a1VoXY
         9gbJzu3e5fe6RF3J2Cb6agOS9l21dAZAg/18Vd+qZurKiMnYaRdlbUWnVwICesF1WgZA
         5zaYMZ1y/HqQADwr95adiYT4f6qNIzIgEvjeP1+WNKNkK7GTUIotwAk3z8i2dAv1V+2C
         Jqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XoNbJpm4P1EPH7VszYEAVkALAmWg4i39Cb3QU+BohCY=;
        b=EbOQUQVWMWRkZHKZR3VMWuHhZN5nFtda1xhskZLtCvtlSolE4EaBcE0Isp7vHNJdT2
         yqHBlDfvwparPqKyN1ZdTv2BHK7thnC4y4q9nkgmWzvzNXNjVkqYujnyPqLD1JDUdF8F
         Lqzpr5f6MfzWh6qdIkwzf60QFTnV5mk+EsNANdkqi7LryK9KBP9dZrgEa0a/9/hNaULG
         NZhzq2sB0HbkZT6h6CmzS1OtcQ1X5kXEx946XxwC/r7Vg9wLvEVRDSFw9VwFc4zpa5ry
         b7O2S+dUq7OwUl1cWjKhqRetEbWatkOvGwl5s52y/eoT7B145TggG4mLf86r4uZl5ONH
         lvNQ==
X-Gm-Message-State: AOAM530eBxdQswOM/Jy9nhUUG5XL2JdIZBU7lsw9+ufOvZWufIFFb6TD
        Ppe3SWJB4+hxoBxjKpXx2lQ=
X-Google-Smtp-Source: ABdhPJy1Zitv5SVLDCtK2T/DmII7wh/VbeMDbB6CTAjleFOgzvdz9EYQdgKNM0dVPBAgbiHGN0WIeg==
X-Received: by 2002:a17:906:1106:: with SMTP id h6mr634641eja.200.1598602840061;
        Fri, 28 Aug 2020 01:20:40 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:4d0:302a:c6fb:6068])
        by smtp.gmail.com with ESMTPSA id qc25sm290708ejb.42.2020.08.28.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 01:20:39 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:20:37 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix comment concerning GCC 4.6
Message-ID: <20200828082037.5xpibd7etkvm7nsx@ltop.local>
References: <20200824232526.16534-1-luc.vanoostenryck@gmail.com>
 <CANiq72nSSrxTJBt4Mpm6uUEJMVEwe6rYedZQe6EtF1jnYqJDbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nSSrxTJBt4Mpm6uUEJMVEwe6rYedZQe6EtF1jnYqJDbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:50:45AM +0200, Miguel Ojeda wrote:
> Hi Luc,
> 
> On Tue, Aug 25, 2020 at 1:25 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > GCC 4.6 is not supported anymore, so remove a reference to it,
> > leaving just the part about version prior GCC 5.
> >
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> Queueing this one too, thanks.

Thanks,
-- Luc
