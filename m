Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D578C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596B82073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407355AbgE1Ung (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:43:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:34535 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407321AbgE1Und (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:43:33 -0400
IronPort-SDR: JJGIvi9PCVXNK93bl/T4jC1Y+ny+E0xSY9j/uHTdnkffk1uYwVV4FrdXp854T7fiWQqzCCSjoM
 9e+6aLKVdFqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 13:43:32 -0700
IronPort-SDR: fPDNBbfFahyufJij4QOlDmjp2fg8jPjaN8CW2W53KtUcO8Zc89rNaJZCppE65v+OvKoXmVg91Y
 AoD68vLhmB4A==
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="376493429"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.209.105.84]) ([10.209.105.84])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 13:43:31 -0700
Subject: Re: [PATCH v4 09/10] x86/resctrl: Add arch_has_{sparse,empty}_bitmaps
 to explain CAT differences
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200526134059.1690-1-james.morse@arm.com>
 <20200526134059.1690-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5ea41011-512f-48f0-ad57-e564b2f2982d@intel.com>
Date:   Thu, 28 May 2020 13:43:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526134059.1690-10-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/26/2020 6:40 AM, James Morse wrote:
> Intel CPUs expect the cache bitmap provided by user-space to have on
> a single span of 1s, whereas AMD can support bitmaps like 0xf00f.
> Arm's MPAM support also allows sparse bitmaps.
> 
> Similarly, Intel CPUs check at least one bit set, whereas AMD CPUs
> are quite happy with an empty bitmap. Arm's MPAM allows an empty
> bitmap.
> 
> To move resctrl out to /fs/ we need to explain platform differences
> like this. Add two resource properties arch_has_{empty,sparse}_bitmaps.
> Test these around the relevant parts of cbm_validate().
> 
> Merging the validate calls causes AMD to gain the min_cbm_bits test
> needed for Haswell, but as it always sets this value to 1, it will
> never match.
> 
> CC: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thank you for adding handling of empty bitmaps.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
