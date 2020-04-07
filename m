Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312ECC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81DC20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgDGTx6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:53:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:18526 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbgDGTx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:53:57 -0400
IronPort-SDR: hbotkgA8sbgQWxEE72MFJFx/PWon/JBJ2lk9VfqsIlZGcM3kSWZQ1tE6dKH1SQz4zAih+p2I9W
 ColjiJnEszSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 12:53:57 -0700
IronPort-SDR: EOQpdJHw8Xv/8Z2IzxVEfz8+bhH1R5V/Zu6RwmkxCBL7Meo/ptCRe+h8PgKIeCeoj2eWbsBF1w
 klMwDaA+/u/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="397968924"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2020 12:53:57 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 12:53:57 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.226]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 12:53:56 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/9 v3] New way to track mce notifier chain actions
Thread-Topic: [PATCH 0/9 v3] New way to track mce notifier chain actions
Thread-Index: AQHWDPp8vp48dLXhV06F4vOElkh+Z6huEcbg
Date:   Tue, 7 Apr 2020 19:53:56 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5D49A9@ORSMSX115.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
In-Reply-To: <20200407163414.18058-1-bp@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The last patch is something tglx spotted yesterday and fixing that with
> the MCE flags is pretty easy - was boxing with a wrapper struct around
> struct mce and that gets really ugly.
>
> Tony, I'm open to suggestions how to test it - I probably don't have an
> access to such box which can trigger read errors on nvdimms or what was
> the use case?

It passes my smoke tests (uncorrectable error consumed by application and
uncorrectable error consumed by mcsafe_memcpy()).

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
