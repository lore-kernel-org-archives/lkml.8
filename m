Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B2CC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C56207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="0EjygVLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgG1Qsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:48:38 -0400
Received: from mail.xenproject.org ([104.130.215.37]:46960 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgG1Qsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W/q3EC2xp/1uSlfzKWEodtbt8+Hkh9fk7Ot5gVkNxDI=; b=0EjygVLrDEeM7fxzEKp2ZCZfyW
        cCJP1O+If5bhP4xNNzbCXDP+PxlwyNtosVREbzqftCtJMDJxbBiLcvc4YspOaTvnKcrrHu2hK0nTJ
        1oEy0V5ch4ZjpSEb84qfhoA5KsAiF8/udmsoizbh1NJwVVwacNWHhuOak4ho4Awlprt8=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1k0SmB-00059l-9Z; Tue, 28 Jul 2020 16:48:27 +0000
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1k0SmA-0007yB-V2; Tue, 28 Jul 2020 16:48:27 +0000
Subject: Re: [PATCH v3 4/4] xen: add helpers to allocate unpopulated memory
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Wei Liu <wl@xen.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Daniel Vetter <daniel@ffwll.ch>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20200727091342.52325-1-roger.pau@citrix.com>
 <20200727091342.52325-5-roger.pau@citrix.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <b5460659-88a5-c2aa-c339-815d5618bcb5@xen.org>
Date:   Tue, 28 Jul 2020 17:48:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727091342.52325-5-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/07/2020 10:13, Roger Pau Monne wrote:
> To be used in order to create foreign mappings. This is based on the
> ZONE_DEVICE facility which is used by persistent memory devices in
> order to create struct pages and kernel virtual mappings for the IOMEM
> areas of such devices. Note that on kernels without support for
> ZONE_DEVICE Xen will fallback to use ballooned pages in order to
> create foreign mappings.
> 
> The newly added helpers use the same parameters as the existing
> {alloc/free}_xenballooned_pages functions, which allows for in-place
> replacement of the callers. Once a memory region has been added to be
> used as scratch mapping space it will no longer be released, and pages
> returned are kept in a linked list. This allows to have a buffer of
> pages and prevents resorting to frequent additions and removals of
> regions.
> 
> If enabled (because ZONE_DEVICE is supported) the usage of the new
> functionality untangles Xen balloon and RAM hotplug from the usage of
> unpopulated physical memory ranges to map foreign pages, which is the
> correct thing to do in order to avoid mappings of foreign pages depend
> on memory hotplug.
I think this is going to break Dom0 on Arm if the kernel has been built 
with hotplug. This is because you may end up to re-use region that will 
be used for the 1:1 mapping of a foreign map.

Note that I don't know whether hotplug has been tested on Xen on Arm 
yet. So it might be possible to be already broken.

Meanwhile, my suggestion would be to make the use of hotplug in the 
balloon code conditional (maybe using CONFIG_ARM64 and CONFIG_ARM)?

Cheers,

-- 
Julien Grall
