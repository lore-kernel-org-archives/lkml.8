Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC8C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346A620684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="UEHhzXj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgq+qKxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgAQAOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:14:03 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36659 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgAQAOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:14:02 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D3BE121FE9;
        Thu, 16 Jan 2020 19:14:01 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 16 Jan 2020 19:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=eMruiSYqr1FxGghMIkkwNO55AX7K0Cr
        Pd/V2d5+JeQI=; b=UEHhzXj2olimoLouYY7utL2wHRT8JpBd69l/8SlnTrf79In
        rm8jn6XKrlsXrM+gjhdMSc/pSSkEwxj01QNES67eSFmd1yact93kuDrhYwvCf2XW
        C+RPgHEYu0DS2NWiNHNf3v4cY6z5eJXqxAkv7lF69FT8Dxps1b4j0qaIg0zueJ06
        KyLaQcvzRmiRKzAbEYzTfSKaI0fj8JCa7fQUXYFq4IMwa20uVfbibDI1eW5l70WP
        gfGsJrwgGVFqmFCEdZ0CuOERSXbBbFmeb5iA6ozuFz7Bg+EUBT1g0I90VuBUunJw
        NXPAYxqUUEqtyNXlG899EQae+a9hwS1ka1D73ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eMruiS
        Yqr1FxGghMIkkwNO55AX7K0CrPd/V2d5+JeQI=; b=bgq+qKxIfYKvCxKG/hbX+5
        Z0ejB/RtYAQS7ZmDSdYYcimVWQ0psXs/gUadU+cBrPHDCqxiToRt2MKj8rFFYZzv
        yPO28OIiX3ZBVb6Q1yalH97PjWyLIHEMF8rLmn4T4SucYE7pEqQCUQUnuqeUBKsS
        DI9yrXG/hrIY68gBTDPw5Gtyi3XDG7A2T2A8jGU8Nqi/xBA8orfUZokiqrgVMcqD
        jZJLv1mCWObFOaT1Ar+KhKKCpA4TKmGONyPP7LY7n2zxUVGTzdqIxBIZzoEKjtrt
        I4amtndKfMk3tVZPDpOjzBp/JPrXOq9AjqFI3qS6Orp89zyTLCsbG3FvBYZVxYlQ
        ==
X-ME-Sender: <xms:SPwgXmP1zPPyT3WOAqwU2-vcYRGThHldOuR2wnOpkI5I_TCsXFNXBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:SPwgXk6uYAN_J-BlCFwdDIGgyK__-V9pwiBZ7lctTS9rTqgeTYewWg>
    <xmx:SPwgXo1prbAADo23zUD7Ta9PJheSGx76nBB_ao8fHoYPnEeE3bZPzA>
    <xmx:SPwgXrrzbveudwt-xIPRdYVgPsEYKvzneM4VS1r88naBCCV-YrTaMg>
    <xmx:SfwgXoYcOGbfCS6lSrZHqm6xYoho6QYWcKUKA7emjUwiWmV6fUV1aA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CE957E00A2; Thu, 16 Jan 2020 19:14:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <17a4475c-e8e4-4514-88e4-4efe7fd8dc8a@www.fastmail.com>
In-Reply-To: <1579123790-6894-13-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-13-git-send-email-eajames@linux.ibm.com>
Date:   Fri, 17 Jan 2020 10:43:40 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v6 12/12] ARM: dts: aspeed: tacoma: Enable XDMA engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jan 2020, at 07:59, Eddie James wrote:
> Enable the XDMA engine node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
