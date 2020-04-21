Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A5CC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772742078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em1Yu/Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgDUN0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgDUN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:26:44 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E0C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:26:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u10so11089842lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfnArLUZmRY8aEwrBjVPUBVpxOW3jh3IS1qWj7upXQU=;
        b=em1Yu/BfKjy3mYbOfEAlWkLy0VxgNac6q02EeVEP40/+dNGIc4qZnxZJzN1aUqqF9j
         VfxvtHk2mRPrs7vASsv9DKckJO97nW9c3BB3iy5fSQ2vVfbASBjRLj90IJEDxJt/c6/D
         QJL12CojEXh74lgwahndqD3uYb+Kn0dpqz43vo4Tgu/Xz9erI3ymcAJ7hQWgDLa4IWa4
         uc0hDUhdx6IQbU437cKwHP4ZxoQQmMtnWgwPOaB+dpaLGUGbXw5dM2Avt5oWVCNIH6Zs
         J0SkSJOxCOQBNfMQgTayFOayDJtSCArLkUmixY9puDICKBavuNMbgxS+4clNfcdtHC2y
         tKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfnArLUZmRY8aEwrBjVPUBVpxOW3jh3IS1qWj7upXQU=;
        b=eYZshBHBfM57jx3IEH9l9Fij+sEZVvAqsAj0nB0ohzwI4WaCr/81hF0BsXC8mN8ZC/
         FsPvjuhA+FRBlx2x+Cwsp+1lMVgG6xfQK7TLILYoYW8neGfRFIAJdZ5jXcq83Igu6cLl
         Efwf+mR5LbceRxlKHUm2hDnXmoq84x3Cu55Eew38XIYeC34z0cQjc36NPh/rLb9fxfj2
         KlwIhRH7K59ozC/W6LD05YtEJKO3Sq8vz4clc+fUn76+oUHQAqSGFDxQusKshyQ0fX7Q
         eGV2o7a40at0Kgx1BJjH9tzmq1/NkS77tX2uVMTXLc3kxlJDUX1nbaf6uVM6J2yvtVoK
         oEaQ==
X-Gm-Message-State: AGi0PubFF1p2yzCSfACny4yazs5GDsBrPlswImvboIeHxBQYfA9f10MZ
        nZJrRKDztBdqdK/J162HG+sg9bTwzWL/EwnVnKI=
X-Google-Smtp-Source: APiQypLYcQNO7N5edDb88BJb18sHe2W/eLWzvSk/+JuQ/mLx5YnFqCfOv/Fs2YtF6iLCsMQ1l1t0CSb3vnU9G7TYzew=
X-Received: by 2002:ac2:53a6:: with SMTP id j6mr13807643lfh.153.1587475602059;
 Tue, 21 Apr 2020 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <328db39335b515b190b518445a777ee97751d393.1587173992.git.baolin.wang7@gmail.com>
 <202004211716.IWGuUFlz%lkp@intel.com>
In-Reply-To: <202004211716.IWGuUFlz%lkp@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 21 Apr 2020 21:26:30 +0800
Message-ID: <CADBw62o4zQ0UBMgSA13TLgb3ZOiBv-CbCS1j7adgUazoREPSzQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: syscon: Add Spreadtrum physical regmap bus support
To:     kbuild test robot <lkp@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 6:03 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Baolin,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on arm-soc/for-next linus/master linux/master v5.7-rc2 next-20200420]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/mfd-syscon-Add-Spreadtrum-physical-regmap-bus-support/20200421-035442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: x86_64-randconfig-f002-20200421 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project a9b137f9ffba8cb25dfd7dd1fb613e8aac121b37)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/mfd/syscon.c:182:31: error: use of undeclared identifier 'sprd_syscon_regmap_bus'
>                    regmap = regmap_init(NULL, &sprd_syscon_regmap_bus, base,
>                                                ^
> >> drivers/mfd/syscon.c:182:10: error: assigning to 'struct regmap *' from incompatible type 'void'
>                    regmap = regmap_init(NULL, &sprd_syscon_regmap_bus, base,
>                           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    2 errors generated.

Ah, sorry, will fix the building errors in next version. Thanks for reporting.

>
> vim +/sprd_syscon_regmap_bus +182 drivers/mfd/syscon.c
>
>    106
>    107  static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>    108  {
>    109          struct clk *clk;
>    110          struct syscon *syscon;
>    111          struct regmap *regmap;
>    112          void __iomem *base;
>    113          u32 reg_io_width;
>    114          int ret;
>    115          struct regmap_config syscon_config = syscon_regmap_config;
>    116          struct resource res;
>    117          bool use_phy_regmap_bus = false;
>    118
>    119          syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
>    120          if (!syscon)
>    121                  return ERR_PTR(-ENOMEM);
>    122
>    123          if (of_address_to_resource(np, 0, &res)) {
>    124                  ret = -ENOMEM;
>    125                  goto err_map;
>    126          }
>    127
>    128          base = ioremap(res.start, resource_size(&res));
>    129          if (!base) {
>    130                  ret = -ENOMEM;
>    131                  goto err_map;
>    132          }
>    133
>    134          /* Parse the device's DT node for an endianness specification */
>    135          if (of_property_read_bool(np, "big-endian"))
>    136                  syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
>    137          else if (of_property_read_bool(np, "little-endian"))
>    138                  syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
>    139          else if (of_property_read_bool(np, "native-endian"))
>    140                  syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
>    141
>    142          /*
>    143           * search for reg-io-width property in DT. If it is not provided,
>    144           * default to 4 bytes. regmap_init_mmio will return an error if values
>    145           * are invalid so there is no need to check them here.
>    146           */
>    147          ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
>    148          if (ret)
>    149                  reg_io_width = 4;
>    150
>    151          ret = of_hwspin_lock_get_id(np, 0);
>    152          if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
>    153                  syscon_config.use_hwlock = true;
>    154                  syscon_config.hwlock_id = ret;
>    155                  syscon_config.hwlock_mode = HWLOCK_IRQSTATE;
>    156          } else if (ret < 0) {
>    157                  switch (ret) {
>    158                  case -ENOENT:
>    159                          /* Ignore missing hwlock, it's optional. */
>    160                          break;
>    161                  default:
>    162                          pr_err("Failed to retrieve valid hwlock: %d\n", ret);
>    163                          /* fall-through */
>    164                  case -EPROBE_DEFER:
>    165                          goto err_regmap;
>    166                  }
>    167          }
>    168
>    169          syscon_config.name = of_node_full_name(np);
>    170          syscon_config.reg_stride = reg_io_width;
>    171          syscon_config.val_bits = reg_io_width * 8;
>    172          syscon_config.max_register = resource_size(&res) - reg_io_width;
>    173
>    174           /*
>    175            * The Spreadtrum syscon need register a real physical regmap bus
>    176            * with new atomic bits updating operation instead of using
>    177            * read-modify-write.
>    178            */
>    179          if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
>    180              of_device_is_compatible(np, "sprd,atomic-syscon")) {
>    181                  use_phy_regmap_bus = true;
>  > 182                  regmap = regmap_init(NULL, &sprd_syscon_regmap_bus, base,
>    183                                       &syscon_config);
>    184          } else {
>    185                  regmap = regmap_init_mmio(NULL, base, &syscon_config);
>    186          }
>    187          if (IS_ERR(regmap)) {
>    188                  pr_err("regmap init failed\n");
>    189                  ret = PTR_ERR(regmap);
>    190                  goto err_regmap;
>    191          }
>    192
>    193          if (!use_phy_regmap_bus && check_clk) {
>    194                  clk = of_clk_get(np, 0);
>    195                  if (IS_ERR(clk)) {
>    196                          ret = PTR_ERR(clk);
>    197                          /* clock is optional */
>    198                          if (ret != -ENOENT)
>    199                                  goto err_clk;
>    200                  } else {
>    201                          ret = regmap_mmio_attach_clk(regmap, clk);
>    202                          if (ret)
>    203                                  goto err_attach;
>    204                  }
>    205          }
>    206
>    207          syscon->regmap = regmap;
>    208          syscon->np = np;
>    209
>    210          spin_lock(&syscon_list_slock);
>    211          list_add_tail(&syscon->list, &syscon_list);
>    212          spin_unlock(&syscon_list_slock);
>    213
>    214          return syscon;
>    215
>    216  err_attach:
>    217          if (!IS_ERR(clk))
>    218                  clk_put(clk);
>    219  err_clk:
>    220          regmap_exit(regmap);
>    221  err_regmap:
>    222          iounmap(base);
>    223  err_map:
>    224          kfree(syscon);
>    225          return ERR_PTR(ret);
>    226  }
>    227
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Baolin Wang
