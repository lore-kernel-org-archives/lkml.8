Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEF720715
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Jke5t/vu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eH1davhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgESAXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:23:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55409 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgESAXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:23:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 19F265C0073;
        Mon, 18 May 2020 20:23:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 18 May 2020 20:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=6dez2inLO9ku1pNNSEEQg2wUTyCCTFZ
        fY7XJVnTZ6zo=; b=Jke5t/vu8yu6lIojT3aomUQNi4Fakt3uHDflIlLQnEuw67N
        nl1dezDfNQvJOgTEkrBZvoW5MOBynt+0ypcxoPrjSiPuVAYL+2aa1MgzMfINgL34
        01bVmRbF5u0YT6loEp8zJ3HDl9R7FFH2a7Jw9RebEZOu9hMKIzzRyDHZjOJAayVO
        +znMhvU1Bu+DthWqE+Fvih4+w8E+hg47lo/OaMzj9kIZnpVXO6TvJQf8RMa2ub10
        5H/4QTrxXBPK3gXPZpQWDiDQm0VoB4VQxPgWU8FVOaFHWUFke6YBfVrlgtx0OcN8
        2dPJm9zAGwNOH5VxtwoctQQ7zh69gc9+6rKJfvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6dez2i
        nLO9ku1pNNSEEQg2wUTyCCTFZfY7XJVnTZ6zo=; b=eH1davhvjbSqau6PYdxA6Z
        MLKj8NDL7V/T7TQ1WggrseuNjWCy/Sqwh1BSevutAAJsSGeSo+Kx7YIAVdyrgP4J
        YnHWk+/BnIKedl7lQEATSOfoX3tFL+/3hbzS8qMbINKkflDX65AfFBYdJZocUPgm
        9UpjNb2mDmwPU64SAjWSL3L9xH0lKhmdJwtBwAmpEApD9cX42iUMr7lpKUy+kZ2K
        7+0YpoyGl587b0MRquTIm3KZku1UGMf9VQFlUpXdEjbUX/J9RG9ANnZl1ZG6o8DK
        umcChQ7n4nqrIoDe87BuAusR4AZHoMVBSRFyjt7bKI2MFSceaigSf8WYwRmzh8GA
        ==
X-ME-Sender: <xms:7SbDXtOnI0j2-kgGwjGTkU4HOfWtB_F2fi1uHnbUNxQk9jPaQNZNKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:7SbDXv8icLiT4lM1bSEA0pNGSzsKFa22FnYhuv7frg64GMewXMmlzQ>
    <xmx:7SbDXsRYpKNoaMee211aGR9FNV4MU8DYUrxgJjoKcIZ2GGMhVsjY2A>
    <xmx:7SbDXptPTWYr0BEwh4whoI3PElvFsQEWJyLbQzM20xj2bI1xGZI1RQ>
    <xmx:7ibDXp5uEtBy5jID-x8ZNuiygRH1WvtrTk3mPttALrjLWGhwFcdj1A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B312E0109; Mon, 18 May 2020 20:23:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <eab147a6-4bc6-491d-aaaf-61526c4df5ff@www.fastmail.com>
In-Reply-To: <20200518112059.c19899ffb17a4843bf4f74ab@kernel.org>
References: <20200517153959.293224-1-andrew@aj.id.au>
 <202005171447.00CFE0C@keescook>
 <20200518112059.c19899ffb17a4843bf4f74ab@kernel.org>
Date:   Tue, 19 May 2020 09:52:48 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Kees Cook" <keescook@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Russell King" <linux@armlinux.org.uk>, labbott@redhat.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_kprobes:_Avoid_fortify=5Fpanic()_when_copying?=
 =?UTF-8?Q?_optprobe_template?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 May 2020, at 11:50, Masami Hiramatsu wrote:
> On Sun, 17 May 2020 14:48:52 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, May 18, 2020 at 01:09:59AM +0930, Andrew Jeffery wrote:
> > > As mentioned, a couple of attempts have been made to address the issue
> > > by casting a pointer to optprobe_template_entry before providing it to
> > > memcpy(), however gccs such as Ubuntu 20.04's arm-linux-gnueabi-gcc
> > > 9.3.0 (Ubuntu 9.3.0-10ubuntu1) see through these efforts.
> > 
> > Ah, dang. :P
> > 
> > How about converting them all to unsized arrays, which would also allow
> > the code to drop the "&" everywhere, I think. This is untested:
> > 
> 
> This looks good to me since it uses same technique in sections.h.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Kees,

Were you planning to send resend this, or were you looking for me to polish it
up?

Andrew
