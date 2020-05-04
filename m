Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327EC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11602073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="KwE4E4Nh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEEqvNl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgEDNYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:24:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35895 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEDNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:24:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B5B375C00EF;
        Mon,  4 May 2020 09:24:04 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 04 May 2020 09:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=DJbaaOuR+6YHYaJHgAZbaqepInhtEO+
        O3opNfcdNHMk=; b=KwE4E4NhpTz3bFlHAfJsiyBVoDjPGT6iphiVk2YB+0MFae/
        bAHjfF9EpBYQou+5B6CoQKJU7i6dfZXQQqb33O6toyISkuQh6lKCBLNa6fEEoyb2
        x1XHQwVA6nn5Qu+u5BYbivJ2IBbZRMn5mRuBRFXMspWPkWJTzhOgjIcXvnYK4YLT
        YwKAcN514atSqpqir0N07vj+4NpaudOkIChi6cQfiv6xJnoOvEcUyTz+CzC8Vcxf
        bymRkPa2Vzjoq8Lv87W8lBPJUolowqd8G+y0AJLqtqh1/mRjS33om2nli4cTEt24
        YN4OuvhpVcUwjF5w6EHzfIMWchCxynRkoeuRclQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DJbaaO
        uR+6YHYaJHgAZbaqepInhtEO+O3opNfcdNHMk=; b=oEEqvNl7bv9sucTj20Y/R/
        PaNZ9cTflvHMhRC5eFH7Okx/LTmLkDRmLDbVvfBEZrcuix6kO7zjsMzOo5Af7u8o
        PEieVA0QT/uT/0M2eC6CG2wApyoZIFdphGo3/wYsFxg+Awxfj5SrCJIcXDT0Ja8j
        K/rP1RSYN5uZQtdxorw3t6SqFCBZC0dnbGCKHckkszG4ukXK4dihYxZ2rk1HIe8c
        mXXhWqQDZq8jAuFJGBEAm9XFgGjJz668ImK/jUL3WnZubKFfchkE+wfdvpm/ijXT
        mJTXXo6UJ4wcmPY8RVf1krfjnAeJ0KoWIFT3KzvcJjUC5KF4kNiayq+BkJMQG2MQ
        ==
X-ME-Sender: <xms:ahewXruF53BQnNhnb2cWtIa8oqZvGEkI5R66wbqsp9C3WOXP_1izYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:ahewXoLCwJMrgaFGB-q6aGgla5a-oVChd3b2MalmrAMdUmmutEHN9Q>
    <xmx:ahewXpf2878l6Q3sK8698xAr2nhmL4zmoH0EKFHkY8XM3kYzS9do2g>
    <xmx:ahewXrLvyf0C32mc8Vaw6JEueOa1RGQqOC1bwfwbQOZJZjyWCG5sxg>
    <xmx:dBewXm0j82CQmSxvcOLkLoxITE2jVaVa7PY6vbAOqaFGWi3EMJ9SIA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 72E8FE010B; Mon,  4 May 2020 09:23:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <0ca41514-d664-41e6-9f0c-0d948db3e9ad@www.fastmail.com>
In-Reply-To: <CACPK8XezSFzCeQN4tkvcmjOHEAgrRGYBiBzRymaazpv8Lh-gTQ@mail.gmail.com>
References: <20200424135303.20952-1-a.filippov@yadro.com>
 <CACPK8XcP3V=8fAUfNvRFqPU9G38dGR43Kpp=Uxm=P_AjrMnzBQ@mail.gmail.com>
 <c1de0c90-d486-4855-bb26-0f3cc416b05d@www.fastmail.com>
 <CACPK8XezSFzCeQN4tkvcmjOHEAgrRGYBiBzRymaazpv8Lh-gTQ@mail.gmail.com>
Date:   Mon, 04 May 2020 22:53:34 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>
Cc:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v5] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 May 2020, at 22:14, Joel Stanley wrote:
> On Mon, 4 May 2020 at 11:04, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Mon, 27 Apr 2020, at 20:41, Joel Stanley wrote:
> > > On Fri, 24 Apr 2020 at 13:53, Alexander Filippov <a.filippov@yadro.com> wrote:
> > > >
> > > > Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> > > > by YADRO.
> > > >
> > > > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> > >
> > > This looks good to me.
> > >
> > > Andrew, do you have any comments before I merge?
> >
> > Not other than muxing all the ADC lines to enable just one seems a bit strange,
> > but Alexander mentioned previously that the rest were simply grounded so it's
> > not going to cause any problems in practice.
> 
> Thanks. Can you say the magic words for patchwork to pick up?
>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
