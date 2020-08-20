Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609502078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDCql8dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHTElh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:41:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30700 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgHTElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597898494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FawlYeQPcm1j7Zq9lJ25yGvGfdLQoOkhrat1d3Sia+Y=;
        b=CDCql8dzj8mTEgD7QoPNi4HnaLLag+xhTDUqltlLC7N0h8tVYSCPlNcPGmjmq8dIEUOfGh
        ms+jNkFc6Nu05U8DBoi/nTRRSfbxlDnEJ4mw/vzFMfupoGwc5zxlnuJIboLUftL/V3BahH
        xv2tSbkvPM8mwzTlMLOU3EVafJtNcWw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-dDBrsD9eM4GUWUKSYQOwsw-1; Thu, 20 Aug 2020 00:41:33 -0400
X-MC-Unique: dDBrsD9eM4GUWUKSYQOwsw-1
Received: by mail-pg1-f197.google.com with SMTP id z16so518476pgh.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FawlYeQPcm1j7Zq9lJ25yGvGfdLQoOkhrat1d3Sia+Y=;
        b=ZIRccayyz44R96yq7yYMU1Dxo9TCd18puEMArYGzSMeHERH20Q87obeDRQ0FKpYQ20
         Wc4ZE9YA96nsWbXWNGiUpRgb1T8RX8aIivH8yqKb2xlmndOTVEcrNQ357gqAWirnOTiz
         mDZgxqpifdg4otPRJsI/RyHicd9ILoIcxYf9UMQff3Wz0N0Xnz3xjdk3PJmP+1b8Cuie
         RFMeCDowUva6CavMJzyEvxLD/zkIPSyZmvUSlRZxf13fY/KvfALACiZYzHGFxoMQTfoK
         EFQ4pkesDkoDvCJHntxQjM9ndkuHjaKT6xh0o3j33eicG2F2HN2SVRwtkt0mzv6tUksE
         uD9w==
X-Gm-Message-State: AOAM532dnSXdX2n5cQkX2GvW5BAduIntNGUzJjeidWj7XWaOcoDBrc30
        zUq71ICVMXONOJaJlFTExvSMhlEZMESazAOSpRC5cWCgGR59vmPVtHsSK+q9SccXuUojrgby1Zm
        ZG7BSMj63tW9IVjr9+oOLLGxg
X-Received: by 2002:a17:90a:6a8d:: with SMTP id u13mr959851pjj.166.1597898492012;
        Wed, 19 Aug 2020 21:41:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDV5HicPAU/dYLjNBDH689m2WckfoWML+OpLh4ESvPaJhPhNe3pktnZl4ZzLv/bV7HCMJXPw==
X-Received: by 2002:a17:90a:6a8d:: with SMTP id u13mr959833pjj.166.1597898491774;
        Wed, 19 Aug 2020 21:41:31 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v128sm961284pfc.14.2020.08.19.21.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:41:31 -0700 (PDT)
Date:   Thu, 20 Aug 2020 12:41:20 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, THP, swap: fix allocating cluster for swapfile by
 mistake
Message-ID: <20200820044120.GB12374@xiangao.remote.csb>
References: <20200819195613.24269-1-hsiangkao@redhat.com>
 <871rk2x7bb.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rk2x7bb.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On Thu, Aug 20, 2020 at 12:36:08PM +0800, Huang, Ying wrote:
> Gao Xiang <hsiangkao@redhat.com> writes:
> 
> > SWP_FS doesn't mean the device is file-backed swap device,
> > which just means each writeback request should go through fs
> > by DIO. Or it'll just use extents added by .swap_activate(),
> > but it also works as file-backed swap device.
> >
> > So in order to achieve the goal of the original patch,
> > SWP_BLKDEV should be used instead.
> >
> > FS corruption can be observed with SSD device + XFS +
> > fragmented swapfile due to CONFIG_THP_SWAP=y.
> >
> > Fixes: f0eea189e8e9 ("mm, THP, swap: Don't allocate huge cluster for file backed swap device")
> > Fixes: 38d8b4e6bdc8 ("mm, THP, swap: delay splitting THP during swap out")
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> Good catch!  The fix itself looks good me!  Although the description is
> a little confusing.
> 
> After some digging, it seems that SWP_FS is set on the swap devices
> which make swap entry read/write go through the file system specific
> callback (now used by swap over NFS only).

Okay, let me send out v2 with the updated commit message in
https://lore.kernel.org/r/20200820012409.GB5846@xiangao.remote.csb/

Thanks,
Gao Xiang

> 
> Best Regards,
> Huang, Ying
> 
> > ---
> >
> > I reproduced the issue with the following details:
> >
> > Environment:
> > QEMU + upstream kernel + buildroot + NVMe (2 GB)
> >
> > Kernel config:
> > CONFIG_BLK_DEV_NVME=y
> > CONFIG_THP_SWAP=y
> >
> > Some reproducable steps:
> > mkfs.xfs -f /dev/nvme0n1
> > mkdir /tmp/mnt
> > mount /dev/nvme0n1 /tmp/mnt
> > bs="32k"
> > sz="1024m"    # doesn't matter too much, I also tried 16m
> > xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
> > xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
> > xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
> > xfs_io -f -c "pwrite -F -S 0 -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
> > xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fsync" /tmp/mnt/sw
> >
> > mkswap /tmp/mnt/sw
> > swapon /tmp/mnt/sw
> >
> > stress --vm 2 --vm-bytes 600M   # doesn't matter too much as well
> >
> > Symptoms:
> >  - FS corruption (e.g. checksum failure)
> >  - memory corruption at: 0xd2808010
> >  - segfault
> >  ... 
> >
> >  mm/swapfile.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 6c26916e95fd..2937daf3ca02 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1074,7 +1074,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> >  			goto nextsi;
> >  		}
> >  		if (size == SWAPFILE_CLUSTER) {
> > -			if (!(si->flags & SWP_FS))
> > +			if (si->flags & SWP_BLKDEV)
> >  				n_ret = swap_alloc_cluster(si, swp_entries);
> >  		} else
> >  			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
> 

