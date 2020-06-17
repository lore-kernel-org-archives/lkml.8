Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B095C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9292070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDt/Y9j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgFQJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:20:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:20:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t21so1330441edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Agm26BgUZufN+QkKwt7IsvkooYgPctBKqrcf8b6bbko=;
        b=jDt/Y9j5LHMVxKH1q+aNeXaqbm7wz0fCv+EkMuY3yw+nhcegVujxaNIykjJaoHpF+V
         PqjNeakc+H/RHIkmX5C1NlKcKuQMr/vFyvINkCyfhGenBw6X206WE2wELCzwXUlW1gDs
         8bggycIZ69WVlircx0yQq4fYSdLzN8Fd11a3aVsEjdJtTKsDEIkcqxtdgOIsTbbGz4QK
         J9UcyEJ0UA+u0UUfFgbu0BxvGMQY2nZjFyccyTU2Yw642oXNbzoHCe8HYfXE0luuf6Md
         VTiioLGbuppn+OEi3EmskpRi/nMKUELbRdECQ8IYgjBoV0fgWNk6NU8fVqfzH4y1ZE7P
         JNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Agm26BgUZufN+QkKwt7IsvkooYgPctBKqrcf8b6bbko=;
        b=kO6HaNiou2I5By2X0b4tYbMxpd73J6grW5GX63qURHFIdWHcN0ufTmzcTv5IVUJRHB
         FpnBP6oHlXLwODc+7ifmT+saacnXdnGq+PlBbLcR8YAmk94aHUXpNHU75wzB0HOaT0zF
         EGXESC/E4jQD8amtIs5Z4bf3C9dJlDRhZjV/H90Jhsmv/He6kbJxbW48hf0PiRMwaqlt
         jOA4Z7+O5rTJOMCsXMsYbX2tpJYBxGB90pqVaG5r85o0YqC9hwQRi27umGdZ5/aN8V+9
         MyVKcLH3tgQkubsNPS74hZTs80yZVvntWLZlf26hNK8Sr4BJSJXxdIKLsNB7zJziEzZW
         xjWg==
X-Gm-Message-State: AOAM5336qLMi8L8b9IqzdvY22bTsJhm5OFRg1gUP2+syTF42UbDZka7J
        GcJb8wHvCC14zy5z9io25EUYGJ4IFejIpRQ2Q7QXJQ==
X-Google-Smtp-Source: ABdhPJyszdNsgurmzPMemV4FISKUQZIr0r9LarcnGZepphSM1TyG7Yr9J2Vy30CCfCX8yV1XoHMFFHL4jrhPTo94Pww=
X-Received: by 2002:a50:f289:: with SMTP id f9mr6211039edm.188.1592385626139;
 Wed, 17 Jun 2020 02:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200612121047.GF4282@kadam>
In-Reply-To: <20200612121047.GF4282@kadam>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 17 Jun 2020 10:20:15 +0100
Message-ID: <CAJ9a7VjAnyoz+5y8xvYDPr8Mg3Hp-kTAOs4c_iwj+fqiiVs10w@mail.gmail.com>
Subject: Re: [kbuild] drivers/hwtracing/coresight/coresight-cti.c:862
 cti_probe() error: we previously assumed 'drvdata' could be null (see line 759)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the comprehensive review of this.

On Fri, 12 Jun 2020 at 14:47, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
>
> Hi Mike,
>
> Here is the buggy line:
>
>  861  err_out:
>  862    cti_pm_release(drvdata);
>                        ^^^^^^^
>

Yes - caling cti_pm_release() if drvdata == NULL would result in bad
things happening!

I would certainly be aiming to fix this, but as you have provided a
patch on another mail - I have reviewed and compiled that, so will
respond further there

Regards

Mike



> To me it's a red flag any time there is a label called "out:".  The
> label should say what is being released like "goto unregister_notifier;".
> The style of error handling here is called a "free everything function"
> and it is the most error prone style of error handling.
>
> A better way to write error handling is to track the most recently
> allocated resource and free it with a well named goto.
>
>         a = alloc();
>         if (!a)
>                 return -ENOMEM;
>
>         b = alloc();
>         if (!b) {
>                 ret = -ENOMEM;
>                 goto free_a;
>         }
>
>         c = alloc();
>         if (!c) {
>                 ret = -ENOMEM;
>                 goto free_b;
>
>         ...
>         return 0;
>
> free_b:
>         free(b);
> free_a:
>         free(a);
>
> The advantage of this is that 1) You only have to track the most recent
> allocation.  2)  You can easily verify that the most recent allocation
> is freed.  3)  Now you can create a free function by copy and pasting
> and adding a free(c);
>
> void my_free(struct whatever *p)
> {
>         free(c);
>         free(b);
>         free(a);
> }
>
> This style uses about the same number of lines of code because although
> we duplicate the free(b) and free(a), we can remove some if statements
> so it ends up being about the same.
>
> The main problem with free everything function is that they free things
> which have not been allocated.  I have added more explanation at the
> bottom of this bug report.
>
> I am also sending a patch which hopefully is clear but I can't actually
> compile it.  :(
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b791d1bdf9212d944d749a5c7ff6febdba241771
> commit: e9b880581d555c8f7b58c7d19cc3f8f9016a1b5f coresight: cti: Add CPU Hotplug handling to CTI driver
> config: arm-randconfig-m031-20200612 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/hwtracing/coresight/coresight-cti.c:862 cti_probe() error: we previously assumed 'drvdata' could be null (see line 759)
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9b880581d555c8f7b58c7d19cc3f8f9016a1b5f
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout e9b880581d555c8f7b58c7d19cc3f8f9016a1b5f
> vim +/drvdata +862 drivers/hwtracing/coresight/coresight-cti.c
>
> 835d722ba10ac92 Mike Leach 2020-03-20  747  static int cti_probe(struct amba_device *adev, const struct amba_id *id)
> 835d722ba10ac92 Mike Leach 2020-03-20  748  {
> 835d722ba10ac92 Mike Leach 2020-03-20  749      int ret = 0;
> 835d722ba10ac92 Mike Leach 2020-03-20  750      void __iomem *base;
> 835d722ba10ac92 Mike Leach 2020-03-20  751      struct device *dev = &adev->dev;
> 835d722ba10ac92 Mike Leach 2020-03-20  752      struct cti_drvdata *drvdata = NULL;
> 835d722ba10ac92 Mike Leach 2020-03-20  753      struct coresight_desc cti_desc;
> 835d722ba10ac92 Mike Leach 2020-03-20  754      struct coresight_platform_data *pdata = NULL;
> 835d722ba10ac92 Mike Leach 2020-03-20  755      struct resource *res = &adev->res;
> 835d722ba10ac92 Mike Leach 2020-03-20  756
> 835d722ba10ac92 Mike Leach 2020-03-20  757      /* driver data*/
> 835d722ba10ac92 Mike Leach 2020-03-20  758      drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> 835d722ba10ac92 Mike Leach 2020-03-20 @759      if (!drvdata) {
> 835d722ba10ac92 Mike Leach 2020-03-20  760              ret = -ENOMEM;
> 835d722ba10ac92 Mike Leach 2020-03-20  761              dev_info(dev, "%s, mem err\n", __func__);
>
> No need to print an error message for kmalloc() failures.  It already
> has a stack trace built in.
>
> 835d722ba10ac92 Mike Leach 2020-03-20  762              goto err_out;
>                                                         ^^^^^^^^^^^^
>
> 835d722ba10ac92 Mike Leach 2020-03-20  763      }
> 835d722ba10ac92 Mike Leach 2020-03-20  764
> 835d722ba10ac92 Mike Leach 2020-03-20  765      /* Validity for the resource is already checked by the AMBA core */
> 835d722ba10ac92 Mike Leach 2020-03-20  766      base = devm_ioremap_resource(dev, res);
> 835d722ba10ac92 Mike Leach 2020-03-20  767      if (IS_ERR(base)) {
> 835d722ba10ac92 Mike Leach 2020-03-20  768              ret = PTR_ERR(base);
> 835d722ba10ac92 Mike Leach 2020-03-20  769              dev_err(dev, "%s, remap err\n", __func__);
>
> At this point "drvdata->ctidev.cpu" is zero.
>
> 835d722ba10ac92 Mike Leach 2020-03-20  770              goto err_out;
> 835d722ba10ac92 Mike Leach 2020-03-20  771      }
> 835d722ba10ac92 Mike Leach 2020-03-20  772      drvdata->base = base;
> 835d722ba10ac92 Mike Leach 2020-03-20  773
> 835d722ba10ac92 Mike Leach 2020-03-20  774      dev_set_drvdata(dev, drvdata);
> 835d722ba10ac92 Mike Leach 2020-03-20  775
> 835d722ba10ac92 Mike Leach 2020-03-20  776      /* default CTI device info  */
> 835d722ba10ac92 Mike Leach 2020-03-20  777      drvdata->ctidev.cpu = -1;
>                                                 ^^^^^^^^^^^^^^^^^^^^^^^^
>
> 835d722ba10ac92 Mike Leach 2020-03-20  778      drvdata->ctidev.nr_trig_con = 0;
> 835d722ba10ac92 Mike Leach 2020-03-20  779      drvdata->ctidev.ctm_id = 0;
> 835d722ba10ac92 Mike Leach 2020-03-20  780      INIT_LIST_HEAD(&drvdata->ctidev.trig_cons);
> 835d722ba10ac92 Mike Leach 2020-03-20  781
> 835d722ba10ac92 Mike Leach 2020-03-20  782      spin_lock_init(&drvdata->spinlock);
> 835d722ba10ac92 Mike Leach 2020-03-20  783
> 835d722ba10ac92 Mike Leach 2020-03-20  784      /* initialise CTI driver config values */
> 835d722ba10ac92 Mike Leach 2020-03-20  785      cti_set_default_config(dev, drvdata);
> 835d722ba10ac92 Mike Leach 2020-03-20  786
> 835d722ba10ac92 Mike Leach 2020-03-20  787      pdata = coresight_cti_get_platform_data(dev);
>                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This function sets drvdata->ctidev.cpu on some success paths and also
> on certain failure paths.
>
> 835d722ba10ac92 Mike Leach 2020-03-20  788      if (IS_ERR(pdata)) {
> 835d722ba10ac92 Mike Leach 2020-03-20  789              dev_err(dev, "coresight_cti_get_platform_data err\n");
> 835d722ba10ac92 Mike Leach 2020-03-20  790              ret =  PTR_ERR(pdata);
> 835d722ba10ac92 Mike Leach 2020-03-20  791              goto err_out;
> 835d722ba10ac92 Mike Leach 2020-03-20  792      }
> 835d722ba10ac92 Mike Leach 2020-03-20  793
> 835d722ba10ac92 Mike Leach 2020-03-20  794      /* default to powered - could change on PM notifications */
> 835d722ba10ac92 Mike Leach 2020-03-20  795      drvdata->config.hw_powered = true;
> 835d722ba10ac92 Mike Leach 2020-03-20  796
> 835d722ba10ac92 Mike Leach 2020-03-20  797      /* set up device name - will depend if cpu bound or otherwise */
> 835d722ba10ac92 Mike Leach 2020-03-20  798      if (drvdata->ctidev.cpu >= 0)
> 835d722ba10ac92 Mike Leach 2020-03-20  799              cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
> 835d722ba10ac92 Mike Leach 2020-03-20  800                                             drvdata->ctidev.cpu);
> 835d722ba10ac92 Mike Leach 2020-03-20  801      else
> 835d722ba10ac92 Mike Leach 2020-03-20  802              cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
> 835d722ba10ac92 Mike Leach 2020-03-20  803      if (!cti_desc.name) {
> 835d722ba10ac92 Mike Leach 2020-03-20  804              ret = -ENOMEM;
> 835d722ba10ac92 Mike Leach 2020-03-20  805              goto err_out;
> 835d722ba10ac92 Mike Leach 2020-03-20  806      }
> 835d722ba10ac92 Mike Leach 2020-03-20  807
> e9b880581d555c8 Mike Leach 2020-05-18  808      /* setup CPU power management handling for CPU bound CTI devices. */
> e9b880581d555c8 Mike Leach 2020-05-18  809      if (drvdata->ctidev.cpu >= 0) {
> e9b880581d555c8 Mike Leach 2020-05-18  810              cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> e9b880581d555c8 Mike Leach 2020-05-18  811              if (!nr_cti_cpu++) {
>                                                              ^^^^^^^^^^^^
>
> e9b880581d555c8 Mike Leach 2020-05-18  812                      cpus_read_lock();
> e9b880581d555c8 Mike Leach 2020-05-18  813                      ret = cpuhp_setup_state_nocalls_cpuslocked(
> e9b880581d555c8 Mike Leach 2020-05-18  814                              CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
> e9b880581d555c8 Mike Leach 2020-05-18  815                              "arm/coresight_cti:starting",
> e9b880581d555c8 Mike Leach 2020-05-18  816                              cti_starting_cpu, cti_dying_cpu);
> e9b880581d555c8 Mike Leach 2020-05-18  817
> e9b880581d555c8 Mike Leach 2020-05-18  818                      cpus_read_unlock();
> e9b880581d555c8 Mike Leach 2020-05-18  819                      if (ret)
> e9b880581d555c8 Mike Leach 2020-05-18  820                              goto err_out;
> e9b880581d555c8 Mike Leach 2020-05-18  821              }
> e9b880581d555c8 Mike Leach 2020-05-18  822      }
> e9b880581d555c8 Mike Leach 2020-05-18  823
> 3c5597e398124e6 Mike Leach 2020-03-20  824      /* create dynamic attributes for connections */
> 3c5597e398124e6 Mike Leach 2020-03-20  825      ret = cti_create_cons_sysfs(dev, drvdata);
> 3c5597e398124e6 Mike Leach 2020-03-20  826      if (ret) {
> 3c5597e398124e6 Mike Leach 2020-03-20  827              dev_err(dev, "%s: create dynamic sysfs entries failed\n",
> 3c5597e398124e6 Mike Leach 2020-03-20  828                      cti_desc.name);
> 3c5597e398124e6 Mike Leach 2020-03-20  829              goto err_out;
> 3c5597e398124e6 Mike Leach 2020-03-20  830      }
> 3c5597e398124e6 Mike Leach 2020-03-20  831
> 835d722ba10ac92 Mike Leach 2020-03-20  832      /* set up coresight component description */
> 835d722ba10ac92 Mike Leach 2020-03-20  833      cti_desc.pdata = pdata;
> 835d722ba10ac92 Mike Leach 2020-03-20  834      cti_desc.type = CORESIGHT_DEV_TYPE_ECT;
> 835d722ba10ac92 Mike Leach 2020-03-20  835      cti_desc.subtype.ect_subtype = CORESIGHT_DEV_SUBTYPE_ECT_CTI;
> 835d722ba10ac92 Mike Leach 2020-03-20  836      cti_desc.ops = &cti_ops;
> 3c5597e398124e6 Mike Leach 2020-03-20  837      cti_desc.groups = drvdata->ctidev.con_groups;
> 835d722ba10ac92 Mike Leach 2020-03-20  838      cti_desc.dev = dev;
> 835d722ba10ac92 Mike Leach 2020-03-20  839      drvdata->csdev = coresight_register(&cti_desc);
> 835d722ba10ac92 Mike Leach 2020-03-20  840      if (IS_ERR(drvdata->csdev)) {
> 835d722ba10ac92 Mike Leach 2020-03-20  841              ret = PTR_ERR(drvdata->csdev);
> 835d722ba10ac92 Mike Leach 2020-03-20  842              goto err_out;
> 835d722ba10ac92 Mike Leach 2020-03-20  843      }
> 835d722ba10ac92 Mike Leach 2020-03-20  844
> 835d722ba10ac92 Mike Leach 2020-03-20  845      /* add to list of CTI devices */
> 835d722ba10ac92 Mike Leach 2020-03-20  846      mutex_lock(&ect_mutex);
> 835d722ba10ac92 Mike Leach 2020-03-20  847      list_add(&drvdata->node, &ect_net);
> 177af8285b59a38 Mike Leach 2020-03-20  848      /* set any cross references */
> 177af8285b59a38 Mike Leach 2020-03-20  849      cti_update_conn_xrefs(drvdata);
> 835d722ba10ac92 Mike Leach 2020-03-20  850      mutex_unlock(&ect_mutex);
> 835d722ba10ac92 Mike Leach 2020-03-20  851
> 835d722ba10ac92 Mike Leach 2020-03-20  852      /* set up release chain */
> 835d722ba10ac92 Mike Leach 2020-03-20  853      drvdata->csdev_release = drvdata->csdev->dev.release;
> 835d722ba10ac92 Mike Leach 2020-03-20  854      drvdata->csdev->dev.release = cti_device_release;
> 835d722ba10ac92 Mike Leach 2020-03-20  855
> 835d722ba10ac92 Mike Leach 2020-03-20  856      /* all done - dec pm refcount */
> 835d722ba10ac92 Mike Leach 2020-03-20  857      pm_runtime_put(&adev->dev);
> 835d722ba10ac92 Mike Leach 2020-03-20  858      dev_info(&drvdata->csdev->dev, "CTI initialized\n");
> 835d722ba10ac92 Mike Leach 2020-03-20  859      return 0;
> 835d722ba10ac92 Mike Leach 2020-03-20  860
> 835d722ba10ac92 Mike Leach 2020-03-20  861  err_out:
> e9b880581d555c8 Mike Leach 2020-05-18 @862      cti_pm_release(drvdata);
>                                                                ^^^^^^^
> 835d722ba10ac92 Mike Leach 2020-03-20  863      return ret;
> 835d722ba10ac92 Mike Leach 2020-03-20  864  }
>
>
>    750  /* release PM registrations */
>    751  static void cti_pm_release(struct cti_drvdata *drvdata)
>    752  {
>    753          if (drvdata->ctidev.cpu >= 0) {
>                     ^^^^^^^
> We are dereferencing this when it wasn't allocated.
>
>    754                  if (--nr_cti_cpu == 0) {
>                             ^^^^^^^^^^^^
> If devm_kasprintf() fails then we are decrementing this when it wasn't
> incremented so now it can be negative.
>
>    755                          cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
>
> If the cpu_pm_register_notifier() fails then we are unregistering this
> when it wasn't registered.  It turns out this is harmless but if we
> only free things which have been allocated then it becomes a lot
> easier to audit the code.
>
>    756
>    757                          cpuhp_remove_state_nocalls(
>    758                                  CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
>
> If cpuhp_setup_state_nocalls_cpuslocked() failed then this wasn't
> allocated.  I believe this is harmless.
>
>    759                  }
>    760                  cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
>    761          }
>    762  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
