Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C6C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BA620719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bX8Cj6PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDFHR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:17:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33055 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:17:57 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so14667620iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Db2gy0KwxZU6sZXsS+kywahq01i5euHIqRm2wacWELU=;
        b=bX8Cj6PIjykCfub7TcZYiQOt5ySTtCwdZUbZ633ovn2CvaO5FXWlClGVfqUjQOMlj4
         J+vh7kwySoGNg8ndT3TbkaSRCDeNtJYuK72xM+V8Nywkf+zjJnOENhFbtKuhtKYqGnzk
         Y4eDL7B4vptrlD4wfMFW+tkqcu0SUO7x4fYZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Db2gy0KwxZU6sZXsS+kywahq01i5euHIqRm2wacWELU=;
        b=hx4onZIS6DxIspgcqThGuVqe/BemobC6813E0QT8EV61OnEwfFXNyh8Gvat3ZZdjTW
         GgTZt+7ZF/vteYN5CEvoxFjeBEw84cs4/JcuApyeVrmG2WIHWykmLeI9m5wAT54UzaP/
         u28e/df/jmbUWGju5q1Vv7JXvBQKcFdFj46RJHbi8kwlzGPMWeFwQZfUqihhvDrYVS71
         6Qk9njRpDrfsqHhPrb7WkPtXBBYazJhxYVuqfGEKEtkmcZagex3Vcn6PUW5+zn30FGRD
         z3F0t5tqBcs60RZiJR9qpbcBPMdSCB+O0Gldhbe4/2O5ekyk/VrMzLKKlUljYNeUaBgx
         /zag==
X-Gm-Message-State: AGi0PuaTbb8uu0KoUXCEV/ddkQTFviRoL0WFQfXlNUsoL6Wb9CfL/sPX
        rH0YaWsfB1hyuRpQwZ+JXG9YIiXsKa5T4mCeSS+wQg==
X-Google-Smtp-Source: APiQypLuUn0LSyK8CCfaiS+KVBTl8I/x4LHlAvyF6y60LcZDxFlbQ4ZBQoOkRGvl73rolvlaiznrylL0WtJiMWVcamk=
X-Received: by 2002:a5d:944c:: with SMTP id x12mr18334175ior.100.1586157474266;
 Mon, 06 Apr 2020 00:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200406051131.225748-1-hsinyi@chromium.org> <202004061558.qA9rRKbq%lkp@intel.com>
In-Reply-To: <202004061558.qA9rRKbq%lkp@intel.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Apr 2020 15:17:28 +0800
Message-ID: <CAJMQK-ibjjMx0oNN1M8bg9+MxocdJP4zfcSojWQZJsGvnRh-7g@mail.gmail.com>
Subject: Re: [PATCH] drm: mediatek: fix device passed to cmdq
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-arm-kernel@lists.infradead.org, CK Hu" <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch depends on
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
branch v5.6-next/soc

On Mon, Apr 6, 2020 at 3:12 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Hsin-Yi,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on clk/clk-next]
> [cannot apply to arm-soc/for-next xlnx/master linus/master v5.6 next-20200405]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Hsin-Yi-Wang/drm-mediatek-fix-device-passed-to-cmdq/20200406-132804
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: arm64-randconfig-a001-20200406 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.3.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/gpu/drm/mediatek/mtk_drm_crtc.c: In function 'mtk_drm_crtc_create':
> >> drivers/gpu/drm/mediatek/mtk_drm_crtc.c:824:29: error: 'struct mtk_drm_crtc' has no member named 'mmsys_dev'
>      824 |    cmdq_mbox_create(mtk_crtc->mmsys_dev,
>          |                             ^~
>    drivers/gpu/drm/mediatek/mtk_drm_crtc.c:832:43: error: 'struct mtk_drm_crtc' has no member named 'mmsys_dev'
>      832 |  ret = of_property_read_u32_index(mtk_crtc->mmsys_dev->of_node,
>          |                                           ^~
>
> vim +824 drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>
>    724
>    725  int mtk_drm_crtc_create(struct drm_device *drm_dev,
>    726                          const enum mtk_ddp_comp_id *path, unsigned int path_len)
>    727  {
>    728          struct mtk_drm_private *priv = drm_dev->dev_private;
>    729          struct device *dev = drm_dev->dev;
>    730          struct mtk_drm_crtc *mtk_crtc;
>    731          unsigned int num_comp_planes = 0;
>    732          int pipe = priv->num_pipes;
>    733          int ret;
>    734          int i;
>    735          bool has_ctm = false;
>    736          uint gamma_lut_size = 0;
>    737
>    738          if (!path)
>    739                  return 0;
>    740
>    741          for (i = 0; i < path_len; i++) {
>    742                  enum mtk_ddp_comp_id comp_id = path[i];
>    743                  struct device_node *node;
>    744
>    745                  node = priv->comp_node[comp_id];
>    746                  if (!node) {
>    747                          dev_info(dev,
>    748                                   "Not creating crtc %d because component %d is disabled or missing\n",
>    749                                   pipe, comp_id);
>    750                          return 0;
>    751                  }
>    752          }
>    753
>    754          mtk_crtc = devm_kzalloc(dev, sizeof(*mtk_crtc), GFP_KERNEL);
>    755          if (!mtk_crtc)
>    756                  return -ENOMEM;
>    757
>    758          mtk_crtc->config_regs = priv->config_regs;
>    759          mtk_crtc->ddp_comp_nr = path_len;
>    760          mtk_crtc->ddp_comp = devm_kmalloc_array(dev, mtk_crtc->ddp_comp_nr,
>    761                                                  sizeof(*mtk_crtc->ddp_comp),
>    762                                                  GFP_KERNEL);
>    763          if (!mtk_crtc->ddp_comp)
>    764                  return -ENOMEM;
>    765
>    766          mtk_crtc->mutex = mtk_disp_mutex_get(priv->mutex_dev, pipe);
>    767          if (IS_ERR(mtk_crtc->mutex)) {
>    768                  ret = PTR_ERR(mtk_crtc->mutex);
>    769                  dev_err(dev, "Failed to get mutex: %d\n", ret);
>    770                  return ret;
>    771          }
>    772
>    773          for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>    774                  enum mtk_ddp_comp_id comp_id = path[i];
>    775                  struct mtk_ddp_comp *comp;
>    776                  struct device_node *node;
>    777
>    778                  node = priv->comp_node[comp_id];
>    779                  comp = priv->ddp_comp[comp_id];
>    780                  if (!comp) {
>    781                          dev_err(dev, "Component %pOF not initialized\n", node);
>    782                          ret = -ENODEV;
>    783                          return ret;
>    784                  }
>    785
>    786                  mtk_crtc->ddp_comp[i] = comp;
>    787
>    788                  if (comp->funcs) {
>    789                          if (comp->funcs->gamma_set)
>    790                                  gamma_lut_size = MTK_LUT_SIZE;
>    791
>    792                          if (comp->funcs->ctm_set)
>    793                                  has_ctm = true;
>    794                  }
>    795          }
>    796
>    797          for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
>    798                  num_comp_planes += mtk_drm_crtc_num_comp_planes(mtk_crtc, i);
>    799
>    800          mtk_crtc->planes = devm_kcalloc(dev, num_comp_planes,
>    801                                          sizeof(struct drm_plane), GFP_KERNEL);
>    802
>    803          for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>    804                  ret = mtk_drm_crtc_init_comp_planes(drm_dev, mtk_crtc, i,
>    805                                                      pipe);
>    806                  if (ret)
>    807                          return ret;
>    808          }
>    809
>    810          ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
>    811                                  mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
>    812                                  NULL, pipe);
>    813          if (ret < 0)
>    814                  return ret;
>    815
>    816          if (gamma_lut_size)
>    817                  drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
>    818          drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut_size);
>    819          priv->num_pipes++;
>    820          mutex_init(&mtk_crtc->hw_lock);
>    821
>    822  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>    823          mtk_crtc->cmdq_client =
>  > 824                          cmdq_mbox_create(mtk_crtc->mmsys_dev,
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
