Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918EFC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F28206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4C/8Je6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgEEWKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:10:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED14C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 15:10:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so1613623pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+NhRWsLm2x5A30r1s+qBjiXMgEROv/YxDTJuQSoy+Y=;
        b=H4C/8Je6JGlahL9mfnwrlCwDUUwCyIWJbrttwPRwkAtgaROaMfI5vPy18zTDRdyE00
         qjQLnyChHmpeuRkV4tw578URIbKwbbVYjJaKEJ9R1mluxvyroz23cIZ2hz0DwJ1gEfDh
         gqOoxYVmJzbT7LM0ipWGU/PRbMUXfkonPLM1GOXZ6pelPMczpl/oS4cHmht22IVBUdqU
         jIpyH4lC4blb4Z5Y5KPQ2LcX1Wiv2sv5kfroCP3d38i3r0qmWg7nyOR1puW2ntb6tBrS
         iUrjwqMvjEF+nSQ813yA3rtdpWrSU72zHMRcw9GOm8+vpXER18tO/8mQNQWBSjhzAUXq
         Uquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+NhRWsLm2x5A30r1s+qBjiXMgEROv/YxDTJuQSoy+Y=;
        b=Fwgn6/+cFyYcWG55dJedd8Mf0yTFnaH4+QQK9N0qfG3JRUKMGdNCsaSCnx7LPIIJ15
         2ToKF+OGpIo1HmRbJBada5/yGyLovsf5uVSV3reLNa0sfZobtgvylVTQFsg/g7HAuWWn
         pfEJVFRP1+Hod5Dr4owBvCLXwz3U2p0ybCMsczuc5Mo9x1apU0F8ZDarLf0fp+Uz1P5g
         7vpqMPZ6QRctnGsYdn9c1ACDUUzXBFPbrtgeXaLGL8p0Vy/uJRk60cFscCkG7VOMVA82
         aSqQGAE6fc0DB4+LQRTK42y2sld81/pli3ieHWgq8SHBz2skSUMp0J2qJ+teihDEy6Pk
         mcTQ==
X-Gm-Message-State: AGi0PuZg2Uk3fTktIlyRFaSi0i/QfxND3WxrCW4fE4TceWt9LhLbh+mW
        KP7lF8shMagFISPD4X6Hy4M10A==
X-Google-Smtp-Source: APiQypKSwE5gLEiw1GKWGoeoiP/f2TNQCODhA/ksQA6kq3+8WbOjY6TgPPe4bbxzA3BCexdiRL6k9A==
X-Received: by 2002:a63:150:: with SMTP id 77mr4386172pgb.136.1588716649770;
        Tue, 05 May 2020 15:10:49 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f27sm97404pga.51.2020.05.05.15.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:10:49 -0700 (PDT)
Date:   Tue, 5 May 2020 16:10:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com, loic.pallardy@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/14] remoteproc: Call core functions based on
 synchronisation flag
Message-ID: <20200505221047.GC18333@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-9-mathieu.poirier@linaro.org>
 <a17d871a-3b3f-a462-9b2c-f9183f80a533@st.com>
 <20200430195749.GC17031@xps15>
 <6f85f227-e244-8136-b0f4-0b6ab167d852@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f85f227-e244-8136-b0f4-0b6ab167d852@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:14:59PM +0200, Arnaud POULIQUEN wrote:
> hi Mathieu,
> 
> On 4/30/20 9:57 PM, Mathieu Poirier wrote:
> > On Tue, Apr 28, 2020 at 07:27:27PM +0200, Arnaud POULIQUEN wrote:
> >>
> >>
> >> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> >>> Call the right core function based on whether we should synchronise
> >>> with a remote processor or boot it from scratch.
> >>>
> >>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> ---
> >>>  drivers/remoteproc/remoteproc_internal.h | 50 ++++++++++++++++++++++++
> >>>  1 file changed, 50 insertions(+)
> >>>
> >>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> >>> index dda7044c4b3e..3985c084b184 100644
> >>> --- a/drivers/remoteproc/remoteproc_internal.h
> >>> +++ b/drivers/remoteproc/remoteproc_internal.h
> >>> @@ -72,6 +72,12 @@ static inline bool rproc_needs_syncing(struct rproc *rproc)
> >>>  static inline
> >>>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->sanity_check)
> >>> +			return rproc->sync_ops->sanity_check(rproc, fw);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->sanity_check)
> >>>  		return rproc->ops->sanity_check(rproc, fw);
> >>
> >> Regarding this patch I'm trying to determine whether it makes sense to have ops or
> >> sync_ops set to null. Your[v3 01/14]  patch commit explains that ops can be null in case of
> >> synchronisation.
> >> But it seems deprecated with the sync_ops introduction...
> > 
> > Your comment made me go over the logic again...  If rproc_needs_syncing() is
> > true then we necessarily have a sync_ops.  If rproc_needs_syncing() is false,
> > there too we automatically have an ops.  As such and as you point out, checking
> > for rproc->sync_ops and rproc-ops is probably useless.
> An Additional test in rproc_set_state_machine should be sufficient, something like that: 
>  /* rproc->ops struct is mandatory if at least one sync flag is false */
>  if (!rproc->ops && !(sync_flags.on_init &&
> 	    sync_flags.after_stop && sync_flags.after_crash))
> 		return -EINVAL;

Right, something like that. 

> 
> > 
> >>
> >> And if sync_ops is null, is it still necessary to define a remoteproc device?
> > 
> > Not sure I understand your point here but with the reasonning from above it
> > is probably moot anyway. 
> Just to mention that a platform device with ops and ops_sync null seems like nonsense 

We agree.

> 
> Regards,
> Arnaud
> > 
> >>
> >> Regards
> >> Arnad
> >>
> >>>  
> >>> @@ -81,6 +87,12 @@ int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> >>>  static inline
> >>>  u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->get_boot_addr)
> >>> +			return rproc->sync_ops->get_boot_addr(rproc, fw);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->get_boot_addr)
> >>>  		return rproc->ops->get_boot_addr(rproc, fw);
> >>>  
> >>> @@ -90,6 +102,12 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
> >>>  static inline
> >>>  int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->load)
> >>> +			return rproc->sync_ops->load(rproc, fw);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->load)
> >>>  		return rproc->ops->load(rproc, fw);
> >>>  
> >>> @@ -98,6 +116,12 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
> >>>  
> >>>  static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->parse_fw)
> >>> +			return rproc->sync_ops->parse_fw(rproc, fw);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->parse_fw)
> >>>  		return rproc->ops->parse_fw(rproc, fw);
> >>>  
> >>> @@ -108,6 +132,13 @@ static inline
> >>>  int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
> >>>  		     int avail)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->handle_rsc)
> >>> +			return rproc->sync_ops->handle_rsc(rproc, rsc_type,
> >>> +							   rsc, offset, avail);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->handle_rsc)
> >>>  		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
> >>>  					      avail);
> >>> @@ -119,6 +150,13 @@ static inline
> >>>  struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
> >>>  						   const struct firmware *fw)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->find_loaded_rsc_table)
> >>> +			return rproc->sync_ops->find_loaded_rsc_table(rproc,
> >>> +								      fw);
> >>> +		return NULL;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->find_loaded_rsc_table)
> >>>  		return rproc->ops->find_loaded_rsc_table(rproc, fw);
> >>>  
> >>> @@ -127,6 +165,12 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
> >>>  
> >>>  static inline int rproc_start_device(struct rproc *rproc)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->start)
> >>> +			return rproc->sync_ops->start(rproc);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->start)
> >>>  		return rproc->ops->start(rproc);
> >>>  
> >>> @@ -135,6 +179,12 @@ static inline int rproc_start_device(struct rproc *rproc)
> >>>  
> >>>  static inline int rproc_stop_device(struct rproc *rproc)
> >>>  {
> >>> +	if (rproc_needs_syncing(rproc)) {
> >>> +		if (rproc->sync_ops && rproc->sync_ops->stop)
> >>> +			return rproc->sync_ops->stop(rproc);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>  	if (rproc->ops && rproc->ops->stop)
> >>>  		return rproc->ops->stop(rproc);
> >>>  
> >>>
