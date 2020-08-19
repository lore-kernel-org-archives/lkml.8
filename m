Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06955C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69B0207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="FOdigWJF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="JtAY3f9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHSITN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:19:13 -0400
Received: from relay3.mymailcheap.com ([217.182.66.161]:57046 "EHLO
        relay3.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:19:11 -0400
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 3DFDB3F15F;
        Wed, 19 Aug 2020 10:19:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 208BD2A51B;
        Wed, 19 Aug 2020 10:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1597825142;
        bh=02CPVV5u+adQWdduGIzzC9teWV2zrSCiBOhEyqwvl2s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FOdigWJF3zNOydYEzEUphq0zxb1f9hVZBVMd36regPQS3L83nWyNsNzsHVg6aVFtu
         tMnldaZ+eVY3l698+v6p101Yd8HIVUkxyyDqxRyroN5z+qfg1ZOhOlfFsuRhqvMqm0
         yvN7ZlBgOFbskn8vJR0ZFzPPwkj2fXpqd2+U0lAw=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fXVo7zClVh5P; Wed, 19 Aug 2020 10:19:00 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 19 Aug 2020 10:19:00 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 7AD804119C;
        Wed, 19 Aug 2020 08:18:59 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="JtAY3f9X";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id AFA914119C;
        Wed, 19 Aug 2020 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1597824967; bh=02CPVV5u+adQWdduGIzzC9teWV2zrSCiBOhEyqwvl2s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JtAY3f9XdbTXM+9aC8nnBoQs8oGdR2cmVuiO4jwcCKMFPrC3Gj6arvz7R9+7H8PEI
         /M3p4AUq20UVBJgtZEOZqqkeHZvAb8wfBBpL2OySedQI9Klp5SI3BIFVIuWo/NRXQA
         u/GokGFh4tJxPMMPMQVKUIjCCQEnirskERmWU7b0=
Message-ID: <3b0ba1c95efa2ac465d9b6312b8e0e2c8fb461b5.camel@aosc.io>
Subject: Re: [PATCH] mfd: core: Fix handle of OF disabled MFD cells
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 19 Aug 2020 16:16:01 +0800
In-Reply-To: <20200819081122.GB4354@dell>
References: <20200801070130.3323112-1-icenowy@aosc.io>
         <20200819081122.GB4354@dell>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AD804119C
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.120:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWO(0.00)[2];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-08-19星期三的 09:11 +0100，Lee Jones写道：
> On Sat, 01 Aug 2020, Icenowy Zheng wrote:
> 
> > When rewriting the OF match code of MFD core, addition of cells
> > disabled
> > in OF will result in a failure with error -ENODEV. This is an
> > unexpected
> > behavior, as the previous behavior is silently ignore the cell. On
> > SBCs with AXP20x PMICs, this leads to boot failure if AXP20x PMIC
> > support is built-in and some cells (especially power supply ones)
> > are
> > disabled.
> 
> Thanks for reporting this.
> 
> Do you mind if I fix this another way?  I plan to reinstate the old
> code that was removed as part of the offending patch.  I will of
> course add your Reported-by tag.

I think it's okay.

I will test it once it's out.

> 
> > Silently ignore the cell when -ENODEV occurs.
> > 
> > Fixes: e49aa9a9bd22 ("mfd: core: Make a best effort attempt to
> > match devices with the correct of_nodes")
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/mfd/mfd-core.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index c3ef58a802bee..31b363c64f4b4 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -215,8 +215,13 @@ static int mfd_add_device(struct device
> > *parent, int id,
> >  				ret = mfd_match_of_node_to_dev(pdev,
> > np, cell);
> >  				if (ret == -EAGAIN)
> >  					continue;
> > -				if (ret)
> > +				if (ret) {
> > +					if (ret == -ENODEV) {
> > +						/* Ignore disabled
> > devices error free */
> > +						ret = 0;
> > +					}
> >  					goto fail_alias;
> > +				}
> >  
> >  				break;
> >  			}
