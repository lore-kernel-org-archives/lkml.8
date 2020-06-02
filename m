Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ABCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9631D206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WSk1w+1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:48:56 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:48:56 -0700 (PDT)
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 295442E1521;
        Tue,  2 Jun 2020 16:48:51 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id sIM0iAAhv4-mmeWtImL;
        Tue, 02 Jun 2020 16:48:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591105731; bh=DZ+4m0IpKnoMyohjYdLVqfAqILLUbRSTQBZ19sLaXSo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=WSk1w+1a3ejh4K4zEQyKiIetrZHihpYz6AshoFdoA9LCyHQJNcRh+npwxDth8EuwS
         SXJrST8fc7HNA3lG4Ufy0YgkRREoPcXEzuTGKXbk9eP1q4r3DQM483AYxHRi9uq/24
         B9wKQ6ktt7CdcXav7PIArMtK5fuaDo88guQ+y8yg=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:210::1:a])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id niHGN11jDl-mmWqcDeN;
        Tue, 02 Jun 2020 16:48:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: kobject_init_and_add is easy to misuse
To:     Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d7c1a000-ca47-bace-c098-d3f3ab0c5127@yandex-team.ru>
Date:   Tue, 2 Jun 2020 16:48:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602121035.GL19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2020 15.10, Matthew Wilcox wrote:
> On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
>> syzkaller reports for memory leak when kobject_init_and_add()
>> returns an error in the function sysfs_slab_add() [1]
>>
>> When this happened, the function kobject_put() is not called for the
>> corresponding kobject, which potentially leads to memory leak.
>>
>> This patch fixes the issue by calling kobject_put() even if
>> kobject_init_and_add() fails.
> 
> I think this speaks to a deeper problem with kobject_init_and_add()
> -- the need to call kobject_put() if it fails is not readily apparent
> to most users.  This same bug appears in the first three users of
> kobject_init_and_add() that I checked --
> arch/ia64/kernel/topology.c
> drivers/firmware/dmi-sysfs.c
> drivers/firmware/efi/esrt.c
> drivers/scsi/iscsi_boot_sysfs.c
> 
> Some do get it right --
> arch/powerpc/kernel/cacheinfo.c
> drivers/gpu/drm/ttm/ttm_bo.c
> drivers/gpu/drm/ttm/ttm_memory.c
> drivers/infiniband/hw/mlx4/sysfs.c
> 
> I'd argue that the current behaviour is wrong, that kobject_init_and_add()
> should call kobject_put() if the add fails.  This would need a tree-wide
> audit.  But somebody needs to do that anyway because based on my random
> sampling, half of the users currently get it wrong.
> 

At his point kobject doesn't own kmem-cache structure itself yet.

So calling kobject_put() will free kmem-cache and then it will be
freed second time on error path in create_cache().

I suppose freeing in case of error should be pushed from common
create_cache() into slab-specific __kmem_cache_create().
