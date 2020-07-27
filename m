Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8799C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgG0PJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:09:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbgG0PJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:09:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88571B71A;
        Mon, 27 Jul 2020 15:09:19 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] xen: add helpers to allocate unpopulated memory
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200727091342.52325-1-roger.pau@citrix.com>
 <20200727091342.52325-5-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <06e21488-25a6-1c9f-366b-3c2ab63e4632@suse.com>
Date:   Mon, 27 Jul 2020 17:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727091342.52325-5-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.20 11:13, Roger Pau Monne wrote:
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
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> I've not added a new memory_type type and just used
> MEMORY_DEVICE_DEVDAX which seems to be what we want for such memory
> regions. I'm unsure whether abusing this type is fine, or if I should
> instead add a specific type, maybe MEMORY_DEVICE_GENERIC? I don't
> think we should be using a specific Xen type at all.

What about introducing MEMORY_DEVICE_VIRT? The comment for
MEMORY_DEVICE_DEVDAX doesn't really fit, as there is no character device
involved.

In the end its the memory management maintainers to decide that.

Other than that you can have my

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
