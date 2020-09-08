Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17DE206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSZftN7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgIHRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbgIHRyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:54:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22978C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:54:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so278905iow.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNthzVzIYmOCtfH4z/pcKeF29sydM0wgwPFHhuTXXMk=;
        b=bSZftN7p6bmjiLd8ObGYCQG9JPQ8oFsjuGwE1HXkLTzIqLH4SYu+PdtJqi9DX+IH23
         T1AAtV4UNMRiQrm57b4AModkmKUxqSxE1ILRpC7KPbvXkBsAJhfSqL6v0aOJjnLS1WS1
         czdrC9sokYVbKjHFOew2VECePyAIJkJ/06FteWe6k03cQaVtrH0QwI0dJghxsgICcLvD
         XDUqs6nVNHdPzvj80HO+YWQ1MKxjPVQWdrvC9ZzczjRNnhrqDsfuvzZJL2exXi3279cz
         r79EIghTG0E/fS3FdDzWYEOXD2f95ron5mskBILKdg2cQXYXfISdmyDUnmaAgJKIAece
         zR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNthzVzIYmOCtfH4z/pcKeF29sydM0wgwPFHhuTXXMk=;
        b=nkFflRSlnui2fcyxgr0KPukQ6KoTHQczjb5Z9jyChuxaQHfh56/R49RK3KdKhryBfS
         QPb2IdDkioLOCAobwcMZmNq0jI+kfDSEq6XOxAzFscG64ItPKlqqm/W451xumd6jMAXA
         SKQxC51pr/dfWiDZhpznJc0L5r0oqYOc4vJ2/z5cm1gQCNXjW68klfwRYUEN2F75dKAm
         PJ8PRzOfzdLa8L+KLoxV9InFcsUkB4PQVOkX3kkf6bqutTBmv/1kpTPVX8s35AiA2o3X
         ULu80NnbK4VnxzgQUWPAth6QgDnk9iscR5m32koU1fnM35dBgXysoJh8AHtGJKl0aOcz
         JwQA==
X-Gm-Message-State: AOAM530j5K5Bk6AXoj8vO5JF+TmRhR1U3dkHNOe7AkSJcsqhNly6BMjf
        RPR2FvzjW6RSIi47QC61+T/Cvv50vWDeO+VZYQRtlg==
X-Google-Smtp-Source: ABdhPJxmqm53V46wAgLNnPDatkKyz0eWBKvKAUPzuIsiHXK3CqvHH48lmAKntfKsj3Hzg1iFDzHUJeiY3/C3Yl+CGMg=
X-Received: by 2002:a02:8805:: with SMTP id r5mr137519jai.52.1599587642348;
 Tue, 08 Sep 2020 10:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200820054718.20115-1-tingwei@codeaurora.org>
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 8 Sep 2020 11:53:51 -0600
Message-ID: <CANLsYkwhypfEkmhg=wK+_F6TxxGiuoSqpgGR0REqsOqC-X-3mg@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] coresight: allow to build coresight as modules
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        tsoni <tsoni@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tingwei,

Apologies for the untimely response to this set, I am hoping to get to
it in the next two weeks.

Thanks,
Mathieu

On Wed, 19 Aug 2020 at 23:47, Tingwei Zhang <tingwei@codeaurora.org> wrote:
>
> Allow to build coresight as modules. This gives developers the feasibility to
> test their code without reboot.
>
> This series is based on below two series.
>
>  - "coresight: allow to build components as modules"
>    https://lkml.org/lkml/2018/6/5/989
>  - "coresight: make drivers modular"
>    https://lkml.org/lkml/2020/1/17/468
>
> Change from v8:
> Protect etmdrvdata[] by modifying it on relevant CPU  (Mathieu and Suzuki)
> Grab the device before allocating memory for the node (Mathieu)
> Add author of coresight core driver (Mathieu)
>
> Change from v7:
> Depends on below change for ETM hotplug (Sai)
> https://lore.kernel.org/linux-arm-kernel/20200729051310.18436-1-saiprakash.ranjan@codeaurora.org/
> Add mutex lock to protect etmdrvdata[] (Suzuki)
> Add helper function coresight_get_ref() (Suzuki)
> Reorg replicator and funnel change. Use two patches to support these
> two drivers. (Suzuki)
> Add fix tag to "coresight: etm: perf: Fix warning caused by etm_setup_aux
> failure" (Suzuki)
> Update author of "coresight: cti: Fix bug clearing sysfs links on callback"
>
> Change from v6:
> Correct module description for CATU (Mike)
> Check ect_ret equals 0 and set ect_enabled flag (Mike)
> Add Tested-by and Reviewed-by from Mike
>
> Change from v5:
> Add below CTI clean up change from Mike into series
>  -https://lists.linaro.org/pipermail/coresight/2020-July/004349.html
> Increase module reference count when enabling CTI device (Mike)
>
> Change from v4:
> Fix error handling in coresight_grab_devicei() (Greg)
> Add coresight: cti: Fix remove sysfs link error from Mike
>  -https://lists.linaro.org/pipermail/coresight/2020-July/004275.html
> Move cti_remove_conn_xrefs() into cti_remove() (Mike)
> Align patch subject to coresight: <component>: <description> (Mike)
>
> Change from v3:
> Rebase to coresight-next (Mike and Mathieu)
> Reorder try_get_module() (Suzuki)
> Clean up etmdrvdata[] in device remote path (Mike)
> Move cti_remove_conn_xrefs to cti_remove (Mike)
>
> Change from v2:
> Rebase to 5.8-rc5. Export coresight_add_sysfs_link and
> coresight_remove_sysfs_link
> Fix one cut and paste error on MODULE_DESCRIPTION of CTI
>
> Change from v1:
> Use try_module_get() to avoid module to be unloaded when device is used
> in active trace session. (Mathieu P)
>
> Change from above two series.
> This series adds the support to dynamically remove module when the device in
> that module is enabled and used by some trace path. It disables all trace
> paths with that device and release the trace path.
>
> Kim Phillips (8):
>   coresight: use IS_ENABLED for CONFIGs that may be modules
>   coresight: etm3x: allow etm3x to be built as a module
>   coresight: etm4x: allow etm4x to be built as a module
>   coresight: etb: allow etb to be built as a module
>   coresight: tpiu: allow tpiu to be built as a module
>   coresight: tmc: allow tmc to be built as a module
>   coresight: allow funnel driver to be built as module
>   coresight: allow replicator driver to be built as module
>
> Mian Yousaf Kaukab (2):
>   coresight: export global symbols
>   coresight: tmc-etr: add function to register catu ops
>
> Mike Leach (2):
>   coresight: cti: Fix remove sysfs link error
>   coresight: cti: Fix bug clearing sysfs links on callback
>
> Tingwei Zhang (12):
>   coresight: cpu_debug: add module name in Kconfig
>   coresight: cpu_debug: define MODULE_DEVICE_TABLE
>   coresight: add coresight prefix to barrier_pkt
>   coresight: add try_get_module() in coresight_grab_device()
>   coresight: stm: allow to build coresight-stm as a module
>   coresight: etm: perf: Fix warning caused by etm_setup_aux failure
>   coresight: cti: add function to register cti associate ops
>   coresight: cti: don't disable ect device if it's not enabled
>   coresight: cti: increase reference count when enabling cti
>   coresight: cti: allow cti to be built as a module
>   coresight: catu: allow catu drivers to be built as modules
>   coresight: allow the coresight core driver to be built as a module
>
>  drivers/hwtracing/coresight/Kconfig           |  54 ++++--
>  drivers/hwtracing/coresight/Makefile          |  22 +--
>  drivers/hwtracing/coresight/coresight-catu.c  |  37 ++++-
>  drivers/hwtracing/coresight/coresight-catu.h  |   2 -
>  .../{coresight.c => coresight-core.c}         | 154 +++++++++++++++---
>  .../hwtracing/coresight/coresight-cpu-debug.c |   2 +
>  .../{coresight-cti.c => coresight-cti-core.c} |  63 ++++++-
>  drivers/hwtracing/coresight/coresight-etb10.c |  28 +++-
>  .../hwtracing/coresight/coresight-etm-perf.c  |  13 +-
>  .../hwtracing/coresight/coresight-etm-perf.h  |   5 +-
>  ...resight-etm3x.c => coresight-etm3x-core.c} |  28 +++-
>  ...resight-etm4x.c => coresight-etm4x-core.c} |  84 +++++++---
>  .../hwtracing/coresight/coresight-funnel.c    |  64 +++++++-
>  .../hwtracing/coresight/coresight-platform.c  |   1 +
>  drivers/hwtracing/coresight/coresight-priv.h  |  24 ++-
>  .../coresight/coresight-replicator.c          |  65 +++++++-
>  drivers/hwtracing/coresight/coresight-stm.c   |  20 ++-
>  drivers/hwtracing/coresight/coresight-sysfs.c |   2 +
>  .../{coresight-tmc.c => coresight-tmc-core.c} |  25 ++-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  21 ++-
>  drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  20 ++-
>  include/linux/coresight.h                     |   3 +-
>  24 files changed, 634 insertions(+), 108 deletions(-)
>  rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (92%)
>  rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (94%)
>  rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (97%)
>  rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (96%)
>  rename drivers/hwtracing/coresight/{coresight-tmc.c => coresight-tmc-core.c} (95%)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
