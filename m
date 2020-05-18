Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C99C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EE72070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiSLHgBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgERGVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERGVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:21:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF78C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:21:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so3810185plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CLsaehW9Taz3Ka2xzbMpVHvc/9aQdrIOzWvQKJbc0kE=;
        b=EiSLHgBjAVCSuePRSDJU4JXRufEb1wYy1y3Q27ccRsMCHmfQSmrKsnI2fRgyVd2FXz
         hm63j+UgR8r/8xnub9nQkN5LYkoQedtczIPIB+cChMkmdliFv3+cqSMy5lBjWx7aDZS8
         sN6K0iR3USlVgGpAtqCvo6WMBa9HDwPjayMcc+fuMSzHOgLJtp3FFvpvBslUJSjfUoWK
         sRO823x53zWtBLZwO0q/CPgaQqYbtkhF202bLMXHQ5/s+kt/Esux+d/9MYAlPjc3zPnF
         QgOAVAWDAbEGx5DgFonbUuHjYpRBEjsF8z4npMjcCe76T7+fgV3uomXmx8u8Q3ydU33R
         wLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CLsaehW9Taz3Ka2xzbMpVHvc/9aQdrIOzWvQKJbc0kE=;
        b=TUNS52mE2x7rnZ71Di8rb2nA1soViQRk6r2SeTA3YIqPzGt37Cv3iGaIMgONFqZhAd
         UrZcoaBDuyT13nN7WsNCWbvwsUQmfUTrgSuh9+VtrqmNiLSYqS9fGV74KKRh11MB2YwR
         shVr+J3HvYnYlN9uzGQVVBxrfqo+xWNhsj4fy7sVWispexqFVWAVHwIQozFjUTcjmeCz
         th1HS8PYKciwLkE+jk5O9PuBjFQpDMVNjMva7bmAySqoAxfIKuVUuwMyv14Lfu5wiqhC
         K0fNZwxcyhResbDPdPXif7A7xiI2up9ecJM1DSc7uCY0m2p10/sl6j6qL32gPeEMkyQK
         Lutw==
X-Gm-Message-State: AOAM533jBz4K0SDw8M4vzi74m+dWD6b7OHN5eh7eW/0GbUV50iriOvTx
        UTQGvL7QE8JaB9HqooGIVqIuwg==
X-Google-Smtp-Source: ABdhPJxjulgCG8gVRBS1hVOMUlGaMrT8f8O4l9B1jasxoYD2DJgZjrJpfy+Buv2OROr94ELwG55cMA==
X-Received: by 2002:a17:902:59d0:: with SMTP id d16mr14408068plj.181.1589782872479;
        Sun, 17 May 2020 23:21:12 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c24sm5025027pjs.51.2020.05.17.23.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 23:21:11 -0700 (PDT)
Date:   Sun, 17 May 2020 23:19:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: linux-next: build failure after merge of the qcom tree
Message-ID: <20200518061948.GA2165@builder.lan>
References: <20200415104152.4d770116@canb.auug.org.au>
 <CALAqxLVN_MZ7XWsg99dhy1=Vde_XSCHey78mrxRuu7a_THxYYw@mail.gmail.com>
 <20200421092935.21eeb395@canb.auug.org.au>
 <CALAqxLUub7SqPQbKJ+OnPtcQhLiu0aFD9YudhDtDfDLNXL6smQ@mail.gmail.com>
 <20200518151635.5b36916b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518151635.5b36916b@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 17 May 22:16 PDT 2020, Stephen Rothwell wrote:

> Hi all,
> 
> On Mon, 20 Apr 2020 19:41:56 -0700 John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Mon, Apr 20, 2020 at 4:29 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Tue, 14 Apr 2020 18:18:11 -0700 John Stultz <john.stultz@linaro.org> wrote:  
> > > >
> > > > On Tue, Apr 14, 2020 at 5:41 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > > > >
> > > > > After merging the qcom tree, today's linux-next build (x86_64
> > > > > allmodconfig) failed like this:
> > > > >
> > > > > drivers/soc/qcom/rpmh-rsc.c: In function '__tcs_buffer_write':
> > > > > drivers/soc/qcom/rpmh-rsc.c:484:3: error: implicit declaration of function 'trace_rpmh_send_msg_rcuidle'; did you mean 'trace_rpmh_send_msg_enabled'? [-Werror=implicit-function-declaration]
> > > > >   484 |   trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
> > > > >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >       |   trace_rpmh_send_msg_enabled
> > > > > cc1: some warnings being treated as errors
> > > > >
> > > > > I don't know why this error only started happening today.  However
> > > > > reverting commit
> > > > >
> > > > >   1d3c6f86fd3f ("soc: qcom: rpmh: Allow RPMH driver to be loaded as a module")
> > > > >
> > > > > fixes the build, so I have done that for today.  
> > > >
> > > >
> > > > Ah. I'm guessing the newly added rpmh-rsc code depends on rpmh being built in.
> > > >
> > > > I'll take a look at it.  
> > >
> > > I am still reverting that commit.  
> > 
> > Yea. I've stirred up some discussion on it, but its fairly
> > complicated. Unfortunately I suspect it will take some time to confirm
> > and justify the change I think is needed, so I think reverting this is
> > the best short term plan.
> 
> I am still reverting that commit.  It is probably time (we are beyond
> -rc6 now) that it is either reverted or fixed in the qcom tree, please.
> 

Thanks for the reminder Stephen, I've pushed the revert out to the qcom
branch now.

Regards,
Bjorn
