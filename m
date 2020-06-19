Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69175C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C45207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592530750;
	bh=7GJVRFvfLFZO3XmquROJWevOB1faMDW7aPLI3u9HBJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tzRXbTOWqihDe0BU8B1GDx6IvnYNsSGf1paPgNnGULoC9k5PNOl+W+4Xu1ExKxB2Y
	 5G6dseWi6WVs68gfEVfRTZVQQeHOQLphNfqwmgcfZjVQiq8WZAXA6x289zh5Mg7R/0
	 Sc88n2QK9UWPcvTksR2jlkoacbYskb1cT3oi678A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgFSBjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:39:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47046 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFSBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:39:05 -0400
Received: by mail-io1-f67.google.com with SMTP id t9so9457244ioj.13;
        Thu, 18 Jun 2020 18:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQaCQMz4gPcbCgUxBie/bq/NUxfZZ0N0zKPA21qmglE=;
        b=Xq/rbUi2gD4IbCKGc7zCHhakswXxI+/iTFXI3+OoJ2rbIyywWSTdOmN286sqTq/+fb
         IrG+fe9VvRRTtwd4Xz240HnO0zZIr7RJrmVxWQEhE7UW4JQo6Dd4lXqUgGwXVRJQPIk4
         J9D8b/jLDhgYeD7joZ3mH9sJg72JSwj4hZtyIDemDMBbgoByCtHKXOIqe9+Z9Z6HDHIf
         rr9lSQME1lcLIpgZmq3BEJbAUc/0A0lEa6fJsdxE7H1Iw/WKXrpqT3LrZNX7sFWOvSU8
         gWjrbKI9xgGbjJqujam/2guE1VNUyrd5++FCnrwoTLXeVXDhX2N/TUb+ohvXlJcUVN2A
         D++w==
X-Gm-Message-State: AOAM532S44BseS4VetPdXljFKTWipx62vlmUM2mwAcGsR3ObVDO3sMdo
        CMCigb82Hb+3/wtwOhfmbUWwwl9Q
X-Google-Smtp-Source: ABdhPJx3XJEtJCckLuOqTp7FtlUgGEfYLt0O1Ee4jIzE9uP05iF1nVh6jw1RPI/ffyb9xaZ+Z/za7g==
X-Received: by 2002:a02:c84b:: with SMTP id r11mr1626447jao.110.1592530744046;
        Thu, 18 Jun 2020 18:39:04 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u20sm2587612iom.30.2020.06.18.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:39:03 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:39:02 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fpga: Fix dead store fpga-mgr.c
Message-ID: <20200619013902.GD3685@epycbox.lan>
References: <20200608125446.23311-1-trix@redhat.com>
 <20200608125446.23311-2-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125446.23311-2-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:54:45AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Using clang's scan-build/view this issue was flagged in fpga-mgr.c
> 
>   drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
>                   ret = id;
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index e05104f5e40c..f38bab01432e 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret = id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>  
>  	mutex_init(&mgr->ref_mutex);
>  
> -- 
> 2.18.2
> 
Applied to for-next,

Thanks!
