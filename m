Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A83C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC65207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0vISYNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETKuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:50:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726570AbgETKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589971853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPZ9QsNwnGV2YxLb/6yk6g6J5pHHPUVFz2+7su2cKBI=;
        b=a0vISYNGRFGz2Q5+aRpE5e56QhkAnosweG3N47iEKHx5MnVJV+NuWnJher4Xr5eUlmvzQP
        C3GdzXdFMExOn5F3xyFdl7jsKBwz0pMSXuFopFHRZ5T1nV7gKyzxkNlP9cFGZWjkWzEJ4/
        cUodDMZ7p7HYW6TfywB2TnRDMqOPaeg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-N9nb8NSRO_2zTJh5Al2Eew-1; Wed, 20 May 2020 06:50:43 -0400
X-MC-Unique: N9nb8NSRO_2zTJh5Al2Eew-1
Received: by mail-ej1-f72.google.com with SMTP id ng1so1166473ejb.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PPZ9QsNwnGV2YxLb/6yk6g6J5pHHPUVFz2+7su2cKBI=;
        b=mEbhycKZkzdy5YPTLxsKElRnHDBFj19i/tS7AfsaMJeiQXLJhMBSHx13ymowheyQn4
         uzX/rGeJc8urKzv5tQc5F4kezIPIsWjjKY/reXBcA/Yzsnx8Vp52DoyjiHXuI7UvjfTO
         UR3YHsABZOcPYxpiReN5WCqnZxREQWXgroRrX/Eu5QAPBLH5A4K8a3U5F4QfCRS+En+p
         CBzH+I/Jdymftseh0r9cfFSMJskFwsOnbfZnTvFK5gPR7E65pjKe13R8O8du3e39xh/H
         59eYfb/w2RDB+vks/wYHXbjINr3xmmiKN6UauYkzhakbla9Unwbe3V0OGye0mej+ZNMn
         PWqQ==
X-Gm-Message-State: AOAM530Nz83akv+vAMwH6Vyw6gHDhH3cQoAg6x1RiHszck4juJ5KQjnQ
        ePK43W9lvKMx9UcMknPz4RYLpRjvq1lWfZv6CCxql0gGz5NxlIpu3rU2pThr+IJwsVMw9xDIi4L
        AraE6PFShu5aKQjkgxLnu8Qws
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr2944768edw.128.1589971842256;
        Wed, 20 May 2020 03:50:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBZRZcuiwta6kbLskORxe8z7aKFxmZ0CTaziznYN9yCX5MAGaa1UCZqCZ0+MSMA1d0cKsjNQ==
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr2944753edw.128.1589971842032;
        Wed, 20 May 2020 03:50:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id wr19sm1521487ejb.67.2020.05.20.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 03:50:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:x86/entry 4/80] drivers/xen/events/events_base.c:1664:6: warning: no previous prototype for 'xen_setup_callback_vector'
In-Reply-To: <202005201858.UeplJGzF%lkp@intel.com>
References: <202005201858.UeplJGzF%lkp@intel.com>
Date:   Wed, 20 May 2020 12:50:40 +0200
Message-ID: <87d06yubgf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
> head:   095b7a3e7745e6fb7cf0a1c09967c4f43e76f8f4
> commit: fad1940a6a856f59b073e8650e02052ce531154c [4/80] x86/xen: Split HVM vector callback setup and interrupt gate allocation
> config: arm-randconfig-r013-20200519 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout fad1940a6a856f59b073e8650e02052ce531154c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> drivers/xen/events/events_base.c:1664:6: warning: no previous prototype for 'xen_setup_callback_vector' [-Wmissing-prototypes]
> 1664 | void xen_setup_callback_vector(void) {}
> |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +/xen_setup_callback_vector +1664 drivers/xen/events/events_base.c
>
>   1654	
>   1655	static __init void xen_alloc_callback_vector(void)
>   1656	{
>   1657		if (!xen_have_vector_callback)
>   1658			return;
>   1659	
>   1660		pr_info("Xen HVM callback vector for event delivery is enabled\n");
>   1661		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
>   1662	}
>   1663	#else
>> 1664	void xen_setup_callback_vector(void) {}

This isn't new in the patch as it just renames 'xen_callback_vector()'
to 'xen_setup_callback_vector()' but we likely need to add 'static'
here. I'll send a patch.


>   1665	static inline void xen_alloc_callback_vector(void) {}
>   1666	#endif
>   1667	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
Vitaly

