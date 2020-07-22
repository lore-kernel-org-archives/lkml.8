Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DC920825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgGVT4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:56:09 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:39194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbgGVT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:56:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7C27781EB13E;
        Wed, 22 Jul 2020 19:56:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: event76_220415b26f38
X-Filterd-Recvd-Size: 1602
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jul 2020 19:56:07 +0000 (UTC)
Message-ID: <1e38634d0f1c94eaaa2c9312ffe112734029a316.camel@perches.com>
Subject: Re: [PATCH] staging: octeon: Indent with tabs instead of spaces
From:   Joe Perches <joe@perches.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Jul 2020 12:56:06 -0700
In-Reply-To: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
References: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 22:19 +0500, Muhammad Usama Anjum wrote:
> Remove a coding style error. It makes code more readable.
[]
> diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
[]
> @@ -27,14 +27,14 @@
>  #define REUSE_SKBUFFS_WITHOUT_FREE  1
>  #endif
>  
> -#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
> +#define USE_ASYNC_IOBDMA		(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
>  
>  /* Maximum number of SKBs to try to free per xmit packet. */
> -#define MAX_OUT_QUEUE_DEPTH 1000
> +#define MAX_OUT_QUEUE_DEPTH		1000
>  
>  #define FAU_TOTAL_TX_TO_CLEAN (CVMX_FAU_REG_END - sizeof(u32))

If you really like alignment to tabstop,
why not align FAU_TOTAL_TX_TO_CLEAN too?


