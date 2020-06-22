Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2ADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BDF20727
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgFVX4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:56:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:11902 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbgFVX4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:56:10 -0400
IronPort-SDR: cjxSC6Mp8hRHguqrALewvWmUeNON9hFivRi9dBUvx/Ub8o0TEwaTOVvsdEehjx0r4AQiGIMESh
 RcZTAguKyVYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="124181112"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="124181112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 16:56:09 -0700
IronPort-SDR: irzyprq6G5p8Nboz85WR7PJ/zywM297w/FBcxuGfnSkwiAz8fhKRvr3cj3fwAc//0h+5khrOiT
 KBFAiYyYBEkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318997735"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.251.16.129]) ([10.251.16.129])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 16:56:08 -0700
Subject: Re: [PATCH] checkpatch: use $root/.git when seeding camel case
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <20200622215834.2858106-1-jacob.e.keller@intel.com>
 <fe60cadc38d430f38ff8cb3d1ca9c1f44260b59d.camel@perches.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <66793797-4be2-9c39-edb6-44f731f7c6d6@intel.com>
Date:   Mon, 22 Jun 2020 16:56:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fe60cadc38d430f38ff8cb3d1ca9c1f44260b59d.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2020 3:11 PM, Joe Perches wrote:
> On Mon, 2020-06-22 at 14:58 -0700, Jacob Keller wrote:
>> When seeding the camel case file, checkpatch.pl uses the $root directory
>> in order to find the acceptable list of allowed camel case words.
>>
>> However, if the current directory is a git repository, checkpatch.pl
>> attempts to seed using the local git directory.
>>
>> This is problematic if checkpatch.pl is passed a --root and is being run
>> from within another git repository. Rather than seeding from the
>> provided root tree, checkpatch.pl will seed using the local files. If
>> the current git repository isn't a kernel tree, this can lead to
>> unexpected warnings about camel case issues.
>>
>> Always honor the $root parameter when seeding camelcase files by using
>> "$root/.git" and changing directory to the $root before invoking git.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -919,8 +919,8 @@ sub seed_camelcase_includes {
>>  
>>  	$camelcase_seeded = 1;
>>  
>> -	if (-e ".git") {
>> -		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
>> +	if (-e "$root/.git") {
>> +		my $git_last_include_commit = `cd $root && ${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
>>  		chomp $git_last_include_commit;
>>  		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
>>  	} else {
>> @@ -947,9 +947,10 @@ sub seed_camelcase_includes {
>>  		return;
>>  	}
>>  
>> -	if (-e ".git") {
>> -		$files = `${git_command} ls-files "include/*.h"`;
>> +	if (-e "$root/.git") {
>> +		$files = `cd $root && ${git_command} ls-files "include/*.h"`;
>>  		@include_files = split('\n', $files);
>> +		@include_files = map("$root/$_", @include_files);
>>  	}
>>  
>>  	foreach my $file (@include_files) {
> 
> checkpatch has 4 uses of ${git_command}
> 
> Maybe git_command should be changed instead.
>
So, in part, I'm not 100% sure. In our use case, it depends on what git
is being used for.

Something like "checkpatch.pl -g HEAD", we would like to target the
local repository. Where as camelcase, we'd like to target the --root
repository.

What if, instead of this, we opt to use the local .git for camelcase
only when $root is non-empty? That way, if --root is applied, camcel
case seeding always uses --root, rather than the local tree.

Something like:

if (-e ".git" && $root eq "") for this block, so then we fall through to
the non-git style instead?

> I wonder how this interacts with the GIT_DIR environment variable.
> 

Probably poorly. I suspect it would end up looking at GIT_DIR instead of
$root/.git, despite the cd.

Thanks,
Jake
