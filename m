Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D24C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FFD207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgEENLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:11:19 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:30294 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgEENLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:11:19 -0400
Subject: Re: perf build error with gcc 10 on arm and aarch64
To:     Leo Yan <leo.yan@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
References: <2869c4f6-9adf-3d55-a41d-a42865ae56f2@mageia.org>
 <EqtrWAkr-uZW90nfEH5i3KgHuQU8DLdDEXPSqRws1z9zrOixq2T0wt5uDhcFI5JVaIr_DGq7PP9Z-Q3B-LAaqQ==@protonmail.internalid>
 <d_gtAu9vE4vjOEgey1diEg23nPoDIv-gc4ranvkRDMtmWycFo1uU_YHcJn5BNlrNVJA1y2zVbUvE8_Lf44bKDg==@protonmail.conversationid>
 <20200505041050.GA8131@leoy-ThinkPad-X240s>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <ed17a79e-81cd-8514-aaa7-13223bd1c789@mageia.org>
Date:   Tue, 5 May 2020 16:11:14 +0300
MIME-Version: 1.0
In-Reply-To: <20200505041050.GA8131@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 05-05-2020 kl. 07:10, skrev Leo Yan:
> 
> Hi Thomas,
> 
> [ + Mathieu/Mike/Suzuki ]
> 
> On Mon, May 04, 2020 at 10:22:27PM +0300, Thomas Backlund wrote:
>> This is building perf from kernel-5.6.10 on armv7hl and aarch64:
>>
>> Compiler is gcc 10.1.0-RC
>>
>>
>>    LD       perf-in.o
>> ld: arch/perf-in.o: in function `.LANCHOR0':
>> /home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
>> multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/cs-etm.h:118:
>> first defined here
>> make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/build/Makefile.build:145:
>> perf-in.o] Error 1
>>
>>    LD       perf-in.o
>> ld: arch/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
>> multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/cs-etm.h:118:
>> first defined here
>> make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/build/Makefile.build:145:
>> perf-in.o] Error 1
>> make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
>> make[1]: *** [Makefile.perf:225: sub-make] Error 2
>> make: *** [Makefile:70: all] Error 2
>>
>>
>> The same build succeeds with gcc 9.3.0
> 
> Thanks for reporting the issue.
> 
> Could you help confirm if below change can resolve this issue?

Yes,

fix confirmed on i586, x86_64, armv7hl and aarch64 builds

so I guess you can add:

Reported-by: Thomas Backlund <tmb@mageia.org>
Tested-by: Thomas Backlund <tmb@mageia.org>



> 
> Thanks,
> Leo
> 
> ---8<---
> 
> Subject: [PATCH] perf cs-etm: Move defined of traceid_list
> 
> The variable 'traceid_list' is defined in the header file cs-etm.h,
> if multiple C files include cs-etm.h the compiler might complaint for
> multiple definition of 'traceid_list'.
> 
> To fix multiple definition error, move the definition of 'traceid_list'
> into cs-etm.c.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   tools/perf/util/cs-etm.c | 3 +++
>   tools/perf/util/cs-etm.h | 3 ---
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 62d2f9b9ce1b..381d9708e9bd 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -94,6 +94,9 @@ struct cs_etm_queue {
>   	struct cs_etm_traceid_queue **traceid_queues;
>   };
> 
> +/* RB tree for quick conversion between traceID and metadata pointers */
> +static struct intlist *traceid_list;
> +
>   static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
>   static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>   static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 650ecc2a6349..4ad925d6d799 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -114,9 +114,6 @@ enum cs_etm_isa {
>   	CS_ETM_ISA_T32,
>   };
> 
> -/* RB tree for quick conversion between traceID and metadata pointers */
> -struct intlist *traceid_list;
> -
>   struct cs_etm_queue;
> 
>   struct cs_etm_packet {
> --
> 2.17.1
> 

