Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723BB2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O3HdXX6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFJWIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJWIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:08:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EAAC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:08:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so4049620wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=19F1c5tK8C2QSbXhWszFDt5PVrxpZGDspM0tZaWiDN0=;
        b=O3HdXX6oBXMtKU68PjHmYMXinaDsBwRo5APrlMrdrONOCSSFxgNKIJbpYOF+K4a4it
         tMRd6K/fQlV12cYUOrLYZPgOfUhxMAdmTb5AaMoKzCcJ95UpJlR4LwZicfsMv/a9VuXn
         ZUMJzt9yEqQCtiHduhSsEvFfFUXyjjjMfKPgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=19F1c5tK8C2QSbXhWszFDt5PVrxpZGDspM0tZaWiDN0=;
        b=BluP66cBkSPZKEnsBImoG2/9I9XICSy1Xga/WE0KHKVbfF1rz3HHnZgrQNgFmaTugt
         9fOfZRF+6WoBXQdqJjMgJHfRrXudfq0mvvtSQ/o4aXYSOnqq63ZIIloxQayo/5DSz4rn
         7Lt0LdcHSwXOLjHw4rfqCRGnf6AQ1u4F0ddleZRY/uyhCJnOxv6tZL8jKbHq7YgR0mpi
         VUY0cGwmRp4tW3Mep+LZW6ZTpP7F/WrBQTJfUPZJ6F6mWyQSHxg/ecGlKrH9I9eVCIpP
         af+KJHNLcwmQlmLmtd3L83BunQ9ErJOGQGOBYSQ022BIBacVsy/0Qp2ObeRNrZLZWKAj
         v6Qw==
X-Gm-Message-State: AOAM530igPEiNey0l5h7XEVaa5107x5XZQh8F6PRLID3M4dV4i93DA8e
        zFXz32ioXxqvX42JRtaoCl3f3Q==
X-Google-Smtp-Source: ABdhPJxgjaPblByLUx5EEm3qgPsOjOkL3AYI8zDOb6dDrb0p+lzXQBKIr7pHTQ5XYFA+Mi6/IMYJiA==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr6285785wrr.164.1591826915914;
        Wed, 10 Jun 2020 15:08:35 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k12sm1713319wrn.42.2020.06.10.15.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 15:08:35 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: add check for
 NONNETWORKING_BLOCK_COMMENT_STYLE
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200610202640.9020-1-scott.branden@broadcom.com>
 <673c2ebaf7a1ca93f3b1192a77ff62167badd896.camel@perches.com>
 <021da2ca-a8d3-d0ad-28c3-6a84464353fd@broadcom.com>
 <33204a397b2d9316e09ae9829e637894b304ea00.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0f037983-6dad-859c-3ded-f7a0c86953df@broadcom.com>
Date:   Wed, 10 Jun 2020 15:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <33204a397b2d9316e09ae9829e637894b304ea00.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2020-06-10 2:42 p.m., Joe Perches wrote:
> On Wed, 2020-06-10 at 14:33 -0700, Scott Branden wrote:
>> Hi Joe,
>>
>> On 2020-06-10 2:16 p.m., Joe Perches wrote:
>>> On Wed, 2020-06-10 at 13:26 -0700, Scott Branden wrote:
>>>> NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
>>>> doesn't seem to be any check for the standard block comment style.
>>>> Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
>>>> on first line of non-networking block comments.
>>> I think there are _way_ too many instances of this form
>>> in non-networking code to enable this.
>>>
>>> $ git grep -P '^\s*/\*\s*\S.*[^\*][^\\]\s*$' -- '*.[ch]' | \
>>>     grep -v -P '^(drivers/net/|net/)' | \
>>>     wc -l
>>> 51407
>> That is true about many things that checkpatch now checks for that
>> didn't previously.
> Not in that quantity of uses it doesn't.
>
> I specifically did _not_ add this very same test
> when I added the other comment tests.
>
>> But, by adding to checkpatch the coding style clearly outlined in
>> coding-style.rst can be followed:
> Well, because there are _so_ many false positives
> that don't need change, I'm not adding this.
>
> As is, I'm nacking it.
>
> If you need it for your use, you should keep it in
> your own tree.
I think this has value for others.
>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> []
>>>> @@ -3408,6 +3408,16 @@ sub process {
>>>>    			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>>>>    		}
>>>>    
>>>> +# Non-Networking with an empty initial /*
>>>> +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
>>>> +		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
>>>> +		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
>>>> +		    $rawline =~ /^\+[ \t]*\*/ &&
>>>> +		    $realline > 2) {
>>>> +			WARN("NONNETWORKING_BLOCK_COMMENT_STYLE",
>>>> +			     "non-networking block comments use an empty /* on first line\n" . $hereprev);
> _Maybe_ this test _might_ be useful if it did a file/patch
> test and used CHK on file, but even then I'm very dubious.
>
> 			my $msg_level = \&WARN;
> 			$msg_level = \&CHK if ($file);
> 			&{msg_level}(etc...)
I can make such change.
As is, checkpatch basically follows the coding style documented for 
networking and has no check for outside.

I do not know the history of the 2 block coding styles but here's a 
radical thought:
Change the coding-style document to pick a single coding style for ALL 
block comment styles and
use that going forward in checkpatch instead?
>
>

