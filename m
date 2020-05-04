Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A7DC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018C2206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="eDpXtSDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgEDWgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:36:09 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:30039 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgEDWgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:36:09 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GHks2CQ0z8r;
        Tue,  5 May 2020 00:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588631766; bh=r9Ra0YsTNI47z6MEyzSs2RXlk4X+BQLFr0esPWmvCXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDpXtSDzNBSoyYdFn2P0bsWoUvPEC9Um/JcPWFcXE0GRu5RqGFbwQ3WVQCIvasKj/
         ezBtzKnZHmBd4lbrfJp0Iy8KuEWGqxK67p2cywxnPWQFSyUK/cQwvrI6zPlCPqLFrX
         nf5HbWEGPa8+5u6gbVOo0duiz+GqulhBTx6zSG3HpEyQoVEZr7dqi1XSCnW4MrgZF1
         i2y92nuXpIpcfsBqLJg9iBbKW1t8iNacBP2ILye/1C7wsCrHrmzbPPWFfDlui0iQWP
         UHPObRQevE9wXlMf8WjCsBtYCxqKEsrxNTTjaHm2X0HVQaTmnQM+jIsuyxFH8MufYs
         7X1mcVCx41/sQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Tue, 5 May 2020 00:36:04 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] clk: at91: allow setting PCKx parent via DT
Message-ID: <20200504223604.GA16549@qmqm.qmqm.pl>
References: <cover.1588623391.git.mirq-linux@rere.qmqm.pl>
 <fd853126e9971b9ef9bdcfe469ed3146a0cad92b.1588623391.git.mirq-linux@rere.qmqm.pl>
 <20200504204447.GL34497@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504204447.GL34497@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:44:47PM +0200, Alexandre Belloni wrote:
> On 04/05/2020 22:19:17+0200, Micha³ Miros³aw wrote:
> > This exposes PROGx clocks for use in assigned-clocks DeviceTree property
> > for selecting PCKx parent clock.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> > v2: rebase and update to clk/clk-at91 branch
> > v3: rebase
> > v4: no changes
> > v5: no changes
> > v6: no changes
> > ---
> >  drivers/clk/at91/at91rm9200.c    |  6 ++++--
> >  drivers/clk/at91/at91sam9260.c   |  5 ++++-
> >  drivers/clk/at91/at91sam9g45.c   |  6 ++++--
> >  drivers/clk/at91/at91sam9n12.c   |  6 ++++--
> >  drivers/clk/at91/at91sam9rl.c    |  4 +++-
> >  drivers/clk/at91/at91sam9x5.c    |  4 +++-
> >  drivers/clk/at91/pmc.c           | 12 ++++++++++--
> >  drivers/clk/at91/pmc.h           |  5 ++++-
> >  drivers/clk/at91/sam9x60.c       |  4 +++-
> >  drivers/clk/at91/sama5d2.c       |  4 +++-
> >  drivers/clk/at91/sama5d3.c       |  6 ++++--
> >  drivers/clk/at91/sama5d4.c       |  4 +++-
> >  include/dt-bindings/clock/at91.h |  1 +
> >  13 files changed, 50 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> > index c44a431b6c97..8da88e9a95d8 100644
> > --- a/drivers/clk/at91/at91rm9200.c
> > +++ b/drivers/clk/at91/at91rm9200.c
> > @@ -100,7 +100,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
> >  
> >  	at91rm9200_pmc = pmc_data_allocate(PMC_MAIN + 1,
> >  					    nck(at91rm9200_systemck),
> > -					    nck(at91rm9200_periphck), 0);
> > +					    nck(at91rm9200_periphck), 0, 4);
> >  	if (!at91rm9200_pmc)
> >  		return;
> >  
> > @@ -159,6 +159,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
> >  						    &at91rm9200_programmable_layout);
> >  		if (IS_ERR(hw))
> >  			goto err_free;
> > +
> > +		at91rm9200_pmc->pchws[i] = hw;
> >  	}
> >  
> >  	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
> > @@ -187,7 +189,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
> >  	return;
> >  
> >  err_free:
> > -	pmc_data_free(at91rm9200_pmc);
> > +	kfree(at91rm9200_pmc);
> 
> I missed that in the previous review but shouldn't that change be part
> of the previous patch for bisectability ?

I was sure I already pushed all of them to the first patch...
Fixed in v7.

Best Regards
Micha³ Miros³aw
