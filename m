Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01482C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D434120674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgCPSJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:09:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:35650 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbgCPSJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:09:05 -0400
IronPort-SDR: ER/kw9YZIDAMXvkib9OQH2bGLfbAxHQl9H3vruB2XiiS8q5w7E2CXAsWyzScTUIwB+i9iB41Yj
 g9zEzh0V+bLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:09:05 -0700
IronPort-SDR: pMN7f1wp5FIHoSowEgrupSmix4PySELm+2jRtnplfi/5yHaNQn9idVQrnJehhw/H5f4tqFOMHm
 dYKH/FSI5O4A==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390785292"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.77.132]) ([10.254.77.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:09:04 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH 01/10] x86/resctrl: Nothing uses struct mbm_state
 chunks_bw
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200214182401.39008-1-james.morse@arm.com>
 <20200214182401.39008-2-james.morse@arm.com>
Message-ID: <6bc0e3e8-5a04-71e1-aa3f-4356379d0cf9@intel.com>
Date:   Mon, 16 Mar 2020 11:09:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200214182401.39008-2-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:23 AM, James Morse wrote:
> Nothing reads struct mbm_states's chunks_bw value, its a copy of
> chunks. Remove it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you

Reinette


