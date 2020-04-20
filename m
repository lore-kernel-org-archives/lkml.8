Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5603AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32783206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atK+wAIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgDTPq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43846 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726931AbgDTPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587397584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLHxi4Hu3j2YEIGoVcQy6We5qDF7KD9rRyHKv+349FQ=;
        b=atK+wAItDenATHvJX7ceaZXM5yq1nqG6E+K2SyXqSUGRK6d04kx71iK7GaSeCuvSU5Szvl
        gxdRs89iAJrhdoa6imMtEVtvtuBmklQmENsJiic5q6XPqCb7FkxaA7IFYsA+n7I0JtHFlX
        u4T4boecovjTug0tCpo837MJyRvWNLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-gsSmE16sNaKdWoPpOPtrAQ-1; Mon, 20 Apr 2020 11:46:21 -0400
X-MC-Unique: gsSmE16sNaKdWoPpOPtrAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D4213F9;
        Mon, 20 Apr 2020 15:46:20 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C8BF5C1B2;
        Mon, 20 Apr 2020 15:46:19 +0000 (UTC)
Subject: Re: [PATCH] intel-speed-select: Fix speed-select-base-freq-properties
 output on CLX-N
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20200420141054.26173-1-prarit@redhat.com>
 <CAHp75VfKCuX1CNMaVLeghdoP9-KHh3+1yuFVgU8qhRbKi69JNQ@mail.gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <d0bfcbfe-4834-624f-b590-1aa93970e5a4@redhat.com>
Date:   Mon, 20 Apr 2020 11:46:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfKCuX1CNMaVLeghdoP9-KHh3+1yuFVgU8qhRbKi69JNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/20 11:43 AM, Andy Shevchenko wrote:
> On Mon, Apr 20, 2020 at 6:11 PM Prarit Bhargava <prarit@redhat.com> wrote:
>>
>> On CLX-N, the perf-profile-level's output is terminated before the
>> speed-select-base-freq-properties are output which results in a corrupt
>> json file.
>>
>> Adjust the output of speed-select-base-freq-properties by one on CLX-N.
>>
> 
> Thanks for the patch, it will be pulled from Srinivas' tree whenever
> he sends a PR to PDx86 mailing list.

Srinivas, OOC do you want these patches to be sent somewhere else?  FWIW, I'm
running get_maintainers.pl to get the mailing list and cc.

P.

> 
> 
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: platform-driver-x86@vger.kernel.org
>> ---
>>  tools/power/x86/intel-speed-select/isst-display.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
>> index 51dbaa5f02ec..f6e2ce181123 100644
>> --- a/tools/power/x86/intel-speed-select/isst-display.c
>> +++ b/tools/power/x86/intel-speed-select/isst-display.c
>> @@ -470,7 +470,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
>>                                 _isst_pbf_display_information(cpu, outf,
>>                                                               tdp_level,
>>                                                           &ctdp_level->pbf_info,
>> -                                                             level + 1);
>> +                                                             level + 2);
>>                         continue;
>>                 }
>>
>> --
>> 2.18.2
>>
> 
> 

