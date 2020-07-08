Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5DF20775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594204774;
	bh=VWPhC4Gq7pX7sjLhrLhoCa8iCMdRCFzbp0T4IOiWh8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=biOcmJA+8LppLSyYsQzXC1d2Y0uD9MNrISDfE4wK8/CFTb8xL6mNB7D/Gb98ygNWA
	 ba4F4/eLRvvkl+v3jhnwFpqKp5O1OJAGtIPT962cjNQ/N0/eIXRSIoUfaRC438Zp6l
	 B7k5n9+d+a4gxi2CZA5CfX2kpRCcsBVmXnF7pP74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgGHKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgGHKjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:39:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D130D20739;
        Wed,  8 Jul 2020 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594204772;
        bh=VWPhC4Gq7pX7sjLhrLhoCa8iCMdRCFzbp0T4IOiWh8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUVVW7UKQebpZCxfAj/yfH0JqmWyqZimy2Nlld785FUp7uDteMXJs8RhnWUzwrCYH
         Nywyx1PO0sK2W/w981QVWvsVP8WdV7uzOMY8T2DfJKGS/89ejltpW0w5fFBhGdkUe3
         uh0F/75gJB+K4sYTOj83VFq+UrIBtnOGi3cEnUPM=
Date:   Wed, 8 Jul 2020 12:39:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: USB MASS STORAGE
 DRIVER
Message-ID: <20200708103928.GC585606@kroah.com>
References: <20200708095500.13694-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708095500.13694-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:55:00AM +0200, Alexander A. Klimov wrote:
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

Your subject lines are very odd compared to all patches for this
subsystem, as well as all other kernel subsystems.  Any reason you are
doing it this way and not the normal and standard method of:
	USB: storage: replace http links with https

That would look more uniform as well as not shout at anyone.

thanks,

greg k-h
