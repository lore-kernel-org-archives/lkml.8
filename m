Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08CE206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FmA4qL1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sjLdDLmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGZI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:29:09 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51573 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgGZI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:29:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 43CFBA2E;
        Sun, 26 Jul 2020 04:29:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 26 Jul 2020 04:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=r8GVHbzEDmWjEFGArOzYS+vA0V7
        d7+scuKLJRAdT1Vs=; b=FmA4qL1VKC3ud0S57gB0eP8rw20s29zFKtvBC/KdAN6
        77Ng488mOUJeMz9k43fUPMGEFHnlUC4Qiy6WVLCOXbjJ9KT0w8CCFkMbBhX+VNf0
        R9HHM/PogsNCn/GzlIhtSjNR+ubSPj6qtEe/Xv5s/ylK8aKGLkmwS23WChK8tMx3
        MjAXDd7VDWKXjN+GHvh1IDSGQtqFtaFCC/iVk6jQ8b1Vf3UgOBatkJltcQmYv+H1
        pEGMtHxX6aKs+Pg09fg4hsjED/zjoPDTHWHHlQzSAhAuBnQzGkJPd5SFeA4l9WXS
        Cn/u7/2Gf4XT7/GEpsJ9k0Xb32ROrl0mQV1pMAHi+VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r8GVHb
        zEDmWjEFGArOzYS+vA0V7d7+scuKLJRAdT1Vs=; b=sjLdDLmw/3bCkfTVRpFYe4
        MUHPBa4OMNr8Zb8zQbsBgdIGsxnK2crY2LyCzTe7juNnhsy4gD3PW2tCToB+vIry
        PQ+RLPY7NjhhqIJEVU93fqyh9yc+qDDDigcbBzzahX1xzkjpxEGAm05fS+JnfRV2
        LAGE2U1aaFQUiUUTAZa6VzWKwmUr+MQJGRPRrc0AVFNZrIyg0/1MUZCmloSPCTT6
        VPXP8oSZwdSd30CtT5y1p0e7v7AeOPvFLrAaa8Y0jkgjgOpvR7nhuVj9QWBG3fv7
        iaWWA6359d987q3OXxwI/+G8Rw4wLXwewlbNbIgwwAuPxjeG9tlGyZyYiyseHwCQ
        ==
X-ME-Sender: <xms:0j4dX9kYWUK38tKz65awkzoyIbk4BTKU0ANZ2jgZOXp1uRA6CpTlbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:0j4dX42mRKrd8B5GF0wBufWQ9DN4C2DJH0N1iAmewoHBJF7HEgHAQw>
    <xmx:0j4dXzrwOfT2SlqtjgYGro1RFhsLjWZHcxGzo_rl34Zn1GbFL574sw>
    <xmx:0j4dX9nQ2hBsWG6uAwOWVlf7jCpDj1lQ1lCB4qaybp_Key7LxaFhZA>
    <xmx:0j4dX5DufT5td7z0VlbEOEdEoxhzJfMF6uu_nyasiEOKnjk1u6mDHw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00F853280060;
        Sun, 26 Jul 2020 04:29:05 -0400 (EDT)
Date:   Sun, 26 Jul 2020 10:29:04 +0200
From:   Greg KH <greg@kroah.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     corbet@lwn.net, davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] devices.txt: document rfkill allocation
Message-ID: <20200726082904.GB447282@kroah.com>
References: <20200726075327.GA25647@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726075327.GA25647@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 09:53:27AM +0200, Pavel Machek wrote:
> Document rfkill allocation.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 2a97aaec8b12..763fedd94d7d 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -375,8 +375,9 @@
>  		239 = /dev/uhid		User-space I/O driver support for HID subsystem
>  		240 = /dev/userio	Serio driver testing device
>  		241 = /dev/vhost-vsock	Host kernel driver for virtio vsock
> +		242 = /dev/rfkill	Turning off radio transmissions (rfkill)
>  
> -		242-254			Reserved for local use
> +		243-254			Reserved for local use

Ugh, really?  Another "let's test this locally" value got merged into
the tree without anyone noticing?

bah...

greg k-h
