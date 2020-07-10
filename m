Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8148C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53C820708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tp233Z04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJBIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJBIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:08:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7450C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 18:08:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so1786108pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eELyJYiCJuXcCWvhr7zSAoIfBQ9kYnYZydQBgDVJFPA=;
        b=tp233Z04wNYzls8ZtvlLs/QlFqTndj/k4NahcX3K9o+n5FI3Wkh/A+BeTKPIbiZsz8
         t1CQtDyBcKUxY+Y1LxdBBLStdFn6mngBLKGqcKcokldZfMCnDosXLqX74AzNmPmqkFmQ
         5R5SOKgXmnO4nSlpeQJhyqhe14K1h6vHXMrX1GSs9xO3TQ5y/5Ytmnx0CAon2iVkdWdl
         N6DBsVogqbn+AbbZ4M/AhNfYiyjlQb6HnMiU/w4r0BGK7WnI/fgLDEFHx+JcbEgCvH+L
         IuWRoYmKdn5NbGOIIVdIRyD/fMShvPsj8Uj875LanQ13myFtmbsuno0Jtb1pqnbPlkts
         0yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eELyJYiCJuXcCWvhr7zSAoIfBQ9kYnYZydQBgDVJFPA=;
        b=WZo7p94ErPCC0W4Z4uoRuSZtYCz76KkCdTflb7s6NS+GIHgAZpDEXlq1tBf25I6xIg
         k+aNDlka0Mk7x7VmMploM63zT1Ktjygd+QlsPa7Pjjxk4VGfJnRaGsjewTKsF48JiLt1
         lTAu/13LVB42MfnwnMzNctOxswHN+DOZ9Ku0nOTst1WLE9QTNBALTvENmy8TaJkztKdH
         VzwLTY7DzEMwzJ0qrf32mUzB/VYCrK4oV5CdrDM732aaqg95unwKe0ybM+WAcQbs94lr
         k6bZpDxULibJobDHmTKyBiumz0oApk59/gHVbYnwurRFyANqamAl9jTbsJReSIDlXnTH
         xL1A==
X-Gm-Message-State: AOAM532wv4nsdKV46sVEZukQPf0wK6K05FA3xBX2HO0mAtHZXHDCyrfO
        n3llOkPuc8PXuTvbWvA1yRGLeSFuEIx6p9kAtUIDeQ==
X-Google-Smtp-Source: ABdhPJzjGcR2gsMVLx4wPO2RkI0hzaqwxSWwi+VFlOSgTRZJa+6v0fC/OAgPuCp+rtNO3zhS/p7RznBRXTk/lTNzC4c=
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr55227165pgd.378.1594343290280;
 Thu, 09 Jul 2020 18:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <202007100326.PBTF6fLW%lkp@intel.com>
In-Reply-To: <202007100326.PBTF6fLW%lkp@intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 9 Jul 2020 18:07:58 -0700
Message-ID: <CAMo8BfK70RcT-WBiabyVM7mOu2qALULh4sGdB12K0-=5ANfRzQ@mail.gmail.com>
Subject: Re: xtensa-linux-ld: section .start VMA overlaps section .image VMA
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 12:37 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
> commit: 5e4417f921238b5acf101bfcd59a7b3463fb2dbd xtensa: reorganize vectors placement
> date:   5 months ago
> config: xtensa-randconfig-r014-20200709 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 5e4417f921238b5acf101bfcd59a7b3463fb2dbd
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d1646087]

The config has CONFIG_XIP_KERNEL=y, so make xipImage
should be used, and it works correctly.

-- 
Thanks.
-- Max
