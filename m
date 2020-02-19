Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5B3C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54DD208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKSW1O83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBSLLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:11:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38862 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSLLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:11:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so12547152pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ESbz0AHqkMkTdB+sm3A0cQw3C+xELGa4YT13KhKcyQY=;
        b=dKSW1O83OHUoh3eB3zqtzzYhLBGu/uU8CecBtF/JpiDAAb0bw1vR82BllvLQadxvcM
         t2kyayKnNMDBRkFnz1H+T52vkxBuBI1I0rIhSN4tx1ParfzXIVObPqaAf7cgJSHeyBlo
         j1sOGVR/0gy1CqcVquqWJsEClFkaUOCiDqjCKhh/H8uxODWlSVQvDhV9pwgF25XbzBPe
         zdywucFIpUVSfj5zhwFJaUKY4J5gAErDw9bhzsMfjozezU8Yy4kic8ZiF8mUgz7jO7jg
         ct2M7yeGSMu6eqoXnNpS2fAtwBnAwPfe46wpP2Go/NsGdTp3TOHrlCX2N/U0I8HocubT
         wFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESbz0AHqkMkTdB+sm3A0cQw3C+xELGa4YT13KhKcyQY=;
        b=LEK3n2DJiFSG8Nmz+7/hFcq/3QSc7AL9QL2tN1JC6vN8mfl3UmRPWSdNTRAg5P2p0J
         bNyYLlaCZ0LqAE0jHXkBNDzto7C7PZHrERLcX914nSRPtV0VTvh7EA2ZiPMMutnoN1gY
         dYi19L9mf/qyNR2V9Ntryqnwm+fKg1RHwnvfa6uwdArFRNio5Q02k3ifz14Ir5c03sh4
         RMzh8lz8joeBQFhFQO/7Joo/wRxIvFrvLo26H8nBy5MyHzpaF42py2hNYybm62+8s5/m
         k080Ts8OEm4Wz+uOrUtjDnyo+1a8io3Au+Av5023iyR6TmKPiR0iF4wC7LOl6CAotFCn
         Orkw==
X-Gm-Message-State: APjAAAXJDsdb+bACz12sSrY7jrHuyL9k+gdn/cjnS5O6ALdgFXt8WHDM
        +sLVTvi/kkDTQ0LTdeqe2k9w
X-Google-Smtp-Source: APXvYqyLAI4XBQFxi1l3Ey7NIzZu20kpSxmX5q9ISWSfgd94tdbrz+7en3ypXsKTzdl0k2IdFp233Q==
X-Received: by 2002:a63:34b:: with SMTP id 72mr26464313pgd.278.1582110662513;
        Wed, 19 Feb 2020 03:11:02 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id w17sm2468320pfi.56.2020.02.19.03.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 03:11:01 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:40:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kref: Clarify the use of two kref_put() in example
 code
Message-ID: <20200219111055.GA4552@mani>
References: <20200213125311.21256-1-manivannan.sadhasivam@linaro.org>
 <20200219035818.08ad246f@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219035818.08ad246f@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Wed, Feb 19, 2020 at 03:58:18AM -0700, Jonathan Corbet wrote:
> On Thu, 13 Feb 2020 18:23:11 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> > Eventhough the current documentation explains that the reference count
> > gets incremented by both kref_init() and kref_get(), it is often
> > misunderstood that only one instance of kref_put() is needed in the
> > example code. So let's clarify that a bit.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/kref.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/kref.txt b/Documentation/kref.txt
> > index 3af384156d7e..c61eea6f1bf2 100644
> > --- a/Documentation/kref.txt
> > +++ b/Documentation/kref.txt
> > @@ -128,6 +128,10 @@ since we already have a valid pointer that we own a refcount for.  The
> >  put needs no lock because nothing tries to get the data without
> >  already holding a pointer.
> >  
> > +In the above example, kref_put() will be called 2 times in both success
> > +and error paths. This is necessary because the reference count got
> > +incremented 2 times by kref_init() and kref_get().
> 
> Out of curiosity, where have you seen this misunderstanding happening?
> I'm not really opposed to this change, but I don't understand why it's
> really needed.
>

Jakub mistakenly spotted one refcounting issue in one of my patchset:
https://lkml.org/lkml/2020/2/3/926

Then I tried to show him the kernel doc for kref and that's where I got this
example code slightly confusing. And while looking into the log, I noticed that
someone deleted the kref_put in error path mistakenly and that commit got
reverted after that. This issue was even discussed in stack overflow.

http://stackoverflow.com/questions/20093127/why-kref-doc-of-linux-kernel-omits-kref-put-when-kthread-run-fail

So I thought about making it more clear of why the kref_put is needed in error
path.

Thanks,
Mani
 
> Thanks,
> 
> jon
