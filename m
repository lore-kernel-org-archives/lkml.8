Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E772C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFF220772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593609255;
	bh=ZIe1Pc79giPmUYI0Hc6to9F6x2+pRUoOQUpjCGHmOw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hB9jXQK2OIU5DsgUpuETULIxH/womHggKBj/WFNP17MDuE8+HZsCpfF4XYKzsg1FG
	 BB2+Fm7YwLaobWZABJx1yPFSblKyzbZVF0U0xqflNUEtD97jftIxopEJdDccKYNCvQ
	 Q6tErZmOT3GPnjqn+Z3G4Qg4L7FL+lXAnNCvLW/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgGANON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbgGANOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:14:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BB320772;
        Wed,  1 Jul 2020 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593609251;
        bh=ZIe1Pc79giPmUYI0Hc6to9F6x2+pRUoOQUpjCGHmOw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+3X6dSjJiBcQFgXE99zLxrzM7WhzQl98zccJACb9K0kZ7AGnR6PwGBuHJkGwvtpa
         najXSdrZB7iSnKGQnpxIt9fgHyyk9bdm8fKm9GgyK0mtToF0a+XMqhttbyk3hIMa0A
         8axMpQQ/rVl9Pl3MRocMVZ9qVP9EPbvbEZ7WTjos=
Date:   Wed, 1 Jul 2020 15:13:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 30/30] misc: cxl: flash: Remove unused pointer
Message-ID: <20200701131357.GA2298198@kroah.com>
References: <20200701083118.45744-1-lee.jones@linaro.org>
 <20200701083118.45744-31-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701083118.45744-31-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 09:31:18AM +0100, Lee Jones wrote:
> The DRC index pointer us updated on an OPCODE_ADD, but never
> actually read.  Remove the used pointer and shift up OPCODE_ADD
> to group with OPCODE_DELETE which also provides a noop.
> 
> Fixes the following W=1 kernel build warning:
> 
>  drivers/misc/cxl/flash.c: In function ‘update_devicetree’:
>  drivers/misc/cxl/flash.c:178:16: warning: variable ‘drc_index’ set but not used [-Wunused-but-set-variable]
>  178 | __be32 *data, drc_index, phandle;
>  | ^~~~~~~~~
> 
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/cxl/flash.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
> index cb9cca35a2263..24e3dfcc91a74 100644
> --- a/drivers/misc/cxl/flash.c
> +++ b/drivers/misc/cxl/flash.c
> @@ -175,7 +175,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
>  	struct update_nodes_workarea *unwa;
>  	u32 action, node_count;
>  	int token, rc, i;
> -	__be32 *data, drc_index, phandle;
> +	__be32 *data, phandle;
>  	char *buf;
>  
>  	token = rtas_token("ibm,update-nodes");
> @@ -206,15 +206,12 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
>  
>  				switch (action) {
>  				case OPCODE_DELETE:
> +				case OPCODE_ADD:
>  					/* nothing to do */
>  					break;
>  				case OPCODE_UPDATE:
>  					update_node(phandle, scope);
>  					break;
> -				case OPCODE_ADD:
> -					/* nothing to do, just move pointer */
> -					drc_index = *data++;
> -					break;

I think this is not correct, as *data++ changes the value there, and so
this changes the logic of the code.

Dropping this one from my queue.

thanks,

greg k-h
