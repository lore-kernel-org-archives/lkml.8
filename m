Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E02C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DFF2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="PaAVGcq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbgFWKeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbgFWKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:34:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC45C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:34:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g21so2682416wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h62r6XS0jqYfIJmWVT9efAIcIqFr2bxw7xGquL+kTA0=;
        b=PaAVGcq51bK0il7pnXFZVs9ta1DoWfsKr4m305qKiGMZEfpaknGGzwmWgA1i5KXEZ4
         eUiOJ2qgAbaJotMouyqdb4KcXiQxHRCpyQPtaq1OHw8df+S/lEG1uaahFRHg/4Fzfsre
         bBwR6d9BFmLMpv4MUVm7XaD2pSRsG2oQZDhFnhErSL6adK0P696KRKXkXUmEx9Si+jkn
         VFjPH33a1UN+dEGxh/+A4/1SqKPsnm7z20xfSdaVnqWEJGaL7QqHHyoCWXcsEawxSkbO
         OUe8vJ/kSCWfVUWmMMmlu7LfO3BY5hbPU5rQO1sKbXEU3URx1PulhVM6k1etrYYO3xfL
         SqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h62r6XS0jqYfIJmWVT9efAIcIqFr2bxw7xGquL+kTA0=;
        b=DjND2dpap+vVBw6jDiJPQqqEhDtjbd5kkQJKHm0Z9qEnpJGMsirWEA6e/n0BN17obp
         dFKprJfcBGKscMkgyrREI03bqDRe7jdqY5rUJDrBKm6OGnsDivyY/MMu652QOwuG/QdZ
         0WH620rQSMOBOc6FACxMr1846s7fv5qhj7p5NanuHTgnRUh5ViIfltm7UGhtqTUWuRNK
         oCSykxMk07y/uh6/J97LVtnoIHFsN2X3RGgUu5A6yh3RuUGycK8/Kfgw0WRPwYATqAOA
         z7uKC4DEBG60cRDS3w1hgRpAN3c43UAxROUy4R39alqmUXFCYim8PGp6nP83JWoGoCQt
         1xEQ==
X-Gm-Message-State: AOAM5332T4CwjmpR4FqDq4KPDKFY4kfg5o1wA5UsDz177DvYgNubwCwZ
        Md6WagCE1yvULn77jJmkYA/izPeGRDz16A==
X-Google-Smtp-Source: ABdhPJxxWuXAogfs3gT9CkzwfSYJDFqGwV3uikEKpo3dOm/EJjyT1TM/371js0JAAmJK8OzKLPoZOA==
X-Received: by 2002:a1c:8192:: with SMTP id c140mr9620670wmd.108.1592908438033;
        Tue, 23 Jun 2020 03:33:58 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id n8sm18676940wrj.44.2020.06.23.03.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:33:57 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: fix CONST_STRUCT when
 const_structs.checkpatch is missing
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200622204844.21030-1-quentin@isovalent.com>
 <8a218fa14cc2e1690df32d278c82587c7507a820.camel@perches.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <d2193403-def1-d833-c9bc-0937afca636b@isovalent.com>
Date:   Tue, 23 Jun 2020 11:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8a218fa14cc2e1690df32d278c82587c7507a820.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-06-22 14:24 UTC-0700 ~ Joe Perches <joe@perches.com>
> On Mon, 2020-06-22 at 21:48 +0100, Quentin Monnet wrote:
>> Checkpatch reports warnings when some specific structs are not declared
>> as const in the code. The list of structs to consider was initially
>> defined in the checkpatch.pl script itself, but it was later moved to an
>> external file (scripts/const_structs.checkpatch). This introduced two
>> minor issues:
>>
>> - When file scripts/const_structs.checkpatch is not present (for
>>   example, if checkpatch is run outside of the kernel directory with the
>>   "--no-tree" option), a warning is printed to stderr to tell the user
>>   that "No structs that should be const will be found". This is fair,
>>   but the warning is printed unconditionally, even if the option
>>   "--ignore CONST_STRUCT" is passed. In the latter case, we explicitly
>>   ask checkpatch to skip this check, so no warning should be printed.
>>
>> - When scripts/const_structs.checkpatch is missing, or even when trying
>>   to silence the warning by adding an empty file, $const_structs is set
>>   to "", and the regex used for finding structs that should be const,
>>   "$line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/)", matches all
>>   structs found in the code, thus reporting a number of false positives.
>>
>> Let's fix the first item by skipping scripts/const_structs.checkpatch
>> processing if "CONST_STRUCT" checks are ignored, and the second one by
>> skipping the test if $const_structs is an empty string.
>>
>> Fixes: bf1fa1dae68e ("checkpatch: externalize the structs that should be const")
> 
> Probably not worthy of a Fixes: line, as that's
> generally used for backporting, but OK by me.

Yeah I hesitated, I'll drop it for v2.

> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -781,8 +781,10 @@ sub read_words {
>>  }
>>  
>>  my $const_structs = "";
> 
> This might be a tiny bit faster/less cpu using:
> 
> my $const_structs;
> 
>> -read_words(\$const_structs, $conststructsfile)
>> -    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
>> +if (show_type("CONST_STRUCT")) {
>> +	read_words(\$const_structs, $conststructsfile)
>> +	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
>> +}
>>  
>>  my $typeOtherTypedefs = "";
>>  if (length($typedefsfile)) {
>> @@ -6660,7 +6662,8 @@ sub process {
>>  
>>  # check for various structs that are normally const (ops, kgdb, device_tree)
>>  # and avoid what seem like struct definitions 'struct foo {'
>> -		if ($line !~ /\bconst\b/ &&
>> +		if ($const_structs ne "" &&
> 
> instead testing
> 
> 		if (defined($const_structs) &&

Sure, I will respin.

Thank you for the review!
Quentin
