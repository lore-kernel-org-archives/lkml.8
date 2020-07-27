Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A84AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B4F2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgG0I7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:59:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG0I7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:59:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFA38AC1D;
        Mon, 27 Jul 2020 08:59:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 818161E12C5; Mon, 27 Jul 2020 10:59:05 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:59:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH] udf: osta_udf.h: delete a duplicated word
Message-ID: <20200727085905.GH23179@quack2.suse.cz>
References: <20200720001455.31882-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720001455.31882-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-07-20 17:14:55, Randy Dunlap wrote:
> Drop the repeated word "struct" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.com>

Thanks! Applied.

								Honza

> ---
>  fs/udf/osta_udf.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/fs/udf/osta_udf.h
> +++ linux-next-20200717/fs/udf/osta_udf.h
> @@ -226,7 +226,7 @@ struct sparingTable {
>  #define ICBTAG_FILE_TYPE_MIRROR		0xFB
>  #define ICBTAG_FILE_TYPE_BITMAP		0xFC
>  
> -/* struct struct long_ad ICB - ADImpUse (UDF 2.60 2.2.4.3) */
> +/* struct long_ad ICB - ADImpUse (UDF 2.60 2.2.4.3) */
>  struct allocDescImpUse {
>  	__le16		flags;
>  	uint8_t		impUse[4];
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
