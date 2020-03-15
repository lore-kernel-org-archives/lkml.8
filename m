Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA3C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2B82051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7oracMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgCOVlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 17:41:22 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55611 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgCOVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 17:41:22 -0400
Received: by mail-pj1-f66.google.com with SMTP id mj6so6953049pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mC8CXXtUqsLPv7Yc0qSPZwh0pSfdpja7KBYMCXDnZPE=;
        b=T7oracMyfCuyfTHRyqGd3oJ2PZaRyWpwDr9crQ6CP8QTO3JpTa8SoaB2JRsu5D97+4
         2yiLqqsVast/yg5zHHp9NIi5p21jhrj2C7rB6Rqkfpi1FPKWEgFqcUk5+fvxxbywzv7y
         sXgNm8WD9+r1B/2dFY0lyYomA1Z/b9qNLLj3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mC8CXXtUqsLPv7Yc0qSPZwh0pSfdpja7KBYMCXDnZPE=;
        b=RG3nXOqbdkw2bXqmg4N4f5/RUh83nKx1NLKPm19kxTAbJuNKwpQjOooZVGA7stu/cl
         1kyZ2ABK5MnejleJvxkE9b86ORWXaoW1kkzjk9GYekWGSX5GxnczF9EZ7tYUjIDHngP4
         bU8R+GaD/NATXJQKubp7Gsd8KxsLiIyUawDL96kDlIlrsQLs2woC3kKGCygMf1aUPscT
         oUqnnAHChRVssVlRPCXv48Lh+Dr+6hiNWaY2ijNuPdl43sI+fUUBq0Fm5Ue+vDy4HbQL
         Kv099rB0DpKH1g+bdw8/JC4DI+IyPTVteWAK0DUVGtGr4SQ0BbL/gr0V8KKqqUM+1ZM2
         unug==
X-Gm-Message-State: ANhLgQ3pAKjYvs0VDgTSaO5e4ScgIXt+ZIl+4UlML25FlvqNNCnezNmh
        yQ+y/7+m7jG8kcB3DHU8xsggnVo+c8s=
X-Google-Smtp-Source: ADFU+vv5U1ZopGMlO3PEEzvPctm5vqseVwPi67r/hOkC/2mtLCnf6XDxqh7lIX+Vml6weTiQbbEOnA==
X-Received: by 2002:a17:90a:bb92:: with SMTP id v18mr17246584pjr.54.1584308480375;
        Sun, 15 Mar 2020 14:41:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id i13sm13250334pfd.180.2020.03.15.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 14:41:19 -0700 (PDT)
Date:   Sun, 15 Mar 2020 14:41:19 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, furquan@chromium.org,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 3/3] platform/chrome: notify: Pull PD_HOST_EVENT status
Message-ID: <20200315214119.GB185829@google.com>
References: <20200312100809.21153-1-pmalani@chromium.org>
 <20200312100809.21153-4-pmalani@chromium.org>
 <d03c96c0-ea23-5b4e-0be0-0a1a296eeaeb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03c96c0-ea23-5b4e-0be0-0a1a296eeaeb@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for the review as always. Kindly see inline:

On Fri, Mar 13, 2020 at 01:43:24PM +0100, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> On 12/3/20 11:08, Prashant Malani wrote:
> > Read the PD host even status from the EC and send that to the notifier
> > listeners, for more fine-grained event information.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_usbpd_notify.c | 87 ++++++++++++++++++++-
> >  1 file changed, 84 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> > index d2dbf7017e29c..3d9db4146217e 100644
> > --- a/drivers/platform/chrome/cros_usbpd_notify.c
> > +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> > @@ -53,11 +53,91 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> >  
> > +/**
> > + * cros_ec_pd_command - Send a command to the EC.
> > + *
> > + * @ec_dev: EC device
> > + * @command: EC command
> > + * @outdata: EC command output data
> > + * @outsize: Size of outdata
> > + * @indata: EC command input data
> > + * @insize: Size of indata
> > + *
> > + * Return: 0 on success, < 0 on failure.
> > + */
> > +static int cros_ec_pd_command(struct cros_ec_device *ec_dev,
> > +			      int command,
> > +			      uint8_t *outdata,
> > +			      int outsize,
> > +			      uint8_t *indata,
> > +			      int insize)
> > +{
> > +	int ret;
> > +	struct cros_ec_command *msg;
> 
> Reverse x-mas tree, please.
> 
Done.
> struct cros_ec_command *msg;
> int ret;
> 
> > +
> > +	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
> > +	if (!msg)
> > +		return -EC_RES_ERROR;
> 
> Use standard linux error codes please, in that case -ENOMEM.
> 
Done.
> > +
> > +	msg->command = command;
> > +	msg->outsize = outsize;
> > +	msg->insize = insize;
> > +
> > +	if (outsize)
> > +		memcpy(msg->data, outdata, outsize);
> > +
> > +	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> > +	if (ret < 0)
> > +		goto error;
> > +
> > +	if (insize)
> > +		memcpy(indata, msg->data, insize);
> > +	ret = EC_RES_SUCCESS;
> 
> Standard linux error codes, just return what cros_ec_cmd_xfer_status returns.
Done.
> 
> > +error:
> > +	kfree(msg);
> > +	return ret;
> > +}
> > +
> > +static void cros_usbpd_get_event_and_notify(struct device  *dev,
> > +					    struct cros_ec_device *ec_dev)
> > +{
> > +	struct ec_response_host_event_status host_event_status;
> > +	u32 event = 0;
> > +	int ret;
> > +
> > +	/*
> > +	 * We still send a 0 event out to older devices which don't
> > +	 * have the updated device heirarchy.
> > +	 */
> > +	if (!ec_dev) {
> 
> Ok, remembering my comment in previous patch it makes sense to check for ec_dev,
> but see below ...
> 
> > +		dev_dbg(dev,
> > +			"EC device inaccessible; sending 0 event status.\n");
> > +		goto send_notify;
> > +	}
> > +
> > +	/* Check for PD host events on EC. */
> > +	ret = cros_ec_pd_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
> > +				 NULL, 0,
> > +				 (uint8_t *)&host_event_status,
> > +				 sizeof(host_event_status));
> > +	if (ret < 0) {
> > +		dev_warn(dev, "Can't get host event status (err: %d)\n", ret);
> 
> This print is unneeded, a error will be printed already if it fails.
Done.
> 
> > +		goto send_notify;
> > +	}
> > +
> > +	event = host_event_status.status;
> > +
> > +send_notify:
> > +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > +}
> > +
> >  #ifdef CONFIG_ACPI
> >  
> >  static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
> >  {
> > -	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > +	struct cros_usbpd_notify_data *pdnotify = data;
> > +
> > +	cros_usbpd_get_event_and_notify(pdnotify->dev, pdnotify->ec);
> >  }
> >  
> >  static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
> > @@ -144,6 +224,8 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
> >  				  unsigned long queued_during_suspend,
> >  				  void *data)
> >  {
> > +	struct cros_usbpd_notify_data *pdnotify = container_of(nb,
> > +			struct cros_usbpd_notify_data, nb);
> >  	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> >  	u32 host_event = cros_ec_get_host_event(ec_dev);
> >  
> 
> Not related to this patch but as you introduced the possibility to have ec_dev
> NULL, crash here.
notify_plat() would only be called for the cros-MFD initialization (i.e
the "platform" case) situation, so ec_dev can be guranteed to be present here.

> 
> 
> > @@ -151,8 +233,7 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
> >  		return NOTIFY_BAD;
> >  
> >  	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> > -		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> > -					     host_event, NULL);
> > +		cros_usbpd_get_event_and_notify(pdnotify->dev, ec_dev);
> >  		return NOTIFY_OK;
> >  	}
> >  	return NOTIFY_DONE;
> > 
