Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEF120675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5VgFNhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGFTlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:41:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D50C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 12:41:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so10731455pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=78gbXC4jpMxACpM+0X+F7N8cUTEI4DO/gKeVwOGZ9qU=;
        b=V5VgFNhGXqswwi5GR+kyly4RkrsxGKxeDE+n/J7r7r3FRVCoXzf2pnhWJT/D2haUEw
         VExqaJnlmvnuxe1OkmR8Lq1oaIf2u23x/yDEpIfKpS36r4/slqYsJzSZVhJm7Jg/wbnc
         TMFFyya8wbFRDa+uTi4TB4Xr4N2NT4wFzZ/kv5GssMwaHrsIRvOnzEQh52o6OQB72lY8
         sEFBLE4mxjbLgRLSyR3XaaNkkpLZd+dVizhT3lZOZHpzhK+sJtdrkwsJeRWbi9BnxS06
         QNlkeMHZyu0pjKlC1x6I5EKT4dOSQ2Pcfu9j5NHWM14FnGu5mh8fW9ZN87QbYplPw4R6
         lgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=78gbXC4jpMxACpM+0X+F7N8cUTEI4DO/gKeVwOGZ9qU=;
        b=XClBGYyj5JFYq+gu/RhDSPWNHmumxg7xuE8oqotdJLPVdrksZe3UhiQkS6tUm1IiKx
         jYAitYsuCxawcKysLXZ9brfrpOCKc/0rpsISwILPmLHebNLoTzxmZepDFrGOWPet4lyD
         LcKbcXK4IlUbaNRj1/WvxH3gspv0Cg7JmBznbV0osaF0cdtmaY6Q8IhADvhbLANEmVLK
         twHDuMO7kvMFFdqA29LgH5mPA6Qd6rQY201as/kAABeqQ37IItdc/pNKu1BPXhiyx7L3
         hnyicMfAi/19wWwxrR1dWXive0ittRG2hZ3qcskU9A0IjuIFRy2jjw5P5h7WiiLsbbEe
         MCXw==
X-Gm-Message-State: AOAM533XlQKHpn4pHSB8SOxIj5v3xf2fBinE4PJ2CM1kZp34XE3J62xm
        cyyA7GiJvNjNAA5vv3OPoKg=
X-Google-Smtp-Source: ABdhPJztwcMBxWZeBaAvpZQruLixu+OvW+j6IhBkC3mk+YmSSEvgwVjFwvd58Du6wbyJ72ZxjYs/UA==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr33488277pls.273.1594064482214;
        Mon, 06 Jul 2020 12:41:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c2sm19613693pgk.77.2020.07.06.12.41.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 12:41:21 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:41:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes
 to Linux error codes
Message-ID: <20200706194120.GB180826@roeck-us.net>
References: <20200704142607.171400-1-linux@roeck-us.net>
 <20200706185230.GA792857@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706185230.GA792857@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:52:30AM -0700, Prashant Malani wrote:
> Hi Guenter,
> 
> On Sat, Jul 04, 2020 at 07:26:07AM -0700, Guenter Roeck wrote:
> > The EC reports a variety of error codes. Most of those, with the exception
> > of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> > error code gets lost. Convert all EC errors to Linux error codes to report
> > a more meaningful error to the caller to aid debugging.
> > 
> > Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 3e745e0fe092..10aa9e483d35 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> >  }
> >  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >  
> > +static const int cros_ec_error_map[] = {
> > +	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> > +	[EC_RES_ERROR] = -EIO,
> > +	[EC_RES_INVALID_PARAM] = -EINVAL,
> > +	[EC_RES_ACCESS_DENIED] = -EACCES,
> > +	[EC_RES_INVALID_RESPONSE] = -EPROTO,
> > +	[EC_RES_INVALID_VERSION] = -ENOTSUPP,
> > +	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> > +	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
> > +	[EC_RES_UNAVAILABLE] = -ENODATA,
> > +	[EC_RES_TIMEOUT] = -ETIMEDOUT,
> > +	[EC_RES_OVERFLOW] = -EOVERFLOW,
> > +	[EC_RES_INVALID_HEADER] = -EBADR,
> > +	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
> > +	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> > +	[EC_RES_BUS_ERROR] = -EFAULT,
> > +	[EC_RES_BUSY] = -EBUSY,
> > +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> > +	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> > +	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> > +	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> > +};
> > +
> >  /**
> >   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> >   * @ec_dev: EC device.
> > @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >   *
> >   * Return:
> >   * >=0 - The number of bytes transferred
> > - * -ENOTSUPP - Operation not supported
> > - * -EPROTO - Protocol error
> > + * <0 - Linux error code
> >   */
> >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >  			    struct cros_ec_command *msg)
> > @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >  	ret = cros_ec_cmd_xfer(ec_dev, msg);
> >  	if (ret < 0) {
> >  		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> > -	} else if (msg->result == EC_RES_INVALID_VERSION) {
> > -		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
> > -			msg->result);
> > -		return -ENOTSUPP;
> >  	} else if (msg->result != EC_RES_SUCCESS) {
> > -		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> > -		return -EPROTO;
> > +		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
> 
> Do we expect a case where cros_ec_error_map[msg->result] == 0?
> 

It seemed to be prudent to assume that this code is not going to be
updated whenever a new EC error code is added. Doing nothing would
risk returning 0, and addding WARN_ON or dev_warn seemed excessive.
Having said that, I don't really have a strong opinion one way
or another, and I'll be happy to change the code to whatever people
think is appropriate.

Thanks,
Guenter
