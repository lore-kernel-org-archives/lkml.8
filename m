Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E60C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20192072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="q8t1Qzsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQPMWpAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgAQAMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:12:25 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33397 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgAQAMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:12:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F77D21DC7;
        Thu, 16 Jan 2020 19:12:23 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 16 Jan 2020 19:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=eMruiSYqr1FxGghMIkkwNO55AX7K0Cr
        Pd/V2d5+JeQI=; b=q8t1QzsnN7aoHs5/oaQCUpnRKJOrTZLBriRrb4klqqVpPSZ
        Um6oV+3SNMrOy5PwmT2iO8D49u0osrdZV1+HklG93xUe/fBWpHyOu081AKDm0fRQ
        +1nPn2Li+Sah1hFEN/UdBUyPF4Plf0d9whgGbQfd/gIYKSiSnTzv6TUt7OD5PN1w
        of3G4rlAGfwtOIEY3rELHVsQ0enyuW3QNfzbgsO7g+ZtE6r0c3Bhn0aZEyZ47bKb
        SJ/8A3uTqKm3DvS/BbbVQgEvEYKJ8+M26b0+zPmDD+AtVVjQKHOnEGE25FjKkZP1
        0PrEeLF/34UtmHjK7wOOxiT1XoLoWW/VgKlRXSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eMruiS
        Yqr1FxGghMIkkwNO55AX7K0CrPd/V2d5+JeQI=; b=mQPMWpAlloFNUnR5IaRTbz
        WdQoKVt9dpOpUidCoEVs6KgiV0wPrBcRfl+mDZG465t8vgF2+5+F9uI/hDmuhblN
        TEl49/Hp7z2tIeqlwTyiafnYAgIIE3Y8cbM6c0dM1ceqaYOwVPktC6iWWt3lJJwI
        kydBy6wI8Fj5ccfORDItCKOxScXrHF+KJiVUjYcS5D2KgQpWb7vLXGCviLcgur9v
        USy6Mhbyh05iW+KZNZpt3pd0EL5W2BmdBkIbJBht5X6Ajzklx1BnNzYiHFKx+MKr
        KOOK7riLtnwM2JQdj3t3XpOnaokIhxNEx7h7r2wM81u7WiYMwkHX3a1/qbV28hJg
        ==
X-ME-Sender: <xms:5vsgXjPzPjmGNbOzl4qF9YjQTapJv4O9SJallQc1HaM_QJgJhSG6Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:5vsgXgmeRu9HhKIjdjSruKcatVe0gdyjRb7JNz0ODcPz6CFIVAiMKg>
    <xmx:5vsgXhwOcysow1b8KHTly5xqI4h-RYe0sHsVXxEa_L3jzAf1YC4LMw>
    <xmx:5vsgXpAdANiWGGbUoQttkFtotnlniLBxl9ZrwVPqsLOQ0dNjI2IcgQ>
    <xmx:5_sgXtTQWzT_4-a6aFplwFF-MdBakhV7uAYIxsQEB0uwdnxxa8WMjw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96D2BE00A2; Thu, 16 Jan 2020 19:12:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <2ebf5f23-66dc-40c5-9812-f635f70b5245@www.fastmail.com>
In-Reply-To: <1579123790-6894-12-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-12-git-send-email-eajames@linux.ibm.com>
Date:   Fri, 17 Jan 2020 10:42:01 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v6_11/12]_ARM:_dts:_aspeed:_witherspoon:_Enable_XDM?=
 =?UTF-8?Q?A_Engine?=
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
