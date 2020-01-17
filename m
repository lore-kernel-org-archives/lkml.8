Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B54CC33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="nIHuqEaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFzk6qeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbgAQAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:07:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43489 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388123AbgAQAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:07:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A1EFB22076;
        Thu, 16 Jan 2020 19:07:23 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 16 Jan 2020 19:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=iVwt3LIcBpxtFQ+R6FD04TuQoW5u6ub
        4oIPG6WUenUY=; b=nIHuqEaQ/sdrRrnsOodMgfAs3fTxRyGjWwxoiqVpAMqh/Qt
        kVmSJqwZU8bxBNnsMPqiJWa3s0SHfcPlBXlASOT6jfKblehz662os+gJu2EBMeaa
        9JbzPVWSCEOyV7kFfSCx2jFlF7UAkrTFk75kwCmJGUqKByCuzo3lJi8J4IKijzOJ
        c7k5D6XTfXPB9jkSddI5Y58MeMkV2TvDbMQLvwun1uQrmEyg1n1ERely/joAyYvY
        /3+hP0wvNMi1ci8CRPAeyjIYn9okYHnAouz0og82Aidmpgq9V014K/bd6n03j5EJ
        WDa5RL8omgYZ99MzbUTm+3Dz+tQKdxdfrYSKvyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iVwt3L
        IcBpxtFQ+R6FD04TuQoW5u6ub4oIPG6WUenUY=; b=xFzk6qeH/mvGkHHqBRPCx8
        Xy+0sptLa18T7CSAZs0gGyWF8+Puym2AKTUC9fW9XW/YqU6iMWL9KjUYN41VYBnH
        53v39rwy/b6QLXY2ltb6l+GV05GE2jYAD+dGpcjoG7sPBklxgKdqrOJf58JTaJq1
        M/SUMx5W4GAtg7AKf/yaT8CUjUvKxkx5zNxb2WmYWLDvzFyjeeMsRaol0yYoCYud
        p3EohTACIeJ85/jDuL8YXXyiKAqYyHO1XwhW2j9XCbWFOmQXw6rSa5AeWjpLGEsP
        GRkNHBSh7WpgVuLg/qYhXTy6rS2IQ8DUO100xA6YrJergIXuVpL9lYik/ljWQBog
        ==
X-ME-Sender: <xms:uvogXrsTmHavIf-jDnARkqGfVjrD6osK6CKmwH0D9y7gJRFUyY4PHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:uvogXjvPrn-SFp5F3ABf5eUxaaF1D1iuRGqUc7kLHp4u7khdoD_BYA>
    <xmx:uvogXnWgjI5Th7WMD_W1W_ecOgLJK6NVEFt2DlkgkYqGuEmWXAW6UQ>
    <xmx:uvogXnkPWU1OIPoNXerWWvGb2FFpP08Ba9Nafp2fogsNj56kBDjA5g>
    <xmx:u_ogXuKuvqk1CinQv_y0rRqWGw2T-enbioXnTs6QkD0pJQb3jp68Sg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF383E00A2; Thu, 16 Jan 2020 19:07:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <34acf604-d2e4-4efe-91ae-52b7a0dee187@www.fastmail.com>
In-Reply-To: <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
Date:   Fri, 17 Jan 2020 10:37:02 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jan 2020, at 07:59, Eddie James wrote:
> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> DMA operations between the SOC (acting as a BMC) and a host processor
> in a server.
> 
> This commit adds a driver to control the XDMA engine and adds functions
> to initialize the hardware and memory and start DMA operations.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
