Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83565C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595DE24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKYgBTQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgB0PDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:03:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729822AbgB0PDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582815793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMskYLY53Jf3aSHX0N06GNsZpJjLW7zL9jNViC6HgMU=;
        b=gKYgBTQzgD/vgDpqBI1XcS3+6d9EnYy4aCLznPMdqJIX84giTqdCEnpm/YrSr6XowceoPb
        fAiVTDDJy7676lDV2iM/1irUshqwoQVwCaVkl0RdV33aJrjnXjQ6Pwy/xRkiavmI/q1hRb
        jJN/lDF7cuRoRVSzV9i8gj2itiIgFP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-FNXzMYquNKOq6YEpaFFKdg-1; Thu, 27 Feb 2020 10:03:01 -0500
X-MC-Unique: FNXzMYquNKOq6YEpaFFKdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7781218B5F93;
        Thu, 27 Feb 2020 15:03:00 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABC0592990;
        Thu, 27 Feb 2020 15:02:59 +0000 (UTC)
Subject: Re: [PATCHv2] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, sboyd@kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org
References: <20200225165749.6399-1-po-hsu.lin@canonical.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <a93abb42-ec5b-5407-6c45-c888f6f9dc5e@redhat.com>
Date:   Thu, 27 Feb 2020 10:02:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225165749.6399-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 11:57 AM, Po-Hsu Lin wrote:
> The following 4 tests in timers can take longer than the default 45
> seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
> Add 45 second timeout per test) to run:
>    * nsleep-lat - 2m7.350s
>    * set-timer-lat - 2m0.66s
>    * inconsistency-check - 1m45.074s
>    * raw_skew - 2m0.013s
> 
> Thus they will be marked as failed with the current 45s setting:
>    not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>    not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>    not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>    not ok 7 selftests: timers: raw_skew # TIMEOUT
> 
> Disable the timeout setting for timers can make these tests finish
> properly:
>    ok 3 selftests: timers: nsleep-lat
>    ok 4 selftests: timers: set-timer-lat
>    ok 6 selftests: timers: inconsistency-check
>    ok 7 selftests: timers: raw_skew
> 
> https://bugs.launchpad.net/bugs/1864626
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/timers/Makefile | 1 +
>   tools/testing/selftests/timers/settings | 1 +
>   2 files changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/timers/settings
> 
> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> index 7656c7c..0e73a16 100644
> --- a/tools/testing/selftests/timers/Makefile
> +++ b/tools/testing/selftests/timers/Makefile
> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>   
>   TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>   
> +TEST_FILES := settings
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> 

v2 changes LGTM..

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

