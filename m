Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1211EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFB1206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 22:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ptLSHDxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEaWAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 18:00:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3708 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEaWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 18:00:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed428e90000>; Sun, 31 May 2020 15:00:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 15:00:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 15:00:21 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 22:00:12 +0000
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to
 pin_user_pages*()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Paul Mundt" <lethal@linux-sh.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
 <20200531205819.GC138722@ravnborg.org>
 <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com>
 <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com>
Date:   Sun, 31 May 2020 15:00:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590962409; bh=mOAHg3HWAQU+SMgvhvLbwcrCiN0aIfRDvzo6PURxuws=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ptLSHDxVso3RmTaVpqglneBPvQzg2bSY6Fo4uzSa9phJrDAwaSIV3oBEMcttBX3x2
         qsP/G2Hr7T8kQOqLlPnrSjvDPtNX21coIAGNE0MtSY4Tu4gedBmuomvOKgDlBd5bYR
         T6X/fSnMmgVhJtsXHbwOeEqU61FkQjt47VAprGjOG600hSdouVmaCoTwI5Sx0/WLi2
         ZndYhUYCfEDX/21wOQorRxy2t4ssGitG6CiCLcE8WfxY6Ap5FYLbEbLhjBdkRSHnH5
         7tJGjJjs722imCo81uA2nV5XcM3a0cuO0fFxm88tw7yPsoxRzX33C6C7p7ACs/EYkw
         0+E6YvRcvKT7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 14:11, Andy Shevchenko wrote:
>     ...
> JFYI, we have history.git starting from v0.01.
> 
OK, thanks for that note. According to that history.git [1],
then: drivers/video/pvr2fb.c had get_user_pages_fast() support added to
pvr2fb_write() back in 2004, but only for CONFIG_SH_DMA, as part of

     commit 434502754f2 ("[PATCH] SH Merge")

...and that commit created the minor bug that patch 0001 here
addresses. (+Cc Paul just for the sake of completeness.)


[1] git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git


thanks,
-- 
John Hubbard
NVIDIA
