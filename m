Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989FC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794AF2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599469442;
	bh=f1uUoeNbcaOfXVuh+SW48DF/4Z4rFxM2dlEuehFZa0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0xABl6kCnyesO/vPnuBOYVRQwtf0hAZ0FxDuGI+WsO6GLR7uUVJEnyb4bcA6ON/P
	 oMcwugPZYfhvtk63We5Ar+oxtYMyXKy9/eL8VNc67FYYciAvF9Gc5K629NbaJw1k+W
	 scXXtQ91pUQnGHK4QI1a8AhEQtmqHtzt8yyFI+7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgIGJEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIGJEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC192145D;
        Mon,  7 Sep 2020 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599469439;
        bh=f1uUoeNbcaOfXVuh+SW48DF/4Z4rFxM2dlEuehFZa0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g50ZtzjMAJhZc2Fq0skJGkDNsjbOuP66ScGVUdr/kg1veXbOszUNfzklgleSOd4Vp
         esz8BTAjcrXra4sk82/Lk69ZErBUfXq995x+4D0osZwSccThyrXUB1QKBOjLZq/jOn
         7FUxG7ZsJwF2ghs9M5rdR85PCiAst1WHnE70ilkQ=
Date:   Mon, 7 Sep 2020 11:04:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/4] device property: Move fwnode_connection_find_match()
 under drivers/base/property.c
Message-ID: <20200907090414.GE1101646@kroah.com>
References: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
 <20200904125123.83725-5-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904125123.83725-5-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:51:23PM +0300, Heikki Krogerus wrote:
> The function is now only a helper that searches the
> connection from device graph and then by checking if the
> supplied connection identifier matches a property that
> contains reference.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  .../driver-api/device_connection.rst          |  43 --------
>  drivers/base/Makefile                         |   2 +-
>  drivers/base/devcon.c                         | 101 ------------------
>  drivers/base/property.c                       |  73 +++++++++++++
>  include/linux/device.h                        |   9 --
>  include/linux/property.h                      |  14 +++
>  6 files changed, 88 insertions(+), 154 deletions(-)
>  delete mode 100644 Documentation/driver-api/device_connection.rst

You also removed the documentation in this patch, which would have been
fine if you had mentioned it in the changelog text :(

I'll go queue up the first 3 patches of this series, can you split this
up into two?

thanks,

greg k-h
