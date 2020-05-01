Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16EC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762B4208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgEAVGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:06:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:3274 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:06:55 -0400
IronPort-SDR: XEq9ZBGISbmFdDu5TEvcsyEMctO/Sck3agWk6mzjJ6rjyxhmZQqOV5N2L8NH+19D77r9wxDIY0
 Fmm0mJDxZbzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 14:06:54 -0700
IronPort-SDR: t2PqYLdbKCc7wr0GW+Q1DcVZcCRz7MTrjlU96aXv/GRzvAc4vieAEvX6CJuFmCThNzQuhVVW5z
 c9NusSaHCRow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="283291765"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 14:06:54 -0700
Subject: [RFC][PATCH 0/2] mm: tweak page cache migration
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, npiggin@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 01 May 2020 14:05:16 -0700
Message-Id: <20200501210516.DFAFF456@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I think this little slice of code is a bit
under-documented.  Perhaps this will help clarify things.

I'm pretty confident the page_count() check in the first
patch is right, which is why I removed it outright.  The
xas_load() check is a bit murkier, so I just left a
warning in for it.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
