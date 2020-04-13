Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E2C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F81D20692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgDMRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:33 -0400
Received: from www84.your-server.de ([213.133.104.84]:59236 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgDMLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:18:31 -0400
X-Greylist: delayed 1713 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:18:30 EDT
Received: from [188.192.105.153] (helo=[192.168.0.7])
        by www84.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <stefani@seibold.net>)
        id 1jNwf5-0000YV-Is; Mon, 13 Apr 2020 12:49:55 +0200
Message-ID: <88b2b2cf708d6d2bded8ed72c1e285322365f627.camel@seibold.net>
Subject: Re: [RESEND PATCH] MAINTAINERS: add an entry for kfifo
From:   Stefani Seibold <stefani@seibold.net>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 13 Apr 2020 12:49:51 +0200
In-Reply-To: <20200413104250.26683-1-brgl@bgdev.pl>
References: <20200413104250.26683-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25780/Sun Apr 12 13:57:54 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked by Stefani Seibold <stefani@seibold.net>

Am Montag, den 13.04.2020, 12:42 +0200 schrieb Bartosz Golaszewski:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Kfifo has been written by Stefani Seibold and she's implicitly
> expected to
> Ack any changes to it.  She's not however officially listed as kfifo
> maintainer which leads to delays in patch review.  This patch
> proposes to
> add an explicit entry for kfifo to MAINTAINERS file.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> I'm not sure why this patch hasn't made it into v5.7 - it's been in
> next
> for weeks now. :(
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..f0f30b2cafa4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9412,6 +9412,13 @@ F:	include/linux/keyctl.h
>  F:	include/uapi/linux/keyctl.h
>  F:	security/keys/
>  
> +KFIFO
> +M:	Stefani Seibold <stefani@seibold.net>
> +S:	Maintained
> +F:	lib/kfifo.c
> +F:	include/linux/kfifo.h
> +F:	samples/kfifo/
> +
>  KGDB / KDB /debug_core
>  M:	Jason Wessel <jason.wessel@windriver.com>
>  M:	Daniel Thompson <daniel.thompson@linaro.org>

