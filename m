Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46A02086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXEXd+i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGFhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgHGFhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:37:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2CBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 22:37:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 25so950748oir.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bshcHl2T8AESsslx0ccXbV3aY6vJT2KoDDHlcYIDHrY=;
        b=aXEXd+i+t+qGNoEFQg3b0uBTCiBKvM7N8rBESwCtzR+MeoPruLJMMbmi3GtB1cCpHa
         rPsSDBqiuP7YU6Gs/XjsfZ+r5ogTTS/vIkmHuJM9d5vG0e63RNRWAHiC9Ywa0SGhBI/8
         LIYgrMup4/T+LLSvaiLzTfx/RJPWILfZ16AIHHMmqWDtxJ4w2ZIiXFnz7nH8kukAyIOT
         uWosKUrijIuQdc8jVdrLzNBSSeubsyLo8w+20txQaU8W3XXRb+dAUJx/IFSwXkhYodrT
         raP5/6UjHaMCxQMLJPqpjSoPgvVOM9MhCGQcnWbga9FabiCh6G2fiOlaNKhB6wTFszfW
         3Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bshcHl2T8AESsslx0ccXbV3aY6vJT2KoDDHlcYIDHrY=;
        b=GbMzlZyjSN5znALZJN0wt4b3snYpM6qxrx72f+NfVnec7tJZE4xWXZ5aF1SAqUWajR
         uooaV2IWJlJe9Fzy1xhr2MF/2e/mhNM6nCO/XujefXuomHQL4Vsbs+2mX0zeKer06K5l
         dUJvKuDfAd6DyJFbqAFaf8vMwPi/723i2VcQEvZz2YrRlGhY0mRNpzFmRyz04qjB8Kfa
         3bC5Smy6k3DdlPqf9bY+9g/BSqpRvPWNeo6/8+WkT6cKWe6ILSZXWewyqAenQJlpKwZ8
         7e9LPPVGV42B3/KIQxbdaIEi61TBz3JGDn4iXTiIrsGSGJCOw7Xc/+6HXY9Cpj2N4SsC
         E4Ig==
X-Gm-Message-State: AOAM532yNm9UzUXTfeecKkdytCTyd2cV+KvgYaqluPjvj/o+kh6RccMU
        gHbTo19JKtfolRVndGcZB0mEc4Zm0YBHPyb431IOCi7v8Qk=
X-Google-Smtp-Source: ABdhPJx4UQV50fxwCcOf9bf53S4B3y5D81RGOt7DCiIie57a/6l8uRD0XwpBincCwB/YLwYElwccK7bSN0X9j4tj2PI=
X-Received: by 2002:aca:c508:: with SMTP id v8mr9674679oif.149.1596778626575;
 Thu, 06 Aug 2020 22:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <202008070734.uF4WSa1Q%lkp@intel.com>
In-Reply-To: <202008070734.uF4WSa1Q%lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 7 Aug 2020 07:36:55 +0200
Message-ID: <CAMhs-H8_KDZgH4XjKoeF4LuR6V4ueDgO9YYF-gecJLg0Gu=7pA@mail.gmail.com>
Subject: Re: drivers/staging/mt7621-pci/pci-mt7621.c:189:11: error:
 'pci_generic_config_read' undeclared here (not in a function)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 7, 2020 at 1:51 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Sergio,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7b4ea9456dd3f73238408126ab00f1d906963d81
> commit: 3b2fa0c92686562ac0b8cf00c0326a45814f8e18 MIPS: ralink: enable PCI support only if driver for mt7621 SoC is selected
> date:   9 months ago
> config: mips-randconfig-r005-20200807 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 3b2fa0c92686562ac0b8cf00c0326a45814f8e18
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/staging/mt7621-pci/pci-mt7621.c:189:11: error: 'pci_generic_config_read' undeclared here (not in a function)
>      189 |  .read  = pci_generic_config_read,
>          |           ^~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/staging/mt7621-pci/pci-mt7621.c:190:12: error: 'pci_generic_config_write' undeclared here (not in a function)
>      190 |  .write  = pci_generic_config_write,
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~
[snip]

PCI is not selected if CONFIG_SOC_MT7621 is not set which is the case
for the attached kernel config... There was a time when the driver
itself was depending on PCI (which for me seems to be the correct
thing to do) but
it was removed creating a regression for gnubee and ralink with pci
based boards. This was done in 'c4d48cf5e2f0 ("MIPS: ralink:
deactivate PCI support for SOC_MT7621")'. To try to fix this issue and
being able again to properly compile the driver I sent the patch is
mentioned here by the test robot in where HAVE_PCI was selected only
in PCI_MT7621 SOC was selected... I was told in the mips kernel list
that this way was not the best thing to do to fix the issue but the
patch was accepted. I also asked about the original compile issue to
the guy who removed first the 'depends PCI' stuff with no answer at
all... So, what should I do to properly fix this?

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos
