Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E189C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69EA2081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgF0FMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:12:39 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:44184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbgF0FMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:12:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B8318180A7FE8;
        Sat, 27 Jun 2020 05:12:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glue64_4900af226e5b
X-Filterd-Recvd-Size: 1995
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Jun 2020 05:12:36 +0000 (UTC)
Message-ID: <82612d7cc05d1a8f178a71be25884ec8ac5ef6cc.camel@perches.com>
Subject: Re: [PATCH] fbtft-bus.c: Removing that prohibited space before ')'
From:   Joe Perches <joe@perches.com>
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Sebastian =?ISO-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Jun 2020 22:12:35 -0700
In-Reply-To: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
References: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-27 at 00:51 -0400, B K Karthik wrote:
> fbtft-bus.c:
> 
> fixing ERROR: space prohibited before that close parenthesis ')' by removing that space and ',' in line 65 and 67.
[]
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67b17..847cbfbbd766 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

Q: Did you compile the files modified by this patch
   before you submitted it?
A: No



