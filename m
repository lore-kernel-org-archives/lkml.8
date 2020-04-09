Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0851C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FAF20784
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b0OwPxXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgDIWlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:41:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40605 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDIWlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:41:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id c5so160695pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZdRvWn8lvqjQXOzNVwZx+IIgNLFHEqUPhHnxLXTuMs=;
        b=b0OwPxXtSVwr9ydvocYKeylG2JO/6QFhFZVwHwUwJ24NfO2B7hP7Ky4APrE5Tm6Ewq
         xlqJLyChsB7pDNYHivew4bgeq1UAW3xd5LWc3REmNdgHrNtXgNYGQkf1rL/Ruq8DenDe
         C05sPsgUM5E51XoVY8wXuJJX2FOxT3Ny7yq5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZdRvWn8lvqjQXOzNVwZx+IIgNLFHEqUPhHnxLXTuMs=;
        b=gUuUagVQwajE2mDhefLtmmm7CnwAsAlqvLDHMGygpWaOQA6KfYnP6/4lhoCWyxfvlo
         7ebLp6H5fe0ctRBJYFkd7oey7xJiy0jrk1+6KX87PVWdYKbCw/q4CtkylQkGzZ7Gkpm5
         ORnTan7tu5RvM06Woy1hUXNx36tGimz+mcZwXpxTWObGXZ0E+tRBk4Xqux4oijIizAy0
         uq3pSZydDd/MBNwvVkM7tolIO0fZ7YJ3zi9iez5VPn1vXHfkSgGmSzayKOKZ/8yDcHFF
         Fmad4gsHgDSL7q5sBh7m6Y02dwQfBSc9YfOQRja+wKZ6UkDpSU6mpJ7MjDvK3bavoqRC
         OM4w==
X-Gm-Message-State: AGi0PuY18kq1vsR2FFiBrtFxvhQsm+pA/HCdI5dmrK5JFymg1E0DIa3/
        7Wej3/V5dCb3rNZALu8r80Iz9g==
X-Google-Smtp-Source: APiQypIBQKj8vwfaiLwpF1X+Z34aBb2o9j9xl9Rxr0e9Iy2oB0nHK58kPlRVGCB4WKfwvVPwnz8OeA==
X-Received: by 2002:aa7:96f6:: with SMTP id i22mr1953906pfq.137.1586472059786;
        Thu, 09 Apr 2020 15:40:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id z190sm124336pgz.73.2020.04.09.15.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:40:59 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:40:58 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 3/3] platform/chrome: typec: Register port partner
Message-ID: <20200409224058.GC15090@google.com>
References: <20200407010940.155490-1-pmalani@chromium.org>
 <20200407010940.155490-4-pmalani@chromium.org>
 <6ad18c9b-6c51-e08a-fb45-d97c9722a693@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad18c9b-6c51-e08a-fb45-d97c9722a693@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks as always. Response inline:

On Thu, Apr 09, 2020 at 11:40:39PM +0200, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Thank you for your patch.
> 
> On 7/4/20 3:09, Prashant Malani wrote:
> > Register (and unregister) the port partner when a connect (and
> > disconnect) is detected.
> > 
> > Co-developed-by: Jon Flatley <jflat@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 1955e1dfebc6d..e7d4d6ccccca6 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -22,6 +22,9 @@ struct cros_typec_port {
> >  	struct typec_port *port;
> >  	/* Initial capabilities for the port. */
> >  	struct typec_capability caps;
> > +	struct typec_partner *partner;
> > +	/* Port partner PD identity info. */
> > +	struct usb_pd_identity p_identity;
> >  };
> >  
> >  /* Platform-specific data for the Chrome OS EC Type C controller. */
> > @@ -191,6 +194,29 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
> >  	return ret;
> >  }
> >  
> > +static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> > +				  bool pd_en)
> > +{
> > +	struct cros_typec_port *port = typec->ports[port_num];
> > +	struct typec_partner_desc p_desc = {
> > +		.usb_pd = pd_en,
> > +	};
> > +
> > +	/*
> > +	 * Fill an initial PD identity, which will then be updated with info
> > +	 * from the EC.
> > +	 */
> > +	p_desc.identity = &port->p_identity;
> > +
> > +	port->partner = typec_register_partner(port->port, &p_desc);
> > +	if (IS_ERR_OR_NULL(port->partner)) {
> > +		port->partner = NULL;
> > +		return PTR_ERR(port->partner);
> 
> This is always returning PTR_ERR(NULL) that yields 0, that's not what you want.
> A static checker warning will be triggered.
> 
Got it. I will use a "ret" variable.
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
> >  		int port_num, struct ec_response_usb_pd_control *resp)
> >  {
> > @@ -213,6 +239,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> >  {
> >  	struct typec_port *port = typec->ports[port_num]->port;
> >  	enum typec_orientation polarity;
> > +	bool pd_en;
> > +	int ret;
> >  
> >  	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> >  		polarity = TYPEC_ORIENTATION_NONE;
> > @@ -227,6 +255,25 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> >  			TYPEC_SOURCE : TYPEC_SINK);
> >  	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
> >  			TYPEC_SOURCE : TYPEC_SINK);
> > +
> > +	/* Register/remove partners when a connect/disconnect occurs. */
> > +	if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
> > +		if (typec->ports[port_num]->partner)
> > +			return;
> > +
> > +		pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
> > +		ret = cros_typec_add_partner(typec, port_num, pd_en);
> > +		if (!ret)
> > +			dev_warn(typec->dev,
> > +				 "Failed to register partner on port: %d\n",
> > +				 port_num);
> > +	} else {
> > +		if (!typec->ports[port_num]->partner)
> > +			return;
> > +
> > +		typec_unregister_partner(typec->ports[port_num]->partner);
> > +		typec->ports[port_num]->partner = NULL;
> > +	}
> >  }
> >  
> >  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> > 
