Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FEFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EE6206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbgEKUn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:43:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:28138 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbgEKUnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:43:24 -0400
IronPort-SDR: /dwEkPbKT/nBde8ZLqWuy5ssHs8RU+2/ble1EyAvhYA3t9l0fXHofOZ/zNxg74aWclOc16m/E6
 COPN5GCfBZ1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 13:43:24 -0700
IronPort-SDR: UpZl4EjoBBil30FlpvxxjWI6R6yrWJy/OcaM0MjAcBg1fwt+GXXF10SbPBgmfJbuBFTt78+NM5
 +AgfM8ZVxTjQ==
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="409047494"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.97.196]) ([10.254.97.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 13:43:23 -0700
Subject: Re: [PATCH v2 08/10] x86/resctrl: Merge AMD/Intel parse_bw() calls
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3db422b2-48d4-2365-dc8f-aabc11abc5d4@intel.com>
Date:   Mon, 11 May 2020 13:43:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430170400.21501-9-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/30/2020 10:03 AM, James Morse wrote:
> Now that we've explained arch_needs_linear to resctrl, the parse_bw()
> calls are almost the same between AMD and Intel.
> 
> The difference is '!is_mba_sc()', which is not checked on AMD. This
> will always be true on AMD CPUs as mba_sc cannot be enabled as
> is_mba_linear() is false.
> 
> Removing this duplication means user-space visible behaviour and
> error messages are not validated or generated in different places.
> 
> CC: Babu Moger <Babu.Moger@amd.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
