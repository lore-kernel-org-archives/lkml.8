Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C38C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC592083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBXj5dIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgIDWHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgIDWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:07:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425BC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 15:07:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o68so5349711pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIzoHfPgxd+3E/DnNS9bx5RxUwh7cFyQWpb2ORZV+Iw=;
        b=pBXj5dIPqoIuLqV8ZfCAnIMNXzJz75fcVCuvJ4Xxo8wUSAhtNWkliCO2LU9wBAq1t/
         JFKl82sjWryUGnKvmJO3cGTPUULA/XD6CxEYxhPoho0I/q/ZLEpFlgDd75KxZv2IaCkk
         n8oQPyZnsxNpKO5PQSZusjUeUdHEIe8f9WXbI8SKFIkk7giplpPKPkcrWL+8E4In56Ry
         4R/eLoqFalD93Z7lxsCvLAVs4LAYm07dF/aH8nMsf7ZzwFjZFHQ8SpQxEPfl2JPRea6o
         rkBxprfXAL1vdo52d4zAQlcVFCgeREZ1Pd4/i/TfDiR7EDA5PVbsVUcGO1G/zShF0p/O
         6syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIzoHfPgxd+3E/DnNS9bx5RxUwh7cFyQWpb2ORZV+Iw=;
        b=FsTB+rx44YoEHroZJWZU3JkNkqY95o+YyV2hsqS9brNCuVArgEduLrB/L/SA8XetCu
         ngkMmQHs6s4t7z1hdhV2Zdzca8BTGrGHdJdFW4ZWPEcH7spnL6ODtwboaEfz90QNxa1O
         JFvpfj5zAnr64Yh3bFNxGJ/C4euKWBzCOmobTkOk4Rp0i4GqPFYJYuigJ4/SSK6SEJMf
         GfH+DUpEexyxMx/nP/x+sElIla9+iSs48oKGVRil4tKYXwwKUYK1bE5B2bNRIOb8WmmS
         PFbWr2m5bcbaB+kU1dvk0VLa35/oMaFbSVNVpIRbtF+2etjz3oAxjZYD2dpLZYuSO204
         LweQ==
X-Gm-Message-State: AOAM532j/FYRJxF1ojjVZqB7eTWA5HSEr/Th1dX1iG7bC4BU/MLFkV1v
        8mGDZiJmCKp+ejC80XES65b+Gw==
X-Google-Smtp-Source: ABdhPJzQW6QZjh3PAJh1kfGFsBu+aUQhZ7m+Fx2JVo9u4LHuSUPmXUZpmcBqdsco0MD61PR8KKegLg==
X-Received: by 2002:a62:e40a:0:b029:138:8fd6:7fd5 with SMTP id r10-20020a62e40a0000b02901388fd67fd5mr8899132pfh.1.1599257235357;
        Fri, 04 Sep 2020 15:07:15 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x4sm7653757pfm.86.2020.09.04.15.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 15:07:14 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:07:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v3 1/3] remoteproc: Expose remoteproc configuration
 through sysfs
Message-ID: <20200904220712.GB404035@xps15>
References: <1599174226-2307-1-git-send-email-rishabhb@codeaurora.org>
 <1599174226-2307-2-git-send-email-rishabhb@codeaurora.org>
 <20200904000454.GD3715@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904000454.GD3715@yoga>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 07:04:54PM -0500, Bjorn Andersson wrote:
> On Thu 03 Sep 18:03 CDT 2020, Rishabh Bhatnagar wrote:
> 
> > Add a feature flag to expose some of the remoteproc configuration
> > through sysfs. This feature is helpful in systems where debugfs is
> > not available/mounted. Currently the recovery and coredump
> > configuration is exposed through sysfs rather than debugfs when
> > this feature is selected.
> > 
> 
> This commit message gives me the feeling that it's about making a
> selection between debugfs vs sysfs. But the patches moves the code from
> debugfs to sysfs and then hide it behind this config option.

Yeah, that description is broken.  Probably a copy/paste from V2.

> 
> That said, I just commented on v2 questioning that this should be a
> compile time option at all - might be useful for some drivers to
> dynamically "hide" these sysfs attributes though.

Dynamically hinding those would require intelligence from platform drivers, the
same kind that could have use the API to manipulate the coredump mode.  That
would have been very easy without the need to move anything from debufs.  But
from what Rishab said his problem is at compile time.

Thanks,
Mathieu

> 
> Regards,
> Bjorn
> 
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > ---
> >  drivers/remoteproc/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index c6659dfe..98d52cbe 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -275,6 +275,17 @@ config TI_K3_DSP_REMOTEPROC
> >  	  It's safe to say N here if you're not interested in utilizing
> >  	  the DSP slave processors.
> >  
> > +config RPROC_SYSFS_CONFIGURATION_SUPPORT
> > +	bool "Expose remoteproc configuration sysfs entries"
> > +	default y
> > +	help
> > +	  Say y here to expose recovery and coredump configuration sysfs
> > +	  entries. This is helpful in operating systems where debugfs is
> > +	  not available/mounted.
> > +
> > +	  It's safe to say N here if you are not interested in accessing
> > +	  recovery and coredump configuration through sysfs.
> > +
> >  endif # REMOTEPROC
> >  
> >  endmenu
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
