Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0D5207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kkKcI0OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgGAOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgGAOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:37:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F264C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 07:37:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so6230695pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5b1y2MCVOrf040MpW0TdG0kQXO6F6mzXFyW0gJdufc=;
        b=kkKcI0OVbYAJGemjVYNNL+0ckR5Q9wU/ipXVEdJtirMRmFBup7NRYDkBrgupNw7sf6
         UiOG2mxd5E/eNdFsG0hLQxh26dyfNc324KRcEXxz2w+KYmnrGXOH/umA09JNifLD/vlS
         JpgpL9MkibNa0fa6noEsSzAwWOnSVIwELavQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5b1y2MCVOrf040MpW0TdG0kQXO6F6mzXFyW0gJdufc=;
        b=AP03QuXeo/z3BRMDXgWTkhG5zVrRjsSxf6ngBJeE48vnmGjyzvwOjUWxBLm5mdmWDq
         TTv5mJOkLD/XwCXgHD+D4yGAfuikLDLxI42K3X0VUF+zq/ijV2UfM5oBov7rc7ToLeD7
         iTO4RPsX5wUvrdHngXuHGaA8KWWYPEWp0tXvLzePIx+TlTNUN9M83qaXQwoQEnuf4fj6
         szxAtY9unPijitlxNhwX3iCEX8vL7sG31BMOynyUdl3KHN9VCePPtQyTg0FhBRyObobR
         QTI06Pe9E7PHA6z3Le2G9eoQr3YEYdKZ0XZa38KLd4eiyMsrSKh54MlUfIBzjHmyurIS
         izgg==
X-Gm-Message-State: AOAM531jQXGL941nMJIOMrHLZlVxSAM1URZuBINoig+hyPZaKMR8IYsg
        ugiDcYqJ6dbGH4Va3KY2Mws6yg==
X-Google-Smtp-Source: ABdhPJx8zn6fZZDMbq1MfQBbaIy4J+r9PNkaiJ0W5gmaWGLyf++fPbP6nwy7sTxmK8I25fh+Xf3yDQ==
X-Received: by 2002:a05:6a00:2257:: with SMTP id i23mr18069722pfu.25.1593614272457;
        Wed, 01 Jul 2020 07:37:52 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id y80sm6221888pfb.165.2020.07.01.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 07:37:51 -0700 (PDT)
Date:   Wed, 1 Jul 2020 07:37:51 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add num_altmodes partner attribute
Message-ID: <20200701143751.GC235106@google.com>
References: <20200701003149.3101219-1-pmalani@chromium.org>
 <20200701120131.GC2184169@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701120131.GC2184169@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks a lot for looking at the patch.

(trimming text)
On Wed, Jul 01, 2020 at 02:01:31PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 30, 2020 at 05:31:48PM -0700, Prashant Malani wrote:
> > Add a user-visible attribute for the number of alt modes available in a
> > partner. This allows userspace to determine whether there are any
> > remaining alt modes left to be registered by the kernel driver. It can
> > begin implementing any policy state machine after all available alt
> > modes have been registered with the connector class framework.
> > 
> > This value is set to "-1" initially, which is an invalid value,
> > signifying that a valid number of alt modes haven't been set for the
> > partner.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > Cc: Benson Leung <bleung@chromium.org>
> > + */
> > +int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes)
> > +{
> > +	if (num_altmodes < 0)
> > +		return -EINVAL;
> > +
> > +	partner->num_altmodes = num_altmodes;
> > +	sysfs_notify(&partner->dev.kobj, NULL, "num_altmodes");
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_partner_set_num_altmodes);
> 
> Who is calling this?  We need a user before we can add a newly exported
> function.

cros-ec-typec (drivers/platform/chrome/cros_ec_typec.c), but the patch for that
isn't ready yet. I will submit v2 when that patch is ready for review.

My apologies for not considering this earlier.

Best regards,

> 
> thanks,
> 
> greg k-h
