Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C499720C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvx5En3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIIUaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgIIU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599683398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nexsJiCuIdw7FA1Tk1xu5+FRgBxFGsMZ4jBAZcpm8c=;
        b=dvx5En3KPWOIeM6b26+I/P8yh+PlVGPX6mRWVIN4qCoUUnb9jropzPuxRxEeyelbjEOZUs
        jvtk7BJu7lxIFkElKmBOUvDLeK4KDHjL7uf6MaZU7rwKDY5TiPNnNCzY6qqJr8jXgNPSXp
        TYighXPiFByh096UMnvybEwXjuYRr/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-J55BP5YrOMKeOlbqDeyhpg-1; Wed, 09 Sep 2020 16:29:54 -0400
X-MC-Unique: J55BP5YrOMKeOlbqDeyhpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 235A818BA283;
        Wed,  9 Sep 2020 20:29:53 +0000 (UTC)
Received: from [10.10.114.200] (ovpn-114-200.rdu2.redhat.com [10.10.114.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A3EC10013D7;
        Wed,  9 Sep 2020 20:29:51 +0000 (UTC)
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
References: <202006261358.3E8AA623A9@keescook>
 <202009091247.C10CDA60C@keescook>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <9f3e5c23-3acd-d14f-06f9-acbc84e052a5@redhat.com>
Date:   Wed, 9 Sep 2020 16:29:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202009091247.C10CDA60C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 3:49 PM, Kees Cook wrote:
> 
> On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
>> Instead of full GNU diff (which smaller boot environments may not have),
>> use "comm" which is more available.
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
>> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Shuah, this really needs to land to fix lkdtm tests on busybox. Can
> you add this to -next? (Or is it better to direct this to Greg for the
> lkdtm tree?)
> 
> Thanks!
> 
> -Kees
> 
>> ---
>>   tools/testing/selftests/lkdtm/run.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
>> index 8383eb89d88a..5fe23009ae13 100755
>> --- a/tools/testing/selftests/lkdtm/run.sh
>> +++ b/tools/testing/selftests/lkdtm/run.sh
>> @@ -82,7 +82,7 @@ dmesg > "$DMESG"
>>   ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>>   
>>   # Record and dump the results
>> -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
>> +dmesg | comm -13 "$DMESG" - > "$LOG" || true
>>   
>>   cat "$LOG"
>>   # Check for expected output
>> -- 
>> 2.25.1
>>
>>
>> -- 
>> Kees Cook
> 

Hi Kees,

You may want to consider a similar follow up to the one Miroslav made to 
the livepatching equivalent:

https://lore.kernel.org/live-patching/nycvar.YFH.7.76.2008271528000.27422@cbobk.fhfr.pm/T/#m1c17812d2c005dd57e9a299a4a492026a156619e

basically 'comm' will complain if two lines from dmesg have the same 
timestamp prefix and their text portions are not sorted.

Regards,

-- Joe

