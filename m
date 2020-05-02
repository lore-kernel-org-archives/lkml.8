Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF57C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BAD2072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEBAT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:19:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:54848 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgEBAT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:19:27 -0400
IronPort-SDR: dKKBNFiCDm6s8Lhdn1ds9RotSYV8k0lnzvuiopihXgEkCPshlV8SCHmkLt+LSI657MwsSsam/l
 vT5ymYNRvjEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 17:19:27 -0700
IronPort-SDR: IWRKiypnfiZ1brXr2iWiV/cItxdv6XAeADrZvcSACy32EvtDaslUBzBOeGc4BJNRKzzI+IkBM8
 cS8IGbnZ5S7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="258759279"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.209.101.237]) ([10.209.101.237])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2020 17:19:27 -0700
Subject: Re: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
References: <20200501231131.2389319-1-jacob.e.keller@intel.com>
 <e1e12e3f6992c00c005ba2b3bcf671c033a1dccc.camel@perches.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <5a1da586-0cc0-1900-477f-6fef61af7f95@intel.com>
Date:   Fri, 1 May 2020 17:19:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e1e12e3f6992c00c005ba2b3bcf671c033a1dccc.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2020 4:42 PM, Joe Perches wrote:
> On Fri, 2020-05-01 at 16:11 -0700, Jacob Keller wrote:
>> NL_SET_ERR_MSG and NL_SET_ERR_MSG_MOD are used to report extended error
>> responses about failure of a netlink command. These strings often end up
>> going over the 80-column limit. Just like logging messages, it is
>> preferred to leave the message all on a single line.
>>
>> Add these to the exception list so that checkpatch.pl will no longer
>> complain about the long lines due to use of these macros.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Andy Whitcroft <apw@canonical.com>
>> Cc: Joe Perches <joe@perches.com>
>> ---
>>  scripts/checkpatch.pl | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index eac40f0abd56..5da3b06fbeaa 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -471,7 +471,8 @@ our $logFunctions = qr{(?x:
>>  	WARN(?:_RATELIMIT|_ONCE|)|
>>  	panic|
>>  	MODULE_[A-Z_]+|
>> -	seq_vprintf|seq_printf|seq_puts
>> +	seq_vprintf|seq_printf|seq_puts|
>> +	NL_SET_ERR_MSG(?:_MOD)?
>>  )};
>>  
>>  our $allocFunctions = qr{(?x:
> 
> <shrug>  OK I guess.
> 
> What about GENL_SET_ERR_MSG ?
>

This appears in far fewer locations, but it does seem reasonable to add
it to this list as well.

> btw:
> 
> There are some uses with what appear to be unnecessary newlines.
> Maybe these newlines should be removed.

Yea, there's a number of places which seem to have put a newline break
after the extack pointer.

A quick search shows that there are about 970 or so uses where we don't
put a newline, and around 220 where we do.

I suppose I can make a series that cleans all of those up along with
this patch.

Thanks,
Jake
