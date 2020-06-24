Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAFD2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592988624;
	bh=PiVWBuP4c6htn4O6UyWhwT4IpNXo7bHxMloEmKHbJ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zf5Sj32gjXHLdrtHDKvcp5lJEIBOwe3fesX6HmCW7kUhpDhYcZLT3W8QGhW7Q55Ze
	 nLKhJCR2PyNA0RSBkxB029m0TDJ3pyanGMaMt+4AnAliUNeTc1hcLCyz7sHGfoISr+
	 gOtismHsGP6/czcMneQQjRZsBpaKRssleFbROr/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbgFXIuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:50:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37846 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389505AbgFXIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:50:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2so1718268wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rd9IzVM8tD3UftxMYmgDMxiwBT/HI+3YrHy3wROEERY=;
        b=l0GKK7EBk6SGTJlFftfARsUBxN9FWqbxF0kqGS+BCryaRywk8yKsGKxNV6twUBLt3g
         UphWpbh3CgTU9O1Q+64l5oqaqQxedUIeogoRuV8+hSkruiYMnt+Mesqfv/U2Pwyc8PcW
         IE1cbVKAO9VCSUxy0Bq9yntQm0PY6HpT2rXaodqJRiH613+3iTcfa8AS7B3iHj3MV5zA
         fQ83g3FJKCYY3uvMQtX7qKn9CS7IYfpkd1NWL9vdvJwAZWRto5XKDfJojJKVPmjzz9s3
         vHlUyJwzj0AsP5sa2DfN89aHdkfNyLKeWzliRSbXmn1zYjq5p5hVU3CvtU4/R81rGK/G
         azbg==
X-Gm-Message-State: AOAM532IFwvyTaFd5e5nmKAVIZTbpdBx1AF4Wr4aF38PiihzwEQnBKzY
        z1Zh6CVHzddkdkp5VYvGyMY=
X-Google-Smtp-Source: ABdhPJx5rN+DJcDsPUmCblVkVpduAwnEGOG7wPIeqoXZAqFAOdV/46mS5MBBC9+J5GZQHCzKzQzcIQ==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr22706313wmg.27.1592988616864;
        Wed, 24 Jun 2020 01:50:16 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id 185sm7124135wmz.22.2020.06.24.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:50:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:50:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624085015.GG1320@dhcp22.suse.cz>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
 <57d8a558-dcb3-b318-8e38-6c016b050414@redhat.com>
 <20200624081324.GA12461@L-31X9LVDL-1304.local>
 <2b2b722a-58de-4c6e-a04e-dc3516b1b8ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2b722a-58de-4c6e-a04e-dc3516b1b8ab@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-06-20 10:41:18, David Hildenbrand wrote:
[...]
> But nothing actually breaks .... because *drummroll* we use huge pages in the vmemmap,
> so the partial depopulate will not actually depopulate anything here. Huge page is 2M,
> the memmap of 128MB sections is exactly 2MB == one hugepages. Trying to depopulate a
> fraction (e.g., 16MB) of that won't do anything.
> 
> 
> Now, forcing a CPU without hugepages - PSE (QEMU: "-cpu host,pse=off)", I can trigger
> via  ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M

OK, now I am following! Thanks a lot. That is something to be mentioned
in the changelog. Small pages might be used if the hotplug happens on a
system with fragmented memory so this is something we do care about.

Thanks a lot David!

-- 
Michal Hocko
SUSE Labs
