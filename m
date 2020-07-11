Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEDEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A6E20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGKHp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 03:45:27 -0400
Received: from mailomta21-sa.btinternet.com ([213.120.69.27]:53647 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgGKHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 03:45:26 -0400
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200711074524.SVO3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Sat, 11 Jul 2020 08:45:24 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.53.71.41]
X-OWM-Source-IP: 31.53.71.41 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvddvgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpedfoeflohhhnhcuqfhlughmrghnqedfuceojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqeenucggtffrrghtthgvrhhnpeffveekffekffefhfevvdevieelvdduuedvteeviefgteetfeffffekieduieekveenucfkphepfedurdehfedrjedurdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihpdhinhgvthepfedurdehfedrjedurdeguddpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeouggvvhgvlhesughrihhvvghruggvvhdrohhsuhhoshhlrdhorhhgqedprhgtphhtthhopeeoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqedprhgtphhtthhopeeoghhushhtrghvohesvghmsggvugguvgguohhrrdgtohhmqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry (31.53.71.41) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5ED9AA6E0630DA2A; Sat, 11 Jul 2020 08:45:24 +0100
Date:   Sat, 11 Jul 2020 08:45:22 +0100
From:   "<John Oldman>" <john.oldman@polehill.co.uk>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: Using comparison to true is
 error prone
Message-ID: <20200711074522.GA20279@henry>
References: <20200710201643.27322-1-john.oldman@polehill.co.uk>
 <69bf7931-7df2-a0f8-8329-929ccb6a2c20@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69bf7931-7df2-a0f8-8329-929ccb6a2c20@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gustavo
Thanks for the feedback.
I'll re-submit the patch.
Many thanks
john



On Fri, Jul 10, 2020 at 03:44:53PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 7/10/20 15:16, John Oldman wrote:
> > clear below issues reported by checkpatch.pl:
> > 
> > CHECK: Using comparison to true is error prone
> > 
> > Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > index ca98274ae390..d9bdd4fb9dc3 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > @@ -363,8 +363,9 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
> >  	}
> >  
> >  	/* HT Cap. */
> > -	if (((pregistrypriv->wireless_mode&WIRELESS_11_5N) || (pregistrypriv->wireless_mode&WIRELESS_11_24N))
> > -		&& (pregistrypriv->ht_enable == true)) {
> > +	if (((pregistrypriv->wireless_mode & WIRELESS_11_5N)
> > +	      || (pregistrypriv->wireless_mode & WIRELESS_11_24N))
> > +	      && (pregistrypriv->ht_enable)) {
> 		 ^			  ^
> The enclosing parentheses are unnecessary.
> 
> Also, if you run checkpatch.pl on your patch, you'll see
> the following:
> 
> CHECK: Logical continuations should be on the previous line
> #12: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:367:
> +	if (((pregistrypriv->wireless_mode & WIRELESS_11_5N)
> +	      || (pregistrypriv->wireless_mode & WIRELESS_11_24N))
> 
> CHECK: Logical continuations should be on the previous line
> #13: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:368:
> +	      || (pregistrypriv->wireless_mode & WIRELESS_11_24N))
> +	      && (pregistrypriv->ht_enable)) {
> 
> 
> It'd be nice to fix the above, too. :)
> 
> --
> Gustavo
> 
> >  		/* todo: */
> >  	}
> >  
> > 
