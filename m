Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C9B20786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgFPK4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:56:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:64356 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgFPK4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:56:17 -0400
IronPort-SDR: DWKtOVJW4SrR8JmzBLaarVAiVo1nzQ702c5yRsLNB8RgkbZHOA4nIlEzeZbCWGhxW0oU1pBdjt
 D8eqLyxgoCQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 03:56:16 -0700
IronPort-SDR: iS5GbzbjKPiXqDKhZpPrConT0bcq2eWASHaqzKGx4fvllcs2ZidupIXhxZrWjdC+Jga7qklkly
 S/l/9R7DZuJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="382837797"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Jun 2020 03:56:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 13:56:12 +0300
Date:   Tue, 16 Jun 2020 13:56:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 2/6] usb: typec: add typec_find_pwr_opmode
Message-ID: <20200616105612.GL3213128@kuha.fi.intel.com>
References: <20200615161512.19150-1-amelie.delaunay@st.com>
 <20200615161512.19150-3-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615161512.19150-3-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:15:08PM +0200, Amelie Delaunay wrote:
> This patch adds a function that converts power operation mode string into
> power operation mode value.
> 
> It is useful to configure power operation mode through device tree
> property, as power capabilities may be linked to hardware design.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 15 +++++++++++++++
>  include/linux/usb/typec.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index c9234748537a..59e1837ef85e 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1448,6 +1448,21 @@ void typec_set_pwr_opmode(struct typec_port *port,
>  }
>  EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
>  
> +/**
> + * typec_find_pwr_opmode - Get the typec power operation mode capability
> + * @name: power operation mode string
> + *
> + * This routine is used to find the typec_pwr_opmode by its string @name.
> + *
> + * Returns typec_pwr_opmode if success, otherwise negative error code.
> + */
> +int typec_find_pwr_opmode(const char *name)
> +{
> +	return match_string(typec_pwr_opmodes,
> +			    ARRAY_SIZE(typec_pwr_opmodes), name);
> +}
> +EXPORT_SYMBOL_GPL(typec_find_pwr_opmode);
> +
>  /**
>   * typec_find_orientation - Convert orientation string to enum typec_orientation
>   * @name: Orientation string
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 5daa1c49761c..f7c63ee3d443 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -254,6 +254,7 @@ int typec_set_mode(struct typec_port *port, int mode);
>  
>  void *typec_get_drvdata(struct typec_port *port);
>  
> +int typec_find_pwr_opmode(const char *name);
>  int typec_find_orientation(const char *name);
>  int typec_find_port_power_role(const char *name);
>  int typec_find_power_role(const char *name);
> -- 
> 2.17.1

thanks,

-- 
heikki
