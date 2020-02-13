Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD05C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B33721734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sFkA2Qy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgBMEZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:25:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18996 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgBMEZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:25:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e44cf8a0002>; Wed, 12 Feb 2020 20:24:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Feb 2020 20:25:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Feb 2020 20:25:11 -0800
Received: from [10.2.168.250] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 04:25:11 +0000
Subject: Re: [PATCH 1/1] checkpatch: support "base-commit:" format
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200212233221.47662-1-jhubbard@nvidia.com>
 <20200212233221.47662-2-jhubbard@nvidia.com>
 <a22937adb1bb364e4f5b8f30ee928a2df5cc226c.camel@perches.com>
 <2dab786b686735ec0c4ee614c64448d78c67a51d.camel@perches.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <5b8d6faf-4eec-ae8a-42e4-0b16713ed288@nvidia.com>
Date:   Wed, 12 Feb 2020 20:22:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2dab786b686735ec0c4ee614c64448d78c67a51d.camel@perches.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581567883; bh=CH0W1IgPYwgWyTV2KHOAEhDBrtMU65kM4pCC54fWw+0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sFkA2Qy936atZnIJPkXIUXcq1h54enMuxBxrb+d/HnleDChtcUZ5u7zT3oW7wD76Q
         T02wSRzNM0/9fSD1KiIm0CVhyDHip9rgMKoYKf0ii758rUiZbsorlxux0hf4zBikFD
         gEjjQjt07XWWBkuh5lLdExIU2WeK9tmzPpoYs7GRS+FzJ2slPd5PzkQ3SYGZTTywaJ
         ieZHQOzjQ/hkv2T8lLCWSidVsw7Og7jRszYIJ6Vibo1JzvSk2OaivDak8iu1GKnO4i
         jb/T1zAAXk86TwAb79Dtjv9l64RQTgdVNa3dY7b8ZaEAJs6lIpbNHVqh2FCWK0GvYz
         ngPuJJW/Zhn0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 5:32 PM, Joe Perches wrote:
> On Wed, 2020-02-12 at 17:06 -0800, Joe Perches wrote:
>> On Wed, 2020-02-12 at 15:32 -0800, John Hubbard wrote:
>>> In order to support the get-lore-mbox.py tool described in [1], I ran:
>>>
>>>      git format-patch --base=<commit> --cover-letter <revrange>
>>>
>>> ...which generated a "base-commit: <commit-hash>" tag at the end of the
>>> cover letter. However, checkpatch.pl generated an error upon encounting
>>> "base-commit:" in the cover letter:
>>>
>>>      "ERROR: Please use git commit description style..."
>>>
>>> ...because it found the "commit" keyword, and failed to recognize that
>>> it was part of the "base-commit" phrase, and as such, should not be
>>> subjected to the same commit description style rules.
>>>
>>> Update checkpatch.pl to include a special case for "base-commit:", so
>>> that that tag no longer generates a checkpatch error.
> []
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>>> @@ -2761,6 +2761,7 @@ sub process {
>>>   
>>>   # Check for git id commit length and improperly formed commit descriptions
>>>   		if ($in_commit_log && !$commit_log_possible_stack_dump &&
>>> +		    $line !~ /base-commit:/ &&
>>
>> If this base-commit: entry is only at the start of line,


As far as I can tell, we should be able to rely on that, yes.


>> I presume this should actually be
>>
>> 		    $line !~ /^base-commit:/ &&
>> or maybe
>> 		    $line !~ /^\s*base-commit:/ &&
>>
>>>   		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
> 
> and probably better to just add it to this line instead like
> 
>   		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
>  

Yes, that looks nice. I'll send a v2 doing it that way.


thanks,
-- 
John Hubbard
NVIDIA
