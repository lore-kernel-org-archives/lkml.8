Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A55C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1976520787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585899739;
	bh=GLPBE38Ftn/zMdfh9nlqAo69KXiCx0hDAEdZxNxgfnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O7IlhhkIW6u2jPH3gJtiQUztlitapWNqbKn+Qmy8BtGD35VRlhOW0pClRE0UG1bda
	 23AYKSuKYXj7aP8gCWM9YaOhNtZdVku2udPpA938yPOWog1v0ZWmEl5yFI2asaKBTW
	 l8eavV9Y9PiMR3pOwLTVOLY3FW3UuyxcIaWGhh90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbgDCHmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389685AbgDCHmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:42:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E0920721;
        Fri,  3 Apr 2020 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585899737;
        bh=GLPBE38Ftn/zMdfh9nlqAo69KXiCx0hDAEdZxNxgfnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4jKcIz50rd6m/Bg27DNSm1/t6FZCB5cLb2qkLDzpygyYqPmeBZt1txJEOyELN3k7
         hfVy5euxwETnU4AWd1wMf57jyGKclNHNhG4IzZDWoZkzFEFbgzcOeBh6sIaJqQpD5p
         dTbyIS2c7OUvZj2f0D9v0Owhqz2Xh5wzzbGCrahE=
Date:   Fri, 3 Apr 2020 09:42:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iulian Olaru <iulianolaru249@gmail.com>
Cc:     daniel.baluta@gmail.com, allison@lohutok.net, info@metux.net,
        alexios.zavras@intel.com, tglx@linutronix.de,
        devel@driverdev.osuosl.org,
        Iulian Olaru <iulianolaru249@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: uwb: Fix missing blank space coding style issue
Message-ID: <20200403074214.GA3478242@kroah.com>
References: <20200329225727.9222-1-iulianolaru249@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329225727.9222-1-iulianolaru249@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 01:57:27AM +0300, Iulian Olaru wrote:
> This patch adds a blank space before the switch argument parenthesis to
> silence checkpatch.pl errors.
> 
> Signed-off-by: Iulian Olaru <iulianolaru249@yahoo.com>
> ---
>  drivers/staging/uwb/drp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This file is no longer in the kernel tree. Always make sure to work
against linux-next, and not Linus's tree, in order to not duplicate
existing efforts.

thanks,

greg k-h
