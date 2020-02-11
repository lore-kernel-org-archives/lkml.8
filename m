Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6176C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F520873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="NCQNv5Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgBKKje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:39:34 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:28677 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgBKKje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:39:34 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48GzmN2qn7z6x;
        Tue, 11 Feb 2020 11:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417572; bh=fbpKp3rnNkha0W+kf3wFRvFjsUb1cKB6hd3hwVW4juI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCQNv5BwvMJX2NleSAIHdMpkye5lZU1rhL79/t3e97bdYTcs/aZDnA1fljHi+LT1e
         BO0jx+0wQY26CopiJJj2xl68u68v9vFoRoK55p1DQUqfDUY0ulmdN83E3oRSLaGkCc
         /9iIyzo8cjQ+CR9G5Pj3CDmqnxLS/vlQJnecsYXcv6OsgfJXyQK3pdDJCjOQTQvXEe
         PjkXM5f+UsamTgncZ1DZqzoKUJWLDevByO3MiYUMaEwAXb16rzaLMuZQJNw2XGESEo
         Nwkw62PjHoUBx3NsfODVp1yP1ukVjzmTCDmXCRa58PwZMpGlmX8fVsofeCq6b2HXGH
         gF6HytFdHXJAw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:39:31 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?iso-8859-2?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [[PATCH staging] 3/7] staging: wfx: fix init/remove vs IRQ race
Message-ID: <20200211103931.GA26303@qmqm.qmqm.pl>
References: <cover.1581410026.git.mirq-linux@rere.qmqm.pl>
 <8f0c51acc3b98fc55d6960036daef7556445cd0a.1581410026.git.mirq-linux@rere.qmqm.pl>
 <20200211092354.GE1778@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200211092354.GE1778@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:23:54PM +0300, Dan Carpenter wrote:
> On Tue, Feb 11, 2020 at 09:46:54AM +0100, Micha³ Miros³aw wrote:
> > @@ -234,8 +234,8 @@ static void wfx_sdio_remove(struct sdio_func *func)
> >  	struct wfx_sdio_priv *bus = sdio_get_drvdata(func);
> >  
> >  	wfx_release(bus->core);
> > -	wfx_free_common(bus->core);
> >  	wfx_sdio_irq_unsubscribe(bus);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This calls sdio_release_host(func);
> 
> > +	wfx_free_common(bus->core);
> >  	sdio_claim_host(func);
> >  	sdio_disable_func(func);
> >  	sdio_release_host(func);
>         ^^^^^^^^^^^^^^^^^^^^^^^^
> so is this a double free?

This is paired with sdio_claim_host() just above.

Best Regards,
Micha³ Miros³aw
