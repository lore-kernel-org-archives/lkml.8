Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0C9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BED20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFK5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:57:44 -0500
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:49539 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgCFK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:57:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9675D837F27E;
        Fri,  6 Mar 2020 10:57:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mom04_25fb8bd6a1122
X-Filterd-Recvd-Size: 3105
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 10:57:40 +0000 (UTC)
Message-ID: <155f99baffe11836fc9d794ff297bdcee7831050.camel@perches.com>
Subject: Re: [Intel-gfx] [PATCH] MAINTAINERS: adjust to reservation.h
 renaming
From:   Joe Perches <joe@perches.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Date:   Fri, 06 Mar 2020 02:56:06 -0800
In-Reply-To: <20200306103946.GT2363188@phenom.ffwll.local>
References: <20200304120711.12117-1-lukas.bulwahn@gmail.com>
         <b0296e3a-31f8-635a-f26d-8b0bc490aae3@amd.com>
         <20200306103946.GT2363188@phenom.ffwll.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 11:39 +0100, Daniel Vetter wrote:
> On Wed, Mar 04, 2020 at 01:08:32PM +0100, Christian König wrote:
> > Am 04.03.20 um 13:07 schrieb Lukas Bulwahn:
> > > Commit 52791eeec1d9 ("dma-buf: rename reservation_object to dma_resv")
> > > renamed include/linux/reservation.h to include/linux/dma-resv.h, but
> > > missed the reference in the MAINTAINERS entry.
> > > 
> > > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > > 
> > >    warning: no file matches F: include/linux/reservation.h
> > > 
> > > Adjust the DMA BUFFER SHARING FRAMEWORK entry in MAINTAINERS.
> > > 
> > > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > 
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> You'll push this too?
> -Daniel
> 
> > > ---
> > > Christian, please pick this patch.
> > > applies cleanly on current master and next-20200303
> > > 
> > >   MAINTAINERS | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6158a143a13e..3d6cb2789c9e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5022,7 +5022,7 @@ L:	dri-devel@lists.freedesktop.org
> > >   L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> > >   F:	drivers/dma-buf/
> > >   F:	include/linux/dma-buf*
> > > -F:	include/linux/reservation.h
> > > +F:	include/linux/dma-resv.h
> > >   F:	include/linux/*fence.h
> > >   F:	Documentation/driver-api/dma-buf.rst
> > >   K:	dma_(buf|fence|resv)

Slightly unrelated:

The K: entry matches a lot of other things
and may have a lot of false positive matches
like any variable named dma_buffer

This should also use (?:...) to avoid a perl
capture group.

Perhaps:

K:	'\bdma_(?:buf|fence|resv)\b'


