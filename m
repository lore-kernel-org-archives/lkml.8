Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD47FC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A889120738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGSXMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:12:19 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:38102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726949AbgGSXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1AEB5D8C3C;
        Sun, 19 Jul 2020 23:11:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: girl50_5c169ea26f20
X-Filterd-Recvd-Size: 1656
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 Jul 2020 23:11:28 +0000 (UTC)
Message-ID: <f9111b6c4132e672fc491232155a39bff4410ed4.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: mark usbvision as obsolete
From:   Joe Perches <joe@perches.com>
To:     bkkarthik <bkkarthik@pesu.pes.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Date:   Sun, 19 Jul 2020 16:11:26 -0700
In-Reply-To: <20200719180411.bkojjvumwe7hkxyc@pesu.pes.edu>
References: <20200719180411.bkojjvumwe7hkxyc@pesu.pes.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-19 at 14:04 -0400, bkkarthik wrote:
> mark staging/media/usbvision as obsolete so
> checkpatch tells people not to send patches.
> 
> Signed-off-by: bkkarthik <bkkarthik@pesu.pes.edu>

This needs to have a full name before the email address.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a88bf0759c90..82120c2fcedd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17946,7 +17946,7 @@ F:	include/uapi/linux/uvcvideo.h
>  USB VISION DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
> -S:	Odd Fixes
> +S:	Odd Fixes / Obsolete
>  W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/staging/media/usbvision/

