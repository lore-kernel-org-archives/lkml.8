Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3CDC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88F0208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgEKSPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:15:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:48472 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgEKSO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:14:59 -0400
IronPort-SDR: sUAk0p1aeW/MFSEKzEXBwTFjcaBUwvxKeJUhwM6K6/LP3ZjrYL8LbLDCr1uXJg3hits8GyIaQW
 wobFUbridamg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 11:14:58 -0700
IronPort-SDR: BpkxzblzM2I1siBJKtycZz+TxOlbj8w5qCdZbj8vzlbHy6R/TrVYfwAIndohx7bWNz5Jz4keiU
 hfre976NkXeA==
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="409004530"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.97.196]) ([10.254.97.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 11:14:58 -0700
Subject: Re: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to
 explain AMD/Intel CAT difference
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <8383ddd9-5849-d948-c391-aeb0cc927423@intel.com>
Date:   Mon, 11 May 2020 11:14:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430170400.21501-10-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/30/2020 10:03 AM, James Morse wrote:
> Intel expects the cache bitmap provided by user-space to have on a
> single span of 1s, whereas AMD can support bitmaps like 0xf00f.
> Arm's MPAM support also allows sparse bitmaps.
> 
> To move resctrl out to /fs/ we need to explain platform differences
> like this. Add a resource property arch_has_sparse_bitmaps. Test this
> around the 'non-consecutive' test in cbm_validate().
> 
> Merging the validate calls causes AMD top gain the min_cbm_bits test
> needed for Haswell, but as it always sets this value to 1, it will
> never match.
> 
> CC: Babu Moger <Babu.Moger@amd.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

The Intel bits do indeed look good to me but we should check the AMD
portion ... I peeked at the AMD spec [1] and found "If an L3_MASK_n
register is programmed with all 0’s, that COS will be prevented from
allocating any lines in the L3 cache" ... so AMD does allow bitmasks of
all 0's (Intel does not).

Does MPAM also allow all 0's? Perhaps "arch_has_sparse_bitmaps" can be
used to indicate that also?

Reinette
 [1] https://developer.amd.com/wp-content/resources/56375.pdf



