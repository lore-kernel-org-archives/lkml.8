Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA49C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504B02074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbgGaRRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:17:08 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:49472 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387465AbgGaRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:17:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CD52E182CED5B;
        Fri, 31 Jul 2020 17:17:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vein84_180cbba26f85
X-Filterd-Recvd-Size: 2243
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 17:17:02 +0000 (UTC)
Message-ID: <a2b0b4a44901674d46de9f949227f35afd21062b.camel@perches.com>
Subject: Re: [PATCH] vim: linux-kernel: Increase columns highlighting to 100+
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 10:17:01 -0700
In-Reply-To: <20200731170755.GB1726@embeddedor>
References: <20200731163301.GA8004@embeddedor>
         <4e30e2df7bec0fedf1a29f7825fbb4c12593eac9.camel@perches.com>
         <20200731170755.GB1726@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-31 at 12:07 -0500, Gustavo A. R. Silva wrote:
> On Fri, Jul 31, 2020 at 09:35:42AM -0700, Joe Perches wrote:
> > On Fri, 2020-07-31 at 11:33 -0500, Gustavo A. R. Silva wrote:
> > > Increase columns highlighting to 100+ once the 80-column warning has
> > > been deprecated in the Linux kernel[1].
> > > 
> > > [1] commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >  plugin/linuxsty.vim | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
> > > index 6f7e331..c42ce72 100644
> > > --- a/plugin/linuxsty.vim
> > > +++ b/plugin/linuxsty.vim
> > > @@ -62,7 +62,7 @@ function s:LinuxFormatting()
> > >      setlocal tabstop=8
> > >      setlocal shiftwidth=8
> > >      setlocal softtabstop=8
> > > -    setlocal textwidth=80
> > > +    setlocal textwidth=100
> > 
> > This is not a good change.
> > 80 columns is still _preferred_.
> > 
> 
> Now that you mention that, I have mixed feelings about this.
> Let's see if we can get more opinions...

I am not a vim user, but maybe remove this line
altogether and add something like

	setlocal colorcolumn=80,100

and let people make their own wrapping decisions.


