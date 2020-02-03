Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE503C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6E92082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgBCS1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:27:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:48173 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgBCS1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:27:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 10:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="278822787"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.86]) ([134.134.177.86])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2020 10:27:28 -0800
Subject: Re: [Intel PMC TGPIO Driver 0/5] Add support for Intel PMC Time GPIO
 Driver with PHC interface changes to support additional H/W Features
To:     Richard Cochran <richardcochran@gmail.com>,
        christopher.s.hall@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com,
        x86@kernel.org, davem@davemloft.net, sean.v.kelley@intel.com
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
 <20200203040838.GA5851@localhost>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <85f42aa9-65fa-121b-a24d-017b56c61267@intel.com>
Date:   Mon, 3 Feb 2020 10:27:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203040838.GA5851@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2020 8:08 PM, Richard Cochran wrote:
> On Wed, Dec 11, 2019 at 01:48:47PM -0800, christopher.s.hall@intel.com wrote:
>> The ART frequency is not adjustable. In order, to implement output
>> adjustments an additional edge-timestamp API is added, as well, as
>> a periodic output frequency adjustment API. Togther, these implement
>> equivalent functionality to the existing SYS_OFFSET_* and frequency
>> adjustment APIs.
> 
> I don't see a reason for a custom, new API just for this device.
> 
> The TGPIO input clock, the ART, is a free running counter, but you
> want to support frequency adjustments.  Use a timecounter cyclecounter
> pair.
> 
> Let the user dial a periodic output signal in the normal way.
> 
> Let the user change the frequency in the normal way, and during this
> call, adjust the counter values accordingly.
> 

To add:

in order to program the pin output correctly, you may need to reverse
the timecounter/cyclecounter calculations. I recall doing something
similar in ixgbe for programming the correct output signal to match.

It may actually be worth adding helper functions to the timecounter
system for doing those kind of reverse calculations for converting from
a time value back into cycles.

> Thanks,
> Richard
> 
