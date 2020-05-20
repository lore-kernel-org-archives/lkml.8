Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F035B20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgETKjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:39:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:8377 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETKjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:39:12 -0400
IronPort-SDR: NmRF0LthZOHg9i73rWx2bt1XDZ1mzYEYENJ6llrrZFMoTqIxLq5JiImTTJ6wu/gE8VJZZigjHy
 Gu9jlx6zrmYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:39:12 -0700
IronPort-SDR: bYPizEdrKgl1xmzG31o7x3BFjpHyFyI18xUIOK35h+LEaIDPQxa8EjYMxCFLA0IzU4DjXmM4c/
 UpvIvckRD+Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="374038852"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2020 03:39:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 May 2020 13:39:09 +0300
Date:   Wed, 20 May 2020 13:39:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1] drivers property: When no children in primary, try
 secondary
Message-ID: <20200520103909.GG1298122@kuha.fi.intel.com>
References: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 01:29:59PM +0300, Andy Shevchenko wrote:
> Software firmware nodes can provide a child node to its parent.
> Since software node can be secondary, we need a mechanism to access
> the children. The idea is to list children of the primary node first
> and when they are finished, continue with secondary node if available.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/property.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 5f35c0ccf5e0..1e6d75e65938 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -708,14 +708,23 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>  						 struct fwnode_handle *child)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	struct fwnode_handle *fwnode = NULL;
> +	struct fwnode_handle *fwnode = NULL, *next;
>  
>  	if (dev->of_node)
>  		fwnode = &dev->of_node->fwnode;
>  	else if (adev)
>  		fwnode = acpi_fwnode_handle(adev);
>  
> -	return fwnode_get_next_child_node(fwnode, child);
> +	/* Try to find a child in primary fwnode */
> +	next = fwnode_get_next_child_node(fwnode, child);
> +	if (next)
> +		return next;
> +
> +	/* When no more children in primary, continue with secondary */
> +	if (!IS_ERR_OR_NULL(fwnode->secondary))
> +		next = fwnode_get_next_child_node(fwnode->secondary, child);
> +
> +	return next;
>  }
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);

Thanks Andy,

-- 
heikki
