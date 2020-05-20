Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F335AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A6820709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgETRcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:32:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:43403 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:32:05 -0400
IronPort-SDR: 2QcuSoLY//wNsExo5tNdfpsQBNMIq7t+lmWut8RmzgRmJ6TUBaPn88iC/w3P0ig6Ypc+6C+bVr
 jUdi2QPeDF6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 10:32:04 -0700
IronPort-SDR: lbS/aYOO9aOTVAqsFs+5KVTl+glo3BcQkWbHrpP73J6Yf83Z8J7s7o4ZDIfrHHx/eHJOMd7CdE
 nSNT0AjdSrUw==
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="268343011"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.101.53]) ([10.254.101.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 10:32:03 -0700
Subject: Re: [PATCH V6 0/4] x86/resctrl: Enable user to view and select thread
 throttling mode
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1589922949.git.reinette.chatre@intel.com>
 <20200519213516.GF444@zn.tnic>
 <1d9ee0f0-8078-e8b6-ce66-6c0bf51cb3b4@intel.com>
 <20200520071109.GA1457@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5c044d17-e42e-1493-28a5-3ecac043c8f1@intel.com>
Date:   Wed, 20 May 2020 10:32:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520071109.GA1457@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 5/20/2020 12:11 AM, Borislav Petkov wrote:
> On Tue, May 19, 2020 at 03:13:59PM -0700, Reinette Chatre wrote:
>> I am very sorry. I was hoping that this series could be considered for
>> inclusion into v5.8 and submitted it seven weeks ago because of that.
>> The recent feedback addressed seemed to be the final few small comments
>> needed to be ready for inclusion and I was afraid that waiting long to
>> address this would cause me to miss opportunity to be considered for
>> inclusion since we are already at rc6.
> 
> That's understandable but does it really matter when it goes in? If not
> in 5.8, then 5.9. I.e., there's always a next kernel.
> 
> So why the hurry?
> 

I was told that these enhancements really needed to get into v5.8,
otherwise the OSV intercepts will be much further out. Certainly not of
concern to you and not your problem, I am just answering your question
as an explanation for my goal for inclusion into v5.8.

It seems inappropriate that I have the title of maintainer and not be
able to have patches considered for inclusion during an entire release
cycle. I completely understand that you are under tremendous load and
expect that you have an incredible amount of things demanding your
attention. I was wrong to expect a higher level of visibility of these
patches and I am sorry that I spammed you with this patchset.

Reinette
