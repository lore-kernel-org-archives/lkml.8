Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D644C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8F022201
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgDPVjq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:39:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:4759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDPVjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:39:45 -0400
IronPort-SDR: V6O70ve3jz4FAcmj/zYJxVeH2JUQVKoljw/5qj3BFSYS099hFumxN5ggs/TtJAqyfCquM9X/3w
 9TCpV4k1R/8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 14:39:45 -0700
IronPort-SDR: bLFGYSxyl5zd7Hw3fGFFSo5pNhIQsbVsechtQx+02/joHUrRLwsM10hGWfYWZGs1AvA/AnfdTb
 58hqCTeIzqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="364127196"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 14:39:44 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 14:39:44 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.107]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 14:39:44 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 0/3] Split lock enumeration cleanup and fixes
Thread-Topic: [PATCH 0/3] Split lock enumeration cleanup and fixes
Thread-Index: AQHWFDG0HtEgXE1Lkk6M73WhlzF8nqh8utIA//+LUeA=
Date:   Thu, 16 Apr 2020 21:39:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5E8BDA@ORSMSX115.amr.corp.intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
 <87k12fm7vp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k12fm7vp.fsf@nanos.tec.linutronix.de>
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

> Why stable? The split lock stuff got merged post 5.6.

I have no sense of time ... in my memory it went in ages ago.  I guess I'm remembering
it making it into TIP.

Drop the stable stuff ... obviously no need.

-Tony
