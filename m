Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B001C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F802206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QpGAjU/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T/YpZQJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgGAK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:58:39 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36625 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729908AbgGAK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:58:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B9815C0178;
        Wed,  1 Jul 2020 06:58:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Jul 2020 06:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=X
        ko+oYoxVUadlpUjLxJMgaxQWoXDIOXW6NjXCYSOOgU=; b=QpGAjU/2N5JU/CSb+
        YBxI7Dozy1Xr//JBPKtC55L92RXUTQ+FguOKC5SiguA7ls7i2SWdJfJZMAXJXkYX
        h6M9BtCWXUP2u4WRhEPMe6WeNTz8k5XJqoBlp407xgrGNC7Yztz+7b3aZMQ6HDyd
        o4vU0NAIziKExdvL/OTor4KwkiaA6ZvpcB4uTcAhpg6P65RHlsiRt8SsNxoZYh8d
        I6Iuv/YrFRhgahQaQbkaSIIawMQDR/4EWi2DAeIZ6MAMpybWHH8Lt962q/92la+1
        fjYeDoJr0n/YmYklJYWWnX90sTE2RDKslPHqaGAZpcHcEvfxY28f7SOI1ezr7LVB
        BJ6uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Xko+oYoxVUadlpUjLxJMgaxQWoXDIOXW6NjXCYSOO
        gU=; b=T/YpZQJG0XCOKJAmY+/kKtLtWNLcWqtKYVUaxRmh8EHjch7Ye6etfydqg
        w8YCSO8D0x3evpnlFrxpVNTrnWs5sXEpZGNF8791sx5MvPUebTyw7qutLKuj0nAR
        q+dbQe0r7h8dqKCzU/6OSET6DG6xZlsHQ2BEgQD1cm5AnibZzx94+4RNPYvJ/fvM
        nAEbppisJ0c3ekUSinNF6IdO7avSCIbS/CJXGyVscoket1lqw4mpnV0bSYEXPCP5
        XzK35DcVJbh6AoTHU2k+XLlig5fctg0zHeiak6zK5ayIccZjdp/8wic1RPzpbLkF
        xS7M63RoKmw6rHiab9ZMSQxrFnZtw==
X-ME-Sender: <xms:XWz8XrCckiIRwR_Qbuh0dtvApWfbZOL3FJo-VNQWsNiRybG7d6zgbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuheekhe
    elffefieduteefkeejffdvueehjeejffehledugfetkedvleekudduvdenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:XWz8XhjzaMvV0F4Ax5r32B08FXraJzcdj-l7tqb5MFRG12q3lrTBLw>
    <xmx:XWz8Xmlpl8eWaybwafLpcLK9wFbQMPkphm8TAlUFXFjPI2WcKIsrZQ>
    <xmx:XWz8Xtyj24OYc5k0ihhf1jg5kwXPuz3NIhJdlr5Qx71ScvZyn4yVrw>
    <xmx:Xmz8XvNwv-HRGR8wz1fEVqisHUKvHCMdMryJDLizMfuNEisP6p5Myw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 860023060066;
        Wed,  1 Jul 2020 06:58:37 -0400 (EDT)
Date:   Wed, 1 Jul 2020 12:58:24 +0200
From:   Greg KH <greg@kroah.com>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
Message-ID: <20200701105824.GB2098169@kroah.com>
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:15:52PM +0800, 孙世龙 sunshilong wrote:
> Hi, list
> 
> Are there some potentially serious problems that I should be aware of
> if I totally disable the CONFIG_ACPI option on the X86_64 platform?

Yes, your ACPI-based system will not boot.

> Would it do harm to the hardware?

It might, try it and see :)

good luck!!!

greg k-h
