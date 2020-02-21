Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3145BC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068FE20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBUUGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:06:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42816 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:06:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id e8so1313569plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EijXnKKsPn7K9V17kkNVa3bqeO3+1rP0dN15QJMaRtw=;
        b=NEdEP0X0ntU0IRRwecqV0nwOatE2EyG5sY/bMN+2HDWbGRA3m9zzmY+q8EOxlca6vo
         f6g1EAKcT5OQTuRTf8QaoMOSiCLuEX+eP80nBJaHVZ2N1XKQu5LlAwBXPkXjy855BWFe
         cvvhWNDtgwlrONnTHvU4lKSSIryC0xNQid70JpAQQIn8SMcomfExKseELQsyuRt+q3wh
         aEXKdGsIq+bTT5YElKPAKuuqcR9BFt+hZf97KkzlKqfAYJ4gDI+wVJBYP7/7bLYegPzq
         TL4g3SZJROD/lvxlhc25bEFl+REFVNe+9oJJ6+2Vq0Xbx6woJj7mVY4cA2Kl85sbKGMh
         XqSA==
X-Gm-Message-State: APjAAAWBlOY84X2dJTk2jkPwZ8b94QCIAfJsXTGrrmXxpCuo7BB5pfs7
        e0MpTkF45QPvUv1aj6oarp4=
X-Google-Smtp-Source: APXvYqzpZGSbUZ2SMI9JRncg6S3oaeh/qgHIoMtwNGGpzXrPb30sGaElGmPZPFW/EWn1cxOprUyucg==
X-Received: by 2002:a17:90a:654a:: with SMTP id f10mr4995597pjs.50.1582315568577;
        Fri, 21 Feb 2020 12:06:08 -0800 (PST)
Received: from sultan-book.localdomain ([2620:15c:f:fd00:d989:fbb1:a399:c92d])
        by smtp.gmail.com with ESMTPSA id d24sm3729762pfq.75.2020.02.21.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 12:06:08 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:06:05 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200221200605.GA2416@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
 <CALvZod5zJo186v=-QHGRvap67axexp6oL8=qXEjq670F2yAdSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5zJo186v=-QHGRvap67axexp6oL8=qXEjq670F2yAdSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:04:38AM -0800, Shakeel Butt wrote:
> Can you also attach the /proc/zoneinfo? Maybe the watermarks are too high.

Here it is (when booted with mem=2G).

Sultan

Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 236
      nr_active_anon 47914
      nr_inactive_file 44716
      nr_active_file 22397
      nr_unevictable 11665
      nr_slab_reclaimable 11217
      nr_slab_unreclaimable 16465
      nr_isolated_anon 0
      nr_isolated_file 0
      workingset_nodes 0
      workingset_refault 0
      workingset_activate 0
      workingset_restore 0
      workingset_nodereclaim 0
      nr_anon_pages 47716
      nr_mapped    34753
      nr_file_pages 79237
      nr_dirty     66
      nr_writeback 0
      nr_writeback_temp 0
      nr_shmem     12120
      nr_shmem_hugepages 0
      nr_shmem_pmdmapped 0
      nr_file_hugepages 0
      nr_file_pmdmapped 0
      nr_anon_transparent_hugepages 0
      nr_unstable  0
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   3143
      nr_written   3073
      nr_kernel_misc_reclaimable 0
  pages free     3975
        min      173
        low      216
        high     259
        spanned  4095
        present  3998
        managed  3975
        protection: (0, 992, 992, 992, 992)
      nr_free_pages 3975
      nr_zone_inactive_anon 0
      nr_zone_active_anon 0
      nr_zone_inactive_file 0
      nr_zone_active_file 0
      nr_zone_unevictable 0
      nr_zone_write_pending 0
      nr_mlock     0
      nr_page_table_pages 0
      nr_kernel_stack 0
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  0
      numa_hit     0
      numa_miss    0
      numa_foreign 0
      numa_interleave 0
      numa_local   0
      numa_other   0
  pagesets
    cpu: 0
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 1
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 2
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 3
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 4
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 5
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 6
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
    cpu: 7
              count: 0
              high:  0
              batch: 1
  vm stats threshold: 8
  node_unreclaimable:  0
  start_pfn:           1
Node 0, zone    DMA32
  pages free     87925
        min      11090
        low      13862
        high     16634
        spanned  294144
        present  270018
        managed  257874
        protection: (0, 0, 0, 0, 0)
      nr_free_pages 87925
      nr_zone_inactive_anon 236
      nr_zone_active_anon 47914
      nr_zone_inactive_file 44716
      nr_zone_active_file 22397
      nr_zone_unevictable 11665
      nr_zone_write_pending 66
      nr_mlock     16
      nr_page_table_pages 1284
      nr_kernel_stack 5024
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  0
      numa_hit     544686
      numa_miss    0
      numa_foreign 0
      numa_interleave 8149
      numa_local   544686
      numa_other   0
  pagesets
    cpu: 0
              count: 358
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 1
              count: 335
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 2
              count: 308
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 3
              count: 337
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 4
              count: 326
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 5
              count: 315
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 6
              count: 370
              high:  378
              batch: 63
  vm stats threshold: 32
    cpu: 7
              count: 292
              high:  378
              batch: 63
  vm stats threshold: 32
  node_unreclaimable:  0
  start_pfn:           4096
Node 0, zone   Normal
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0, 0, 0)
Node 0, zone  Movable
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0, 0, 0)
Node 0, zone   Device
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0, 0, 0)
