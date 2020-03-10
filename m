Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F17C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3932464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583841599;
	bh=l0GPZ7rgbbX42aXiVWrJZANgIIl3Aa/6T0DuOcGTUrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qXvgsM5iMNIaVTCIi+wmybrLJtkS7xlXkGfoSNNo1ohQ78alILXGlakYT1lbmXFst
	 IPD/6086njLHHQRdX0/2rDHHPresrKUmBkziHFouC4eHZBch/VCOkzULRNUkMlUJb6
	 lXif247SVAz4RQx1LP0XyT8W9eiRWosM2l1Wf1rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgCJL76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:59:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39360 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:59:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id f7so1032294wml.4;
        Tue, 10 Mar 2020 04:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bAhm3DuaLfkzUm2lkD/QpZIHlNuTATTEEtwUNoLDMc=;
        b=H5WlDiIcRKRNsZ5ub5rK9FEK1l0y+mnnmFPfvMMGzXM2eL7qth29CXc387NxexQQ7n
         wYdePWPXJZx5VJc0SwcHeTVSCvB8YvjWNbSfV1uNHmgxS9eSxVpW9K8jboR2DeN4Qikf
         p0z7BhuLhxw3u+zpJrO+Q35OhtS6m44KWlXaHbuL1HANYxvFHFccsJXo/xTmDJD56A/V
         86DuETJgTRZ3sF+8l4zcVI+GpnzdxfLuM1uCzLzitz83ha5fjAX4Dp6/GR2duy0xnILC
         wsuOpektqHgPV5m2SfIgU7MeZjyVPUH2K0ux1Gzn374yzPe7srIt9gDQiAcKl0n0UnFf
         HvcQ==
X-Gm-Message-State: ANhLgQ1Q2LGAYQEyPG42iPmuwBTPu77IA8UqbJFz9s7mNAPVa65DSXKh
        UmnGekSOI+GU0B++Ehr6WjQ=
X-Google-Smtp-Source: ADFU+vuTmNn8vy4JGsoYYV4PMEgdh1palpn0A7Ri4XkzIOQ/sbHDPtvrJg+BmE/NgDS3Qt080LephA==
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr1914581wmi.80.1583841596287;
        Tue, 10 Mar 2020 04:59:56 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m21sm3763917wmi.27.2020.03.10.04.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:59:55 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:59:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Igor Mammedov <imammedo@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 07/11] virtio-mem: Allow to offline partially
 unplugged memory blocks
Message-ID: <20200310115955.GI8447@dhcp22.suse.cz>
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-8-david@redhat.com>
 <20200310114312.GG8447@dhcp22.suse.cz>
 <e505b4cb-1d12-d6e6-3524-9dfa65ae34bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e505b4cb-1d12-d6e6-3524-9dfa65ae34bf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 12:46:05, David Hildenbrand wrote:
> On 10.03.20 12:43, Michal Hocko wrote:
> > On Mon 02-03-20 14:49:37, David Hildenbrand wrote:
> > [...]
> >> +static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
> >> +					    unsigned long mb_id)
> >> +{
> >> +	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
> >> +	unsigned long pfn;
> >> +	int sb_id, i;
> >> +
> >> +	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
> >> +		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> >> +			continue;
> >> +		/*
> >> +		 * Drop our reference to the pages so the memory can get
> >> +		 * offlined and add the unplugged pages to the managed
> >> +		 * page counters (so offlining code can correctly subtract
> >> +		 * them again).
> >> +		 */
> >> +		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
> >> +			       sb_id * vm->subblock_size);
> >> +		adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
> >> +		for (i = 0; i < nr_pages; i++)
> >> +			page_ref_dec(pfn_to_page(pfn + i));
> > 
> > Is there ever situation this might be a different than 1->0 transition?
> 
> Only if some other code would be taking a reference. At least not from
> virtio-mem perspective.

OK, so that is essentially an error condition. I think it shouldn't go
silent and you want something like
	if (WARN_ON(!page_ref_sub_and_test(page)))
		dump_page(pfn_to_page(pfn + i), "YOUR REASON");

-- 
Michal Hocko
SUSE Labs
