Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D357CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE992073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHaQSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:18:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:42417 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHaQSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:18:34 -0400
IronPort-SDR: bHNKhcgWCCKC8BbIRaXN9obBSEbarAz8TN2nfOeaWcPUlvwQ4vtBJfH+Fv0PGKu9x/K8Ex2k8X
 buURgs6+ZrCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="158017172"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="158017172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 09:18:29 -0700
IronPort-SDR: JoD+LXH8r7nIR9pwizZhL0agboDTc4CQEfMSnL4q/visw3TuQO2aHUiDeN6aH8q8IhryEh744W
 7jnVukwpeuhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="296978887"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2020 09:18:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 09:17:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 09:17:37 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 31 Aug 2020 09:17:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH] MAINTAINERS: IA64: mark Status as Odd Fixes only
Thread-Topic: [PATCH] MAINTAINERS: IA64: mark Status as Odd Fixes only
Thread-Index: AQHWfmUDEdRyqneU9UeJF3APC1yQGalSZ4Iw
Date:   Mon, 31 Aug 2020 16:17:36 +0000
Message-ID: <331482a4b3b9437f9282b9fc05b9739d@intel.com>
References: <7e719139-450f-52c2-59a2-7964a34eda1f@infradead.org>
In-Reply-To: <7e719139-450f-52c2-59a2-7964a34eda1f@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJQTY0IGlzbid0IHJlYWxseSBiZWluZyBtYWludGFpbmVkLCBzbyBtYXJrIGl0IGFzDQo+IE9k
ZCBGaXhlcyBvbmx5Lg0KDQpBY2tlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29t
Pg0KDQo=
