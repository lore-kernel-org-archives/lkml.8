Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434BF2081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm8r5tns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLKZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFLKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:25:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151BC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:25:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m7so3578519plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cUX8I3zbQvQLr1JtDLu8cxMFi8HBUB/7MciF2bMGdXA=;
        b=Xm8r5tnsMoGuSi4xpAI9+p+TAX+EGw+C+Bue1QyTIMG0CVcJ9jRKmmIQxK/wnkpKbc
         7nrAjHjR87jnCXJtSLUFuKFm8t1Ukhq9UleBP4oTnjOyi1e3KODNkQ76Zl4p/jjC2EVb
         nvby513WQsjxYOWwsX961qlEo67QxJpVx0VbsnG+mTmtxHntGmXDANcbX4bVNkx7T4cl
         Y6yb2hI1yDphLwpBYlkoLmM/9BlN/wAnLgWEdQt7iOW8PcbSRhoqcuP5iJMz8hpHPJsf
         cXLICpttu05Pg/MMeRnlZxEg0OEn9eI2zvYAJbs72qRf9Uzy2WZNqfX9LrSZFK2eHaIC
         1B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUX8I3zbQvQLr1JtDLu8cxMFi8HBUB/7MciF2bMGdXA=;
        b=hjt7vRFvZUPjHNdOhaWcapLQjpoEyS8vus6s5Ah9lh7pipBs8i16WoL/p0iwvwqIch
         /nkCRPWLBvUxRHQq9MIxm2C7ylxyvH+BiPJy3rBb6VuIHYjXHUxpRq8WsEtJBuzR6Vxx
         eB2RJthvpbLXQ27WXZWgEtCvH2ZWh1cbg40EEtpAmB5/SnYERTJ/S9avwsj6qdM2hxWL
         zEYizjSbECct9Tsz2wfb/HOWW5Vy68KrND/zAsQ8y+bWaCAXezuzSpXqkEiPgOKEeJwJ
         k+Jca8IBpiv4SSVZrbqKuQqSLVH5nvXQXxiM9btTL+VPb3aFANHzLqLdFVOg9i77Zgjj
         1bDg==
X-Gm-Message-State: AOAM531VdxUnmES5Z6Itc8O4oMY8qJmQg+SLGXCrhFbd48eGiwkb06gb
        qVwqI443SMAyaIli6viybd4OI7LK
X-Google-Smtp-Source: ABdhPJyDf0t7pZ2FhXW0i0j+FfjSrBnypvQDMT+Lriq057tGe/P55czkaQp9gxDfqZGw9iHCNuzHJg==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr10732696plp.19.1591957553757;
        Fri, 12 Jun 2020 03:25:53 -0700 (PDT)
Received: from localhost ([49.205.222.116])
        by smtp.gmail.com with ESMTPSA id x18sm5750238pfr.106.2020.06.12.03.25.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 03:25:53 -0700 (PDT)
Date:   Fri, 12 Jun 2020 15:55:51 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200612102551.GA5377@afzalpc>
References: <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
 <20200607161116.GN1551@shell.armlinux.org.uk>
 <20200608110902.GA5736@afzalpc>
 <CACRpkdboPBGBdHaRtZ=OAFvikYZVh=BVu192uyiB8T=yeHHEbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdboPBGBdHaRtZ=OAFvikYZVh=BVu192uyiB8T=yeHHEbA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 10, 2020 at 12:10:21PM +0200, Linus Walleij wrote:
> On Mon, Jun 8, 2020 at 1:09 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > Not yet. Yes, i will do the performance evaluation.
> >
> > i am also worried about the impact on performance as these
> > [ get_user_pages() or friends, kmap_atomic() ] are additionally
> > invoked in the copy_{from,to}_user() path now.
> 
> I am happy to help!

Thanks Linus

> I am anyway working on MMU-related code (KASan) so I need to be on
> top of this stuff.

i earlier went thr' KASAN series secretly & did learn a thing or two
from that!

> What test is appropriate for this? I would intuitively think hackbench?

'dd', i think, as you mentioned 'hackbench' i will use that as well.

> > Note that this was done on a topic branch for user copy. Changes for
> > kernel static mapping to vmalloc has not been merged with these.
> > Also having kernel lowmem w/ a separate asid & switching at kernel
> > entry/exit b/n user & kernel lowmem by changing ttbr0 is yet to be
> > done. Quite a few things remaining to be done to achieve vmsplit 4g/4g
> 
> I will be very excited to look at patches or a git branch once you have
> something you want to show. Also to just understand how you go about
> this.

Don't put too much expectation on me, this is more of a learning for
me. For user copy, the baby steps has been posted (To'ed you). On the
static kernel mapping on vmalloc front, i do not want to post the
patches in the current shape, though git-ized, will result in me
getting mercilessly thrashed in public :). Many of the other platforms
would fail and is not multi-platform friendly. i do not yet have a
public git branch, i can send you the (ugly) patches separately, just
let me know.

> I have several elder systems under my roof

i have only a few low RAM & CPU systems, so that is certainly helpful.

> so my contribution could hopefully be to help and debug any issues

If you would like, we can work together, at the same time keep in mind
that me spending time on it would be intermittent & erratic (though i
am trying to keep a consistent, but slow pace) perhaps making it
difficult to coordinate. Or else i will continue the same way & request
your help when required.

For the next 3 weeks, right now, i cannot say whether i would be able
to spend time on it, perhaps might be possible, but only during that
time i will know.

Regards
afzal
