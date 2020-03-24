Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E3EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E68720775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCXPJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:09:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgCXPJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:09:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42C1FAC22;
        Tue, 24 Mar 2020 15:09:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] xen: enable BALLOON_MEMORY_HOTPLUG by default
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Ian Jackson <ian.jackson@eu.citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20200324150015.50496-1-roger.pau@citrix.com>
 <20200324150015.50496-2-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f4ce1d95-c80a-8727-7ddc-9199bb2036c4@suse.com>
Date:   Tue, 24 Mar 2020 16:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324150015.50496-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.20 16:00, Roger Pau Monne wrote:
> Without it a PVH dom0 is mostly useless, as it would balloon down huge
> amounts of RAM in order get physical address space to map foreign
> memory and grants, ultimately leading to an out of memory situation.
> 
> Such option is also needed for HVM or PVH driver domains, since they
> also require mapping grants into physical memory regions.
> 
> Suggested-by: Ian Jackson <ian.jackson@eu.citrix.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>   drivers/xen/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 57ddd6f4b729..c344bcffd89d 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -13,6 +13,7 @@ config XEN_BALLOON
>   config XEN_BALLOON_MEMORY_HOTPLUG
>   	bool "Memory hotplug support for Xen balloon driver"
>   	depends on XEN_BALLOON && MEMORY_HOTPLUG
> +	default y
>   	help
>   	  Memory hotplug support for Xen balloon driver allows expanding memory
>   	  available for the system above limit declared at system startup.
> 

Another variant would be to set: default XEN_BACKEND

This would match the reasoning for switching it on.

Either way would be fine with me, so you can add

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
