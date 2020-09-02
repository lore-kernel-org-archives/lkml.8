Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED39C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DB120678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Ob4KSGs+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5760nFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgIBPDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:03:46 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40851 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbgIBNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:51:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C4C125804AD;
        Wed,  2 Sep 2020 09:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 09:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2yjs51SuYlYSUilMgak7DQa/qGy
        KL3VPzrK0/NXEgZ4=; b=Ob4KSGs+ScX2RMUcN1Qibmw5cQESFwSC0pFbE8wqKZc
        m5nkQb5Y2tBPaY2Hz9hTFztGlMtfc5PBr4edZG7ArA19QeES6fI8f4tV+vcoWRKb
        m2g7HYoUnxZrR+0C3Ki6vvw94NOPDmcXnkqDCaysVH4qu/Pi2+AJwho7v6XAT4OZ
        SRnLcNr7R7UtNDsyRi0caPt0apEOiJvxJSow/EQIq5otI0xryNh2cBOrJDDrteFk
        ibs0GanyXN0aqwQ+GYaP0zRg9x+zU3pLNDpjMgTUG2ahnoZxOkRago6wszquLQIv
        IrdvvxgI2W+DFnqG6nhQkblqKEG27OkbyvBHweS18nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2yjs51
        SuYlYSUilMgak7DQa/qGyKL3VPzrK0/NXEgZ4=; b=G5760nFNMyXQWhN5KyukMM
        udReu9QsqR0W2kjd5/SUQGJVmj9jAnwSbsX3I+DmIQyLCXsNB6liY37QJrpdjlB9
        XkDlwGlWTutRdGU3DvxCBFTBxrqJyjSejKL5S+8b+ngaii1nxoUJXUvwfTyccjzF
        43JLzQrA4dnl0xY/ahOSjQc+L9oUL00UXWq2lQQjZ9rTlP42sTU9EAmv/7Ae7Ro8
        bN+g8udv64RJsoY+YzzlsRdWgECs4ve6TB4VAATFfdhIs8gutmUHQeXQwebTd9qN
        pZX1z4j0ZUcowakUaKNg3yEH3KmGLEubfHX7hdwr5E+aQV8UB8bFsY+1IxpcgzDA
        ==
X-ME-Sender: <xms:uaBPX-eV7nXPZJGjSJt1bHcJTOnSMBht08hKYbjIKtXV4tlpN6AXvA>
    <xme:uaBPX4N5LVwYS626MpVzK3aiGWdnb2c49h3MVSrZ43tJZOZmD9rjzelzS85uJWQyU
    Kg_vOu8Yc_wAijE9cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepuddvkedruddtjedrvdeguddrudejkeenucfuphgrmhfkphfpvghtfi
    horhhkpeduvdekrddutdejrddvgedurddujeeknecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:uaBPX_jGrLA5Y2alrz3ER7XaSjV4eGI0TIrj5UsuOThsw2QJo1LOMg>
    <xmx:uaBPX7_z1jVK__ais8ONw8-vqr7VRJfhamNUdhQxu-btV4KiRAUUHA>
    <xmx:uaBPX6sm2516Td2w0p4xZ3jyDg0KA-rwvzEgpndpLi_fn8Xy7U0zJA>
    <xmx:uqBPX-I9e8oFLm-tMzgkKO3PDIU5kakpsjf4WojxltWyu5CapHu7c4XNrkE>
Received: from cisco (unknown [128.107.241.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25B2F30600A6;
        Wed,  2 Sep 2020 09:40:08 -0400 (EDT)
Date:   Wed, 2 Sep 2020 07:39:56 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>,
        syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] seccomp: don't leak memory when filter install races
Message-ID: <20200902133956.GB1136703@cisco>
References: <20200902014017.934315-1-tycho@tycho.pizza>
 <20200902090849.bvevcuhtae73pplm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902090849.bvevcuhtae73pplm@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:08:49AM +0200, Christian Brauner wrote:
> On Tue, Sep 01, 2020 at 07:40:16PM -0600, Tycho Andersen wrote:
> > In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
> > the listener fd, then check to see if we can actually use it later in
> > seccomp_may_assign_mode(), which can fail if anyone else in our thread
> > group has installed a filter and caused some divergence. If we can't, we
> > partially clean up the newly allocated file: we put the fd, put the file,
> > but don't actually clean up the *memory* that was allocated at
> > filter->notif. Let's clean that up too.
> > 
> > To accomplish this, let's hoist the actual "detach a notifier from a
> > filter" code to its own helper out of seccomp_notify_release(), so that in
> > case anyone adds stuff to init_listener(), they only have to add the
> > cleanup code in one spot. This does a bit of extra locking and such on the
> > failure path when the filter is not attached, but it's a slow failure path
> > anyway.
> > 
> > Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> > ---
> 
> This looks sane to me!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> One thing I noticed when checking the failure paths. In init_listener we
> allocate the notifier by directly storing it into filter->notif and if
> anon_inode_getfile() fails we simply kfree(filter->notif) but don't NULL
> it and leave filter->notif pointing to freed memory.
> Since we have a few places where we check filter->notif whether it is
> initialized or not maybe we should NULL filter->notif if init_listener()
> fails or alloc the notifier into a tmp variable and only assign it to
> filter->notif after we can't fail anymore in init_listener().
> 
> Just a thought since the error path in seccomp_set_mode_filter() is a
> little more complex. :)

Yeah it seems like we definitely should, and maybe this is what Kees
was talking about and I missed it.

I'll send a patch on top of this shortly.

Tycho
