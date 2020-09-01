Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6D72078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgIAPK1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:10:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:44800 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIAPKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:10:14 -0400
IronPort-SDR: lGB35X8lVXqmeURg5B9yY/hSidyFMrhUriySavm/P2O703ZaDR3QUjfYJi58IsZW6zuhsMDZOO
 gn2Mbg1GmeFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154691600"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="154691600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 08:10:11 -0700
IronPort-SDR: jLzcTjk/uOBg0RoHZOwp9TqCg46yUBWklGXcFqU/0inGvOaQE/ITf+KSTV66U7KvtoGIQ1EVrF
 2SdB7Su8O8GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="404805931"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2020 08:10:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 08:08:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 08:08:37 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Tue, 1 Sep 2020 08:08:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Rientjes" <rientjes@google.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] ia64: fix min_low_pfn/max_low_pfn build errors
Thread-Topic: [PATCH] ia64: fix min_low_pfn/max_low_pfn build errors
Thread-Index: AQHWfZeQG2gN8ZpSAUuKNWhMot21E6lTqDQAgAA/7AA=
Date:   Tue, 1 Sep 2020 15:08:37 +0000
Message-ID: <706c8eed209c4379baf2f1ac81b0112a@intel.com>
References: <20200829000126.2463-1-rdunlap@infradead.org>
 <20200901041902.GC424181@linux.ibm.com>
In-Reply-To: <20200901041902.GC424181@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I can take it via the memblock tree, would appreciate an Ack.

Thanks

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
