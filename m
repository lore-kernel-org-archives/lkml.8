Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BDA2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407351AbgE1UsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:48:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:33702 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407361AbgE1UsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:48:17 -0400
IronPort-SDR: y7+YuBGDZXMu1WGHEjYZfjO4UQzutBxw+Gx+mdGaLXgJnFFICsMzP8h+FcNUIHek5Ofot+7RyJ
 ANsAud8DwhnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 13:48:15 -0700
IronPort-SDR: fdrY26aHiOHES6o3A3++/DhfQpP5qC/qbzmt11Lh9om46dWEDFKZYbh3zSHSYR7CvGE0kSTwBj
 DSBd6JIadlXQ==
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="376494617"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.209.105.84]) ([10.209.105.84])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 13:48:14 -0700
Subject: Re: [PATCH v4 10/10] cacheinfo: Move resctrl's get_cache_id() to the
 cacheinfo header file
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200526134059.1690-1-james.morse@arm.com>
 <20200526134059.1690-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3b1babde-b439-3cb4-e819-40f54263f46f@intel.com>
Date:   Thu, 28 May 2020 13:46:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526134059.1690-11-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/26/2020 6:40 AM, James Morse wrote:
> resctrl/core.c defines get_cache_id() for use in its cpu-hotplug
> callbacks. This gets the id attribute of the cache at the corresponding
> level of a cpu.
> 
> Later rework means this private function needs to be shared. Move
> it to the header file.
> 
> The name conflicts with a different definition in intel_cacheinfo.c,
> name it get_cpu_cacheinfo_id() to show its relation with
> get_cpu_cacheinfo().
> 
> Now this is visible on other architectures, check the id attribute
> has actually been set.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---

Moving this out of resctrl seems appropriate, thank you.

For the resctrl portions:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
