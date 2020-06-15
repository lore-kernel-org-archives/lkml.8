Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1FFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750162074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgFOUsY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:48:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:11797 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgFOUsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:48:23 -0400
IronPort-SDR: wv8Hm55XLfxdWJ2Kn8lpWzH6ZAiyJHSJBcFqKgQeB31p+UkLct1f2FTCac0BdblIyCzU8aAild
 QfAoi/L8XTAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 13:48:22 -0700
IronPort-SDR: Am/SKLeJ8b43icXAXBUuywBBQBFzKMk1G/MzbnK6Jx0ZG6mgW369the8WlUoZK4qJ+yTrSuS7Y
 Iblsn38rPnFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="308862080"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2020 13:48:22 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 13:48:21 -0700
Received: from fmsmsx102.amr.corp.intel.com ([169.254.10.33]) by
 fmsmsx156.amr.corp.intel.com ([169.254.13.189]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 13:48:21 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "jlelli@redhat.com" <jlelli@redhat.com>
Subject: RE: [Patch v1] i40e: limit the msix vectors based on housekeeping
 CPUs
Thread-Topic: [Patch v1] i40e: limit the msix vectors based on housekeeping
 CPUs
Thread-Index: AQHWQ1KUwSgU+rT5bUSl1INlbp/95KjaJWLQ
Date:   Mon, 15 Jun 2020 20:48:21 +0000
Message-ID: <02874ECE860811409154E81DA85FBB58C25F8001@FMSMSX102.amr.corp.intel.com>
References: <20200615202125.27831-1-nitesh@redhat.com>
 <20200615202125.27831-2-nitesh@redhat.com>
In-Reply-To: <20200615202125.27831-2-nitesh@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nitesh Narayan Lal <nitesh@redhat.com>
> Sent: Monday, June 15, 2020 1:21 PM
> To: linux-kernel@vger.kernel.org; frederic@kernel.org; mtosatti@redhat.com;
> sassmann@redhat.com; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Keller,
> Jacob E <jacob.e.keller@intel.com>; jlelli@redhat.com
> Subject: [Patch v1] i40e: limit the msix vectors based on housekeeping CPUs
> 
> In a realtime environment, it is essential to isolate
> unwanted IRQs from isolated CPUs to prevent latency overheads.
> Creating MSIX vectors only based on the online CPUs could lead
> to a potential issue on an RT setup that has several isolated
> CPUs but a very few housekeeping CPUs. This is because in these
> kinds of setups an attempt to move the IRQs to the limited
> housekeeping CPUs from isolated CPUs might fail due to the per
> CPU vector limit. This could eventually result in latency spikes
> because of the IRQ threads that we fail to move from isolated
> CPUs. This patch prevents i40e to add vectors only based on
> available online CPUs by using housekeeping_cpumask() to derive
> the number of available housekeeping CPUs.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---

Ok, so the idea is that "housekeeping" CPUs are to be used for general purpose configuration, and thus is a subset of online CPUs. By reducing the limit to just housekeeping CPUs, we ensure that we do not overload the system with more queues than can be handled by the general purpose CPUs?

Thanks,
Jake
