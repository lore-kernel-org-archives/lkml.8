Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FAC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 05:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863152071C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 05:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgASFdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 00:33:08 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:47155 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgASFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 00:33:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 43A46182251C0;
        Sun, 19 Jan 2020 05:33:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wheel05_8f543acaa5616
X-Filterd-Recvd-Size: 1631
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 Jan 2020 05:33:04 +0000 (UTC)
Message-ID: <b1437d2f1543e73a20250342a764185772167658.camel@perches.com>
Subject: Re: [PATCH 3/3] Staging: comedi: usbdux: cleanup long line and
 align it
From:   Joe Perches <joe@perches.com>
To:     Simon Fong <simon.fongnt@gmail.com>, abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 18 Jan 2020 21:32:06 -0800
In-Reply-To: <20200119035243.7819-1-simon.fongnt@gmail.com>
References: <20200119035243.7819-1-simon.fongnt@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-19 at 11:52 +0800, Simon Fong wrote:
> Clean up long line and align it
[]
> diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
[]
> @@ -204,7 +204,8 @@ struct usbdux_private {
>  	struct mutex mut;
>  };
>  
> -static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)

Why do you believe this to be a long line?
It's only 63 characters.

         1         2         3         4         5         6         7
1234567890123456789012345678901234567890123456789012345678901234567890

static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)

> +static void usbdux_unlink_urbs(struct urb **urbs,
> +			       int num_urbs)
>  {
>  	int i;
>   

