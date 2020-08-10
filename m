Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8D207CD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597067801;
	bh=SdnRjVTx+XenxW0mx6UmkUexgdMB8KMdeUjFwmhv2yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mztA4wYZB8PNuVc+Xh9SyevERkAt0MV2FxrwzuagfdeTljn/t5EcfU/EW/nLca3XS
	 G42bRocPH7/ldloJewg/xDv/oevdq/dPrpLM/5tVfDofeSuOIqsSEQ9gcNiLN+wUOS
	 ua0xohcPK64rK4+dTYExLzte/BOicAl3fGi8uV2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHJN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgHJN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:56:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC1B2078D;
        Mon, 10 Aug 2020 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597067799;
        bh=SdnRjVTx+XenxW0mx6UmkUexgdMB8KMdeUjFwmhv2yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmhHKG+Sjryr43HZGFUTKyF64RRPiYc5FAw9/8cIHo3kkBMjwdVulsEcYeO9BjFR9
         0eB/ecwLP1aLSHqdyP5XZRAs2wnemDEhF6rSVgnMTdw9pSmFtYSNWu9/eMcE+rzE7F
         KF1P+dHwCz3uAWpbh18BCdePAyIs0LzPHUOe5JWk=
Date:   Mon, 10 Aug 2020 15:56:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Izabela Bakollari <izabela.bakollari@gmail.com>
Cc:     nhorman@tuxdriver.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCHv2 net-next] dropwatch: Support
 monitoring of dropped frames
Message-ID: <20200810135650.GA3726113@kroah.com>
References: <20200707171515.110818-1-izabela.bakollari@gmail.com>
 <20200804160908.46193-1-izabela.bakollari@gmail.com>
 <CAC8tkWDuvz3HQDp=Bb-Sfgiks1ETG-j1SMFn6O2nhyzYL5Cc8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC8tkWDuvz3HQDp=Bb-Sfgiks1ETG-j1SMFn6O2nhyzYL5Cc8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 03:39:40PM +0200, Izabela Bakollari wrote:
> I have worked on this feature as part of the Linux Kernel Mentorship
> Program. Your review would really help me in this learning process.

You sent this just a bit less than 1 week ago, and it's the middle of
the kernel merge window, where no maintainer can take any new patches
that are not bugfixes, and they are totally busy with the merge window
issues.

Give people a chance, try resending this after the net-next tree is open
in a few weeks.

thanks,

greg k-h
