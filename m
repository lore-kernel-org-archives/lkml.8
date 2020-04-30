Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABADC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3746920731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/LUbAAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgD3Ttf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Ttf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:49:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245CC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:49:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s18so3353082pgl.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eVgbuol89Iq0veE3I85Gk84NyFRa8gOBSOw6m+GRCSg=;
        b=x/LUbAAMBI9EjfhEunVYObFNi0ilObBdHfFK9/9Y5x8kQ72e+7rk4hmGcWo23uxalQ
         oR+hheCz7Y9fkffCw8PJeHEjjQknHmVO0oeQlyBcP0esveORtxk/8mlHR5f9WUh+9dfH
         wl0CWP60y7fvrr5frOrebzPRYj8vOrbw85QPcl4mYo6l7Lp2ucpGmNVuPAqzotP8FZ4J
         MUpoIva+US8Kpxx3SNED8vA9DHbg8o4/JpjjD1wXT5x9MLzYfrEer/m3wC/ajwJXQIrU
         ocFIMjfD+eDvyvTdKsjCkAuUCLQgjgMJkCS8tUPC7vh5bI6kPnSLgkuXUx3FQTnyEJ8/
         TZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eVgbuol89Iq0veE3I85Gk84NyFRa8gOBSOw6m+GRCSg=;
        b=Czv8j6XvdC2yhd55iWNge4vswDGuCsmLnfDOKKkJ+dj3S4Ad7OSf250wHCRQP5FMcc
         Zilvh+v4eDxEiXQYtJX2Mqms1r6mhcH13acQQXKgZQTR0kzBjVlLLNoIhFDeA8jgX1Ka
         5EaDsrRU821cY9PuQQU+UCHWlRtjDwPF8kSfy6PJispFy2UD+qH3Y4KeAlNwCR5WoqrK
         JdO+lS1a/TFIztxptr1ISbY29SwcpddkHszaCraB5x6nQHGlSJWM39xFf5bqgEfTr/BT
         97ArpwkDO7Um/NbRk+3SKtiIts0fihvZYKuwQThgIaX/kuumUxHtA2TS4sJr7m2NfdQd
         1Mfg==
X-Gm-Message-State: AGi0Pua/OLK9P1OrcpieIvqL6FV4/mXlKgqvb0KVe4wJXDCBr/foKfeD
        y1OaGiPkU3gR3jJuJECux2q6Qg==
X-Google-Smtp-Source: APiQypI9zanAp40tlGa9iIJ5KTbKbr2YTHaLxGZRYxFJQ1lE4/d/8jwLCZytJiPDVXLWJjC8Nhu0tA==
X-Received: by 2002:a63:1d46:: with SMTP id d6mr624552pgm.236.1588276174377;
        Thu, 30 Apr 2020 12:49:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm517061pju.3.2020.04.30.12.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:49:33 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:49:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com, loic.pallardy@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] remoteproc: Add new operation and flags for
 synchronistation
Message-ID: <20200430194931.GB17031@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-4-mathieu.poirier@linaro.org>
 <7c5c8d5e-feb7-74ad-a2eb-1ccb8192b0ae@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5c8d5e-feb7-74ad-a2eb-1ccb8192b0ae@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 06:38:41PM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> > Add a new sync_ops to support use cases where the remoteproc
> > core is synchronising with the remote processor.  Exactly when to use
> > the synchronisation operations is directed by the flags in structure
> > rproc_sync_flags.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  include/linux/remoteproc.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index ac4082f12e8b..ceb3b2bba824 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -353,6 +353,23 @@ enum rsc_handling_status {
> >  	RSC_IGNORED	= 1,
> >  };
> >  
> > +/**
> > + * struct rproc_sync_flags - platform specific flags indicating which
> > + *			      rproc_ops to use at specific times during
> > + *			      the rproc lifecycle.
> > + * @on_init: true if synchronising with the remote processor at
> > + *	     initialisation time
> > + * @after_stop: true if synchronising with the remote processor after it was
> > + *		stopped from the cmmand line
> typo command
> > + * @after_crash: true if synchronising with the remote processor after
> > + *		 it has crashed
> > + */
> > +struct rproc_sync_flags {
> > +	bool on_init;
> > +	bool after_stop;
> > +	bool after_crash;
> > +};
> > +
> how about a bit field instead (just a proposition)?
> Platform driver would set the sync flag and rproc_set_sync_flag could be a 
> simple mask instead of a switch case.

I opted for a structure over bit fields because I thought it would be easier to
read/understand.  Both approaches are valid and I have to particular preference
other than, in my own view, a structure is easier to understand.  

I'll wait a little to see what other people think.  If nobody objects the next
revision will have bit fields.

> 
> Is it possible to split this patch in a different ways because difficult to understand as
> rproc_sync_flags seems not used before 
> [PATCH v3 09/14] remoteproc: Deal with synchronisation when crashing

Certainly

> 
> Thanks
> Arnaud  
> 
> >  /**
> >   * struct rproc_ops - platform-specific device handlers
> >   * @start:	power on the device and boot it
> > @@ -459,6 +476,9 @@ struct rproc_dump_segment {
> >   * @firmware: name of firmware file to be loaded
> >   * @priv: private data which belongs to the platform-specific rproc module
> >   * @ops: platform-specific start/stop rproc handlers
> > + * @sync_ops: platform-specific start/stop rproc handlers when
> > + *	      synchronising with a remote processor.
> > + * @sync_flags: Determine the rproc_ops to choose in specific states.
> >   * @dev: virtual device for refcounting and common remoteproc behavior
> >   * @power: refcount of users who need this rproc powered up
> >   * @state: state of the device
> > @@ -482,6 +502,7 @@ struct rproc_dump_segment {
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > + * @sync_with_rproc: true if currently synchronising with the rproc
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> >   */
> > @@ -492,6 +513,8 @@ struct rproc {
> >  	const char *firmware;
> >  	void *priv;
> >  	struct rproc_ops *ops;
> > +	struct rproc_ops *sync_ops;
> > +	struct rproc_sync_flags sync_flags;
> >  	struct device dev;
> >  	atomic_t power;
> >  	unsigned int state;
> > @@ -515,6 +538,7 @@ struct rproc {
> >  	size_t table_sz;
> >  	bool has_iommu;
> >  	bool auto_boot;
> > +	bool sync_with_rproc;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> >  	u8 elf_class;
> > 
