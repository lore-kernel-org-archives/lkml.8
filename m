Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD1BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A0C206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="U9qYpLGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/QDZ4VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgGKGYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:24:44 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49999 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgGKGYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:24:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EE187EA3;
        Sat, 11 Jul 2020 02:24:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 11 Jul 2020 02:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8A2Py9jlDUXosNHf+tIf1lzSvF3
        YWY+pBbKgn9E4Kbg=; b=U9qYpLGCmWF3jGgn4MGK6pKrcarxbLaVdXn5QSpNQvg
        eXu74TCi85xFhcEuGTX3VI8NHwrBlwgKJgRI7S4+jI8vBSkYAgLR5zhkPSrsVarT
        Fan4zlBx0qT+F/oLbWIuitz4KrfwxAF01Bj39ZIP+z88pgKNqT3Zpsq9d+z8oonT
        o9syS95tx6a+L+CJb5NQjfmlGbktPiYta8e58tcSJEIvd+6WG/mq9u18eTg/UHlh
        iwX0LZBpEmfy5clhfGK+LJW30uqJLvXlgt/uGSvHaoJyXl6TsMkyWF4OyXk+sS/e
        Mx2VthHRZQs6feu1y+akdoxJxX9ciFD2kdBNiYarl0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8A2Py9
        jlDUXosNHf+tIf1lzSvF3YWY+pBbKgn9E4Kbg=; b=X/QDZ4VIauQbVmgwaKWicr
        Fq1oWMSQyVL+A3ZaUMhKi1xbcErx1xd6I8JT3/3YpiztVwWQ9jmw3pxTC8SIsCgB
        aUI0FjPNn8pGbJQWjWMoHe14n9UKkO8eZ2Z/0nS4XFzkLInIvELrRbfjqGq0Wb3y
        Ig0VZ24xqK5eygygWo/XwBz/6mAbco3PRVlzV0T4uLsG59y9EfB9MQnOtboF2O6M
        IWWSVPH6RbANIbkzAnwUNmBCc6bI8ayovCgHGsKzFvKRqMWhxTDZIanMEB/lvGHe
        6pehquMTgs0ZNNg2jBj2N2PmVqo4ASzxv+pGU4ElfV8nlgbOSD/samBEVXGuq3kw
        ==
X-ME-Sender: <xms:KlsJX1tVo-hRwIEXOwSwxGMHuJVB0fTcNJqQETrdtbvl3_BnXH0cTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepieevhffhiefftdejveekledttedtteefheeileevvdehue
    efffdtveefkedtgfeunecuffhomhgrihhnpegsghhnuhdrohhrghdpsghmohiiihhllhgr
    rdhorhhgpdhklhhimhhovhhgrhgrnhgumhgrshhtvghrrghlvdhklhhimhhovhdruggvpd
    hlkhhmlhdrohhrghenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:KlsJX-c1Fa76TWRiiIvRiga4Hv4rd7rL-BVbtGrScIdN1xBoBbdfZA>
    <xmx:KlsJX4zVyScQPOG9oY1fS8jak4NeD-GB4TcYxXY4Wu92qgyr9GArfw>
    <xmx:KlsJX8Mgv9BEHPzSnR-MQhAVXQ4qrzKrLs2cHOrm_1qto68FuAHnvg>
    <xmx:KlsJX3lhgpI0ZY082q1T8pErObKfZAE3GElUAioV_BzAKRxIMHA77g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D328D30600B2;
        Sat, 11 Jul 2020 02:24:41 -0400 (EDT)
Date:   Sat, 11 Jul 2020 08:24:42 +0200
From:   Greg KH <greg@kroah.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB OVER IP DRIVER: Replace HTTP links with HTTPS ones
Message-ID: <20200711062442.GA2784200@kroah.com>
References: <20200710173931.29270-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710173931.29270-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:39:31PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.

Again, subject line mess :(
