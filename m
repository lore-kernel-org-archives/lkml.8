Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650EB20709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbgFYFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:51:00 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:55878 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbgFYFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:51:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2E12618029120;
        Thu, 25 Jun 2020 05:50:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: head29_411519126e4a
X-Filterd-Recvd-Size: 2280
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 05:50:57 +0000 (UTC)
Message-ID: <51ca818443648cb25a604448dea022d6ac2ea09f.camel@perches.com>
Subject: Re: [RFC] Reed-Solomon Code: Update no_eras to the actual number of
 errors
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Aiden Leong <aiden.leong@aibsd.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Date:   Wed, 24 Jun 2020 22:50:56 -0700
In-Reply-To: <202006242231.E17DAB2@keescook>
References: <20200625041141.8053-1-aiden.leong@aibsd.com>
         <202006242231.E17DAB2@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 22:35 -0700, Kees Cook wrote:
> On Wed, Jun 24, 2020 at 09:10:53PM -0700, Aiden Leong wrote:
> > Corr and eras_pos are updated to actual correction pattern and erasure
> > positions, but no_eras is not.
[]
> > @@ -312,14 +313,21 @@
> >  				eras_pos[j++] = loc[i] - pad;
> >  			}
> >  		}
> > +		if (no_eras > 0)
> > +			*no_eras = j;
> 
> Is this meant to be "if (j > 0)" or "if (no_eras != NULL)" ? It's
> uncommon to use > 0 for a pointer value.
> 
> >  	} else if (data && par) {
> >  		/* Apply error to data and parity */
> > +		j = 0;
> >  		for (i = 0; i < count; i++) {
> >  			if (loc[i] < (nn - nroots))
> >  				data[loc[i] - pad] ^= b[i];
> >  			else
> >  				par[loc[i] - pad - len] ^= b[i];
> > +			if (b[i])
> > +				j++;
> >  		}
> > +		if (no_eras > 0)
> > +			*no_eras = j;
> 
> I assume it's a pointer test, so both would be:
> 
> 		if (no_eras_ptr != NULL)
> 			*no_eras_ptr = j;

More common still would be

		if (no_eras_ptr)
			*no_eras_ptr = j;

though I think using _ptr is too Hungarian.


