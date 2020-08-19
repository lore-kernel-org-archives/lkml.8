Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC18C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBB206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="AQNYrbOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKWgKTRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHSKmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:42:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54191 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbgHSKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:42:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DA20F5C008F;
        Wed, 19 Aug 2020 06:42:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 19 Aug 2020 06:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=G
        rhlYBHahFUnfdeextaZfRwniN2kk8VF9Pt6+h/0TuI=; b=AQNYrbOw0aMP2QXnQ
        MxiJwCO0NtYEIuSS7CTcvGrEQGtpaXYYB/V4qn1314029uZLK3DN8WxJtFYNtIHv
        vhiS4qVv2Hk9hVrudXu2FQ2lgkW8XrMwhvlBBOsai4BcuLyzycL+lqUhjygZni8K
        /E9yi3Xqbt3TV327d8VrHxaLskSMRCcaNfYuKtbkOSop8H0WMrBYhLbDIxf5aCmI
        dj6PgfujAxbYK3QSg85ylTxsAwPcpLDQk+sp9pC9eYQBETsuLXQ1kxS6WTBZAYx/
        x6UJpD42oQ1coGOlYdhDcwv9soS47MwivXfLFqyiXYr5jUDCrdmO2h3K7Oy0OI80
        kt9aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GrhlYBHahFUnfdeextaZfRwniN2kk8VF9Pt6+h/0T
        uI=; b=TKWgKTRt1bliMpQJSGf1O8FjBHHZBZ9H2JPyejT+pUzpdPpgEbpEwRxat
        k4GxdGGT8kauIcaEyOMAqG0QDbPB5GEyBN13iFNT98j/sRWuEoLfTaRkWflx3VaX
        7ImPEZFL+5rJmDBdJPFNRwPBgy0L6ax1fV+s2KI8Y3Ln4/bmN6CxGJnRlX1vVBgA
        U+5qdPLxRF3Q5cA18BOS3bx2fEDRpMh/JxhkdxT/YqYU9vV7VxAVq7CTHg/azOFk
        Jjym2bwM/xukMynCiaKwZZ4unIWFJrvC7uVRqX7UuNSjR8+X0m1B+WQHy5ce8ChM
        Qg0JfkZjHx/N1iVm+eUwGvEEQYwsg==
X-ME-Sender: <xms:FwI9X16ENOIG2m0lkRUp4qWsnKGKyGOY-6Mrm96Ks49dcBU6WdGrcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueehke
    ehlefffeeiudetfeekjeffvdeuheejjeffheeludfgteekvdelkeduuddvnecukfhppeek
    fedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:FwI9Xy7s5lG-00CtzeRBB3kBcuNgiLBJBR_jp1Bx_JLc2nmOJHv83w>
    <xmx:FwI9X8c7TO3tppmN_-z3FOXFs2tzHMWYHtG1PPi6n3UzF_kDhkH4SA>
    <xmx:FwI9X-KpgXlpVLpAKMXisqPJglUyp-_Ue69FAWYgehrl1bv2ivZA6A>
    <xmx:FwI9X3hPOzmSZb82UkoyTdW-NkeQs2tDoMo5NOXllOoS3VPn6sAbMw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 440153280059;
        Wed, 19 Aug 2020 06:42:31 -0400 (EDT)
Date:   Wed, 19 Aug 2020 12:42:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
Message-ID: <20200819104254.GA41946@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:46:06PM +0530, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 11:45 PM peter enderborg
> <peter.enderborg@sony.com> wrote:
> >
> > On 8/18/20 7:53 PM, Muni Sekhar wrote:
> > > On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
> > >> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> > >>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> > >>>> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > >>>>> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > >>>>>> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > >>>>>>> Hi all,
> > >>>>>>>
> > >>>>>>> I’ve two identical Linux systems with only kernel differences.
> > >>>>>> What are the differences in the kernels?
> > >>>> You didn't answer this question, is this the same kernel source being
> > >>>> compared here?  Same version?  Same compiler?  Everything identical?
> > >>> Both systems are having exactly the same hardware configuration.
> > >>> Compiler and kernel versions are different. One system has Ubuntu
> > >>> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
> > >>> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
> > >>> version 7.5.0).
> > >> Those are _very_ different kernel versions, with many years and tens of
> > >> thousands of different changes between them.
> > >>
> > >> Hopefully the newer kernel is faster, so just stick with that :)
> > > But unfortunately the newer kernel is very slow, that is the reason
> > > for starting this investigation :)
> > > Any type of help,  and guidelines to dive deeper will be highly appreciated.
> >
> > On the 4.4 kernel you dont have
> >
> > +CONFIG_RETPOLINE=y
> > +CONFIG_INTEL_RDT=y
> Thanks! That is helpful. Yes, I see 4.4 kernel don't have the above
> two config options.
> What analysis can be done to narrow down the root cause?

"root cause" is you are comparing a kernel without any spectre/meltdown
mitigations, with one that has it.

Those mitigations are known to have a huge slowdown on some
benchmarks/workloads, as you have shown here.

If you don't like this, you can disable these changes on newer kernels,
if you really really know what you are doing, but I strongly do not
recommend it.

Also you can complain to your hardware vendors for selling you broken
hardware :)

> Any example of reference could be helpful to understand.

Look up Spectre and Meltdown for many many examples of what happened and
what went wrong with chip designs and how we had to fix these things in
the kernel a few years ago.

greg k-h
