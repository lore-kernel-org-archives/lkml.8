Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3510F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="AbYWfCIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FOvR6siG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgEDLE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:04:28 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:32907 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgEDLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:04:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7F7C62D8;
        Mon,  4 May 2020 07:04:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 04 May 2020 07:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=49dwVzlg4yout0mlI0duNcm7pu2D5zR
        VEWyuXFEPhGU=; b=AbYWfCIh+Tz/F50g7Tweaswku+okSFIb8Wo4E8U6foqtSM8
        ZYq90QcAXG/rYSrgWAxUunR/NIKo8L0jrJiDMR2TrbJ6gResjk9t1BjFPHRVJJPG
        zOISYVxOXjy3U1q2PvSBFOPtOcVx8FteX8dYqEqJE6zGN2+G3o9BUMv/PzUyGWqe
        qvKqFuKzgQvTRVGFp4XQOBLhT/o0Q3sQ21ehzLKs6bGESJaymgCz3oAw934IdQuP
        b+J6Xb+AI+IwpOv9F8gYKDJvXOLEAg0zOpXMMfgAl41eAaiZe47EbyZ/KIUOZ4D7
        Nu0jYnNxdQTBWV8TLYPdWZHk93V+jW4tJzr4eFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=49dwVz
        lg4yout0mlI0duNcm7pu2D5zRVEWyuXFEPhGU=; b=FOvR6siGanOLWuUXtSMMl0
        o5uHqKxG3w5na9zs2jG7xeazFlHVCiqcrLv7AZRInMl063YJSocYi811HiR39MBu
        YWfJMWtccdjbc96RmKAPg36M4W3FBMl/zu/GcSsJ0q8IWf1qjn9YR9QfQ3hoITct
        CgcFs+k+yY5pvXJnEvEgb/i/7vi8oubVbOYhzaF3oz0GloUpx/hHghflEIzkFZVj
        fZDQOyKeC5H6HRGP5WCzpjM6wVKXI8Tmy0fIcbov2c3MOr+CJ1i4A5stkTOl3mEz
        u3g3BxM7TpJ+IF+J3F0CUnWAzVvY1HKlDx9/N4qrIZDm3WSHAZEshyTDqbqg8Mtg
        ==
X-ME-Sender: <xms:t_avXrXmlbQpGG5_yRbhLXtv1WgwUOVvBIS58b2naUbAdf_yleCQ4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:t_avXs5I4xlwGIpDS-tB7qxaOzAluwOdfezFC9QOmv-LpJU505O-CQ>
    <xmx:t_avXurijGF2Ua1hkypHCzPPMfpKzIoNwqGkXHIEyzlbT3mmpCYiwA>
    <xmx:t_avXnn4wsesB9ILvaXG-OB5KPmuh9NWy5RYqW1PiBM13v7U8UYQjQ>
    <xmx:uPavXltuK2j6jja0egnmx5b-v3iTrYs6VXZHLR2NwnSSBT7RQ1vzVw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0543AE0131; Mon,  4 May 2020 07:04:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <c1de0c90-d486-4855-bb26-0f3cc416b05d@www.fastmail.com>
In-Reply-To: <CACPK8XcP3V=8fAUfNvRFqPU9G38dGR43Kpp=Uxm=P_AjrMnzBQ@mail.gmail.com>
References: <20200424135303.20952-1-a.filippov@yadro.com>
 <CACPK8XcP3V=8fAUfNvRFqPU9G38dGR43Kpp=Uxm=P_AjrMnzBQ@mail.gmail.com>
Date:   Mon, 04 May 2020 20:34:02 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Alexander A. Filippov" <a.filippov@yadro.com>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
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



On Mon, 27 Apr 2020, at 20:41, Joel Stanley wrote:
> On Fri, 24 Apr 2020 at 13:53, Alexander Filippov <a.filippov@yadro.com> wrote:
> >
> > Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> > by YADRO.
> >
> > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> 
> This looks good to me.
> 
> Andrew, do you have any comments before I merge?

Not other than muxing all the ADC lines to enable just one seems a bit strange,
but Alexander mentioned previously that the rest were simply grounded so it's
not going to cause any problems in practice.

Andrew
