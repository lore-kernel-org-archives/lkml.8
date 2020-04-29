Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C47CC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4792074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588152687;
	bh=zcWiW9EZ/F59Gdq3DfETx5yx1yXKXf0jOhZZEYwW3KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ur0VnBrQ7/K4hCSV6yf07An4p474NUBEg3ycSL0FGM9JToMZKW4Kx8Wmdi1DOf2tJ
	 bz/5nHs8NFHQ0LHljFqU2BmE5z0sHf5kkJvs+aQWTWeFJpsaP6EVTt18dgOFYpFirK
	 s7XLqdKrekrSkMgzWS7gNq51wXLck03EVN0wv8+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD2Jb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Jb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:31:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FC620731;
        Wed, 29 Apr 2020 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588152685;
        bh=zcWiW9EZ/F59Gdq3DfETx5yx1yXKXf0jOhZZEYwW3KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdsGb0N6ienkbt9rjp5Y1GXj0GFhUhiD40ZaBN5q3qaQ89UfUA/gbTDObL2bCtT1c
         EEhrwV040WDkl6Eh20vpccqaexnTdMcPrelWBiaRYEWZUJPWPuQkVuqdJL92qkER+x
         6n2YCsiaVrUDkC2jRKEpD9QJv2kCMZY8Ov/23yU0=
Date:   Wed, 29 Apr 2020 11:31:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "K V, Abhilash" <abhilash.k.v@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ajay Gupta <ajayg@nvidia.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: fix ucsi_register_port_psy typo
Message-ID: <20200429093123.GB2079263@kroah.com>
References: <20200429085211.2879411-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429085211.2879411-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:52:04AM +0200, Arnd Bergmann wrote:
> The dummy function in the header file has the wrong name,
> conflicting with a local ucsi_register_port function:
> 
> drivers/usb/typec/ucsi/ucsi.c:890:12: error: conflicting types for 'ucsi_register_port'
>   890 | static int ucsi_register_port(struct ucsi *ucsi, int index)
>       |            ^~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/typec/ucsi/ucsi.c:17:
> drivers/usb/typec/ucsi/ucsi.h:344:19: note: previous definition of 'ucsi_register_port' was here
>   344 | static inline int ucsi_register_port(struct ucsi_connector *con) { return 0; }
>       |                   ^~~~~~~~~~~~~~~~~~
> drivers/usb/typec/ucsi/ucsi.c: In function 'ucsi_register_port':
> drivers/usb/typec/ucsi/ucsi.c:939:8: error: implicit declaration of function 'ucsi_register_port_psy'; did you mean 'ucsi_unregister_port_psy'? [-Werror=implicit-function-declaration]
>   939 |  ret = ucsi_register_port_psy(con);
>       |        ^~~~~~~~~~~~~~~~~~~~~~
>       |        ucsi_unregister_port_psy
> 
> Fixes: 992a60ed0d5e ("usb: typec: ucsi: register with power_supply class")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index e52b5540b254..cba6f77bea61 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -341,7 +341,7 @@ int ucsi_resume(struct ucsi *ucsi);
>  int ucsi_register_port_psy(struct ucsi_connector *con);
>  void ucsi_unregister_port_psy(struct ucsi_connector *con);
>  #else
> -static inline int ucsi_register_port(struct ucsi_connector *con) { return 0; }
> +static inline int ucsi_register_port_psy(struct ucsi_connector *con) { return 0; }
>  static inline void ucsi_unregister_port_psy(struct ucsi_connector *con) { }
>  #endif /* CONFIG_POWER_SUPPLY */
>  
> -- 
> 2.26.0
> 

This was sent yesterday and will show up in the next linux-next release,
sorry for the delay.

greg k-h
