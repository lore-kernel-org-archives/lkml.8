Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD693C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5E4206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg+7+l0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbgDNQ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:29:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391585AbgDNQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586881730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjWxSbfmmzPB+9cl5oT2tFJutn094jI8t91pgbfl/bY=;
        b=Lg+7+l0awlscI6r41NP9qWLUDweEjgBo+c6LXHuK0xxeJ6uHmUjOzDfmrd0lh8L5JqO7+z
        a3Q9eVmSrCLArN8j3QboSfI0pU0wi1ffpM3AARR7D7OW2EGCtgj4JLpFtCZcEgo3xXDyCp
        5MD/cRr8TGPnpkCh88c1S6PCaJN/oQY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-XawANqj8OqOsSn4-l6wFSg-1; Tue, 14 Apr 2020 12:28:46 -0400
X-MC-Unique: XawANqj8OqOsSn4-l6wFSg-1
Received: by mail-qt1-f197.google.com with SMTP id g23so12305960qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjWxSbfmmzPB+9cl5oT2tFJutn094jI8t91pgbfl/bY=;
        b=DCR3EkRgBxmLRddXmJOmLh/906zIIRosQJDp5DnLKu0wbuJoOWHJ9KdXh/HIBiskgR
         2aVpoeg75Hl2f+n2Vk7ms7Ou1VcgyWqa6ijIrPOnhcFcaq2adaeGzGKD327bfhAEeZTi
         T4ICM1ZzflIFhIo1QZPgpm0wIjKrZywpQ/m7Dq5R4jwUw5c6wSkzWeYAcPFVtehsczAf
         1v2axhQYFRqM3R+ss4uBCysEEwlvvjU3h0TsoAKXMkLMxd57bHlEEOVhMgLAMCl5wRxB
         4uMdteUV+Bbn9vHQQVEsJrVqf0TXmAJbb2MLQJ4ltMkopFMaWx6MI35BQ32fSHbfsCKA
         laSg==
X-Gm-Message-State: AGi0PubqGrRLw0KtHOMyW57Y7bxklKyuUEdeuFG5pmhi/7XYLcMx8Mos
        QEtQv8SAnPXNlKecpSepH93CNXikUTPxmS8XLs9DpxN8GAxeyGK89fP8eY89KjnlWpbL3IveuI5
        fIMmDe+SIA5w4BlTzuR9TS53x
X-Received: by 2002:ac8:6043:: with SMTP id k3mr15295318qtm.99.1586881725609;
        Tue, 14 Apr 2020 09:28:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4y/Xa4C4HgHuCyuPRYI8NOYdTc8eSgKzUQlVgQoEI+PhLHm/qmH5N/f+tJAy3tV4SwX5BzQ==
X-Received: by 2002:ac8:6043:: with SMTP id k3mr15295280qtm.99.1586881725363;
        Tue, 14 Apr 2020 09:28:45 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id o22sm371970qtm.90.2020.04.14.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:28:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:28:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Samuel Ortiz <samuel.ortiz@intel.com>,
        Robert Bradford <robert.bradford@intel.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        teawater <teawaterz@linux.alibaba.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Len Brown <lenb@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
Message-ID: <20200414122716-mutt-send-email-mst@kernel.org>
References: <20200311171422.10484-1-david@redhat.com>
 <20200329084128-mutt-send-email-mst@kernel.org>
 <b9984195-bb48-e2a6-887d-0905692a7524@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9984195-bb48-e2a6-887d-0905692a7524@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:15:18AM +0200, David Hildenbrand wrote:
> On 29.03.20 14:42, Michael S. Tsirkin wrote:
> > On Wed, Mar 11, 2020 at 06:14:12PM +0100, David Hildenbrand wrote:
> >> This series is based on latest linux-next. The patches are located at:
> >>     https://github.com/davidhildenbrand/linux.git virtio-mem-v2
> >>
> >> I now have acks for all !virtio-mem changes. I'll be happy to get review
> >> feedback, testing reports, etc. for the virtio-mem changes. If there are
> >> no further comments, I guess this is good to go as a v1 soon.
> > 
> > I'd like to queue it for merge after the release. If you feel it's ready
> > please ping me after the release to help make sure it didn't get
> > dropped.  I see there were some reports about people having trouble
> > using this, pls keep working on this meanwhile.
> 
> Hi Michael,
> 
> I think this is ready to go as a first version. There are a couple of
> future work items related to kexec/kdump:
> - Teach kexec-tools/kexec_file_load() to not place the kexec
>   kernel/initrd onto virtio-mem added memory.
> - Teach kexec-tools/kdump to consider a bigger number of memory
>   resources for dumping.
> 
> In general, as virtio-mem adds a lot of memory resources, we might want
> to tweak performance in that area as well. Future stuff.
> 
> So I suggest queuing this. If you need a resend, please let me know.
> 
> Cheers!

Thanks!
I'll queue it for merge after the release. If possible please ping me
after the release to help make sure it didn't get dropped.




> -- 
> Thanks,
> 
> David / dhildenb

