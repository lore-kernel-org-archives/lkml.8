Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7797C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC8B20768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QN4Bkr8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMKRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:17:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62589C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 03:17:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so4780400wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Jksw957ApTEUdNh+WJ+SMHxYZwMIbppobCvjvmWoFY=;
        b=QN4Bkr8TeVYbJBa6MMwSkHdWx/riEzXkTnXVWpsIjsobcal0reicM/9cElmteR8CUR
         /EeCa6G2bsbzJPjwoeml1DGIKdysExzQTvmpAO3tJxEadzy07Kyl0OrWt34BveGxpbIa
         pJxzcHfIRsTVkG1AeW+Vxmp4nCikq3LLySOcccSgz2yn7d30CAQsRcq8i01d4yWQ8U80
         h3DABNX66w5Kmr8cPnnwVn9nHK2hAjSE335SQ8hbx1k4xN57qxfTqt3H2PwK2waeOFQO
         zyWA7aeBEYDhqELGCny4UBg58sTufYumo6cRL7pFiNZLNVueGYZunkoYIX1iD90FWO+7
         6L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Jksw957ApTEUdNh+WJ+SMHxYZwMIbppobCvjvmWoFY=;
        b=G99WMczolQRB+Ct803isKs8wUdDcBA4Bt+4ODOJ2vtEd/bp6GUBCNPqs09FthT7NQd
         7IVeKSOJljN5Caxon5Ej5x7RxRJMj+ThinVkiUyEpJVHbzKZAvq4rmLjXjcIewp9l1K2
         U0FkV4G7uwHaC8yFYLG+Mvm/9L6k7A9RWCM/cqyu1ORzSSi7Rca//yZsNzVrVrJugE92
         6kVrhcxMDj3QjGNIaJaQN2QjGKYrLyEHNBIGzc1Q2YOQcSlnpCpmbbQHcwEJO7vt+7+c
         UTFfv8dNK0o7px5qHCGANBk/DdHvmRAteg6BofjPgwiRf44tR89XRNTpNuvDiuIHTsgb
         iKpw==
X-Gm-Message-State: AOAM530EEbRGWPFUz8yPhBSOeC8X/vvx0ZgKAM/1t3KR3d/HLkSu/IDm
        B4mXlzm+8xuLpP/YYC5Q+1iNkw==
X-Google-Smtp-Source: ABdhPJz31vqukdsdocXiZ3R5woRV0W54AJOsLQCkCk6VzoTnkJcBkq16BiBZJAsfLjdST1/6ACkqhg==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr3220762wrv.387.1597313826743;
        Thu, 13 Aug 2020 03:17:06 -0700 (PDT)
Received: from holly.lan (82-132-221-219.dab.02.net. [82.132.221.219])
        by smtp.gmail.com with ESMTPSA id m1sm8647311wmc.28.2020.08.13.03.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 03:17:06 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:17:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
Message-ID: <20200813101703.566thqmnc2d7cb3n@holly.lan>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com>
 <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com>
 <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 02:55:12PM +0530, Sumit Garg wrote:
> On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> > > One
> > > last worry is that I assume that most people testing (and even
> > > automated testing labs) will either always enable NMI or won't enable
> > > NMI.  That means that everyone will be only testing one codepath or
> > > the other and (given the complexity) the non-tested codepath will
> > > break.
> > >
> 
> The current patch-set only makes this NMI to work when debugger (kgdb)
> is enabled which I think is mostly suitable for development
> environments. So most people testing will involve existing IRQ mode
> only.
> 
> However, it's very much possible to make NMI mode as default for a
> particular serial driver if the underlying irqchip supports it but it
> depends if we really see any production level usage of NMI debug
> feature.

The effect of this patch is not to make kgdb work from NMI it is to make
(some) SysRqs work from NMI. I think that only allowing it to deploy for
kgdb users is a mistake.

Having it deploy automatically for kgdb users might be OK but it seems
sensible to make this feature available for other users too.

Daniel.
