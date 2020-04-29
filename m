Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5814DC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298A8206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="AQ8VdrvJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RF1Zc3H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgD2NoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:44:01 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38131 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbgD2NoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:44:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 161D05C032C;
        Wed, 29 Apr 2020 09:44:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 29 Apr 2020 09:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RCkDFCkJ36lrnnoBT4PNHnDTJIA
        yrsJLEZzeqnANdOY=; b=AQ8VdrvJPUngy+owDVLnDzYd9A1GPRywCSjbOdCArWh
        CCFE8cZfIkJlvZ5Y/FjUMVlsWfYVYr69XAgZBmGqFTQhc0R5f0kBaz6owdKF7xaz
        YFxcJ5ZE8+jydVwt1+kNhoQ1ZHjvzvvmX+SRSrTJV8WjbKFiL/7Mg52JEEF4cOqb
        JgYOcxMVf7nNTFrl+xaS/t77X/uo8eoC/Ssde/JoLq82dXauwW0ZRry7+40BX/u4
        j78lVB46VBLt5hf3hgvjU7DCqjHdPpwyIvtlyaniOJN6hOOV1iNAleub1NjbmZve
        IKLbyJDvyVVqXsE2d+ndlaEdW4rmjYWUccLZiAO1zqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RCkDFC
        kJ36lrnnoBT4PNHnDTJIAyrsJLEZzeqnANdOY=; b=RF1Zc3H744YcckFjtaTly/
        p39Emml01M31zsNvnwHJq+4i0r/RxAvjead5TzgNAdFMH4MDyYmX0un3hT3cfeVi
        eJPAnp4SraPaLz4A5cmrM7eWe+7vpvLYN3eYkh4EOd3pdBVqsuphbd/b9gXMEHdM
        JqQSJmg4AVZafNDKjy5UdW0PnxEJVl9L1m9cuFk+Ub+S9+hrtPPpMlNeOmRN2wiU
        X+Psp8MpgvL/MvcXLEKkDoJa+Y/n8VCnT9NpUMh3TcY8Bkpdw9BnlVAVjsX8ikrw
        wGsJpVqXoVnyRG9whhx6zzq4tWMczw+VKLE4fN2FL3wm419Zp+NJow/37UjRS95Q
        ==
X-ME-Sender: <xms:n4SpXldwacOaPD6Q4Y3Ndfu8ds0BQfHEMlz_BawAwCIvb0Q3FmTgtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:n4SpXheFf1MHon5mWloqgUusi6l7poOym-YrbFJhj8-yjKiRj36B-g>
    <xmx:n4SpXn2YYLkiRQBWw7sV1XsTO2UYUkL77E2y1QIpk_tj6U_J59GWfQ>
    <xmx:n4SpXh8OQqdRdFrxvsdrCvmJhCwI3YClgwdy-0fvhm6cqfuLAV-gRA>
    <xmx:oISpXmQhvve9eJVDbDd3cR8wxmuq7kkKkMzaLJYNZRwSz7ciLGqElA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 545393065ED1;
        Wed, 29 Apr 2020 09:43:59 -0400 (EDT)
Date:   Wed, 29 Apr 2020 15:43:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] w1_therm: fix reset_select_slave. Creating
 w1_therm.h
Message-ID: <20200429134357.GA2132814@kroah.com>
References: <20200429133048.139402-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133048.139402-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:30:48PM +0200, Akira Shimahara wrote:
> Patch for enhancement of w1_therm module.
>  - Creating a w1_therm.h file to clean up the code and documenting it.
>  - fix reset_select_slave function: w1_reset_select_slave() from w1_io.c
> 	could not be used here because a SKIP ROM command is sent if only
> 	one device is on the line. At the beginning of the search process,
> 	sl->master->slave_count is 1 even if more devices are on the line,
> 	causing data collision in the bus.

This should be three different patches, one to create the file by moving
the code, one to document it, and the last to do the fix.

thanks,

greg k-h
