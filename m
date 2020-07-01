Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685D920780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgGAPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:46:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:54009 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGAPqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:46:38 -0400
IronPort-SDR: ZBh2onh17iTRNMlsNcFJn3W0Boz6FF8f6o5fLZKFH/gn0teeMRrngCIOskCvsa5GK9BU8Z7S6v
 PqPh6g3oJvfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="134075931"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="134075931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:46:38 -0700
IronPort-SDR: 4wJ3hkVveuE05LUCdhTqEwJ0coWC/y+NKcaPobYnpTx/tCoKqcc6ENy7s5p+N0Ldu6EKecLe6u
 JS4w+A05p4YA==
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="481642725"
Received: from sadedonx-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.134.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:46:36 -0700
Date:   Wed, 1 Jul 2020 08:46:35 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [PATCH 2/3] mm/vmscan: move RECLAIM* bits to uapi header
Message-ID: <20200701154635.2dwwz2b6xbeyp2rc@intel.com>
Mail-Followup-To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
References: <20200701152621.D520E62B@viggo.jf.intel.com>
 <20200701152624.D6FBDDA8@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701152624.D6FBDDA8@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:26:24, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> It is currently not obvious that the RECLAIM_* bits are part of the
> uapi since they are defined in vmscan.c.  Move them to a uapi header
> to make it obvious.
> 
> This should have no functional impact.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: "Tobin C. Harding" <tobin@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Daniel Wagner <dwagner@suse.de>
> 
> --
> 
> Note: This is not cc'd to stable.  It does not fix any bugs.
> ---
> 
>  b/include/uapi/linux/mempolicy.h |    7 +++++++
>  b/mm/vmscan.c                    |    8 --------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff -puN include/uapi/linux/mempolicy.h~mm-vmscan-move-RECLAIM-bits-to-uapi include/uapi/linux/mempolicy.h
> --- a/include/uapi/linux/mempolicy.h~mm-vmscan-move-RECLAIM-bits-to-uapi	2020-07-01 08:22:12.502955333 -0700
> +++ b/include/uapi/linux/mempolicy.h	2020-07-01 08:22:12.508955333 -0700
> @@ -62,5 +62,12 @@ enum {
>  #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
>  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>  
> +/*
> + * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> + * ABI.  New bits are OK, but existing bits can never change.
> + */
> +#define RECLAIM_ZONE  (1<<0)	/* Run shrink_inactive_list on the zone */
> +#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
> +#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */

Have you considered turning this into an enum while moving it?

>  
>  #endif /* _UAPI_LINUX_MEMPOLICY_H */
> diff -puN mm/vmscan.c~mm-vmscan-move-RECLAIM-bits-to-uapi mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-move-RECLAIM-bits-to-uapi	2020-07-01 08:22:12.504955333 -0700
> +++ b/mm/vmscan.c	2020-07-01 08:22:12.509955333 -0700
> @@ -4091,14 +4091,6 @@ module_init(kswapd_init)
>  int node_reclaim_mode __read_mostly;
>  
>  /*
> - * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> - * ABI.  New bits are OK, but existing bits can never change.
> - */
> -#define RECLAIM_ZONE  (1<<0)	/* Run shrink_inactive_list on the zone */
> -#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
> -#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
> -
> -/*
>   * Priority for NODE_RECLAIM. This determines the fraction of pages
>   * of a node considered for each zone_reclaim. 4 scans 1/16th of
>   * a zone.
> _
