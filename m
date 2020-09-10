Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9069520719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgIJWBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:01:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:19526 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgIJWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:01:49 -0400
IronPort-SDR: uHDGCZX9VPTPdDsmpwjpxTAPcEqxWY0z9JorPqIqNmZJ0XgaRlb8XxSYH5zAMJu1BZztRTqpIL
 FEiDCKIbX80w==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="138160321"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="138160321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 15:01:49 -0700
IronPort-SDR: QbaKABNB6/EoSyxG13iWtkm1aumy31ZG2ZYaEVBtfMDgQfbOe8wQcxWY/rB5VEaAfB+rDTS3jB
 sniE4nxHdwIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="305033315"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2020 15:01:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B0BFA15C; Fri, 11 Sep 2020 01:01:45 +0300 (EEST)
Date:   Fri, 11 Sep 2020 01:01:45 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
Message-ID: <20200910220145.5j7iogqulmvg5vr6@black.fi.intel.com>
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:47:39PM -0700, Vijay Balakrishna wrote:
> When memory is hotplug added or removed the min_free_kbytes must be
> recalculated based on what is expected by khugepaged.  Currently
> after hotplug, min_free_kbytes will be set to a lower default and higher
> default set when THP enabled is lost. This leaves the system with small
> min_free_kbytes which isn't suitable for systems especially with network
> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
> kills.
> 
> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org

NAK. It would override min_free_kbytes set by user.

-- 
 Kirill A. Shutemov
