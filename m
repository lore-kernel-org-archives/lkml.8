Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45630C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E0E2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="caX+Ir0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ROdAAu0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403999AbgDPD43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:56:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36717 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgDPD4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:56:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D06EA5C0111;
        Wed, 15 Apr 2020 23:56:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 15 Apr 2020 23:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=YIfc6yIC2BLuseO1/P1Gj+zOdgsgiLg
        pvWs+B1qmSOI=; b=caX+Ir0iipoGQK8AcRu9Yfc1lvZAF1n9JoP6T4MvnqeLaKX
        HR9/HEKpWI8t6cnw7aTA8fqsHTX/IwOiwGaiBkc8YeIsKEJXO9t3CwEfi+Ayr3+g
        eX7JY04CgxPj43j9pZKIlUhohhtpPTuVaDVJhC5gMmJ6F3gfhiNYarcrHiLjyAyF
        bjtScbc4EPxMLNSCABpuJteo7gi3HqVJIh0AP6O4CkNFR/QEkeiH07851JZI3PPQ
        zSdXDJOfl6MrITX3Pm9HtEIMRnBTJVyFnO8meBpWgPZC3OZzKa/dbJihje0ySs2z
        ROLbSPSD1muxdOVqO3UYf7VYPJ+0o0VfL8rOhVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YIfc6y
        IC2BLuseO1/P1Gj+zOdgsgiLgpvWs+B1qmSOI=; b=ROdAAu0G4mF9TsBznYXtRB
        FIItH/jON2fNCy1T1Y6SRk/sPlygCJQfGveqZtmk+iczKgTrdF6toMqGOepTwXS/
        He+ROWpzpJqJK/BFadKVTCcK04hntiWuOX3m6/xA+9uan6jAdM+YKwiZSrzhNo2R
        VPziuou5PvZfceFhFQR565RaypOB3MyyDHJmf9oDpZZ5C9Y8EgT4t66KpecA0GA8
        nxgWSocEjI5TdTG7PJlS312LTeqrUvQRsiNGkiS4JCD0LlnO3nr+4ea4yrjCyxw/
        97aCgCTNOz9oCqRRQGeL7GvD9ptlqsz14n0oUOcupI1wOo+xqVl3EAaDnWJwR+HA
        ==
X-ME-Sender: <xms:Z9eXXsHRcjZJClS8H5854KEKrV5CULc4D7dHTLOM6JAk8W7Z0kvFlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfeeggdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:Z9eXXgNqfcWJoBosiX5Jo_xdrE-MECqk5t05HtRVdDFUyDSiniP_bw>
    <xmx:Z9eXXpDxTDoju9Oh30kRlNO7hASzNt5F9ZdC_0lud1wvnVyVY-fdmw>
    <xmx:Z9eXXnzvK0-E0GCyaxo5I8p2mqHXZdAhhxwcWh7zZwj6DpWQp2KZ6A>
    <xmx:Z9eXXvAxpjhJg0SpMySa-HGbX5O6SNZ-RiNWMCAiyCOTUJ3c9CKpIw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 98BE9E00B9; Wed, 15 Apr 2020 23:56:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1131-g3221b37-fmstable-20200415v1
Mime-Version: 1.0
Message-Id: <2a546e5b-5a5e-42e8-a201-67cd9063249f@www.fastmail.com>
In-Reply-To: <20200410145904.GA15615@bbwork.lan>
References: <20200406101553.28958-1-a.filippov@yadro.com>
 <ad46ff33-8ce2-4ffa-b12e-204053e4f705@www.fastmail.com>
 <20200410145904.GA15615@bbwork.lan>
Date:   Thu, 16 Apr 2020 13:26:50 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Alexander A. Filippov" <a.filippov@yadro.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Apr 2020, at 00:29, Alexander A. Filippov wrote:
> On Fri, Apr 10, 2020 at 02:29:47PM +0930, Andrew Jeffery wrote:
> > 
> > 
> > > +&i2c11 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&i2c12 {
> > > +	status = "okay";
> > > +};
> > 
> > Are you accessing devices on the busses from userspace? It would
> > be helpful to comment here why you're enabling all of these busses
> > but not describing any devices on them, if it's necessary to enable
> > them at all.
> > 
> 
> Yes, some of them are unused and may be removed.
> For others I'll add comments in the next version.
> 
> > > +
> > > +&adc {
> > > +	status = "okay";
> > 
> > You should specify the pinmux configuration for the channels you're using
> > to ensure exclusive access to those pins (otherwise they could be exported
> > e.g. as GPIOs).
> 
> It was just copied from Romulus and looks like I missed iio-hwmon-battery.
> Is it what you meant?

The Romulus devicetree may need to be fixed too :)

Andrew
