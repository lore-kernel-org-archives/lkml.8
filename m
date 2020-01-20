Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2ABC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0747022522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqP/Qxol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATUTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:19:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42615 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:19:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so295454plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 12:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4uQ0Ytid32n2WyL1url/nvWMiyBpJsDojy+EoEWTFX0=;
        b=eqP/QxolKj6Uv5xr++tkXwMv1BV+g6AOzK2xxloYJ4edQpyRVZ1o2LmMmrxhscHCrY
         OLHLondggt0qHrOa+1VREJ1wK4LFxwB1hCNTcD+PvqYu9/Qm9tJgyYrMHRbXpxfCdKW5
         czcqZO7BFtnV3FS47FUF05El1g2sVX8jn0axKG5/X0oZZmcjDvrEyORgECZI480GVPa+
         io18qGjj+o4Wv137kbtnQu2AAir8xTjbcyt7k9nGeA2H6d+bgWK30SesLsCHOglJ7eVL
         hNlU/CLDyu7WvA6RiNOjJtB4Dj5FnizX5ZRdMMplGTdwnz4jx3Udhaua8b8R+t7TfG2B
         hXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4uQ0Ytid32n2WyL1url/nvWMiyBpJsDojy+EoEWTFX0=;
        b=aXp5nOeC6nS+mYEHq0csGQwrh3GB5IpAqhZdIiB6QqFmWbBwiZfwCzwrqTtW1X3XTN
         nJSzdg9M1ocULdMeMdioTErFDkATrF1FzJS6FchOSaawqnXGwA3x5LoBcisIb0CsOnJm
         p9VLwINJDNfYYpWBCjf9guKBw4Qk7n/HwkkeBukDjYM1S8V5vTIOjmjPzzpdAb4KTr9K
         If8tqvc7m4Ey7u9E36zaQguIun4B8NetgYxOs7FPrYpD+CRItmHZst5o7ppxJ7W9ayT3
         SIULwmSQcNtNtF1foPC+wE7t1erb+bhJLpS+ajjrMyMXsOgrIMgMHHUxSebwHr03PNLW
         IjOw==
X-Gm-Message-State: APjAAAV8UInoQDPr0oOU7Zo37WKj8ChrBxtyJ/V82z2ktys3yP1n9BVZ
        jwZyTxwgotn5mJie1Yrv9gqxaA==
X-Google-Smtp-Source: APXvYqxy/23Osmk/G5dCHhfefOJ2GrkrW6Jne/rwJJ6c7uF3c2qAIs18uzVYxqXuFDzdxsCM3ols/w==
X-Received: by 2002:a17:902:d68e:: with SMTP id v14mr1619827ply.36.1579551587827;
        Mon, 20 Jan 2020 12:19:47 -0800 (PST)
Received: from yoga (wsip-184-181-24-67.sd.sd.cox.net. [184.181.24.67])
        by smtp.gmail.com with ESMTPSA id w20sm40393776pfi.86.2020.01.20.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 12:19:47 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:19:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] remoteproc: Add prepare/unprepare callbacks
Message-ID: <20200120201944.GO1511@yoga>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-3-paul@crapouillou.net>
 <20191221202039.GG549437@yoga>
 <1579122951.3.2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579122951.3.2@crapouillou.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Jan 13:15 PST 2020, Paul Cercueil wrote:

> Hi Bjorn,
> 
> 
> Le sam., déc. 21, 2019 at 12:20, Bjorn Andersson
> <bjorn.andersson@linaro.org> a écrit :
> > On Tue 10 Dec 08:40 PST 2019, Paul Cercueil wrote:
> > 
> > >  The .prepare() callback is called before the firmware is loaded to
> > >  memory. This is useful for instance in the case where some setup is
> > >  required for the memory to be accessible.
> > > 
> > 
> > Would it make sense to somehow tie this prepare/unprepare to the actual
> > struct rproc_mem_entry that needs the resource enabled?
> 
> Do you need such granularity?
> 

I don't have such needs, but given some of the memory structure that
Suman and Loic has been talking about I would expect that such need
exists.

> In my case, the three memories need the same clock to be enabled.
> 

But we can update your driver to associate your one clock with the
memory objects if/when we end up implementing this later.

Regards,
Bjorn

> -Paul
> 
> 
> > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > > 
> > >  Notes:
> > >      v2-v4: No change
> > > 
> > >   drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
> > >   include/linux/remoteproc.h           |  4 ++++
> > >   2 files changed, 19 insertions(+), 1 deletion(-)
> > > 
> > >  diff --git a/drivers/remoteproc/remoteproc_core.c
> > > b/drivers/remoteproc/remoteproc_core.c
> > >  index 0a9fc7fdd1c3..3ea5f675a148 100644
> > >  --- a/drivers/remoteproc/remoteproc_core.c
> > >  +++ b/drivers/remoteproc/remoteproc_core.c
> > >  @@ -1299,11 +1299,19 @@ static int rproc_start(struct rproc *rproc,
> > > const struct firmware *fw)
> > >   	struct device *dev = &rproc->dev;
> > >   	int ret;
> > > 
> > >  +	if (rproc->ops->prepare) {
> > >  +		ret = rproc->ops->prepare(rproc);
> > >  +		if (ret) {
> > >  +			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
> > >  +			return ret;
> > >  +		}
> > >  +	}
> > >  +
> > >   	/* load the ELF segments to memory */
> > >   	ret = rproc_load_segments(rproc, fw);
> > >   	if (ret) {
> > >   		dev_err(dev, "Failed to load program segments: %d\n", ret);
> > >  -		return ret;
> > >  +		goto unprepare_rproc;
> > >   	}
> > > 
> > >   	/*
> > >  @@ -1354,6 +1362,9 @@ static int rproc_start(struct rproc *rproc,
> > > const struct firmware *fw)
> > >   	rproc_unprepare_subdevices(rproc);
> > >   reset_table_ptr:
> > >   	rproc->table_ptr = rproc->cached_table;
> > >  +unprepare_rproc:
> > >  +	if (rproc->ops->unprepare)
> > >  +		rproc->ops->unprepare(rproc);
> > > 
> > >   	return ret;
> > >   }
> > >  @@ -1483,6 +1494,9 @@ static int rproc_stop(struct rproc *rproc,
> > > bool crashed)
> > > 
> > >   	rproc->state = RPROC_OFFLINE;
> > > 
> > >  +	if (rproc->ops->unprepare)
> > >  +		rproc->ops->unprepare(rproc);
> > >  +
> > >   	dev_info(dev, "stopped remote processor %s\n", rproc->name);
> > > 
> > >   	return 0;
> > >  diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > >  index 5f201f0c86c3..a6272d1ba384 100644
> > >  --- a/include/linux/remoteproc.h
> > >  +++ b/include/linux/remoteproc.h
> > >  @@ -355,6 +355,8 @@ enum rsc_handling_status {
> > > 
> > >   /**
> > >    * struct rproc_ops - platform-specific device handlers
> > >  + * @prepare:	prepare the device for power up (before the firmware
> > > is loaded)
> > >  + * @unprepare:	unprepare the device after it is stopped
> > >    * @start:	power on the device and boot it
> > >    * @stop:	power off the device
> > >    * @kick:	kick a virtqueue (virtqueue id given as a parameter)
> > >  @@ -371,6 +373,8 @@ enum rsc_handling_status {
> > >    * @get_boot_addr:	get boot address to entry point specified in
> > > firmware
> > >    */
> > >   struct rproc_ops {
> > >  +	int (*prepare)(struct rproc *rproc);
> > >  +	void (*unprepare)(struct rproc *rproc);
> > >   	int (*start)(struct rproc *rproc);
> > >   	int (*stop)(struct rproc *rproc);
> > >   	void (*kick)(struct rproc *rproc, int vqid);
> > >  --
> > >  2.24.0
> > > 
> 
> 
