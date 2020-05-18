Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22723C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B8920826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgERRLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:11:20 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:47312 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbgERRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:11:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DDE31100E7B40;
        Mon, 18 May 2020 17:11:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: badge74_7fac34a359a27
X-Filterd-Recvd-Size: 2431
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 May 2020 17:11:17 +0000 (UTC)
Message-ID: <06434e4d5980b17a1cacee80369087cbd7a8cbe0.camel@perches.com>
Subject: Re: [PATCH][next] i2c: mediatek: fix integer overflow on an integer
 multiplication
From:   Joe Perches <joe@perches.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Colin King <colin.king@canonical.com>, qii.wang@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 May 2020 10:11:16 -0700
In-Reply-To: <20200518165928.GA5109@ninjato>
References: <20200518165529.57821-1-colin.king@canonical.com>
         <20200518165928.GA5109@ninjato>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 18:59 +0200, Wolfram Sang wrote:
> On Mon, May 18, 2020 at 05:55:29PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the calculation of sample_ns is using a 32 bit integer
> > multiplication and can potentially overflow. Fix this by making the
> > constant a long long to use a 64 bit multiply and hence
> > avoid an overflow.
> > 
> > Addresses-Coverity: ("Unintentional integer overflow")
> > Fixes: 5f1ae73d538a ("i2c: mediatek: Add i2c ac-timing adjust support")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> CCing the patch author.
> 
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index 702061805925..c93492b997ce 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -551,7 +551,7 @@ static int mtk_i2c_check_ac_timing(struct mtk_i2c *i2c,
> >  	const struct i2c_spec_values *spec;
> >  	unsigned int su_sta_cnt, low_cnt, high_cnt, max_step_cnt;
> >  	unsigned int sda_max, sda_min, clk_ns, max_sta_cnt = 0x3f;
> > -	long long sample_ns = (1000000000 * (sample_cnt + 1)) / clk_src;
> > +	long long sample_ns = (1000000000LL * (sample_cnt + 1)) / clk_src;

unsigned long long?


