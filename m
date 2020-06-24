Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92099C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705622070E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nu9kRpny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgFXEBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFXEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:01:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E38C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:00:59 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so426134edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dF8dKxnPHS2Nn5CyPf9mD/eDU6sU82EnnsCXFYTCNns=;
        b=nu9kRpnyHBfkgT5jPPqbE2CWH+IOFurfeMDCJ4Xh0XO27lhkCehDRewcYvJIFXhblU
         vggpF9KXpKhPNAVOt2EkirnGGKT0Kw0PA9t8D2196Pmj4/zuwzB/FyNej43N9NdPAziQ
         Z1/aE8nkQD624Kn+k0Y+NWFw7ycvvCx+DSGK1uTaK5vQbKFlDgKIga8BWqi7VxcPj/Ai
         kQlyLzPOAiopDJXV6HhGFLlGZOcbGa5jcfOt+T5hgWQbk/UUx3U9Bxhu6+06Pr59PhBL
         pOJA8d47F4ZDYkYEIoC2uHrRsp+kjSRbaDiwt3EtYF23/gkqLXArRig+F0OhVaFN7U8D
         KGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dF8dKxnPHS2Nn5CyPf9mD/eDU6sU82EnnsCXFYTCNns=;
        b=S6o93ChO3wwyBMIu5H0CsZsYBhPeuWUTLpQ5HxtrQIZ1e681dlw0+1cxIYDo6OgFRy
         LWcwW/A13p9NcSuG1ATVGSAG4bSO0mCCMtSZYdFQRXxMF6kuOVuJyT+1iALCnSzzt6HA
         GUalW+Cpi+GTd8B3q6Zz9PPB83r7ZGXLDp1ovDokckNPS4nYLgpZfoXVZ4snC59CRLYZ
         gvJbJRSOaYI6B3Vrc5gB25Zm2C0+iVCOVds4reur5lGw+4zNTQL/xDKvh/09ANBMg4tZ
         7KouUGH/57Np6EMIrqOgyJXaEtxQoqvXpL4zxy5MBxOZkYCWEluleJDu+kvTWCEJN30o
         vbqw==
X-Gm-Message-State: AOAM530BXidAWZHEUftnbWB9uvJuzyw+T5S1qgoC5pCJ6yNMvXLjv3PE
        uFYRYM5Z92QrMRhHd5XV701Skh2G
X-Google-Smtp-Source: ABdhPJx/BKefyBmRSup9YzE3H8G/XhgzGkEgd/Q/lDRLB4MgNTGuREvKtkOx1OK66k/7Ba442lHxkQ==
X-Received: by 2002:a50:f0c4:: with SMTP id a4mr25610656edm.125.1592971258190;
        Tue, 23 Jun 2020 21:00:58 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id dt22sm15421965ejc.104.2020.06.23.21.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 21:00:57 -0700 (PDT)
Subject: Re: reset-brcmstb-rescal.c:undefined reference to
 `devm_ioremap_resource'
To:     kernel test robot <lkp@intel.com>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <202006240911.ujUUG94l%lkp@intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8bf7aba0-55c0-d505-6907-333b1b5eb807@gmail.com>
Date:   Tue, 23 Jun 2020 21:00:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006240911.ujUUG94l%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2020 6:26 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
> commit: 4cf176e52397853e4a4dd37e917c5eafb47ba8d1 reset: Add Broadcom STB RESCAL reset controller
> date:   6 months ago
> config: um-allmodconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout 4cf176e52397853e4a4dd37e917c5eafb47ba8d1
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    /usr/bin/ld: arch/um/drivers/vde.o: in function `vde_open_real':
>    (.text+0x9cb): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: (.text+0x61d): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: arch/um/drivers/vector_user.o: in function `user_init_socket_fds':
>    vector_user.c:(.text+0x53a): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `pcap_nametoaddr':
>    (.text+0x10095): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `pcap_nametonetaddr':
>    (.text+0x10155): warning: Using 'getnetbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `pcap_nametoproto':
>    (.text+0x10395): warning: Using 'getprotobyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `pcap_nametoport':
>    (.text+0x1018b): warning: Using 'getservbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
>    /usr/bin/ld: drivers/reset/reset-brcmstb-rescal.o: in function `brcm_rescal_reset_probe':
>>> reset-brcmstb-rescal.c:(.text+0x21b): undefined reference to `devm_ioremap_resource'
>    /usr/bin/ld: drivers/reset/reset-intel-gw.o: in function `intel_reset_probe':
>    reset-intel-gw.c:(.text+0x5be): undefined reference to `devm_platform_ioremap_resource'
>    collect2: error: ld returned 1 exit status

This is a late report, it was fixed upstream with:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fbcc53514c5e410dd598685c5fbbe1e6a5a87e1
-- 
Florian
