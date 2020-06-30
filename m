Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7D9206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593507663;
	bh=JcF8qvU8w2KHZowpHoHgAHPE8do02qsOarLkPLKejdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bebKhAD/Cnqn74IB3t8hZONmOSkHHdcAJxvKZHQMx8G5PrHi5lI0dN0f4NaEbYgmw
	 5kEjrrU73fAtktMcxDmBPlUiQn1MuCZJ/NaxVYOR9O88rRr+dKUMlAup8eatYRmPYU
	 fzlb0k/hpX5Jw8VnoPKVOsRiw10hG+NBJ3nb7K24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgF3JBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgF3JBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:01:01 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CCC206C3;
        Tue, 30 Jun 2020 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593507660;
        bh=JcF8qvU8w2KHZowpHoHgAHPE8do02qsOarLkPLKejdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOPIoThJ9cnFewrARtPtEO4OILc92Zvg+2hVVlBwENeL5KPwQ3RCm5NWChQ2okHfX
         F9q3iSZ919056i8uQPrhCIhP1mPEbZzz6JCEqkGnfKafizFUEYnkEr/7cwqyTOv4Lj
         ZeCWgvx4NXT5UYv7NJamBf1SDPbEYLREc0rPoy9I=
Date:   Tue, 30 Jun 2020 11:00:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630090057.GG637809@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
> +EXPORT_SYMBOL_GPL(spi_read_sbase);

Why are you exporting symbols?  Nothing in this patch uses them.

And that's the spi_* namespace for the SPI core, not your tiny driver,
why pollute the global namespace in a confusing way like this?

thanks,

greg k-h
