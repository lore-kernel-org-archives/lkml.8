Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7D3C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4030720731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjM7yFpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgEARyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729973AbgEARyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:54:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959ECC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:54:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l20so4846972pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DRg3zcbdwJvHwwdmWPDqLT8eUhyWI38G+2e6Y0MIzuw=;
        b=AjM7yFpPFJFc/Xp09RqIRFsPyXCGYSShJyQBSCnCAyE+7w0uxt38ym2oxCXiPcXovx
         Q/VYY+Ad7CH5P3WyBOeGS99Gdjk8IzNpvQltN/LRSZn/sTMubaTznSKXIxSKFFacj5il
         FaBkG5E3ASrBNabkNSKuWq3L8ENPNZ3qHMXlcXhdGhiV9b7UZAb2guXey8knRe3/cXsc
         ahnapvrVM0moMOfekNoNbIoNxB4q5i/KZLK9r1TJrfDu7ZYbV9qYNod8IdCEnAuw+GQz
         POEKAE5o/gcllW5kSLgV85yXbaJt99SohMDdSB6PkngnJ998oezxGG0uRjzsnrf/qmmI
         yA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DRg3zcbdwJvHwwdmWPDqLT8eUhyWI38G+2e6Y0MIzuw=;
        b=KbM0olXvXvB04emZ0A5zVFFjsN0mXAIgmNkA6riWqBOnM1NJPGodS5dGf0V/h6aA5u
         Gu2dsEd/JcASMcdilBrTxr+BqSOvuCNo8NCgI5tSYlk1lxIID5f0hGdOcHI0Sfu2fMtZ
         V5YJDhpHwHEJvBPlGMPjTVfEEmEmo6wgjkKCqxS8/8IBJmm533/bWD4uEcqyb921D4a2
         XQ6U2Cq4g3i0GqMkzN0gxKjJq0ZjnsPlwrTXPaQ6Bjl6s45yLTlS+mLhWc+YgySUY2k9
         M0DO6VcDzIoTI4YeRqJMCmcyUhZvenhxVIov4F7uVseiPWu1HbNQQpTq4Ldmow3AYjwc
         x7QQ==
X-Gm-Message-State: AGi0PuZJaZCMsveah6ihZ5IQVRFFJz9YazuM4ruuPNgMhpTJit/Ml6vk
        tgNdGqOOo/bGa8/OmOQpxfVtvw==
X-Google-Smtp-Source: APiQypKinFwjLxwudUbIQPJSzcgT/R+sN9xYkeIHLb7Ej4S4Zq5Bpmiy+iZT5kj2ZM3AoMThjH03xA==
X-Received: by 2002:a63:564e:: with SMTP id g14mr5324203pgm.63.1588355689010;
        Fri, 01 May 2020 10:54:49 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s38sm2528104pgk.31.2020.05.01.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 10:54:48 -0700 (PDT)
Date:   Fri, 1 May 2020 11:54:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] remoteproc: stm32: Set synchronisation state
 machine if needed
Message-ID: <20200501175446.GF18004@xps15>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-13-mathieu.poirier@linaro.org>
 <defc59b2-4d64-a108-2e5e-ecc579f70a8b@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defc59b2-4d64-a108-2e5e-ecc579f70a8b@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:47:19PM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 4/24/20 10:25 PM, Mathieu Poirier wrote:
> > Set the flags and operations to use if the M4 has been started
> > by another entity than the remoteproc core.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/stm32_rproc.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> > index dcae6103e3df..02dad3f51c7a 100644
> > --- a/drivers/remoteproc/stm32_rproc.c
> > +++ b/drivers/remoteproc/stm32_rproc.c
> > @@ -598,13 +598,20 @@ static struct rproc_ops st_rproc_ops = {
> >  	.get_boot_addr	= rproc_elf_get_boot_addr,
> >  };
> >  
> > -static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
> > +static struct rproc_ops st_rproc_sync_ops = {
> >  	.start		= stm32_rproc_sync_start,
> >  	.stop		= stm32_rproc_stop,
> > +	.kick		= stm32_rproc_kick,
> 
> Seems independent of the path.

I agree - on the flip side I didn't find a better place to put it.  Had I did a
one line patch someone would have asked me to stuff it somewhere.  I'll have
another look to see if I can find something decent.

> 
> >  	.parse_fw       = stm32_rproc_sync_parse_fw,
> >  	.find_loaded_rsc_table = stm32_rproc_sync_elf_find_loaded_rsc_table,
> >  };
> >  
> > +static struct rproc_sync_flags st_sync_flags = {
> > +	.on_init = true, /* sync with MCU when the kernel boots */
> > +	.after_stop = false, /* don't resync with MCU if stopped from sysfs */
> > +	.after_crash = false, /* don't resync with MCU after a crash */
> > +};
> > +
> could be const

If I do make this a const I'll have to move the call to
rproc_set_state_machine() inside the "if (state == M4_STATE_CRUN)".  It also
means that people won't be able to make dynamic adjustment to the
synchronisation states based on specifics discovered at probe() time.  They will
need to declare different synchronisation ops for all the potential scenarios.

I don't have a strong opinion on any of this.  I'll wait a little to see what
other people think.  If nobody chimes in I'll make this a const in the next
revision.

> 
> >  static const struct of_device_id stm32_rproc_match[] = {
> >  	{ .compatible = "st,stm32mp1-m4" },
> >  	{},
> > @@ -803,6 +810,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >  	struct stm32_rproc *ddata;
> >  	struct device_node *np = dev->of_node;
> >  	struct rproc *rproc;
> > +	struct rproc_sync_flags sync_flags = {0};
> >  	unsigned int state;
> >  	bool auto_boot = false;
> >  	int ret;
> > @@ -837,11 +845,17 @@ static int stm32_rproc_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	if (state == M4_STATE_CRUN) {
> > +		auto_boot = true;
> > +		sync_flags = st_sync_flags;
> 
> seems an useless copy 
> 
> Regards,
> Arnaud
> 
> >  		ret = stm32_rproc_get_loaded_rsc_table(pdev, ddata);
> >  		if (ret)
> >  			goto free_rproc;
> >  	}
> >  
> > +	ret = rproc_set_state_machine(rproc, &st_rproc_sync_ops, sync_flags);
> > +	if (ret)
> > +		goto free_rproc;
> > +
> >  	rproc->auto_boot = auto_boot;
> >  	rproc->has_iommu = false;
> >  	ddata->workqueue = create_workqueue(dev_name(dev));
> > 
