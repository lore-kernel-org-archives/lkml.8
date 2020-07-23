Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C137C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B40207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595516428;
	bh=4R4rFlQ9S7IYpPvd2WbOvsP7WGTiScpv5SiKG/TqEqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JQxcnH3mXW3LVZm7kwANcZkJeu+96uXdwBESrjNUG17/MwWZA14E0GjjUxJG99X0r
	 Ua305hyTD/mehBWXWR+aaAKtd0gSJejquHv5dfVAzYcbUhTw4VM9HIWFMTS3kIRlI+
	 /8e/J5ZAdVQn7SbG8mxurvw9igGlamghPLgzQVu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgGWPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbgGWPA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:00:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2324920709;
        Thu, 23 Jul 2020 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595516426;
        bh=4R4rFlQ9S7IYpPvd2WbOvsP7WGTiScpv5SiKG/TqEqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWKFSwsuuHedWFV8296RhqiXfCSflXGX0Mn4uTu2UdfcsBjoobW2Wk5OKHlxHFCoX
         G4UjFgSV5B5Auc5KuE7Z/zq/r0ncUwVV1RvMi4lqvQpSKDOJWVu+oiM6SW2T7WPA0+
         ulmfBIJpknRApArlcjRuXrW5kwO3d2jWmbHNAZpg=
Date:   Thu, 23 Jul 2020 17:00:30 +0200
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
Message-ID: <20200723150030.GA2515799@kroah.com>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
 <69f6f7fc-4fb6-248a-684a-b853ee0836bc@free.fr>
 <3fea884b-05d3-ff67-b9fe-41c9b46cf478@free.fr>
 <20200706195758.GA100842@kroah.com>
 <23a476f9-8ea3-566e-be5e-5237fb14bb91@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a476f9-8ea3-566e-be5e-5237fb14bb91@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:10:23AM +0200, Marc Gonzalez wrote:
> On 06/07/2020 21:57, Greg Kroah-Hartman wrote:
> 
> > Given the lack of testing of the patch, it doesn't seem wise to add
> > this, right?
> 
> You're probably not wrong :)
> 
> > Please get some testing, and some more users, and I'll be glad to
> > consider it.
> 
> "Users" == files modified to use the new helper?

Yes.

> How many files would you suggest? 3? 5? 10?

How many do you see that can use it?  I would suggest "all" :)

thanks,

greg k-h
