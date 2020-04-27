Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09BC81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C0C21D79
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD0XJB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:09:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:25350 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0XJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:09:01 -0400
IronPort-SDR: CiSfXrGRg+4mUdBJPOZkvSR9tyBN/5TucfUyfXzeXV5k4b9ZNHzWTa0K9Nd1yItJ8n2PFWo39A
 6smOxR4ykdzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 16:09:01 -0700
IronPort-SDR: p9W4QCXJcDwYX9ymVbBmEOs/thB1bW7Wf5XfRDODzBOs0MSN6Se7K/rqOUjFRHQIV1cSz84MpT
 jDZ5yQRfCNpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="260896169"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2020 16:09:00 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Apr 2020 16:09:00 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.133]) with mapi id 14.03.0439.000;
 Mon, 27 Apr 2020 16:09:00 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 6/7] x86/traps: Fix up invalid PASID
Thread-Topic: [PATCH 6/7] x86/traps: Fix up invalid PASID
Thread-Index: AQHWBtMhyjaBsrFNmEyApZQ4dM/Yo6iMJWwAgAINuwD//41J4A==
Date:   Mon, 27 Apr 2020 23:08:59 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F6070AA@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de> <20200427224646.GA103955@otc-nc-03>
In-Reply-To: <20200427224646.GA103955@otc-nc-03>
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

> Just for the record I also suggested to have a proper errorcode in the
> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
> instructions.

Thomas,

Is the heuristic to avoid decoding the user instructions OK (you are just pointing
out that you should not be given credit for this part of the idea)?

Or are you saying that you'd like to see the instruction checked to see that it
was an ENQCMD?

-Tony

 
