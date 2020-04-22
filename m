Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB4C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD322076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDVOpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:45:06 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:45042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDVOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:45:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 543E94DB6;
        Wed, 22 Apr 2020 14:45:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wheel41_6607a0a47ab58
X-Filterd-Recvd-Size: 1617
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Apr 2020 14:45:01 +0000 (UTC)
Message-ID: <a857bb9785f48dea47b4d04dd0b939b0172e6320.camel@perches.com>
Subject: Re: [PATCH] media: MAINTAINERS: Fix Hantro, Rga and Rkvdec entries
From:   Joe Perches <joe@perches.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, kernel@collabora.com,
        Johan Jonker <jbx6244@gmail.com>
Date:   Wed, 22 Apr 2020 07:42:43 -0700
In-Reply-To: <20200422111403.19114-1-ezequiel@collabora.com>
References: <20200422111403.19114-1-ezequiel@collabora.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 08:14 -0300, Ezequiel Garcia wrote:
> It seems recent merges introduced a couple issues
> here, so let's fix them all. Also, reorder Rockchip
> video decoder as per parse-maintainers.pl script
> and add linux-rockchip mailing list.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> +ROCKCHIP VIDEO DECODER DRIVER
> +M:	Ezequiel Garcia <ezequiel@collabora.com>
> +L:	linux-media@vger.kernel.org
> +L:	linux-rockchip@lists.infradead.org
> +S:	Maintained
> +F:	drivers/staging/media/rkvdec/
> +F:	Documentation/devicetree/bindings/media/rockchip,vdec.yaml

alphabetic case sensitive order please.

+F:	Documentation/devicetree/bindings/media/rockchip,vdec.yaml
+F:	drivers/staging/media/rkvdec/


