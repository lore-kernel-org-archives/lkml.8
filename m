Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A86C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA10207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404360AbgE1PVj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:21:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:21665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404271AbgE1PVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:21:37 -0400
IronPort-SDR: +PrWkeR7NKbm099t4fJUvZ+lKP9z0oYEoVYWmLEm6QqHhulTcWq5V0XpJOXMbBv7sZFCepHtn4
 SKVvYvZ4ghxA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:21:37 -0700
IronPort-SDR: 2StUYC0pcSlnqJlBdbSoTJnv84fYnfmJ21iYzmKquRBq+uXwQMWWmIDeuVWswkskwoSgfpyK06
 Hqq7wjvK7ElQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="256192753"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 08:21:37 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 08:21:36 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.119]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.235]) with mapi id 14.03.0439.000;
 Thu, 28 May 2020 08:21:36 -0700
From:   "Kleen, Andi" <andi.kleen@intel.com>
To:     "Tang, Feng" <feng.tang@intel.com>, Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Thread-Topic: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Thread-Index: AQHWNQIlUjqwkSwmEkaddhwmrHfhIqi9nR5A
Date:   Thu, 28 May 2020 15:21:36 +0000
Message-ID: <E8ECBC65D0B2554DAD44EBE43059B3741A2BFEEC@ORSMSX110.amr.corp.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200528141802.GB1810@lca.pw>
 <20200528151020.GF93879@shbuild999.sh.intel.com>
In-Reply-To: <20200528151020.GF93879@shbuild999.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>If it's true, then there could be 2 solutions, one is to skip the WARN_ONCE as it has no practical value, as the real >check is the following code, the other is to rectify the percpu counter when the policy is changing to >OVERCOMMIT_NEVER.

I think it's better to fix it up when the policy changes. That's the right place. The WARN_ON might be useful to catch other bugs.

-Andi
 
