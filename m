Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E0EC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BBE214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgA0JLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:51320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgA0JLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:11:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E706AACF2;
        Mon, 27 Jan 2020 09:11:04 +0000 (UTC)
Date:   Mon, 27 Jan 2020 10:11:03 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Colin King <colin.king@canonical.com>
Cc:     <linux-i2c@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: parport: fix spelling mistake: "Atmost" -> "At
 most"
Message-ID: <20200127101103.111bac39@endymion>
In-Reply-To: <20200125202020.12861-1-colin.king@canonical.com>
References: <20200125202020.12861-1-colin.king@canonical.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2020 20:20:20 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a module parameter description.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i2c/busses/i2c-parport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
> index f8f94a25af26..81eb441b2387 100644
> --- a/drivers/i2c/busses/i2c-parport.c
> +++ b/drivers/i2c/busses/i2c-parport.c
> @@ -129,7 +129,7 @@ static int parport[MAX_DEVICE] = {0, -1, -1, -1};
>  module_param_array(parport, int, NULL, 0);
>  MODULE_PARM_DESC(parport,
>  		 "List of parallel ports to bind to, by index.\n"
> -		 " Atmost " __stringify(MAX_DEVICE) " devices are supported.\n"
> +		 " At most " __stringify(MAX_DEVICE) " devices are supported.\n"
>  		 " Default is one device connected to parport0.\n"
>  );
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
