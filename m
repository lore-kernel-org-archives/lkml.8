Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5445207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591300121;
	bh=gOWvV9xCJNtvMNcB63kf3S9kliMZUWR1TUmuJIhOrOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lOcmsSv22FUXuZ6rLbe5R3iMspwtw7Jh4GVTfRdcPxbTFtBE+614YFvN2bhbYUMrd
	 psRagZXxn5RvayqOFBjW6jE0h4XdMRIP6lZneGEB1roL04br1fL2m1c2uNaPpG6x59
	 tSWovqqkGu+QeRj+UquptKJ1DU0eReIqaVwA3GrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgFDTsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:48:40 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38570 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgFDTsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:48:40 -0400
Received: by mail-ej1-f65.google.com with SMTP id a25so7411215ejg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTrf5G/vUzU07HYOvQgtYZjrqE1meRALatuKyM8unFs=;
        b=QojCsx/e5pOn+7a2+a2T2RJNDR0ew6KWH/r5QcL6weU21sieaBsSR76hrPY77goF4X
         vXV3irdisAUBH6/6WO1DIqCFWAGLcp7NrVwLtc3ePUSJkRw47xPd7HjQP9ttMqDMMr3b
         qsvbG9QNWSwXg5vX1XcM0zJtKqJHlv+Io0D7BA6P32pqvDpTkyY7BYHHYurRv3ixVppQ
         BMG1AykTdznkYrsnECCTMbwlqAXmRSdKY4aNCqohiX3/7IqO3t0OVXvZ9XDq/+dS0PKm
         nhDXTYT/1eKYIsRvPcfm6CREJ+5eWbtQ+h0WueeF5SMe3Yq3xt1h93d6VdnE9WoHfx7G
         TGpQ==
X-Gm-Message-State: AOAM532E3HxvutXsktUpYgqF1NIYBPaBIf/CF4E1sYcH5gWWNi+cDWov
        qYMm6oCZd+k1hDxdt7MQZeE=
X-Google-Smtp-Source: ABdhPJzg1V21YbwZo48olWTzghgzMYu7b92Ge5dV8HYELavBMay8j0H5sr4nxPXVSzE9xcKrexW66w==
X-Received: by 2002:a17:906:4554:: with SMTP id s20mr5161109ejq.241.1591300118040;
        Thu, 04 Jun 2020 12:48:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id o12sm3130442edq.7.2020.06.04.12.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 12:48:36 -0700 (PDT)
Date:   Thu, 4 Jun 2020 21:48:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: elfcore.c:undefined reference to `dump_emit'
Message-ID: <20200604194835.GA1196@kozik-lap>
References: <202006050259.crcymbuq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006050259.crcymbuq%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 02:38:01AM +0800, kernel test robot wrote:
> Hi Krzysztof,
> 
> It's probably a bug fix that unveils the link errors.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9fb4c5250f10dc4d8257cd766991be690eb25c5b
> commit: e18a8c104d777af46aa5c8573c8a19ba2b5de597 ia64: Hide the archdata.iommu field behind generic IOMMU_API
> date:   8 days ago
> config: ia64-randconfig-r006-20200604 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e18a8c104d777af46aa5c8573c8a19ba2b5de597
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ia64-linux-ld: arch/ia64/kernel/elfcore.o: in function `elf_core_write_extra_phdrs':
> >> elfcore.c:(.text+0x172): undefined reference to `dump_emit'
> ia64-linux-ld: arch/ia64/kernel/elfcore.o: in function `elf_core_write_extra_data':
> elfcore.c:(.text+0x2b2): undefined reference to `dump_emit'

Thanks for the report. Error was there already, before my commits.

Mentioned commit e18a8c104d77 ("ia64: Hide the archdata.iommu field
behind generic IOMMU_API") was a fix for commit e93a1695d7fb ("iommu:
Enable compile testing for some of drivers"). After reverting both of
them (so reverting compile testing and the fix), the error is visible.

Best regards,
Krzysztof

