Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88372074F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbgF3OXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:23:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:25713 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgF3OXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:23:44 -0400
IronPort-SDR: BO+84pG9wX0V3yzmmBnaBG0J22TZtWHaDhQIUAiYWtSB30VOp3x6SljS199lm0i3BZpnrNThAj
 jIl2ztrXk3Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="146226364"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="146226364"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 07:23:42 -0700
IronPort-SDR: 8/vYlNUih71TH5mZdt+Sy56pLFMlWldhDqN48xdbXSa5o0JjX1wFk0EcNTCgIuUdA7Mw7lMcxc
 7Tz6uW4WBHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="386709302"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2020 07:23:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jun 2020 17:23:39 +0300
Date:   Tue, 30 Jun 2020 17:23:39 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v4 2/2] platform/chrome: cros_ec_typec: Add PM support
Message-ID: <20200630142339.GE856968@kuha.fi.intel.com>
References: <20200629211329.2185342-1-pmalani@chromium.org>
 <20200629211329.2185342-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629211329.2185342-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:13:29PM -0700, Prashant Malani wrote:
> Define basic suspend resume functions for cros-ec-typec. On suspend, we
> simply ensure that any pending port update work is completed, and on
> resume, we re-poll the port state to account for any
> changes/disconnections that might have occurred during suspend.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v4:
> - No changes (added Reviewed-by received in v3).
> 
> Changes in v3:
> - Remove superfluous DEV_PM_OPS #define.
> 
> Changes in v2:
> - Remove #ifdef-ery, add __maybe_unused tag to functions.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 69c4118e280c..cb95d190f06a 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -720,11 +720,35 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __maybe_unused cros_typec_suspend(struct device *dev)
> +{
> +	struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +	cancel_work_sync(&typec->port_work);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cros_typec_resume(struct device *dev)
> +{
> +	struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +	/* Refresh port state. */
> +	schedule_work(&typec->port_work);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cros_typec_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
> +};
> +
>  static struct platform_driver cros_typec_driver = {
>  	.driver	= {
>  		.name = DRV_NAME,
>  		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
>  		.of_match_table = of_match_ptr(cros_typec_of_match),
> +		.pm = &cros_typec_pm_ops,
>  	},
>  	.probe = cros_typec_probe,
>  };

thanks,

-- 
heikki
