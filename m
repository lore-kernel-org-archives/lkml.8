Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45585C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38B820C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kx5XpKiC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Ucj/GoSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgIICyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:54:35 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:33482
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729413AbgIICye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599620073;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=DnhwCP229i87YO0gil1v2pIvlcOhMyrrC8CfVQwQDR8=;
        b=Kx5XpKiCusMSZtzC9gGbSkogIg1yN3tF4hqomZhFRBNY/hRhjq+0J470mebh+iid
        gKgoT4WPWIn4wj12Qna++ITKiPEPfCr7BmVwpu0vXQmTZoVNJ1IzUeJ7/b+wcP9Vybb
        GzYqtbJ2vhA0xKFv61nsuik0GGd1gHD+pjmbe7uI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599620073;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=DnhwCP229i87YO0gil1v2pIvlcOhMyrrC8CfVQwQDR8=;
        b=Ucj/GoSqN95RSDOvuhKhW9DUvqzw7WdZ7pHy+vrLAe2MnrlELtWKG1AVzq8/kUxR
        9VBjLspNzQ2ARK7lOdWa0DqKs3vzRvt+iQ0KlbxzzJ60pdmpeNBAa3fSCrBwVNg1YGu
        ryvdVniKUadTbUm/rkImZ4KFRC/qHCdSK/I2ZT8c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D688AC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Wed, 9 Sep 2020 02:54:33 +0000
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <0101017470c94718-f16cae71-8e87-47fb-92bf-f7169d9d584f-000000@us-west-2.amazonses.com>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
 <CANLsYkwhypfEkmhg=wK+_F6TxxGiuoSqpgGR0REqsOqC-X-3mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwhypfEkmhg=wK+_F6TxxGiuoSqpgGR0REqsOqC-X-3mg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.09-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 01:53:51AM +0800, Mathieu Poirier wrote:
> Hi Tingwei,
> 
> Apologies for the untimely response to this set, I am hoping to get to
> it in the next two weeks.
>

It's fine, Mathieu. Please let me know your comments once you have time.
I'm targeting to get these set merged in 5.10 Kernel.
 
> Thanks,
> Mathieu
> 
> On Wed, 19 Aug 2020 at 23:47, Tingwei Zhang <tingwei@codeaurora.org>
> wrote:
> >
> > Allow to build coresight as modules. This gives developers the
> feasibility to
> > test their code without reboot.
> >
> > This series is based on below two series.
> >
> >  - "coresight: allow to build components as modules"
> >    https://lkml.org/lkml/2018/6/5/989
> >  - "coresight: make drivers modular"
> >    https://lkml.org/lkml/2020/1/17/468
> >
> > Change from v8:
> > Protect etmdrvdata[] by modifying it on relevant CPU  (Mathieu and
> Suzuki)
> > Grab the device before allocating memory for the node (Mathieu)
> > Add author of coresight core driver (Mathieu)
> >
> > Change from v7:
> > Depends on below change for ETM hotplug (Sai)
> >
> https://lore.kernel.org/linux-arm-kernel/20200729051310.18436-1-saiprakash
> .ranjan@codeaurora.org/
> > Add mutex lock to protect etmdrvdata[] (Suzuki)
> > Add helper function coresight_get_ref() (Suzuki)
> > Reorg replicator and funnel change. Use two patches to support these
> > two drivers. (Suzuki)
> > Add fix tag to "coresight: etm: perf: Fix warning caused by
> etm_setup_aux
> > failure" (Suzuki)
> > Update author of "coresight: cti: Fix bug clearing sysfs links on
> callback"
> >
> > Change from v6:
> > Correct module description for CATU (Mike)
> > Check ect_ret equals 0 and set ect_enabled flag (Mike)
> > Add Tested-by and Reviewed-by from Mike
> >
> > Change from v5:
> > Add below CTI clean up change from Mike into series
> >  -https://lists.linaro.org/pipermail/coresight/2020-July/004349.html
> > Increase module reference count when enabling CTI device (Mike)
> >
> > Change from v4:
> > Fix error handling in coresight_grab_devicei() (Greg)
> > Add coresight: cti: Fix remove sysfs link error from Mike
> >  -https://lists.linaro.org/pipermail/coresight/2020-July/004275.html
> > Move cti_remove_conn_xrefs() into cti_remove() (Mike)
> > Align patch subject to coresight: <component>: <description> (Mike)
> >
> > Change from v3:
> > Rebase to coresight-next (Mike and Mathieu)
> > Reorder try_get_module() (Suzuki)
> > Clean up etmdrvdata[] in device remote path (Mike)
> > Move cti_remove_conn_xrefs to cti_remove (Mike)
> >
> > Change from v2:
> > Rebase to 5.8-rc5. Export coresight_add_sysfs_link and
> > coresight_remove_sysfs_link
> > Fix one cut and paste error on MODULE_DESCRIPTION of CTI
> >
> > Change from v1:
> > Use try_module_get() to avoid module to be unloaded when device is used
> > in active trace session. (Mathieu P)
> >
> > Change from above two series.
> > This series adds the support to dynamically remove module when the
> device in
> > that module is enabled and used by some trace path. It disables all
> trace
> > paths with that device and release the trace path.
> >
> > Kim Phillips (8):
> >   coresight: use IS_ENABLED for CONFIGs that may be modules
> >   coresight: etm3x: allow etm3x to be built as a module
> >   coresight: etm4x: allow etm4x to be built as a module
> >   coresight: etb: allow etb to be built as a module
> >   coresight: tpiu: allow tpiu to be built as a module
> >   coresight: tmc: allow tmc to be built as a module
> >   coresight: allow funnel driver to be built as module
> >   coresight: allow replicator driver to be built as module
> >
> > Mian Yousaf Kaukab (2):
> >   coresight: export global symbols
> >   coresight: tmc-etr: add function to register catu ops
> >
> > Mike Leach (2):
> >   coresight: cti: Fix remove sysfs link error
> >   coresight: cti: Fix bug clearing sysfs links on callback
> >
> > Tingwei Zhang (12):
> >   coresight: cpu_debug: add module name in Kconfig
> >   coresight: cpu_debug: define MODULE_DEVICE_TABLE
> >   coresight: add coresight prefix to barrier_pkt
> >   coresight: add try_get_module() in coresight_grab_device()
> >   coresight: stm: allow to build coresight-stm as a module
> >   coresight: etm: perf: Fix warning caused by etm_setup_aux failure
> >   coresight: cti: add function to register cti associate ops
> >   coresight: cti: don't disable ect device if it's not enabled
> >   coresight: cti: increase reference count when enabling cti
> >   coresight: cti: allow cti to be built as a module
> >   coresight: catu: allow catu drivers to be built as modules
> >   coresight: allow the coresight core driver to be built as a module
> >
> >  drivers/hwtracing/coresight/Kconfig           |  54 ++++--
> >  drivers/hwtracing/coresight/Makefile          |  22 +--
> >  drivers/hwtracing/coresight/coresight-catu.c  |  37 ++++-
> >  drivers/hwtracing/coresight/coresight-catu.h  |   2 -
> >  .../{coresight.c => coresight-core.c}         | 154 +++++++++++++++---
> >  .../hwtracing/coresight/coresight-cpu-debug.c |   2 +
> >  .../{coresight-cti.c => coresight-cti-core.c} |  63 ++++++-
> >  drivers/hwtracing/coresight/coresight-etb10.c |  28 +++-
> >  .../hwtracing/coresight/coresight-etm-perf.c  |  13 +-
> >  .../hwtracing/coresight/coresight-etm-perf.h  |   5 +-
> >  ...resight-etm3x.c => coresight-etm3x-core.c} |  28 +++-
> >  ...resight-etm4x.c => coresight-etm4x-core.c} |  84 +++++++---
> >  .../hwtracing/coresight/coresight-funnel.c    |  64 +++++++-
> >  .../hwtracing/coresight/coresight-platform.c  |   1 +
> >  drivers/hwtracing/coresight/coresight-priv.h  |  24 ++-
> >  .../coresight/coresight-replicator.c          |  65 +++++++-
> >  drivers/hwtracing/coresight/coresight-stm.c   |  20 ++-
> >  drivers/hwtracing/coresight/coresight-sysfs.c |   2 +
> >  .../{coresight-tmc.c => coresight-tmc-core.c} |  25 ++-
> >  .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
> >  .../hwtracing/coresight/coresight-tmc-etr.c   |  21 ++-
> >  drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
> >  drivers/hwtracing/coresight/coresight-tpiu.c  |  20 ++-
> >  include/linux/coresight.h                     |   3 +-
> >  24 files changed, 634 insertions(+), 108 deletions(-)
> >  rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c}
> (92%)
> >  rename drivers/hwtracing/coresight/{coresight-cti.c =>
> coresight-cti-core.c} (94%)
> >  rename drivers/hwtracing/coresight/{coresight-etm3x.c =>
> coresight-etm3x-core.c} (97%)
> >  rename drivers/hwtracing/coresight/{coresight-etm4x.c =>
> coresight-etm4x-core.c} (96%)
> >  rename drivers/hwtracing/coresight/{coresight-tmc.c =>
> coresight-tmc-core.c} (95%)
> >
> > --
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > a Linux Foundation Collaborative Project
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
