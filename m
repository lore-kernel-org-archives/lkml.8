Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9458C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93642217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHnU8lNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATTpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:45:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42325 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgATTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:45:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so213733pfz.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vra/ayO7Hv5ZTpKJr2wDgQyoS7rN2is/vNAM65Supwc=;
        b=yHnU8lNVQmUMQGyXiOwpLI4cU2GSjtx5ErZQ9Yo+Tdsl+ySR5Pl6NV3czcvI/lmtd9
         oAfTivmsVrkb0ilS5v9/+kmIc2R5MAL6LVFTmCjXvI2y910h4dge4y5lAQuc98ZLA5j+
         5Px47QaPq9jP4uM20ol1e4ymDSsHPN91u9De7jM0Y48xci6UcSkpgL46PeMyU0cY0ZQc
         3tfR4IYsCmgp3wataIChebo7No9EaphsxNqDXYn1q44GJ0RaQvEKNVLsRAMETNZBRMsG
         kEK17vzyIFdjTw5KhLZf4fYM66F7i1zxwFg8Tesy+b8MjvdmICaTipdqc5oadUg+gYwU
         WRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vra/ayO7Hv5ZTpKJr2wDgQyoS7rN2is/vNAM65Supwc=;
        b=Wn19eb4d5m04Ou2ZwgdRzOwnFWydwThEusQtIwPWYpo9/fATIEnWanDAymbV215QsC
         O4OTR+8Xy6QggsMQpJtI2pnll3SxSv/SEW+Ucj/GnMfLn3eR3ZQaGv2fc5CQbJWjJ0Pz
         vBebRzhhVzYb/jaD/Nz3tXfhiATsrCBQBRrIN0LMcq/U+yjKnGdNBMxVCIuBCAJ2tHNa
         y6+B8yfvyvOlF8NdpFMYWpad4OUmG5O9hT9JGztFNPoH/5r/zQZA9PufAaatS1+tawqv
         uR3b4xi5S7bN/rDrls0ZLWLITl1JgupEBtvYjtpxmk2WlTESbGLqL4ft9lWZomXBMFCv
         iMFQ==
X-Gm-Message-State: APjAAAU1ShFMC5GpzQW1lbn6l/seRZJ/qnKG7saSYg/O/OJ20QaMeNrE
        wbCRgLisQwLEyqb4dTYfOQ632Q==
X-Google-Smtp-Source: APXvYqyW8fDbS/lJwkosIwPqcq42R7hQ3w4BR8KWf/VZHH6WJsnCXQfG5YvvCeudC77ofjjDuV959w==
X-Received: by 2002:a62:a515:: with SMTP id v21mr783153pfm.128.1579549504464;
        Mon, 20 Jan 2020 11:45:04 -0800 (PST)
Received: from yoga (wsip-184-181-24-67.sd.sd.cox.net. [184.181.24.67])
        by smtp.gmail.com with ESMTPSA id h26sm42224287pfr.9.2020.01.20.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 11:45:03 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:45:00 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien DESSENNE <fabien.dessenne@st.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, "od@zcrc.me" <od@zcrc.me>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] remoteproc: Add device-managed variants of
 rproc_alloc/rproc_add
Message-ID: <20200120194500.GM1511@yoga>
References: <20191210164014.50739-1-paul@crapouillou.net>
 <20191210164014.50739-2-paul@crapouillou.net>
 <6fff431f-dd3f-a67e-e40b-8cee4060c37a@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fff431f-dd3f-a67e-e40b-8cee4060c37a@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 Dec 01:43 PST 2019, Fabien DESSENNE wrote:

> Hi Paul,
> 
> 
> Good initiative! See me remarks below.
> 

I concur!

> 
> On 10/12/2019 5:40 PM, Paul Cercueil wrote:
> > Add API functions devm_rproc_alloc() and devm_rproc_add(), which behave
> > like rproc_alloc() and rproc_add() respectively, but register their
> > respective cleanup function to be called on driver detach.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >
> > Notes:
> >      v3: New patch
> >      v4: No change
> >
> >   drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++++++++
> >   include/linux/remoteproc.h           |  5 +++
> >   2 files changed, 72 insertions(+)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 307df98347ba..0a9fc7fdd1c3 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> 
> 
> Maybe these devm function shall be defined in a new remoteproc/devres.c 
> file. Although it seems to be a common usage I don't know if there is a 
> rule for that.
> 

Let's keep it in this same file, the devres.c would be tiny.

> 
> > @@ -1932,6 +1932,33 @@ int rproc_add(struct rproc *rproc)
> >   }
> >   EXPORT_SYMBOL(rproc_add);
> >   
> > +static void devm_rproc_remove(void *rproc)
> > +{
> > +	rproc_del(rproc);
> > +}
> > +
> > +/**
> > + * devm_rproc_add() - resource managed rproc_add()
> > + * @dev: the underlying device
> > + * @rproc: the remote processor handle to register
> > + *
> > + * This function performs like rproc_add() but the registered rproc device will
> > + * automatically be removed on driver detach.
> > + *
> > + * Returns 0 on success and an appropriate error code otherwise.
> > + */
> > +int devm_rproc_add(struct device *dev, struct rproc *rproc)
> > +{
> > +	int err;
> > +
> > +	err = rproc_add(rproc);
> > +	if (err)
> > +		return err;
> > +
> > +	return devm_add_action_or_reset(dev, devm_rproc_remove, rproc);
> > +}
> > +EXPORT_SYMBOL(devm_rproc_add);
> > +
> >   /**
> >    * rproc_type_release() - release a remote processor instance
> >    * @dev: the rproc's device
> > @@ -2149,6 +2176,46 @@ int rproc_del(struct rproc *rproc)
> >   }
> >   EXPORT_SYMBOL(rproc_del);
> >   
> > +static void devm_rproc_free(struct device *dev, void *res)
> > +{
> > +	rproc_free(*(struct rproc **)res);
> > +}
> > +
> > +/**
> > + * devm_rproc_alloc() - resource managed rproc_alloc()
> > + * @dev: the underlying device
> > + * @name: name of this remote processor
> > + * @ops: platform-specific handlers (mainly start/stop)
> > + * @firmware: name of firmware file to load, can be NULL
> > + * @len: length of private data needed by the rproc driver (in bytes)
> > + *
> > + * This function performs like rproc_alloc() but the acuired rproc device will
> 
> 
> typo: s/acuired/acquired
> 
> 
> > + * automatically be released on driver detach.
> > + *
> > + * On success the new rproc is returned, and on failure, NULL.
> > + */
> > +struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
> > +			       const struct rproc_ops *ops,
> > +			       const char *firmware, int len)
> > +{
> > +	struct rproc **ptr, *rproc;
> > +
> > +	ptr = devres_alloc(devm_rproc_free, sizeof(*ptr), GFP_KERNEL);
> > +	if (!ptr)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rproc = rproc_alloc(dev, name, ops, firmware, len);
> > +	if (rproc) {
> > +		*ptr = rproc;
> > +		devres_add(dev, ptr);
> > +	} else {
> > +		devres_free(ptr);
> > +	}
> > +
> > +	return rproc;
> 
> 
> Can't you use devm_add_action_or_reset() here too?
> 

The proposed function matches how everyone else is doing devm_*_alloc(),
so I would like to keep it as is.

Regards,
Bjorn

> 
> > +}
> > +EXPORT_SYMBOL(devm_rproc_alloc);
> > +
> >   /**
> >    * rproc_add_subdev() - add a subdevice to a remoteproc
> >    * @rproc: rproc handle to add the subdevice to
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 16ad66683ad0..5f201f0c86c3 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -595,6 +595,11 @@ int rproc_add(struct rproc *rproc);
> >   int rproc_del(struct rproc *rproc);
> >   void rproc_free(struct rproc *rproc);
> >   
> > +struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
> > +			       const struct rproc_ops *ops,
> > +			       const char *firmware, int len);
> > +int devm_rproc_add(struct device *dev, struct rproc *rproc);
> > +
> >   void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
> >   
> >   struct rproc_mem_entry *
> 
> 
> BR
> 
> Fabien
