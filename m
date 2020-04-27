Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D22C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D07E206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgD0U03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:26:29 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:55056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0U03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:26:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id EA3A4100E7B42;
        Mon, 27 Apr 2020 20:26:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub03_1b15e2b16104b
X-Filterd-Recvd-Size: 3435
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 20:26:26 +0000 (UTC)
Message-ID: <7b29655cc4ab872d338565145498bd15118dad8d.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add email addresses from .yaml files
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh+dt@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Mon, 27 Apr 2020 13:26:24 -0700
In-Reply-To: <20200427130448.74b75c3a6c91e5ede31542e4@linux-foundation.org>
References: <87d082jtfn.fsf@collabora.com>
         <20200420175909.GA5810@ravnborg.org>
         <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
         <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
         <7beaedfd63017973b910dd21cac13ecb42dbe503.camel@perches.com>
         <20200427055755.GA21898@ravnborg.org>
         <79ade7bc8ce57ef11f94011bad1842372c61fdd7.camel@perches.com>
         <20200427130448.74b75c3a6c91e5ede31542e4@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 13:04 -0700, Andrew Morton wrote:
> On Sun, 26 Apr 2020 23:33:02 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Mon, 2020-04-27 at 07:57 +0200, Sam Ravnborg wrote:
> > > Hi Joe.
> > 
> > Hi Sam.
> > 
> > > On Sun, Apr 26, 2020 at 10:40:52PM -0700, Joe Perches wrote:
> > > > .yaml files can contain maintainer/author addresses and it seems
> > > > unlikely or unnecessary that individual MAINTAINER file section
> > > > entries for each .yaml file will be created.
> > > > 
> > > > So dd the email addresses found in .yaml files to the default
> > >      ^
> > >      add
> > 
> > Andrew, can you add the a to this please?
> > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > > Tested-by: Sam Ravnborg <sam@ravnborg.org>
> > > 
> > > The patch did not apply on top of -rc3, but it was trivial to fix.
> > > Tested and works like a charm.
> > > Thanks for doing this!
> > 
> > As most of my patches, it was done using -next
> > 
> 
> The patch assumes that we have
> 
> -	    if ($file_emails) {
> -		my @poss_addr = $text =~ m$[A-Za-z_-_\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> -		push(@file_emails, clean_file_emails(@poss_addr));
> -	    }
> 
> but today's next has
> 
> 	    if ($file_emails) {
> 		my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> 		push(@file_emails, clean_file_emails(@poss_addr));
> 	    }
> 
> so what do do here?

It's not "do do" nor "doo doo", but it is odd.
Must be some weirdness with the evolution email composer again.

I'll resubmit with Sam's sign-offs using a proper git-send-email
(and I'll fix the dd/add typo, thanks Sam)



