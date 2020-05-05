Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70652C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E612206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="q4VZsEbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGjGewXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgEEOsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:48:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38247 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729065AbgEEOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:48:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A791F5C0114;
        Tue,  5 May 2020 10:48:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 05 May 2020 10:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kfT8ZL/aV6Mm5grejUEjVjEC1xM
        kxA/XGNBpdFiLAvA=; b=q4VZsEbYXjBdmg+bYJMsB9PlXvdvHudKAF2W7IczXji
        Mn3kosPvJ8q/k4dPLxIzopeHxO7y79C/iK4NWsI0HRYpjGvEmI92u14KXeAzQLvR
        Xt2Vpk6iRCpztA56SMKOdazi4TNkfk7Pg9J5/kQ0q2+QOWor0uJBlzBUTPUwSe9p
        JZIkTPkTc/Wkh3soqMmcK9QJx39TphhdyB4lMjr579SBNB/t/lnhDj3q7tl/tIcy
        ELoxBTgQCuXRCyHU/9aDEJatrXvZ8M+UMErhUaU4PVpi2OJH0qYoetmfJeTQwSHI
        m2/S66bB4YzScyZVpMBmBjgveerJfvmYvyOo5AWJ2eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kfT8ZL
        /aV6Mm5grejUEjVjEC1xMkxA/XGNBpdFiLAvA=; b=qGjGewXSgRNCk+x0/kv0D3
        5iC1lRHDm9IKo3qrAa+UqB7CfhvUqFUUa8QH36rTDvQc3IbnLDSWqJkTEKbpiULG
        lnWytYb85laZrK7I3Sr8P2jQIm8EdKbfQyDA2WuX3bAC2++WSsPGLghj5mIC0bae
        JomZqhLSJn8wfxjcLoqugw2b8JMeFZjqGOb63KS8x94kh3IbwwI9NU7rtxHMlsDp
        HBK9SIBQWYAV8/xR7Wr9w+6WHcSvYTpAmpzJ2i6CYgq4Fiad46RR4Br2SV3jaKZJ
        IN7U/s67L4qJSDYkEqNFmStogWxfND+3W0imqtLmH8v4lmTvFcgkAcDLSLByueXQ
        ==
X-ME-Sender: <xms:sHyxXo4dYFytKfne1AQSsrx9RFDCjttmlVQ9iQR01R741aBv3DbZFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:sHyxXqotKpWkQbZor0craKikS8L5Nz08yRnf9H_5C0TWboi9qhyTaA>
    <xmx:sHyxXnE-JT-0FBBjzRO6aszC1R_XhAMtv7McoOIcbTl40nM6zilv1w>
    <xmx:sHyxXmWjjeb5AznIXuwAQFm-Ak8wKDrtJEkoy_WQD0mOI29KhchUpA>
    <xmx:sHyxXtr9UocSRf9Qbb7r0M1NC4PYkz9-YJW3RH3vJmpNaMxr5vG50g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0734C3066089;
        Tue,  5 May 2020 10:48:15 -0400 (EDT)
Date:   Tue, 5 May 2020 16:48:11 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] w1_therm: creating w1_therm.h
Message-ID: <20200505144811.GD838641@kroah.com>
References: <20200429225915.198956-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429225915.198956-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:59:15AM +0200, Akira Shimahara wrote:
> Creating w1_therm.h header to organize code. Organize the w1_therm.c file
> to gather hardware functions, device specific functions, interface
> functions and sysfs functions.
> 
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> ---
>  drivers/w1/slaves/w1_therm.c | 302 +++++++++++++++--------------------
>  drivers/w1/slaves/w1_therm.h | 138 ++++++++++++++++
>  2 files changed, 269 insertions(+), 171 deletions(-)
>  create mode 100644 drivers/w1/slaves/w1_therm.h

Wait, why is a .h file needed for just a single .c file?


<snip>

>  static ssize_t read_therm(struct device *device,


> +/** read_therm()
> + * @param sl pointer to the slave to read
> + * @param info pointer to a structure to store the read results
> + * @return 0 if success, -kernel error code otherwise
> + */
> +static ssize_t read_therm(struct device *device,
> +			struct w1_slave *sl, struct therm_info *info);
> +

Why is this function needed to be declared in this .h file?

Why is any of this needed?  For some reason I thought you needed a .h
file to make things simpler for other .c files, but if all of this is
static, it's not needed at all, right?

thanks,

greg k-h
