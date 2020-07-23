Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF61620709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGWScF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:32:05 -0400
Received: from foss.arm.com ([217.140.110.172]:49924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgGWScF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:32:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90AECD6E;
        Thu, 23 Jul 2020 11:32:04 -0700 (PDT)
Received: from [192.168.0.57] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64E8A3F66E;
        Thu, 23 Jul 2020 11:32:03 -0700 (PDT)
Subject: Re: [PATCH v5 00/10] x86/resctrl: Misc cleanup
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200708163929.2783-1-james.morse@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1887b64a-dd18-25ff-a9f4-885c231c60b2@arm.com>
Date:   Thu, 23 Jul 2020 19:31:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708163929.2783-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 08/07/2020 17:39, James Morse wrote:
> These are the miscellaneous cleanup patches that floated to the top of
> the MPAM tree.

Is there anything else I should do with this series?
(Does patch 10 need an ACK from anyone else?)

Would a branch or pull request make anyone's life easier?


Thanks,

James

> The only interesting thing are the patches to make the AMD/Intel
> differences something resctrl understands, instead of just 'happening'
> because of the different function pointers.
> This will become more important once MPAM support is added. parse_bw()
> and friends are what enforces resctrl's ABI. Allowing an
> architecture/platform to provide a subtly different function here would
> be bad for user-space.
> 
> MPAM would set arch_has_sparse_bitmaps and arch_has_empty_bitmap, but
> not arch_needs_linear.

> Nothing in this series should change any behaviour.
