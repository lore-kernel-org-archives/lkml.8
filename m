Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7ACC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ABC20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgEPSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 14:03:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:62835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgEPSD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 14:03:26 -0400
IronPort-SDR: cCk9wouJxIMyRghWZ0SES4NvmjOat5mJET4p7SSP3JBF4+vRzABWXYsZxC8FF/p6SDKwSku+35
 2gCFNRjaRaTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 11:03:25 -0700
IronPort-SDR: Z31a2n/hd7Dsfm/lHEEvXOvaxGuk10Ms3iMtJKImczUNUybsYIu3iYxPX4Gy0+GrHA5GHyZiPy
 XiUyO5/GiE9A==
X-IronPort-AV: E=Sophos;i="5.73,400,1583222400"; 
   d="scan'208";a="465312117"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.21.145]) ([10.251.21.145])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 11:03:24 -0700
Subject: Re: [PATCH V3 3/4] x86/resctrl: Enable per-thread MBA
To:     Babu Moger <babu.moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <3510244af29b7443221dc926745fd0cf541576e0.1588808538.git.reinette.chatre@intel.com>
 <bb5b518c-2a10-1e0b-9c7d-29e58093a04a@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <2e04ff69-d246-82dd-12b9-83a1f36fccfa@intel.com>
Date:   Sat, 16 May 2020 11:03:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bb5b518c-2a10-1e0b-9c7d-29e58093a04a@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/14/2020 12:04 PM, Babu Moger wrote:
> 
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Wednesday, May 6, 2020 6:50 PM
>> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
>> tony.luck@intel.com
>> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
>> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
>> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
>> Subject: [PATCH V3 3/4] x86/resctrl: Enable per-thread MBA
>>
>> From: Fenghua Yu <fenghua.yu@intel.com>
>>

...

>>  static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
>>  					 struct seq_file *seq, void *v)
>>  {
>>  	unsigned int throttle_mode = 0;
>>
>> +	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA)) {
>> +		seq_puts(seq, "per-thread\n");
>> +
> You probably don't need an extra line here.
> 

This area looks slightly different after moving to a resource property
but unnecessary extra lines will be removed.

Thank you very much

Reinette
