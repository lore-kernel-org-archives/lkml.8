Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F17AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C18A206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="qJTBuiJK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fbp/KElP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIBBy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:54:28 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49163 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgIBBwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:52:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 87F8B5804D5;
        Tue,  1 Sep 2020 21:40:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 21:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=DFTb+WrDls2Qe7YvWg6Ss2kLmQy
        ImV5+mMvFZSh1DVE=; b=qJTBuiJKgjwAX+LcSaDJBFxd7DzdJ7tCShkyXxvLGbY
        xVTxFK4G20VdTFVyeQZ4nXxdewZuZqYT2xVCYc4/IuMh2P5wIqbZrKnYuCD0EWV4
        waL97TGaTkFDiIOARjFPCGirBcZ7HC8WM8mFqrKJo2ECrWk3YVocfNcugnL0oCUa
        wivhYSBSFc065rh2Gx/S1D+u+cydSy31arTvUyo2jIKtlTPk5SyA/DZV3hg9V6Di
        1lYVZIMt3tbA8jNtjcacb3H2ipOMIMYdWesby0phC52uqbUkocPZuaeoKnMxqWvU
        kXEjZl8SVrT/Jy7GXFegxA/iXFjOl2WWYBcG6DkI/WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DFTb+W
        rDls2Qe7YvWg6Ss2kLmQyImV5+mMvFZSh1DVE=; b=Fbp/KElP5mE4T+XJs08iB+
        rCUSHNC25QUPqOcfobBV7RioX2cJXXqb9PxbwEJ9mzmrujvtcKqw4Oh8vF4neVpd
        7MEoisAWRozK+GGH/0LOaiX1X7bLKht59zR+EG7evlh/lWcWnP31+Pi+KmR811w+
        lrCYg14HCMUxhtiQQc8pwriW1fANHxw4RP5M1RhaFe6TSBygkSj19AbmdkDrlXk4
        ouxbIqq/gNp8umJD3r+njDLmirtA9XS5oADcPYZUbKAA/V8EU8nqnRago+dTknrF
        uLimBKKOFfTxRIL4zHrXatjNaDhGKCbzyvLYPaO/nWuJEhGxPy1jJ9nUiyl8aM4g
        ==
X-ME-Sender: <xms:J_hOXymKe527WBOutnK5fHMGJMgs4E7zTtI9MMlEM8Yy7kHO7qvGxw>
    <xme:J_hOX53FfD83G5tFA8Mr2Q6pfzNpH-Np03fTK6Q5yaH7gOuzkgRCLcZGdRz8x7uzh
    AGjPJA2yiKAlMyxG2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepjeefrddvudejrddutddriedtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:J_hOXwqKx2t5Gq5qiZOusWgGTrHUVXAYKZAz5d_fwjd_NilkASt1wQ>
    <xmx:J_hOX2kuFlyB9W3HNvhYdrlQYgW22g9cWIyDUm4cSbgcVkNndwxwpQ>
    <xmx:J_hOXw3dMzb1xnAD8mdOQ2b_SuiJaZNSACUCXqqx8ySc--mHLqWA9A>
    <xmx:J_hOX989M629DIRJmGYr2Ey4vsNf-jm84X-XNOd_qgxNRble080Ine1uxO0>
Received: from cisco (c-73-217-10-60.hsd1.co.comcast.net [73.217.10.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id E73DD328005A;
        Tue,  1 Sep 2020 21:40:54 -0400 (EDT)
Date:   Tue, 1 Sep 2020 19:40:54 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 2/2] mailmap, MAINTAINERS: move to tycho.pizza
Message-ID: <20200902014054.GC583718@cisco>
References: <20200902014017.934315-1-tycho@tycho.pizza>
 <20200902014017.934315-2-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902014017.934315-2-tycho@tycho.pizza>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, Sep 01, 2020 at 07:40:17PM -0600, Tycho Andersen wrote:
> I've changed my e-mail address to tycho.pizza, so let's reflect that in
> these files.

Hopefully you can pick this one up too? :D

Thanks,

Tycho
