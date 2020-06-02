Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354CA206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:13:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:56835 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgFBRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:13:12 -0400
IronPort-SDR: Rj2Xd5ek/uE0Ck68dyw9UHtVTRTIyJwvMO4c8imnouG9v0YhzOIp4Pnp3dqo/vaj5NKjdMXOoy
 VeaID6oTy36A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 10:13:11 -0700
IronPort-SDR: GGgrdG1oywjifHY4TWR/usPDuJswkayqUThgmvQsbFdUdVZ5puPuft2cpTllbpkzGAKc4xNJLP
 YhD0zGH36cJA==
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="272431786"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.209.123.248]) ([10.209.123.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 10:13:11 -0700
Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
To:     Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <63f23edd-39d3-0577-6e00-21066ddfe57f@intel.com>
Date:   Tue, 2 Jun 2020 10:13:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2020 4:00 PM, Babu Moger wrote:
> Memory bandwidth is calculated reading the monitoring counter
> at two intervals and calculating the delta. It is the software’s
> responsibility to read the count often enough to avoid having
> the count roll over _twice_ between reads.
> 
> The current code hardcodes the bandwidth monitoring counter's width
> to 24 bits for AMD. This is due to default base counter width which
> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
> to adjust the counter width. But, the AMD hardware supports much
> wider bandwidth counter with the default width of 44 bits.
> 
> Kernel reads these monitoring counters every 1 second and adjusts the
> counter value for overflow. With 24 bits and scale value of 64 for AMD,
> it can only measure up to 1GB/s without overflowing. For the rates
> above 1GB/s this will fail to measure the bandwidth.
> 
> Fix the issue setting the default width to 44 bits by adjusting the
> offset.
> 
> AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

There is no fixes tag but if I understand correctly this issue has been
present since AMD support was added to resctrl. This fix builds on top
of a recent feature addition and would thus not work for earlier
kernels. Are you planning to create a different fix for earlier kernels?

Reinette
