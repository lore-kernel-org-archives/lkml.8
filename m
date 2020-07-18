Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B50C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7A320738
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0LOPk3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGRUS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGRUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:18:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B3C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:18:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i3so10209148qtq.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:in-reply-to:date:subject:from:to:cc
         :message-id;
        bh=RN+57Sf0O1lrNGjq2DvkcxCavUydH1X+nGVJ8HA3O9E=;
        b=i0LOPk3YceftGkAKJfdlGv9L1Txc057n49lmjFAWgQ//eQubRx6YdqVLUKKKyjwbKR
         ck1QmijGben6UziIAQSPHbtMoAUZ0gGGQ2fmTrKlIDFxnKI1e0ZXzEQ/ogtlWm3aaSEH
         w1k0eOFMcaIJ5f5bRUl2sDn5WPHfkxV5Ru2RHWguwFdcdULPnBv1XEq3rwd5yhYXnkjA
         cUJV7aoCG92gl1AIeDl9lnGorilA82/bad0Wp0jV4SLSs+la8kt0miBnfIlFbKhTOguM
         pyXSv/ArTg9sic4ckdiLpBoBL7MpM83cLSgmVKwO1QOj7nRS0xgV/C1GprC1IHpx7lEw
         2m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:in-reply-to:date
         :subject:from:to:cc:message-id;
        bh=RN+57Sf0O1lrNGjq2DvkcxCavUydH1X+nGVJ8HA3O9E=;
        b=tZuvOO2iW/BmlOtncw9/nzNYgejGfWt51TEjODAMoUn1fOSDX96v3WpyT3XYzrTiPA
         nQfi1AGfdJAm+D8rEFtoeuNNxOZcCXmSBvjI9MHUQz2DYZcUQurClo6DwEEL5+TJdoW4
         EDbSBhS62KjB4uiDe+iGNMrP1YngRXTz7YGTJU9Bt7zGXpkdKlFAbRtSF1ICAN67zxEB
         50O+Vqgu9ibSeTidBH39QUx8Olf2GQhS1/coIIV5ZDuYMCC8jn2DVFWtDyAYyltf4l6z
         sdkfq9CC95cz8/HX3kGHes0kWQmU06yielkOYt1tIedbxS5RnjTIS8wpLvAvpKn/yOpt
         4qhA==
X-Gm-Message-State: AOAM533GMxUsbXX06NJyXEbr27YvDS7ln3xEKd4FDeHgzaj7iVh7bWtP
        3m4yjgUDmJbcLA+xYCHfHbmNB8Y1vmM=
X-Google-Smtp-Source: ABdhPJwelMgw6SWWTTG3yrsxL8bTVjtsq+EVpnyT7GQSA7IDYP3CUljmbSOVsKxOeiK2GFT0Nk9cDg==
X-Received: by 2002:aed:3bb8:: with SMTP id r53mr16791934qte.58.1595103507625;
        Sat, 18 Jul 2020 13:18:27 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j45sm14841840qtk.31.2020.07.18.13.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 13:18:26 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <202007150718.6LcA4qZN%lkp@intel.com>
Date:   Sat, 18 Jul 2020 16:18:25 -0400
Subject: Re: [PATCH v2 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "kernel test robot" <lkp@intel.com>, <kishon@ti.com>,
        <vkoul@kernel.org>
Cc:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>
Message-Id: <C4A102A7YC2W.1LPN6MZLYYUKV@atris>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 15, 2020 at 7:48 AM kernel test robot wrote:
> Hi Liam,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on 8f3d9f354286745c751374f5f1fcafee6b3f3136]
>=20
> url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/phy-tusb1210=
-use-bitmasks-to-set-VENDOR_SPECIFIC2/20200715-003517
> base:    8f3d9f354286745c751374f5f1fcafee6b3f3136
> config: parisc-allyesconfig (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s ARCH=3Dparisc=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    hppa-linux-ld: drivers/phy/ti/phy-tusb1210.o: in function `tusb1210_pr=
obe':
> >> (.text+0x2f4): undefined reference to `__cmpxchg_called_with_bad_point=
er'
> >> hppa-linux-ld: (.text+0x324): undefined reference to `__cmpxchg_called=
_with_bad_pointer'
>    hppa-linux-ld: (.text+0x354): undefined reference to `__cmpxchg_called=
_with_bad_pointer'
>=20

Hi,

I sent another patch[1] to try to address this.

The issue seems to come from the fact that the parisc architecture
doesn't support cmpxchg on u8 pointers. cmpxchg is called by
set_mask_bits.

Thanks,
Liam

[1] https://lore.kernel.org/patchwork/patch/1272617/

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
