Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32711C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37CF20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="p8gHEwVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tayYDuen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgDWOlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:41:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54923 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgDWOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:41:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 77A2F5C00A6;
        Thu, 23 Apr 2020 10:41:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 23 Apr 2020 10:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=v
        h1D6eeMXVfJXWiUsvNWHJ/jhwMyhAERGolH522CAwE=; b=p8gHEwVQZgRKCTZPJ
        viAvj1SZSUJaj/xA5/4hpch16P7qL/8KVcl8bw70qiDBk9r39+ORXO4D3rdwZV0Y
        dW2l90rWLtrU+urC8zuuTpyKKgXt8/VQs+GsUCV5Rnou54kF4urzityJ9ogwrkjm
        HiGTEcYXj6bfjhIdjnbPZXUFcJRe7ii4dDJNdXw9r/NfdQd0tN3e/13drcdSoyWk
        TyDUeITC7+Li81SoShV7DTkZXCAvyjTkZ0pOUfOqfJXhr8h4b7P7/kOCYpvdJvi1
        uR97VqcSrins1PCezwlCYKIfLOl3F0rZ+bVpXcvfvsD/YknfeQaxUMWMi2cCSZGh
        ILvMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=vh1D6eeMXVfJXWiUsvNWHJ/jhwMyhAERGolH522CA
        wE=; b=tayYDuenZku3a9W1ADF7+fX36A0fnz7VNXQuJNMCd5lK0ABtFU2SvOF13
        5A5RSsECSbEonjx/624Xvpk8LudYCyk+uaI2CHWZISuPE7semoK5lSb4e5+2fplh
        GDPrOzmI74xx8xyJHb/Sd3sIm6UwNs2cIRLWRVMAFbeACwsw6N/W4tfiwpKOFANG
        zzzr9AqaSMkziAPn8IDQwzK0pggohcuy9whrJVwJCZCvmzdpLvkhMWAUuizcdePL
        A0w8fZjc1sg7wFIpVfEZ6jDL+LQrYErqFiHYcLUJ8C7+dIbb34gmWCYpF1eGUh6r
        LAOQyDUF48O9EKBpDjpDIfr3Qtzig==
X-ME-Sender: <xms:D6mhXkQt3SMWKSdmTanoweDDNeFzipjFxhTEGNgIYSHAo_TVouTmSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekre
    dttddtudenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:D6mhXpjhUZfNePk0MPds8rtV8U3-SOJJp265x_W70Rkysui4SZ67nQ>
    <xmx:D6mhXk4ZDTHNhjxqk7SIMfncSlY54USKjg1cSqVdjRDpGCceU9MS4Q>
    <xmx:D6mhXmBbyalTwu17lo2c6MINthZ-yHelyIda3wkFRT8n-HPb11OIBg>
    <xmx:D6mhXnoP3DeRfxiK1qivOOcnEBfxyEr457ekGAMNsktLgE5L4WWoGg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF2A63065D2F;
        Thu, 23 Apr 2020 10:41:18 -0400 (EDT)
Date:   Thu, 23 Apr 2020 16:41:16 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changes in w1_therm.c and adding w1_therm.h
Message-ID: <20200423144116.GA7319@kroah.com>
References: <20200414170248.299534-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414170248.299534-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 07:02:48PM +0200, Akira Shimahara wrote:
> From: Akira SHIMAHARA <akira215corp@gmail.com>
> 
> Patch for enhacement of w1_therm module. Added features :
>  - Bulk read : send one command for all the slaves 
>  		on the bus to trigger temperature conversion
>  - Optimized conversion time regarding to device resolution
>  - Dedicated sysfs entry for powering read,
>  		resolution set/get, eeprom save/restore
>  - Alarms settings and reading
>  - Code optimization to mitigate bus traffic
>  		(devices information are stored to avoid
> 		interrogating each device every-time)
> 
> Following sysfs entry are added :
>  - temperature (RO) : return the temperature in 1/1000°
>  - ext_power (RO) : return the power status of the device
>  - resolution (RW) : get or set the device resolution (supported devices)
>  - eeprom (WO) :trigger a save or restore to/from device EEPROM
>  - alarms (RW) : read or write TH and TL in the device RAM
>  - therm_bulk_read (RW) : Attribute at master level to trigger 
>  		bulk read and to survey the progress of devices conversions
>  - w1_slave has been kept for compatibility

You do not document any of these new sysfs files, why not?

Please add entries to Documentation/ABI/

And for the temp and other issues, shouldn't you use the "default"
kernel subsystems instead of creating your own api here?

thanks,

greg k-h
