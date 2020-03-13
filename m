Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D97C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0667D2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCMX2G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:28:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:61396 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCMX2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:28:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 16:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; 
   d="scan'208";a="237398961"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2020 16:28:05 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 16:28:05 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.76]) with mapi id 14.03.0439.000;
 Fri, 13 Mar 2020 16:28:05 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] ia64: replace setup_irq() by request_irq()
Thread-Topic: [PATCH v4] ia64: replace setup_irq() by request_irq()
Thread-Index: AQHV9UGq2aCUP9ErHUejHyKw+orV3ahG8YeAgABB30A=
Date:   Fri, 13 Mar 2020 23:28:05 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F59FA55@ORSMSX115.amr.corp.intel.com>
References: <20200304004936.4955-1-afzal.mohd.ma@gmail.com>
 <20200308120350.19117-1-afzal.mohd.ma@gmail.com>
 <20200313123141.GA7155@afzalpc>
In-Reply-To: <20200313123141.GA7155@afzalpc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems you handle pull requests for ia64, if this change is okay, can
> please consider taking this thr' your tree ?

Looks ok. Will apply.

-Tony
