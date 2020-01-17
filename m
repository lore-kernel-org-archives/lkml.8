Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79376C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4628E21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDBUm8PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgAQWwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:52:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46967 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgAQWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:52:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so12323839pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YsipyYbr71+9e31r8uuk3JQ+6WQjuC8y1wrt6WH8ZeI=;
        b=CDBUm8PAA4YTMmam7hHsPI026QKv6W3mlIOr2PTSmF7XeIhpRt3/LB6fmZHXT5a6Vm
         f0V6aM/9vCtJDdv6N3kd7u9MimLqE4dVVAnWp4CE1M0yAxAuGQpCem7ARlGO8yQ4iY/a
         PSKA96/80RRow8maqI00AU9BbAaSKfaKwYjbuxGVMLRNkjeRptLPPPKLhudAL6dcJBDL
         vbVy6+u1W6/VORHMMc8VFYqhcK4Cd1Pe+8c0c/ewkXHFwwMIyz8DCeau+yB/svGWYRhF
         a02BjidRl4Z+40KiIf15OdnY7/BIi++gP6Yck30Qp18JY0oJ6ewy8k8HZrm6wyqnfUcv
         vnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YsipyYbr71+9e31r8uuk3JQ+6WQjuC8y1wrt6WH8ZeI=;
        b=Rc0kNi2Ql5SdTP6ALmtSmvnNTPBAt/wqdSxT4KkwBhVzuZby3grssLT+154/2GccXu
         VIL9b4fxqO5kzCK+XxiVIXxSQOd35o+yOBtk987XQFgxYtH4zp0Hx6+JVvuY7zxFQZ2X
         8TWue6pFx0pkB6UVBxqCdjUODi0fGK7pOz3mLNfwBxvJzUc7og+aAo3yMB22nxKvJLjl
         oFicb45uFwpJehfvA56nKz21nadukJSPwnBcmuOpVwuAg+o6JS+ncWHjrJ5a+cc855J9
         8tZEVVraGyJSyqo7qHh8ASpXAbKW3Mr3IRyx+Sgo1dqB4KowIV/ot27Ug4S5AsF+Fup8
         gPjw==
X-Gm-Message-State: APjAAAV9MZ3MEMjZ2gSvzX+ElpISTYwCSnn79K7Oh8RiCMK9qXyWNxNx
        ev5iXYYLmyEemxEVHlC5UVvWQg==
X-Google-Smtp-Source: APXvYqzGs+gkpKD2iIPDGV5FgCTt6txDmtAj7/ikKdL7oiZKBsLYzx8QAV15xrKhXA7ZXRTh5YUNyg==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr5390132pfi.131.1579301540092;
        Fri, 17 Jan 2020 14:52:20 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n188sm29570370pga.84.2020.01.17.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:52:19 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:52:17 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     =?iso-8859-1?Q?Cl=E9ment?= Leger <cleger@kalray.eu>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
Message-ID: <20200117225217.GA27535@xps15>
References: <20200115102142.11229-1-cleger@kalray.eu>
 <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
 <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
 <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com>
 <612100872.12377996.1579101063237.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <612100872.12377996.1579101063237.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

On Wed, Jan 15, 2020 at 04:11:03PM +0100, Clément Leger wrote:
> 
> 
> ----- On 15 Jan, 2020, at 16:09, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
> 
> > On 1/15/20 3:28 PM, Clément Leger wrote:
> >> Hi Arnaud,
> >> 
> >> ----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
> >> 
> >>> Hi Clément,
> >>>
> >>> On 1/15/20 11:21 AM, Clement Leger wrote:
> >>>> In order to support preallocated notify ids, if their value is
> >>>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
> >>>> dynamically but try to allocate the requested one. This is useful when
> >>>> using custom ids to bind them to custom vendor resources. For instance,
> >>>> it allow to assign a group of queues to a specific interrupti in order
> >>>> to dispatch notifications.
> >>>>
> >>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
> >>>> ---
> >>>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
> >>>>  include/linux/remoteproc.h           |  1 +
> >>>>  2 files changed, 20 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/remoteproc/remoteproc_core.c
> >>>> b/drivers/remoteproc/remoteproc_core.c
> >>>> index 307df98347ba..b1485fcd0f11 100644
> >>>> --- a/drivers/remoteproc/remoteproc_core.c
> >>>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
> >>>>  	/*
> >>>>  	 * Assign an rproc-wide unique index for this vring
> >>>>  	 * TODO: assign a notifyid for rvdev updates as well
> >>>> -	 * TODO: support predefined notifyids (via resource table)
> >>>>  	 */
> >>>> -	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
> >>>> -	if (ret < 0) {
> >>>> -		dev_err(dev, "idr_alloc failed: %d\n", ret);
> >>>> -		return ret;
> >>>> +	if (rsc->vring[i].notifyid == FW_RSC_NOTIFY_ID_ANY) {
> >>>> +		ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
> >>>> +		if (ret < 0) {
> >>>> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
> >>>> +			return ret;
> >>>> +		}
> >>>> +		notifyid = ret;
> >>>> +
> >>>> +		/* Let the rproc know the notifyid of this vring.*/
> >>>> +		rsc->vring[i].notifyid = notifyid;
> >>>> +	} else {
> >>>> +		/* Reserve requested notify_id */
> >>>> +		notifyid = rsc->vring[i].notifyid;
> >>>> +		ret = idr_alloc(&rproc->notifyids, rvring, notifyid,
> >>>> +				notifyid + 1, GFP_KERNEL);
> >>>> +		if (ret < 0) {
> >>>> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
> >>>> +			return ret;
> >>>> +		}
> >>>>  	}
> >>>> -	notifyid = ret;
> >>>>  
> >>>>  	/* Potentially bump max_notifyid */
> >>>>  	if (notifyid > rproc->max_notifyid)
> >>>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
> >>>>  
> >>>>  	rvring->notifyid = notifyid;
> >>>>  
> >>>> -	/* Let the rproc know the notifyid of this vring.*/
> >>>> -	rsc->vring[i].notifyid = notifyid;
> >>>>  	return 0;
> >>>>  }
> >>> The rproc_free_vring function resets the notifyid to -1 on free.
> >>> This could generate a side effect if the resource table is not reloaded.
> >> 
> >> Oh indeed, I did not thought of that. What would you recommend ?
> >> If using -1 in free vring, notify ids will be reallocated at next
> >> round.
> > Regarding the code i'm not sure that it is useful to reset the notifyID to -1 on
> > free.

I'm not sure setting notifyid to -1 in rproc_free_vring() is such a big problem.
No matter the code path I look at, if rproc_free_vring() is called something
serious has happened and the resource table will be reloaded if another attempt
at booting the remote processor is done.  It can also be that a graceful
shutdown is underway, in which case the resource table will be reloaded anyway
if/when the slave is brought back in service.

Let me know if I'm missing a scenario.

To me the real problem is if a FW image has set the notifyids in the resource
table to 0xffffffff, thinking they will be overwritten.  In that case things
will really south. 

> > In current version, on alloc, the notifyID is overwriten without check.
> > And as vdev status is updated, vring struct in resource table should be
> > considered as invalid
> > Except if i missed a usecase/race condition...
> > 
> >> 
> >> I was also worried that it would break some existing user applications
> >> which uses "0" as a notify id in vring but expect the id to be
> >> allocated dynamically. With my modification, it means it will try to
> >> use "0" as a predefined id, leading to allocation failure.

From my point of view they will have been lucky for all this time.  Even with
a new version of the resource table (which I think is the right way go)
cases like this will break.

Thanks,
Mathieu

> >> 
> > Yes this could introduce regression for firmware that sets 0 as default value.
> > Probably better to introduce this patch with a new version of the resource table
> > :)
> 
> Understood ;)
> 
> Regards,
> 
> Clément
> 
> > 
> > Regards
> > Arnaud
> >>>
> >>>>  
> >>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >>>> index 16ad66683ad0..dcae3394243e 100644
> >>>> --- a/include/linux/remoteproc.h
> >>>> +++ b/include/linux/remoteproc.h
> >>>> @@ -123,6 +123,7 @@ enum fw_resource_type {
> >>>>  };
> >>>>  
> >>>>  #define FW_RSC_ADDR_ANY (-1)
> >>>> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in
> >>>> rproc_free_vring
> >> 
> >> Indeed.
> >> 
> >> Thanks for your review.
> >> 
> >> Regards,
> >> 
> >> Clément
> >> 
> >>>
> >>> Regards,
> >>> Arnaud
> >>>>  
> >>>>  /**
> > >>>   * struct fw_rsc_carveout - physically contiguous memory request
