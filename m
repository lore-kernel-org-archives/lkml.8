Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA32C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8305F207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stzkNDaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgIIQTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbgIIQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:15:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EECBC061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:15:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so2570509pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oY8i8zDBnk0gKRnuxDGT2YiT6nqinwVfpiV/RQrvGWs=;
        b=stzkNDaVyhJCHKQmG7jR2O5DxAT3JhXv3Q6LGkHxCHBrg+IvTNsmlpxt7B1Za2Vln7
         JQSsQ/uisoUXYwSKhvPpqXxtGJROw6RpuMfWWY4/gShEZwdEEknHqsMX4tl/HvOJ7dzQ
         AKlGp8HLcB8YfeY7RlIfQUTY1BMAfl4c7NYxizDlflT9gfDuKOH0yJScDzH2Ae3va3+4
         qUB2xxbWq5xewl+7OsPjZr9DeKNi0IJA6OZ9zkSLxzpVybrafSpBQMg7dKKbpElYPWWq
         bvOH+XjwYnPkX+MxghvOF+Z+kFXPrfWyZnSag7/sNxCIfkuAcRH7muKw76ORDMVdkYhi
         OYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oY8i8zDBnk0gKRnuxDGT2YiT6nqinwVfpiV/RQrvGWs=;
        b=XPSEgfwHn+isDFTivXD5bOuKwb4q2AfI9Wya1kAqtUiFcVpQt3zd147PpCA8aQ/1tF
         /XxcKlssfheNtfdjV3NpcWsXJNO8bqqMCipPM6Psc+cg1NoQgKewfuMZ+Edc4EEI8T+r
         TUwPNam2ak96juqZ+fpjy6AIMWwUZ9LIvDNpyHxwJ8SBDtLovx2rRN78uWTJBD1i8I3V
         bNd/nTVhRJEkk3GAAOMiqOxHELwY/KYRsLlgQkeyVUK5N23DfrirRw0XgA9K4qdJqY/9
         s3aNupq8ZyNRbc5nXmkxJcWKyIR0/kyxrAiqw5RehoYa323ohN3EBBGMRNrPQDOCA/XD
         UnVw==
X-Gm-Message-State: AOAM530NX0UvpldB5253f/oAkdQZr9Ui5fyLC27jYvwanRGVNOCEr+t3
        arlfB+kcr0fWoeEhXrozvwC/9A==
X-Google-Smtp-Source: ABdhPJzut6xo3S3CXtU88zGtMAjgEL23PD4NB6Sd4V4IL9r6CGSyHYS/ucSCmHf+At+JaIMXxbVklA==
X-Received: by 2002:a17:902:7298:b029:d0:cbe1:e74c with SMTP id d24-20020a1709027298b02900d0cbe1e74cmr1697938pll.39.1599668126381;
        Wed, 09 Sep 2020 09:15:26 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y5sm2947356pge.62.2020.09.09.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:15:25 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:15:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        tsoni <tsoni@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v9 00/24] coresight: allow to build coresight as modules
Message-ID: <20200909161523.GA553266@xps15>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
 <CANLsYkwhypfEkmhg=wK+_F6TxxGiuoSqpgGR0REqsOqC-X-3mg@mail.gmail.com>
 <0101017470c9475d-00e296fc-1173-4afa-95cb-22ac70d85d5b-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101017470c9475d-00e296fc-1173-4afa-95cb-22ac70d85d5b-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 02:54:33AM +0000, Tingwei Zhang wrote:
> On Wed, Sep 09, 2020 at 01:53:51AM +0800, Mathieu Poirier wrote:
> > Hi Tingwei,
> > 
> > Apologies for the untimely response to this set, I am hoping to get to
> > it in the next two weeks.
> >
> 
> It's fine, Mathieu. Please let me know your comments once you have time.
> I'm targeting to get these set merged in 5.10 Kernel.

From the above it is not clear if you want this set to be _in_ the 5.10 cycle
or added to my list _during_ the 5.10 cycle, which would make it part of the
5.11 cycle.  In any case the latter seems more realistic. 

>  
> > Thanks,
> > Mathieu
> > 
> > On Wed, 19 Aug 2020 at 23:47, Tingwei Zhang <tingwei@codeaurora.org>
> > wrote:
> > >
> > > Allow to build coresight as modules. This gives developers the
> > feasibility to
> > > test their code without reboot.
> > >
> > > This series is based on below two series.
> > >
> > >  - "coresight: allow to build components as modules"
> > >    https://lkml.org/lkml/2018/6/5/989
> > >  - "coresight: make drivers modular"
> > >    https://lkml.org/lkml/2020/1/17/468
> > >
> > > Change from v8:
> > > Protect etmdrvdata[] by modifying it on relevant CPU  (Mathieu and
> > Suzuki)
> > > Grab the device before allocating memory for the node (Mathieu)
> > > Add author of coresight core driver (Mathieu)
> > >
> > > Change from v7:
> > > Depends on below change for ETM hotplug (Sai)
> > >
> > https://lore.kernel.org/linux-arm-kernel/20200729051310.18436-1-saiprakash
> > .ranjan@codeaurora.org/
> > > Add mutex lock to protect etmdrvdata[] (Suzuki)
> > > Add helper function coresight_get_ref() (Suzuki)
> > > Reorg replicator and funnel change. Use two patches to support these
> > > two drivers. (Suzuki)
> > > Add fix tag to "coresight: etm: perf: Fix warning caused by
> > etm_setup_aux
> > > failure" (Suzuki)
> > > Update author of "coresight: cti: Fix bug clearing sysfs links on
> > callback"
> > >
> > > Change from v6:
> > > Correct module description for CATU (Mike)
> > > Check ect_ret equals 0 and set ect_enabled flag (Mike)
> > > Add Tested-by and Reviewed-by from Mike
> > >
> > > Change from v5:
> > > Add below CTI clean up change from Mike into series
> > >  -https://lists.linaro.org/pipermail/coresight/2020-July/004349.html
> > > Increase module reference count when enabling CTI device (Mike)
> > >
> > > Change from v4:
> > > Fix error handling in coresight_grab_devicei() (Greg)
> > > Add coresight: cti: Fix remove sysfs link error from Mike
> > >  -https://lists.linaro.org/pipermail/coresight/2020-July/004275.html
> > > Move cti_remove_conn_xrefs() into cti_remove() (Mike)
> > > Align patch subject to coresight: <component>: <description> (Mike)
> > >
> > > Change from v3:
> > > Rebase to coresight-next (Mike and Mathieu)
> > > Reorder try_get_module() (Suzuki)
> > > Clean up etmdrvdata[] in device remote path (Mike)
> > > Move cti_remove_conn_xrefs to cti_remove (Mike)
> > >
> > > Change from v2:
> > > Rebase to 5.8-rc5. Export coresight_add_sysfs_link and
> > > coresight_remove_sysfs_link
> > > Fix one cut and paste error on MODULE_DESCRIPTION of CTI
> > >
> > > Change from v1:
> > > Use try_module_get() to avoid module to be unloaded when device is used
> > > in active trace session. (Mathieu P)
> > >
> > > Change from above two series.
> > > This series adds the support to dynamically remove module when the
> > device in
> > > that module is enabled and used by some trace path. It disables all
> > trace
> > > paths with that device and release the trace path.
> > >
> > > Kim Phillips (8):
> > >   coresight: use IS_ENABLED for CONFIGs that may be modules
> > >   coresight: etm3x: allow etm3x to be built as a module
> > >   coresight: etm4x: allow etm4x to be built as a module
> > >   coresight: etb: allow etb to be built as a module
> > >   coresight: tpiu: allow tpiu to be built as a module
> > >   coresight: tmc: allow tmc to be built as a module
> > >   coresight: allow funnel driver to be built as module
> > >   coresight: allow replicator driver to be built as module
> > >
> > > Mian Yousaf Kaukab (2):
> > >   coresight: export global symbols
> > >   coresight: tmc-etr: add function to register catu ops
> > >
> > > Mike Leach (2):
> > >   coresight: cti: Fix remove sysfs link error
> > >   coresight: cti: Fix bug clearing sysfs links on callback
> > >
> > > Tingwei Zhang (12):
> > >   coresight: cpu_debug: add module name in Kconfig
> > >   coresight: cpu_debug: define MODULE_DEVICE_TABLE
> > >   coresight: add coresight prefix to barrier_pkt
> > >   coresight: add try_get_module() in coresight_grab_device()
> > >   coresight: stm: allow to build coresight-stm as a module
> > >   coresight: etm: perf: Fix warning caused by etm_setup_aux failure
> > >   coresight: cti: add function to register cti associate ops
> > >   coresight: cti: don't disable ect device if it's not enabled
> > >   coresight: cti: increase reference count when enabling cti
> > >   coresight: cti: allow cti to be built as a module
> > >   coresight: catu: allow catu drivers to be built as modules
> > >   coresight: allow the coresight core driver to be built as a module
> > >
> > >  drivers/hwtracing/coresight/Kconfig           |  54 ++++--
> > >  drivers/hwtracing/coresight/Makefile          |  22 +--
> > >  drivers/hwtracing/coresight/coresight-catu.c  |  37 ++++-
> > >  drivers/hwtracing/coresight/coresight-catu.h  |   2 -
> > >  .../{coresight.c => coresight-core.c}         | 154 +++++++++++++++---
> > >  .../hwtracing/coresight/coresight-cpu-debug.c |   2 +
> > >  .../{coresight-cti.c => coresight-cti-core.c} |  63 ++++++-
> > >  drivers/hwtracing/coresight/coresight-etb10.c |  28 +++-
> > >  .../hwtracing/coresight/coresight-etm-perf.c  |  13 +-
> > >  .../hwtracing/coresight/coresight-etm-perf.h  |   5 +-
> > >  ...resight-etm3x.c => coresight-etm3x-core.c} |  28 +++-
> > >  ...resight-etm4x.c => coresight-etm4x-core.c} |  84 +++++++---
> > >  .../hwtracing/coresight/coresight-funnel.c    |  64 +++++++-
> > >  .../hwtracing/coresight/coresight-platform.c  |   1 +
> > >  drivers/hwtracing/coresight/coresight-priv.h  |  24 ++-
> > >  .../coresight/coresight-replicator.c          |  65 +++++++-
> > >  drivers/hwtracing/coresight/coresight-stm.c   |  20 ++-
> > >  drivers/hwtracing/coresight/coresight-sysfs.c |   2 +
> > >  .../{coresight-tmc.c => coresight-tmc-core.c} |  25 ++-
> > >  .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
> > >  .../hwtracing/coresight/coresight-tmc-etr.c   |  21 ++-
> > >  drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
> > >  drivers/hwtracing/coresight/coresight-tpiu.c  |  20 ++-
> > >  include/linux/coresight.h                     |   3 +-
> > >  24 files changed, 634 insertions(+), 108 deletions(-)
> > >  rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c}
> > (92%)
> > >  rename drivers/hwtracing/coresight/{coresight-cti.c =>
> > coresight-cti-core.c} (94%)
> > >  rename drivers/hwtracing/coresight/{coresight-etm3x.c =>
> > coresight-etm3x-core.c} (97%)
> > >  rename drivers/hwtracing/coresight/{coresight-etm4x.c =>
> > coresight-etm4x-core.c} (96%)
> > >  rename drivers/hwtracing/coresight/{coresight-tmc.c =>
> > coresight-tmc-core.c} (95%)
> > >
> > > --
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum,
> > > a Linux Foundation Collaborative Project
> > >
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
