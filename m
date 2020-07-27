Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127AC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559B02075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgG0Fvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:51:43 -0400
Received: from kernel.crashing.org ([76.164.61.194]:45384 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgG0Fvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:51:42 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06R5p6VB010182
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Jul 2020 00:51:16 -0500
Message-ID: <e7d9923c14a423f9e6e9427ad5437a539734a363.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] fsi/sbefifo: Clean up correct FIFO when receiving
 reset request from SBE
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org
Cc:     Joachim Fenkes <FENKES@de.ibm.com>, linux-kernel@vger.kernel.org,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Date:   Mon, 27 Jul 2020 15:51:05 +1000
In-Reply-To: <20200724071518.430515-2-joel@jms.id.au>
References: <20200724071518.430515-1-joel@jms.id.au>
         <20200724071518.430515-2-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-24 at 16:45 +0930, Joel Stanley wrote:
> From: Joachim Fenkes <FENKES@de.ibm.com>
> 
> When the SBE requests a reset via the down FIFO, that is also the
> FIFO we should go and reset ;)

Is it ?

I no longer work for IBM and dont have access to any of the
documentation here but I had vague memories that we would get a reset
request in the down fifo in order to reset the up one since we control
the up one and the host controls the down one, no ?

Cheers,
Ben.

> Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> Signed-off-by: Joachim Fenkes <FENKES@de.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-sbefifo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index f54df9ebc8b3..655b45c1f6ba 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -400,7 +400,7 @@ static int sbefifo_cleanup_hw(struct sbefifo
> *sbefifo)
>  	/* The FIFO already contains a reset request from the SBE ? */
>  	if (down_status & SBEFIFO_STS_RESET_REQ) {
>  		dev_info(dev, "Cleanup: FIFO reset request set,
> resetting\n");
> -		rc = sbefifo_regw(sbefifo, SBEFIFO_UP,
> SBEFIFO_PERFORM_RESET);
> +		rc = sbefifo_regw(sbefifo, SBEFIFO_DOWN,
> SBEFIFO_PERFORM_RESET);
>  		if (rc) {
>  			sbefifo->broken = true;
>  			dev_err(dev, "Cleanup: Reset reg write failed,
> rc=%d\n", rc);

