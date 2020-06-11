Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B8F20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgFKSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:01:45 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:49246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbgFKSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:01:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E01D5181D3042;
        Thu, 11 Jun 2020 18:01:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ant15_2a17d4e26dd5
X-Filterd-Recvd-Size: 2064
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 18:01:41 +0000 (UTC)
Message-ID: <17564b0632ef8ca6a64023fe430d69e861f252f1.camel@perches.com>
Subject: Re: [PATCH] drm/bridge: make array frs_limits static, makes object
 smaller
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Jun 2020 11:01:41 -0700
In-Reply-To: <20200611133924.923774-1-colin.king@canonical.com>
References: <20200611133924.923774-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 14:39 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array frs_limits on the stack but instead make it
> static. Makes the object code smaller by 123 bytes
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   23456	   5712	     64	  29232	   7230	drivers/gpu/drm/bridge/tc358768.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   23333	   5712	     64	  29109	   71b5	drivers/gpu/drm/bridge/tc358768.o
> 
> (gcc version 9.3.0, amd64)

It's curious that the data size didn't change.

Perhaps you should make sure you do not compile
with allyesconfig when you show these change.

For instance: x86-64 defconfig with this bridge
enabled:

$ size drivers/gpu/drm/bridge/tc358768.o
   text	   data	    bss	    dec	    hex	filename
   9423	    300	      0	   9723	   25fb	drivers/gpu/drm/bridge/tc358768.o


