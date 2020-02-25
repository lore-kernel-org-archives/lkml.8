Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A82C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FB21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582625036;
	bh=C7opyRW/+l907HNE0jf96begBCh8Snm95dN6DgLEDv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MjxgQwx6p1k+aQZ9IKGLYEAA31sf5LL5r9Y6DUQ6tc3wqOBQvkTDHIvw4Lt668Rbf
	 JXaw8DqPTvfkRBlOoFErAHhFnLuFcDytFj6Yp/5esNto3sMyM9h1zUEI/Qy4JTTWJR
	 Bvub8obITAgXlsNOaO5b0/3lii4ppkdZX8DyQ4lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgBYKDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:03:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39864 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgBYKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:03:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so5148524wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 02:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J5sz8+yP/6v8aTbTC8x2kZvJpVVQE6WGcOOQCZp7IGA=;
        b=Psj4qjNOBoDFGEeX8GGJ0PIiG+0tkEZLZ81GoQDVoS5QJzQEHJZ1R/gdtGtmTgDvto
         znNx5vYL1vlLi0EFSYb6wxdThrco0J0yOBCGLlAj0weqvYDGeAH5mjZrMt8TKOCJ77ce
         ElAWBHNKG/cwnlpN7Ng1TkgcOVdY62ewpdKASc1/U9WzC2sO0xvM4yZwQnjS7YHJ/X74
         2hl/g1n1Js5Ft6xBXt3mdl7/89u00bdDqkbnhMKiS9go288J8MqDAOfZY7SjnEM3r9hD
         1MdH0A3N8FZ+nNqvr1eUnzCVwB0QRK0ax/o5lGJ99FXcxFH3tlcQGvDmI+Wjn9Prh6Pb
         qF9Q==
X-Gm-Message-State: APjAAAVNBkVAU3kp0zkQF4zaXUlEypJTzpfUTkM+599MoNWHHllfU24w
        rQmQu3CmeqkHVpAidSI8LOaYxvyD
X-Google-Smtp-Source: APXvYqyFr5546l3wp5CiUlxS7XTkzokuV9gkuAos6nPjQfHymkckcp313EWNWoGbu0G328zdI7DHdA==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr73494632wrm.191.1582625033174;
        Tue, 25 Feb 2020 02:03:53 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n13sm3612685wmd.21.2020.02.25.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:03:52 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:03:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200225100352.GN22443@dhcp22.suse.cz>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220103849.GG20509@dhcp22.suse.cz>
 <20200221142847.GG4937@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221142847.GG4937@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-02-20 22:28:47, Baoquan He wrote:
> On 02/20/20 at 11:38am, Michal Hocko wrote:
> > On Thu 20-02-20 12:33:09, Baoquan He wrote:
> > > Memory sub-section hotplug was added to fix the issue that nvdimm could
> > > be mapped at non-section aligned starting address. A subsection map is
> > > added into struct mem_section_usage to implement it. However, sub-section
> > > is only supported in VMEMMAP case.
> > 
> > Why? Is there any fundamental reason or just a lack of implementation?
> > VMEMMAP should be really only an implementation detail unless I am
> > missing something subtle.
> 
> Thanks for checking.
> 
> VMEMMAP is one of two ways to convert a PFN to the corresponding
> 'struct page' in SPARSE model. I mentioned them as VMEMMAP case, or
> !VMEMMAP case because we called them like this previously when reviewed
> patches, hope it won't cause confusion.
> 
> Currently, config ZONE_DEVICE depends on SPARSEMEM_VMEMMAP. The
> subsection_map is added to struct mem_section_usage to track which sub
> section is present, VMEMMAP fills those bits which corresponding
> sub-sections are present, while !VMEMMAP, namely classic SPARSE, fills
> the whole map always.
> 
> As we know, VMEMMAP builds page table to map a cluster of 'struct page'
> into the corresponding area of 'vmemmap'. Subsection hotplug can be
> supported naturally, w/o any change, just map needed region related to
> sub-sections on demand. For !VMEMMAP, it allocates memmap with
> alloc_pages() or vmalloc, thing is a little complicated, e.g the mixed
> section, boot memory occupies the starting area, later pmem hot added to
> the rear part.
> 
> About !VMEMMAP which doesn't support sub-section hotplog, Dan said 
> it's more because the effort and maintenance burden outweighs the
> benefit. And the current 64 bit ARCHes all enable
> SPARSEMEM_VMEMMAP_ENABLE by default.

OK, if this is the primary argument then make sure to document it in the
changelog (cover letter).
-- 
Michal Hocko
SUSE Labs
