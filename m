Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C0C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD4C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589297718;
	bh=O+2/wW34ztW0Tzz6tppqjVMxHuVB5ZpUuSewnq32w/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dRp2tkeQ6tYMiSirVHQ7p2NR4jYO7Su4Aya5GNF7V20CqtDJvXEA4Z5Cv5+qzpro6
	 PIAPkQRiVnQYthEGQHimS+hepUEyifm15WFE09VvDUl76ZIeI63Nm7MQFQ7ynzqPV6
	 Ua4782StXEx9MyRT5lldkkFraPaCbC6mivXovkmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgELPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:35:18 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43064 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgELPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:35:17 -0400
Received: by mail-pg1-f170.google.com with SMTP id l12so6305832pgr.10;
        Tue, 12 May 2020 08:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IACEJSbgjfxq+BYzs3zD2rIKVKj69qiCzKfaSwCOxxY=;
        b=X16CMivvHqmZTgSQfVc3AGk1IN6v9Vkw4EQeOBQxxarQYLYEZBF0eEH2j0KN55ABkE
         +gHAFTpHgwib8cF17R/slUgpJKdiNfhezfIrpkUtwH3Ae4G9UeTa91j+oc5sUR2OSuWN
         mOMpXYcoigTPgAZxI3bHpDAo4qO2nJPFmH0ux6SsdfDRjmJvtN1IToP1In1jFRfNDdL2
         PXLvUBaE8FM/w1zsud793tfqhgVpmMmdhWVNrhexYX7qDTqHTpjz6zltP21UMb2XGgpA
         T4sNM3s5v1gqnSgHxvTNHiga2L+v5dSIEs09wJ0euiVu5AU7eH8f57SraL/bh/shMM/i
         d1pw==
X-Gm-Message-State: AGi0PublHAheXejQDynzkILH9Zvxpcw2DRX/+/yaNH43E2mC4Fuwa2bC
        mtQAuXzH2wXObYTydqngDRZP7peDHr0=
X-Google-Smtp-Source: APiQypJpROjarbCMvMM4Ndd2r0ywRWUfOCUl8nJ2ZyQX2uy/YBcNA+qitkmlzvLBSTs6XzxZOJtl6A==
X-Received: by 2002:aa7:9d02:: with SMTP id k2mr21122894pfp.269.1589297716947;
        Tue, 12 May 2020 08:35:16 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j7sm13150420pjy.9.2020.05.12.08.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:35:15 -0700 (PDT)
Date:   Tue, 12 May 2020 08:35:14 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] fpga: stratix10-soc: remove the pre-set
 reconfiguration condition
Message-ID: <20200512153514.GA125665@epycbox.lan>
References: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, May 12, 2020 at 08:27:31AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> The reconfiguration mode is pre-set by driver as the full reconfiguration.
> As a result, user have to change code and recompile the drivers if he or
> she wants to perform a partial reconfiguration. Removing the pre-set
> reconfiguration condition so that user can select full or partial
> reconfiguration via overlay device tree without recompiling the drivers.
> 
> Also add an error message if the configuration request is failure.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..2da8a40 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -182,12 +182,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	uint i;
>  	int ret;
>  
> -	ctype.flags = 0;
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +		ctype.flags = 1;
Have you considered:

ctype.flags = BIT(COMMAND_RECONFIG_FLAG_PARTIAL);

instead (assuming 1, lines up with BIT(COMMAND_RECONFIG_FLAG_PARTIAL)?

If not: Can you define a constant?
>  	} else {
>  		dev_dbg(dev, "Requesting full reconfiguration.\n");
> +		ctype.flags = 0;
>  	}
>  
>  	reinit_completion(&priv->status_return_completion);
> @@ -210,6 +210,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  
>  	ret = 0;
>  	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> +		dev_err(dev, "RECONFIG_REQUEST failed\n");
>  		ret = -ETIMEDOUT;
>  		goto init_done;
>  	}
> -- 
> 2.7.4
> 

Cheers,
Moritz
