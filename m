Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DAC5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AE7207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rofXMqqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgBTA1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:27:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44640 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgBTA1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:27:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id j8so1969306qka.11;
        Wed, 19 Feb 2020 16:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yBk+R8vCbSw5xpNQVNRg7HmG4Olx/oWqNTA9S4QsKz0=;
        b=rofXMqqGIaLcHwa1DG5DkXkGjySQV4pFvsjSQerHl/4pTBIxj4RfCGmJC9d8P1kecz
         hzOu77VzsqDVsryL613Ih8cqnqbUZ6s566WLJ0j7CQmrzmXfGMtQPpIVgeFF1fkfRtp7
         QnJqoJ5qWzP0wVprLzoX50IS4ncv0AewPPTQey1M8LZQyAD/nFCdj0ta/IUBIfgdp9iS
         xveLRcBygb3zfi8N6+JSqjeHvAXz4dUUhGpJZWXHo+kg91bWHUHNjfmm0fzBXJz5nabO
         ZmTSseTB7VmHOXqv7YU2BkTCrhBR7Lamq6+ZFtsllfJA0u2wwCrhTTThimUvDQWgSbwW
         AvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBk+R8vCbSw5xpNQVNRg7HmG4Olx/oWqNTA9S4QsKz0=;
        b=Arh2RH3PQmmFTovat5S2zh9g8pdCfKoFGBw3IzxZ0TpWScljcbF63B9V0Tf+MTllKp
         De0bApXCfYKWcq33XcQGfJaDdQyzJI+9oeSkVausr9zLG3dNALDSF0NbC6I5WJ2oJyYm
         UvtSwaNO92ficlzdtmXpfzuTlCSjix/3039HMKWg6z+R7nX/yku1+dMWp3biAmarwJXU
         nsdUsf8gdwq3POhFL65dGyDNG9HGH4X+0Qq55kOpXmGRKRhyqd1CrsVlwHTTNqCGBjpo
         Vd6mkuuG4XmTXQH9tct0PTaTeEEGuxwhExuBrVXCJZ3YsxVKdvaNGOH3PkoQvhUTUI5T
         W39Q==
X-Gm-Message-State: APjAAAXQgSJVfw3F8KAg7pl0I8gmBC0MpPKaQuQo7+TmpdOVDBr9o6R2
        ouGpQp7r+t4heI2ohQ6vTJ8=
X-Google-Smtp-Source: APXvYqy3aAgDyTv7/CdGh1j7DLqx5eo/zj5tVgqNJdVXqys1VHflP07r9NZtd+tEADPW35EHgmd4EQ==
X-Received: by 2002:a37:6393:: with SMTP id x141mr22771653qkb.134.1582158442595;
        Wed, 19 Feb 2020 16:27:22 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r37sm889732qtj.44.2020.02.19.16.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 16:27:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E2D1821B34;
        Wed, 19 Feb 2020 19:27:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Feb 2020 19:27:19 -0500
X-ME-Sender: <xms:Z9JNXtSPSsab4cfiU9DymOc_Fz6gZePGaLcc3dBhnb80-JaqFXAybQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Z9JNXkkS1N5F4pGJ_Xoms083kNRJUYdvwMBNQgZ7ggatZAFnhSe3sQ>
    <xmx:Z9JNXjve57JPgQ7Ig4v3yj7yqJ_0d5iC6mEs9YAThhudqOTRd4cUEA>
    <xmx:Z9JNXv-nnt0zLmR8I_crAYAZ2aT3LbVP68fqgErYrzZaJbFgM8-7iQ>
    <xmx:Z9JNXkY4PT0Ybf7bgfQC_hfVE2zmhcm9xhh3cVNUa4GzM8Zl1Ur1tBbnknA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E2E63280059;
        Wed, 19 Feb 2020 19:27:18 -0500 (EST)
Date:   Thu, 20 Feb 2020 08:27:17 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC v2 3/4] Documentation/locking/atomic: Add a litmus test for
 atomic_set()
Message-ID: <20200220002717.GG69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200219062627.104736-4-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002191004420.1514-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002191004420.1514-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:07:09AM -0500, Alan Stern wrote:
> On Wed, 19 Feb 2020, Boqun Feng wrote:
> 
> > We already use a litmus test in atomic_t.txt to describe the behavior of
> > an atomic_set() with the an atomic RMW, so add it into atomic-tests
> > directory to make it easily accessible for anyone who cares about the
> > semantics of our atomic APIs.
> > 
> > Additionally, change the sentences describing the test in atomic_t.txt
> > with better wording.
> 
> One very minor point about the new working in atomic_t.txt:
> 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index ceb85ada378e..d30cb3d87375 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
> >  the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> >  and are doing it wrong.
> >  
> > -A subtle detail of atomic_set{}() is that it should be observable to the RMW
> > -ops. That is:
> > +A note for the implementation of atomic_set{}() is that it cannot break the
> > +atomicity of the RMW ops. That is:
> 
> This would be slightly better if you changed it to: "it must not break".
> 

Got it. Indeed it's the better wording, thanks!

Regards,
Boqun

> The comments in the litmus test and README file are okay as they stand.
> 
> Alan
> 
