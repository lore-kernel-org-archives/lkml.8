Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14646C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E005420772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532343;
	bh=j4eMMoarX1f4rYZawVdTSJLmd2Yr8lYae78R5pTEHGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YUQhJRN9VIMbZhrGWVtt1KpV/MqdnwWHOLKb6U7790ENdr+H2uV7G/9mEOIs2oC7R
	 /K63d1MsVYofKQDdsDyzVMriQh+liVX8UmNTD6SupbEbchw8WHTMSh7VeaeNUxmWIp
	 fzQxJS4cmn9FuRcGpqs0msyWvuKoolxuymU2zr40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCRLwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRLwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:52:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97191205ED;
        Wed, 18 Mar 2020 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532342;
        bh=j4eMMoarX1f4rYZawVdTSJLmd2Yr8lYae78R5pTEHGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tx+/3CzPnBDsnwzf8p0lZ7jLmQGWwOz1Ql9yItxh/eRbr/BxG26LeROVZBZ+nGwB0
         ZZ/AFlTnjMlrBbxyfvIbMkO0MeCJco8di0kIAsHdPzooI3IYc67PFNkI567Y3n6xY2
         wBkLIeOLIbn0DDewBarQDdqltUU0OIxwolHXdjts=
Date:   Wed, 18 Mar 2020 12:52:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v3 22/24] firmware: xilinx: Add system shutdown API
 interface
Message-ID: <20200318115219.GC2472686@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-23-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583538452-1992-23-git-send-email-jolly.shah@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:30PM -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add system shutdown API interface which asks firmware to
> perform system shutdown/restart.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 13 +++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  4 +++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index f671b6b..d3f637b 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -834,6 +834,19 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
>  
>  /**
> + * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
> + * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
> + * @subtype:	Specifies which system should be restarted or shut down
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
> +{
> +	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
> +				   0, 0, NULL);
> +}
> +
> +/**
>   * ggs_show - Show global general storage (ggs) sysfs attribute
>   * @device: Device structure
>   * @attr: Device attribute structure
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 8ccaa39..13b9fdb 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -66,7 +66,8 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> -	PM_REQUEST_NODE = 13,
> +	PM_SYSTEM_SHUTDOWN = 12,
> +	PM_REQUEST_NODE,

So you might have changed the value of PM_REQUEST_NODE, is that ok?

Why remove the explicit value?

thanks,

greg k-h
