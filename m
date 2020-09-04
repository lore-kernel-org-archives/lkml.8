Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2A8206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="HlfKGcc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgIDH5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:57:42 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:42092 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIDH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UX09Qx4my4iQJ9tpbhbv55z9gt8MX+X9FF9KxeKoY3c=; b=HlfKGcc3anetVZvH2Ir+dLNkjB
        F60whqXQio34uUCPSTbsJKvetmgJxyIid0sShmatr9d3m8L2E01qVrotRP6c5qLivntA7M9g7Ce/T
        W25gnp6dQKv6mJryFxShE+bZ1vRTlMFtUpmxTkx63/4niflzgQjKUtN4OI67Cc3AZolw=;
Received: from lfbn-mar-1-582-44.w109-208.abo.wanadoo.fr ([109.208.127.44] helo=[192.168.1.116])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1kE6bI-0003Od-6F; Fri, 04 Sep 2020 02:57:38 -0500
Subject: Re: [PATCH v3 1/3] perf dso: Use libbfd to read build_id and
 .gnu_debuglink section
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
References: <20200821165238.1340315-1-rbernon@codeweavers.com>
 <20200903002519.GA3487700@kernel.org> <20200903165132.GA3495158@kernel.org>
From:   Remi Bernon <rbernon@codeweavers.com>
Message-ID: <76cc6da5-bf1e-4de3-7b79-b9759dc6e5b9@codeweavers.com>
Date:   Fri, 4 Sep 2020 09:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903165132.GA3495158@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 18:51, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 02, 2020 at 09:25:19PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Aug 21, 2020 at 06:52:36PM +0200, Remi Bernon escreveu:
>>> Wine generates PE binaries for most of its modules and perf is unable
>>> to parse these files to get build_id or .gnu_debuglink section.
>>>
>>> Using libbfd when available, instead of libelf, makes it possible to
>>> resolve debug file location regardless of the dso binary format.
>>>
>>> Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Jacek Caban <jacek@codeweavers.com>
>>> ---
>>>
>>> v3: Rebase and small changes to PATCH 2/3 and and PATCH 3/3.
>>>
>>>   tools/perf/util/symbol-elf.c | 80 ++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 77 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>>> index 8cc4b0059fb0..f7432c4a4154 100644
>>> --- a/tools/perf/util/symbol-elf.c
>>> +++ b/tools/perf/util/symbol-elf.c
>>> @@ -50,6 +50,10 @@ typedef Elf64_Nhdr GElf_Nhdr;
>>>   #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
>>>   #endif
>>>   
>>> +#ifdef HAVE_LIBBFD_SUPPORT
>>
>> So, the feature test should also test for the buildid struct field, see
>> below:
>>
>>> +#define PACKAGE 'perf'
>>> +#include <bfd.h>
>>> +#else
>>>   #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
>>>   extern char *cplus_demangle(const char *, int);
>>>   
>>> @@ -65,9 +69,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
>>>   {
>>>   	return NULL;
>>>   }
>>> -#else
>>> -#define PACKAGE 'perf'
>>> -#include <bfd.h>
>>> +#endif
>>>   #endif
>>>   #endif
>>>   
>>> @@ -530,6 +532,36 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>>>   	return err;
>>>   }
>>>   
>>> +#ifdef HAVE_LIBBFD_SUPPORT
>>> +
>>> +int filename__read_build_id(const char *filename, void *bf, size_t size)
>>> +{
>>> +	int err = -1;
>>> +	bfd *abfd;
>>> +
>>> +	abfd = bfd_openr(filename, NULL);
>>> +	if (!abfd)
>>> +		return -1;
>>> +
>>> +	if (!bfd_check_format(abfd, bfd_object)) {
>>> +		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
>>> +		goto out_close;
>>> +	}
>>> +
>>> +	if (!abfd->build_id || abfd->build_id->size > size)
>>> +		goto out_close;
>>
>> amazonlinux:1, centos:6, debian:8, mageia:5, oraclelinux:6, ubuntu:14.04
>> fail, its all old stuff, but adding a reference to abfd->build_id to the
>> feature test that ends up defining HAVE_LIBBFD_SUPPORT will solve that,
>> I'll do it tomorrow morning if you don't beat me to it.
>>
>> util/symbol-elf.c: In function 'filename__read_build_id':
>> util/symbol-elf.c:551:11: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    if (!abfd->build_id || abfd->build_id->size > size)
>>             ^~
>> util/symbol-elf.c:551:29: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    if (!abfd->build_id || abfd->build_id->size > size)
>>                               ^~
>> util/symbol-elf.c:554:17: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    memcpy(bf, abfd->build_id->data, abfd->build_id->size);
>>                   ^~
>> util/symbol-elf.c:554:39: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    memcpy(bf, abfd->build_id->data, abfd->build_id->size);
>>                                         ^~
>> util/symbol-elf.c:555:18: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
>>                    ^~
>> util/symbol-elf.c:555:50: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
>>                                                    ^~
>> util/symbol-elf.c:556:12: error: 'bfd {aka struct bfd}' has no member named 'build_id'
>>    err = abfd->build_id->size;
>>              ^~
>>    CC       /tmp/build/perf/util/cap.o
>> make[4]: *** [/tmp/build/perf/util/symbol-elf.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>>    LD       /tmp/build/perf/util/scripting-engines/perf-in.o
>>    LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>> make[3]: *** [util] Error 2
>> make[2]: *** [/tmp/build/perf/perf-in.o] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [sub-make] Error 2
>> make: *** [all] Error 2
>> make: Leaving directory `/git/linux/tools/perf'
>> + exit 1
>> [perfbuilder@five ~]$
> 
> So, I have the cset at the end of this message in front of your series +
> the following patch applied to your patch, the debuglink part seems ok
> and can continue depending on just libbfd, having or not abfd->buildid.
> 

Thanks! I may have missed the first changeset you mention -- IIUC the 
one adding the feature check -- but it sounds good to me nonetheless.

Should I do anything?
-- 
Rémi Bernon <rbernon@codeweavers.com>
