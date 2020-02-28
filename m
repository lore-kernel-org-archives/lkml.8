Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20692C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2BA2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZYtRjO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgB1Gae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:30:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36430 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgB1Gad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:30:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so1297450qto.3;
        Thu, 27 Feb 2020 22:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7TS07qm5BTzPoIctEpgMyVEvZEu8e9vIDaiI4S1jRII=;
        b=nZYtRjO2I5BXWjnVy9qkjCyLXjT2Ji1fya8iFrWtSm7NGagYGnzGjEJpYjVg7T1sXA
         Vehqo1LeklXK5N9yoq0o6uoFcKXMQPMfjcyp1TMBPAkEPk0SL08w8V1V1oLUzBVC9BZo
         ZHYyIudKx0rfsTQ4leSYIpoxBSesP23LpTR9tbknlOGK4bVI//+2pXh64Sa8UsDo3ewR
         P4UCBttEUCmQhN9K0mieJP9UjRLJKGYZgEqb4/vW2JZJ1OIIR6GHxL892zDWCHiYa0Q2
         uEieDhkqY2mdfq1zm3bVRn1NhtasXu7+BmZhmx1AhQeYTleA6/eorLHR0C2RRG55j12x
         EMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7TS07qm5BTzPoIctEpgMyVEvZEu8e9vIDaiI4S1jRII=;
        b=q5vHH1UG0tiNgS5jSG4iPiWzEvjyR8Tue/5+/u10RdWGSJF5npwSv3yC3jBXHumdPq
         7AKQo+Qfayy/CFVUoXEADAclSf+NLORY4CING+ZqIfyR+8VvhToUJEw4Au4uKX8UOpD1
         jPlZ4RdvnYrJWYRLJRJ3gNYYXFA4Rgpe2Di3jDzu/D1iWaSeMp3ISXBoE/tRx53rgWEC
         LS8hF6wFabAN28mZNI5mWD7Q5uMbp4OTT6P/a5qBdk4Jtfli/oqzW2J4S3wjwQ3q+AR7
         U0XjbjUFRt9ZrTfSR2BsZOAAi5Tp1ZMY/aszJh22MQlQte+Ivyo/iijnzLtW33Hs8qD3
         WZ0A==
X-Gm-Message-State: APjAAAW/CjxP9ijXOqCZP8ERyiyQsrX4ePfiIwjDAehIgalg9bwbJ/7m
        nn1wwvIAOhbXDWsyxGOOJQg=
X-Google-Smtp-Source: APXvYqyKKsLHfSmrkm4O8hNO/kg9yQvuJCRhggQK6nbbKYMtA5F22j+wO2BXVUeOHtAdu68tCg666Q==
X-Received: by 2002:ac8:1a19:: with SMTP id v25mr2978785qtj.146.1582871432010;
        Thu, 27 Feb 2020 22:30:32 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d74sm4563641qke.91.2020.02.27.22.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:30:31 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 26FD522223;
        Fri, 28 Feb 2020 01:30:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Feb 2020 01:30:30 -0500
X-ME-Sender: <xms:grNYXsWgcUpfsfN09fLzyHZUG__G6GTb4afd0J8m0PSo1qxoP8-zqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:grNYXs5eGZYyBdtyRgeRt5bitl3y1L8zsOhgTEfm7meDUuW658yxug>
    <xmx:grNYXjJ74cxQy4R6lApHewhbLkliRfffyDeQwOpaHtWQb3kybLWmqw>
    <xmx:grNYXtL_W5dH1OPLHRUMJj-hiBETIVOKPF0WhLT5vf4M9dJajaq34g>
    <xmx:hrNYXk42OucZ4QYMvWLkxJFki1WoSWsYUa5dwpMARXh6Dxr7O7pbJJUKwH8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE49C3280065;
        Fri, 28 Feb 2020 01:30:25 -0500 (EST)
Date:   Fri, 28 Feb 2020 14:30:24 +0800
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
Subject: Re: [PATCH v3 2/5] Documentation/locking/atomic: Fix atomic-set
 litmus test
Message-ID: <20200228063024.GU69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200227004049.6853-3-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002271133300.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002271133300.1730-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:34:55AM -0500, Alan Stern wrote:
> On Thu, 27 Feb 2020, Boqun Feng wrote:
> 
> > Currently the litmus test "atomic-set" in atomic_t.txt has a few things
> > to be improved:
> > 
> > 1)	The CPU/Processor numbers "P1,P2" are not only inconsistent with
> > 	the rest of the document, which uses "CPU0" and "CPU1", but also
> > 	unacceptable by the herd tool, which requires processors start
> > 	at "P0".
> > 
> > 2)	The initialization block uses a "atomic_set()", which is OK, but
> > 	it's better to use ATOMIC_INIT() to make clear this is an
> > 	initialization.
> > 
> > 3)	The return value of atomic_add_unless() is discarded
> > 	inexplicitly, which is OK for C language, but it will be helpful
> > 	to the herd tool if we use a void cast to make the discard
> > 	explicit.
> > 
> > Therefore fix these and this is the preparation for adding the litmus
> > test into memory-model litmus-tests directory so that people can
> > understand better about our requirements of atomic APIs and klitmus tool
> > can be used to generate tests.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Patch 5/5 in this series does basically the same thing for 
> Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.  How come you 
> used one patch for that, but this is split into two patches (2/5 and 
> 4/5)?
> 

When I was working one the first version, I wasn't so sure that we would
reach the agreement of where to put the litmus tests, and the litmus
test in the atomic_t.txt obviously needs a fix, so I separated the fix
and the adding of a litmus test to make my rebase easier ;-). But you're
right, the separation is not needed now. 

I will merge those two patches into one in the next version, also with
the name adjustment you and Andrea have pointed out. Thanks!

Regards,
Boqun

> Alan
> 
> > ---
> >  Documentation/atomic_t.txt | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index 0ab747e0d5ac..ceb85ada378e 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -91,15 +91,15 @@ ops. That is:
> >    C atomic-set
> >  
> >    {
> > -    atomic_set(v, 1);
> > +    atomic_t v = ATOMIC_INIT(1);
> >    }
> >  
> > -  P1(atomic_t *v)
> > +  P0(atomic_t *v)
> >    {
> > -    atomic_add_unless(v, 1, 0);
> > +    (void)atomic_add_unless(v, 1, 0);
> >    }
> >  
> > -  P2(atomic_t *v)
> > +  P1(atomic_t *v)
> >    {
> >      atomic_set(v, 0);
> >    }
> > 
> 
> 
