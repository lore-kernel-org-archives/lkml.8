Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632AAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338C3207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgESWOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:14:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:25011 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgESWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:14:01 -0400
IronPort-SDR: A7Owm0J4mtLcZ/fUsRRSCMRk8R0XKfxlqDenbdTJkVCLH69xigv16cHD6rEliEasQuY+ciIlrf
 UU+a5Ns5whoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 15:14:01 -0700
IronPort-SDR: 2MWpHGqR35+mDeyE6AqtyUXSdJ/NguJmYOo59tFvN01VlDa2/vukJC3CWnxGOaShnWJELBPRHE
 /0DlzF1xIHKA==
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="scan'208";a="439787051"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 15:14:00 -0700
Subject: Re: [PATCH V6 0/4] x86/resctrl: Enable user to view and select thread
 throttling mode
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1589922949.git.reinette.chatre@intel.com>
 <20200519213516.GF444@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <1d9ee0f0-8078-e8b6-ce66-6c0bf51cb3b4@intel.com>
Date:   Tue, 19 May 2020 15:13:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519213516.GF444@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 5/19/2020 2:35 PM, Borislav Petkov wrote:
> On Tue, May 19, 2020 at 02:28:27PM -0700, Reinette Chatre wrote:
>> V5 upstream submission available from:
>> https://lore.kernel.org/lkml/cover.1589844108.git.reinette.chatre@intel.com
> 
> Is there any chance for not spamming us with this patchset almost every
> day?
> 
> From Documentation/process/submitting-patches.rst:
> 
> "Wait for a minimum of one week before resubmitting or pinging reviewers
> - possibly longer during busy times like merge windows."
> 

I am very sorry. I was hoping that this series could be considered for
inclusion into v5.8 and submitted it seven weeks ago because of that.
The recent feedback addressed seemed to be the final few small comments
needed to be ready for inclusion and I was afraid that waiting long to
address this would cause me to miss opportunity to be considered for
inclusion since we are already at rc6.

Reinette


