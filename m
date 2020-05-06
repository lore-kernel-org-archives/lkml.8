Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACDBC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FD4208D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgEFOym convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgEFOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:54:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DAC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:54:42 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jWLRW-0004Ds-LE; Wed, 06 May 2020 16:54:38 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jWLRW-0003Y2-7b; Wed, 06 May 2020 16:54:38 +0200
Message-ID: <05e51534c3d6284f555fd262b666c94d12cbd010.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: meson: add gxl internal dac reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 16:54:38 +0200
In-Reply-To: <1jy2q5f9zc.fsf@starbuckisacylon.baylibre.com>
References: <20200122092526.2436421-1-jbrunet@baylibre.com>
         <6f661498f58c6a519095d0657413f4b89d3ef21e.camel@pengutronix.de>
         <1jimi2tqsn.fsf@starbuckisacylon.baylibre.com>
         <1jy2q5f9zc.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, 2020-05-06 at 15:50 +0200, Jerome Brunet wrote:
> On Tue 14 Apr 2020 at 10:28, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
> > On Thu 23 Jan 2020 at 11:13, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > > On Wed, 2020-01-22 at 10:25 +0100, Jerome Brunet wrote:
> > > > Add the reset line of the internal DAC found on the amlogic gxl SoC family
> > > > 
> > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > ---
> > > >  include/dt-bindings/reset/amlogic,meson-gxbb-reset.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
> > > > index ea5058618863..883bfd3bcbad 100644
> > > > --- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
> > > > +++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
> > > > @@ -69,7 +69,7 @@
> > > >  #define RESET_SYS_CPU_L2		58
> > > >  #define RESET_SYS_CPU_P			59
> > > >  #define RESET_SYS_CPU_MBIST		60
> > > > -/*					61	*/
> > > > +#define RESET_ACODEC			61
> > > >  /*					62	*/
> > > >  /*					63	*/
> > > >  /*	RESET2					*/
> > > 
> > > Thank you, applied to reset/next.
> > 
> > Hi Philip,
> > 
> > It seems reset/next has not made it to v5.7-rc1
> > 
> > Would it be possible to provide an immutable branch with this change, or
> > maybe let Kevin apply this change through the amlogic tree ?
> > 
> > It would allow us to progress on some DT changes during this new cycle.
> > 
> > Thanks
> > Jerome
> 
> Hi Philip, how can we move forward on this ?

Sorry for the delay, I have missed the last window. I've now created an
immutable branch:

  git://git.pengutronix.de/pza/linux.git reset/meson-gxl-dac

which I will be included in the next reset pull request.

regards
Philipp
