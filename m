Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56D2C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7434D20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgBFJ2Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:28:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:56809 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgBFJ2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:28:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 01:28:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="250005064"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2020 01:28:24 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 01:28:24 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Feb 2020 01:28:24 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Feb 2020 01:28:24 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.141]) with mapi id 14.03.0439.000;
 Thu, 6 Feb 2020 17:28:22 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "tysand@google.com" <tysand@google.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Topic: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Index: AQHV3Mq/N+pHUOUW3kyXc/hsfZBMQqgNWrYAgACKBvA=
Date:   Thu, 6 Feb 2020 09:28:22 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E4238BA@shsmsx102.ccr.corp.intel.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <6ccbfeea-de66-20d7-0e08-a5834a3c3d3f@redhat.com>
In-Reply-To: <6ccbfeea-de66-20d7-0e08-a5834a3c3d3f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 6, 2020 5:10 PM, David Hildenbrand wrote:
> so dropping caches (echo 3 > /proc/sys/vm/drop_caches) will no longer
> deflate the balloon when conservative_shrinker=true?
> 

Should be. Need Tyler's help to test it.

Best,
Wei

