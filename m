Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D136C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA742072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD0GdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:33:06 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:33794 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:33:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 08A06100E7B45;
        Mon, 27 Apr 2020 06:33:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shape82_1aade746dd105
X-Filterd-Recvd-Size: 2237
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 06:33:03 +0000 (UTC)
Message-ID: <79ade7bc8ce57ef11f94011bad1842372c61fdd7.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add email addresses from .yaml files
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Sun, 26 Apr 2020 23:33:02 -0700
In-Reply-To: <20200427055755.GA21898@ravnborg.org>
References: <87d082jtfn.fsf@collabora.com>
         <20200420175909.GA5810@ravnborg.org>
         <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
         <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
         <7beaedfd63017973b910dd21cac13ecb42dbe503.camel@perches.com>
         <20200427055755.GA21898@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 07:57 +0200, Sam Ravnborg wrote:
> Hi Joe.

Hi Sam.

> On Sun, Apr 26, 2020 at 10:40:52PM -0700, Joe Perches wrote:
> > .yaml files can contain maintainer/author addresses and it seems
> > unlikely or unnecessary that individual MAINTAINER file section
> > entries for each .yaml file will be created.
> > 
> > So dd the email addresses found in .yaml files to the default
>      ^
>      add

Andrew, can you add the a to this please?

> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Tested-by: Sam Ravnborg <sam@ravnborg.org>
> 
> The patch did not apply on top of -rc3, but it was trivial to fix.
> Tested and works like a charm.
> Thanks for doing this!

As most of my patches, it was done using -next

cheers, Joe

