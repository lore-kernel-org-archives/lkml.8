Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D45C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B706206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAaRCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:02:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:60372 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgAaRCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:02:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 09:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; 
   d="scan'208";a="377395532"
Received: from unknown (HELO [134.134.177.86]) ([134.134.177.86])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2020 09:02:13 -0800
Subject: Re: [Intel PMC TGPIO Driver 1/5] drivers/ptp: Add Enhanced handling
 of reserve fields
To:     christopher.s.hall@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@redhat.com, x86@kernel.org, richardcochran@gmail.com,
        davem@davemloft.net, sean.v.kelley@intel.com
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
 <20191211214852.26317-2-christopher.s.hall@intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <04485e14-52a0-3075-94d9-50d81f6b11da@intel.com>
Date:   Fri, 31 Jan 2020 09:02:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20191211214852.26317-2-christopher.s.hall@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 1:48 PM, christopher.s.hall@intel.com wrote:
> From: Christopher Hall <christopher.s.hall@intel.com>
> 
> Add functions that parameterize checking and zeroing of reserve fields in
> ioctl arguments. Eliminates need to change this code when repurposing
> reserve fields.
> 

One thing to note that may be problematic with this handling: a later
usage of a reserved field must still be reported as zero for callers of
the old ioctl variants. Reserved fields were only handled properly in
the "2" variants of the ioctls.

This change might make it harder to notice and remember to ensure that
previously unused fields get zero'd for the old ioctls.

Richard, thoughts?

Thanks,
Jake
