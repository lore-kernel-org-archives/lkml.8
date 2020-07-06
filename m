Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B03FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0AB2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594065483;
	bh=cI/zLzLd3mGGwy05JZSth7UR/fLz9XqwcHwFVQnAahA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ecgwKc2Xgynd4iTcKsEMxmExihAkppXZv2jUmRxi/JCUMju/rp4joqJPEP8XUwx21
	 e9agjof5Wn+teFSX1ZfQcravhWusF/cOWjXZw38ihcgakMnHNyKJT8bMxrNJP128Su
	 tPdHgCkw4Z5LlENTJhTEJlztR43/1c58v7bmYvDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgGFT6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFT6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:58:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5619B207D0;
        Mon,  6 Jul 2020 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594065480;
        bh=cI/zLzLd3mGGwy05JZSth7UR/fLz9XqwcHwFVQnAahA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIAv2+00Jk5NrCyAwJOs3NsihA64mWr8qUiIUMPhkO6HRaLGuXoLaQ8YgcHLYaspb
         q3eWsEdXcyI/nBfIIgBX6o5cOewWreVJuVQcNAAbvfJVY5pvpd7fmhxMrQAXKLHYZP
         AmYx4N5ZbzT7fHayOReaA6yDMF8DMKFkL2v3iA4c=
Date:   Mon, 6 Jul 2020 21:57:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Small devm helper for devm implementations
Message-ID: <20200706195758.GA100842@kroah.com>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
 <69f6f7fc-4fb6-248a-684a-b853ee0836bc@free.fr>
 <3fea884b-05d3-ff67-b9fe-41c9b46cf478@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fea884b-05d3-ff67-b9fe-41c9b46cf478@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:56:04PM +0200, Marc Gonzalez wrote:
> Hello Greg,
> 
> Would you agree to take this series?

Given the lack of testing of the patch, it doesn't seem wise to add
this, right?

Please get some testing, and some more users, and I'll be glad to
consider it.

thanks,

greg k-h
