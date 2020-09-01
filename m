Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CDA2067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgIAO4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgIAOyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:54:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D50A6ACC3;
        Tue,  1 Sep 2020 14:54:41 +0000 (UTC)
Subject: Re: [PATCH v5 3/3] xen: add helpers to allocate unpopulated memory
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
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
References: <20200901083326.21264-1-roger.pau@citrix.com>
 <20200901083326.21264-4-roger.pau@citrix.com>
 <20200901144539.GI753@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <4b24c8c3-fb0f-23ad-09c5-81fcfdb6a2b5@suse.com>
Date:   Tue, 1 Sep 2020 16:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901144539.GI753@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.20 16:45, Roger Pau Monné wrote:
> On Tue, Sep 01, 2020 at 10:33:26AM +0200, Roger Pau Monne wrote:
>> +static int fill_list(unsigned int nr_pages)
>> +{
>> +	struct dev_pagemap *pgmap;
>> +	void *vaddr;
>> +	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
>> +	int nid, ret;
>> +
>> +	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>> +	if (!pgmap)
>> +		return -ENOMEM;
>> +
>> +	pgmap->type = MEMORY_DEVICE_GENERIC;
>> +	pgmap->res.name = "Xen scratch";
>> +	pgmap->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +
>> +	ret = allocate_resource(&iomem_resource, &pgmap->res,
>> +				alloc_pages * PAGE_SIZE, 0, -1,
>> +				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
>> +	if (ret < 0) {
>> +		pr_err("Cannot allocate new IOMEM resource\n");
>> +		kfree(pgmap);
>> +		return ret;
>> +	}
>> +
>> +	nid = memory_add_physaddr_to_nid(pgmap->res.start);
> 
> I think this is not needed ...
> 
>> +
>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>> +        /*
>> +         * memremap will build page tables for the new memory so
>> +         * the p2m must contain invalid entries so the correct
>> +         * non-present PTEs will be written.
>> +         *
>> +         * If a failure occurs, the original (identity) p2m entries
>> +         * are not restored since this region is now known not to
>> +         * conflict with any devices.
>> +         */
>> +	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>> +		xen_pfn_t pfn = PFN_DOWN(pgmap->res.start);
>> +
>> +		for (i = 0; i < alloc_pages; i++) {
>> +			if (!set_phys_to_machine(pfn + i, INVALID_P2M_ENTRY)) {
>> +				pr_warn("set_phys_to_machine() failed, no memory added\n");
>> +				release_resource(&pgmap->res);
>> +				kfree(pgmap);
>> +				return -ENOMEM;
>> +			}
>> +                }
>> +	}
>> +#endif
>> +
>> +	vaddr = memremap_pages(pgmap, nid);
> 
> ... and NUMA_NO_NODE should be used here instead, as this memory is just
> fictitious space to map foreign memory, and shouldn't be related to
> any NUMA node.
> 
> The following chunk should be folded in, or I can resend.

I can fold it in.


Juergen
