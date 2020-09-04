Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E29BC28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BCF2078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgIDMmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:42:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:41:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85C67ACB5;
        Fri,  4 Sep 2020 12:40:59 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] xen/balloon: fixes for memory hotplug
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20200901083326.21264-1-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <0b3daa72-692f-e747-4842-48a7a1b66dd4@suse.com>
Date:   Fri, 4 Sep 2020 14:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901083326.21264-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.20 10:33, Roger Pau Monne wrote:
> Hello,
> 
> The following series contain some fixes in order to split Xen
> unpopulated memory handling from the ballooning driver using the
> ZONE_DEVICE functionality, so that physical memory regions used to map
> foreign pages are not tied to memory hotplug.
> 
> Note this is currently only available for x86 due to Arm using an
> identity map for dom0 p2m and thus needing special handling.
> 
> Thanks, Roger.
> 
> Roger Pau Monne (3):
>    xen/balloon: add header guard
>    memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
>    xen: add helpers to allocate unpopulated memory
> 
>   drivers/dax/device.c                    |   2 +-
>   drivers/gpu/drm/xen/xen_drm_front_gem.c |   9 +-
>   drivers/xen/Kconfig                     |  11 ++
>   drivers/xen/Makefile                    |   1 +
>   drivers/xen/balloon.c                   |   4 +-
>   drivers/xen/grant-table.c               |   4 +-
>   drivers/xen/privcmd.c                   |   4 +-
>   drivers/xen/unpopulated-alloc.c         | 185 ++++++++++++++++++++++++
>   drivers/xen/xenbus/xenbus_client.c      |   6 +-
>   drivers/xen/xlate_mmu.c                 |   4 +-
>   include/linux/memremap.h                |   9 +-
>   include/xen/balloon.h                   |   4 +
>   include/xen/xen.h                       |   9 ++
>   mm/memremap.c                           |   2 +-
>   14 files changed, 232 insertions(+), 22 deletions(-)
>   create mode 100644 drivers/xen/unpopulated-alloc.c
> 

Applied the series to xen/tip.git for-linus-5.9


Juergen
