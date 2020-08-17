Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16A120716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="Y5q4KHNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgHQOYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbgHQOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:24:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33446C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:24:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so14066944wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kqxt808PPWfu0yCoyZKJb1d4aYyLmcIDBs5/lTjgw0Y=;
        b=Y5q4KHNEACs8O07zfrxNL1kRfLPlbbgxZqTbPE6MeB+yLp44+RDK+VZPxeiqtf+MZC
         Pka9DDT5ku83slck/qDdbdLxfy04L6HjgZbZTwNdaHq4U64Z4bqDXP5ocrBVtyLTexAO
         DEDDt1QDtD9mciaPba9UPQcoZ1ZQxr30mV24nl5qRMaQvHLuxR39/k9R+i/9e/XAPLqp
         v6zuoQ9W10qygZ/FPI9UfBqV5G9yi68GBl7A60JCVQqY92HIO3/F94f+eTJoWoTDwh7h
         ZKeASx3sZsV2WxU54xCHjqb5nFgxwTprdlqT3FvqhB1OXKP3lzuOz48t3990PSeuDcOL
         KhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqxt808PPWfu0yCoyZKJb1d4aYyLmcIDBs5/lTjgw0Y=;
        b=ms/NrspQXuDYyikAcrv+gGl/bD7OmNJS7LaoN+8jEp/BOBz/OaaOI9pbgHVuUbc1Oy
         gN2XfspB8hM+Z7KMoTC42N9b9dfrlJ9yKx5xRTEd023oZB8ggNfn3lE2q65Y3D9fEI1A
         lr2rM69OnK6HrOaPKfC0MJNmHwSdoMn2Ty5zAmsDt9Jgobd1kh7V8gkIexVA9sFgkprP
         aK8+OpDeS9loXTL5tzibdulbANFWQLj2YXXaM+9B6y2FRSY7kqYemLn4STKqOYxqsQ6X
         Oo7xY3m9eO3gP4MCFRXJCtoONdY7jaWjtaONk/NvJ88qX0bK7/ngdmwgcwihZw3Z7V2u
         SnYA==
X-Gm-Message-State: AOAM5302HABizU+SOZGHhXhlel+UFqF19GIxpMn/W0U8tQpbWzD3n9Am
        diTWprNeM9IdwP+pyPxAWCeOeb0FGAY29qms0TY=
X-Google-Smtp-Source: ABdhPJwGg4n3YYplhQme+3WeT7xmZ7PDQKk/liLAocO/Ll7dNZmsGXMvQluqkZhOQ/ESK9EtkAUfug==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr15721526wme.189.1597674285399;
        Mon, 17 Aug 2020 07:24:45 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:3009:af69:3d13:4910? ([2a01:e0a:3cb:7bb0:3009:af69:3d13:4910])
        by smtp.gmail.com with ESMTPSA id g7sm32321888wrv.82.2020.08.17.07.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 07:24:44 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: get CONFIG_ prefix from the environment
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20200817095056.31001-1-jerome@forissier.org>
 <12f2214fbfbea24f831461c1896b0954ca672976.camel@perches.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <4e3e28f1-9498-55c7-b5cc-787a51724a1b@forissier.org>
Date:   Mon, 17 Aug 2020 16:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12f2214fbfbea24f831461c1896b0954ca672976.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/20 4:09 PM, Joe Perches wrote:
> On Mon, 2020-08-17 at 11:50 +0200, Jerome Forissier wrote:
>> Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
>> environment variable. Out-of-tree projects may therefore use Kconfig
>> with a different prefix, or they may use a custom configuration tool
>> which does not use the CONFIG_ prefix at all. Such projects may still
>> want to adhere to the Linux kernel coding style and run checkpatch.pl.
>> To make this possible, update checkpatch to use the value of $CONFIG_
>> if defined or "CONFIG_" otherwise.
>>
>> Signed-off-by: Jerome Forissier <jerome@forissier.org>
>> ---
>>  scripts/checkpatch.pl | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 2cbeae6d9aee..2cf750175a71 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
>>  # git output parsing needs US English output, so first set backtick child process LANGUAGE
>>  my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>>  my $tabsize = 8;
>> +my $CONFIG_ = $ENV{"CONFIG_"} || "CONFIG_";
> 
> I'm not a big fan of environment variable being
> used to control program behavior.

OK.

> 
> Maybe add something to .checkpatch.conf instead.

That would work equally well for me. I will post a V2.

Thanks,
-- 
Jerome

> 
>>  sub help {
>>  	my ($exitcode) = @_;
>> @@ -6528,16 +6529,16 @@ sub process {
>>  		}
>>  
>>  # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
>> -		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
>> +		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^$CONFIG_/) {
>>  			WARN("IS_ENABLED_CONFIG",
>> -			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
>> +			     "IS_ENABLED($1) is normally used as IS_ENABLED($CONFIG_$1)\n" . $herecurr);
>>  		}
>>  
>>  # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
>> -		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
>> +		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)($CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
>>  			my $config = $1;
>>  			if (WARN("PREFER_IS_ENABLED",
>> -				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
>> +				 "Prefer IS_ENABLED(<FOO>) to $CONFIG_<FOO> || $CONFIG_<FOO>_MODULE\n" . $herecurr) &&
>>  			    $fix) {
>>  				$fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
>>  			}
> 
