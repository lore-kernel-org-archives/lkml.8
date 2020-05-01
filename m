Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CB8C47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72992166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2k1bwmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgEARkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729970AbgEARkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:40:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C730C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:40:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so1870419pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IP/WBu47pU6ouhN2oeGfSsgFnxkqGn0drzckoDk4hk=;
        b=g2k1bwmwn9a1ALHurechtGzFhXxdRQbUhn9qt00gPUOW08JxjqCRX4zk9gIj28tb4f
         94iRLJTuLlqeVyYta8Zoomyv4dNVAaULtz3vpVph3UxyyOopN58eA/BTJjA8QUjBxdlr
         clw8OpJAGPHwc5M8nwIdrmheTQ5l3u788kaAT7k8VWTJZhM0wPm0C1XmCn68mFe3VAyM
         jUrYUjYiNOQOlmOGHn5/KOicu4wTRYGBR5BcYEcYkpCz/vc/+NCBfkJHsyDuObzW/LVv
         OU1nHwpDYH8N05YBvkypSM4970b4gk0TkZm+LIM00ewZgLTsYuibIHS6q7ZhJxxJ/I1o
         9BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IP/WBu47pU6ouhN2oeGfSsgFnxkqGn0drzckoDk4hk=;
        b=fuTByymjOi/kvsuC2z/0ofGgn43jUfa/sYx0+hOC7cyFPwP0dmJeClpMgnXr+wKvnK
         CC0e1gVlSVDME5HQy6eshZ6NjjTFVv5NB/mKsLzoAroUwD/s77mRBPDgL31oKSXRyedd
         ArFBYoP0JCZGiVV7WFa6VdgMRONeAKMcvej2Qpe1ADi34UIqvT5wNM8gMhJPcLkLIAnK
         P1/0rSxFUXS9U6kAUwExoU8dFVQCHTVbWyeTRhPZabx4KOPNqSV3MGudk/zP+CI3W64z
         2Fkup95+dZ+jp+TwU42ZKkB+d5L0iz0LI45e5CDmU5u4689Mg6QzTOBG41FRSL3PPu1h
         dITg==
X-Gm-Message-State: AGi0PuYs92YJ6SNtZB+4dimmoIc5KRLYNPeaHfHmBXDUvgmVJ3SNwMnB
        evzR5STFksVIkTO1i/zTYHh0Bw==
X-Google-Smtp-Source: APiQypL9HBkwlP+KAWPfkuqO0QiNUaR8CIOzODdIq3IXOkeBwGVMRk2Ak/cqUy/WU7qJdpA0gK/ErQ==
X-Received: by 2002:a63:7e1b:: with SMTP id z27mr4928900pgc.19.1588354832991;
        Fri, 01 May 2020 10:40:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id fu12sm236152pjb.20.2020.05.01.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 10:40:32 -0700 (PDT)
Date:   Fri, 1 May 2020 11:40:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] remoteproc: stm32: Get coprocessor state
Message-ID: <20200501174030.GE18004@xps15>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-7-mathieu.poirier@linaro.org>
 <faa9b0e1-2e2f-609f-c436-2a58223f5f72@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa9b0e1-2e2f-609f-c436-2a58223f5f72@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:38:24PM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 4/24/20 10:24 PM, Mathieu Poirier wrote:
> > Introduce the required mechanic to get the state of the M4 when the
> > remoteproc core is initialising.
> > 
> > Mainly based on the work published by Arnaud Pouliquen [1].
> > 
> > [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
> > ---
> >  drivers/remoteproc/stm32_rproc.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> > index a285f338bed8..89fbd2ffac93 100644
> > --- a/drivers/remoteproc/stm32_rproc.c
> > +++ b/drivers/remoteproc/stm32_rproc.c
> > @@ -38,6 +38,15 @@
> >  #define STM32_MBX_VQ1_ID	1
> >  #define STM32_MBX_SHUTDOWN	"shutdown"
> >  
> > +#define RSC_TBL_SIZE		(1024)
> > +
> > +#define M4_STATE_OFF		0
> > +#define M4_STATE_INI		1
> > +#define M4_STATE_CRUN		2
> > +#define M4_STATE_CSTOP		3
> > +#define M4_STATE_STANDBY	4
> > +#define M4_STATE_CRASH		5
> > +
> >  struct stm32_syscon {
> >  	struct regmap *map;
> >  	u32 reg;
> > @@ -635,12 +644,23 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
> >  	return 0;
> >  }
> >  
> > +static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
> > +				     unsigned int *state)
> > +{
> > +	/* See stm32_rproc_parse_dt() */
> > +	if (!ddata->m4_state.map)
> > +		return -EINVAL;
> > +
> > +	return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
> > +}
> i would manage here the default state depending on the error types
> if (!ddata->m4_state.map {
> 	/* 
> 	 * We couldn't get the coprocessor's state, assume
> 	 * it is not running.
> 	 */
> 	state = M4_STATE_OFF;
> 
> 	return 0;
> }
> 
> return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
> 
> 
> 
> > +
> >  static int stm32_rproc_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct stm32_rproc *ddata;
> >  	struct device_node *np = dev->of_node;
> >  	struct rproc *rproc;
> > +	unsigned int state;
> >  	bool auto_boot = false;
> >  	int ret;
> >  
> > @@ -664,6 +684,15 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto free_rproc;
> >  
> > +	ret = stm32_rproc_get_m4_status(ddata, &state);
> > +	if (ret) {
> > +		/*
> > +		 * We couldn't get the coprocessor's state, assume
> > +		 * it is not running.
> > +		 */
> > +		state = M4_STATE_OFF;
> 
> So here just handle the error;

Ok

> 
> Regards
> Arnaud
> > +	}
> > +
> >  	rproc->auto_boot = auto_boot;
> >  	rproc->has_iommu = false;
> >  	ddata->workqueue = create_workqueue(dev_name(dev));
> > 
