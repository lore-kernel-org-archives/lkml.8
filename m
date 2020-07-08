Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748692065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgGHD1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:27:16 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:50474 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728732AbgGHD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:27:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id AF53C180A7FE1;
        Wed,  8 Jul 2020 03:27:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scent31_0601c2926eb9
X-Filterd-Recvd-Size: 1944
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Jul 2020 03:27:13 +0000 (UTC)
Message-ID: <1c37340fba4afb910a37cae43182f6c48302fa28.camel@perches.com>
Subject: Re: [PATCH][next] drm/nouveau: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Ben Skeggs <skeggsb@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Date:   Tue, 07 Jul 2020 20:27:12 -0700
In-Reply-To: <CACAvsv4ahps=4gWwGXwvHFZOTBg1ubW86t3++dN4fAJ6JsBhDw@mail.gmail.com>
References: <20200707173628.GA29695@embeddedor>
         <CACAvsv4ahps=4gWwGXwvHFZOTBg1ubW86t3++dN4fAJ6JsBhDw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-08 at 13:22 +1000, Ben Skeggs wrote:
> On Wed, 8 Jul 2020 at 03:31, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> I really like this!  I was not a fan of explicitly marking those with comments.
> 
> Thank you, taken in my tree.
[]
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[]
> > @@ -932,7 +932,7 @@ nv50_dp_bpc_to_depth(unsigned int bpc)
> >         switch (bpc) {
> >         case  6: return 0x2;
> >         case  8: return 0x5;
> > -       case 10: /* fall-through */
> > +       case 10: fallthrough;

IMO: this comment/fallthrough should be removed instead.


