Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C9C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D354206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="pU3O/TGz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOzSyMqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgAQABw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:01:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34347 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgAQABw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:01:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 50F0D22077;
        Thu, 16 Jan 2020 19:01:51 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 16 Jan 2020 19:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=+4d46nAg69apB++QN888O8Q+rlJqDsK
        iGI/rETf8CM4=; b=pU3O/TGzgUZ3cp3Ae/Qw15GIvIjIhv/92V3RUdmVj6lSds/
        pXL0Z7/YbEl3E0cFfDuhfUm0ckwZwa6rxViF7OcVTGxni6emI4oQ2LLu5bswSN8l
        kZkhu81p1sWyemLn6DViC0DKSGaE39pcIzvK8ffh+7VE6Vl0o65OEtJy//REukeb
        tfGWPjc037eNB0SvKApmpr4rlcLNaIs3kxHCQbt/We8haJm600Li3uDmgU7hVlX8
        knBTLQ1X54GMJMpeGBOca1nMU2MPEGX91VPIOvtiqtxxc67osNpieHi0XjfT5VwZ
        dBSKTyp+awkXY5/upHAG3sOhdIzNmoj3V6dm30w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+4d46n
        Ag69apB++QN888O8Q+rlJqDsKiGI/rETf8CM4=; b=sOzSyMqvMQhD65VKHv+Mg2
        pj1KC1HwCxPjpA+4oJr6HoWgigppLMyvZp51ONbGdaW4aLv+BxC+cXgeOO0f8tJs
        M+bA2zaqxHEOnEuguEWztQSxkn76/XN7r6Ju27Ti/o95F2JWH5d23Nmu7qFe+JcJ
        Q6LUSdj3elIlkPKnLfNEHq03PbgiHIOMbykFZRn7fyiYlm1oqzlWvGTH4AL8zgV3
        mzuc8nj0DQEoWbhGl1P5LH0jOiNXDl4ep8cSV4HUtrjYrdI0Ow3BVyeJSiIoKghD
        fJlI9w/q4O5btBE+JtblN0+Ghe8V0hH72S5epN/hS4HUHO1wR83yy3MbRztZhtzw
        ==
X-ME-Sender: <xms:bvkgXrwp2O7KjDadKYhXFxuD_ExIQbhRvZrHICMXQhVuzo6jm8X_CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:bvkgXlrTSkyde1d1nfqk5OXTTD2kEYACVJ1253A8zSxeDrdMRZKduQ>
    <xmx:bvkgXunaSZJfs2iTREwtxands2Y9uFDPHpdw4J7KZX1ze64THoavXA>
    <xmx:bvkgXoo2rAyhshiNGu-So5CQPpZawZ0EOO1diF6-5V1YCLlWB7TtAg>
    <xmx:b_kgXmn2xVH8CBc3Khf_qc91iCtNFOjCWCY0rnCuspTEJHtAa-pfeg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7DCD5E00A2; Thu, 16 Jan 2020 19:01:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <9007a9db-5250-4ad7-b436-da26d6e1b620@www.fastmail.com>
In-Reply-To: <1579123790-6894-6-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-6-git-send-email-eajames@linux.ibm.com>
Date:   Fri, 17 Jan 2020 10:31:30 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v6 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jan 2020, at 07:59, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
