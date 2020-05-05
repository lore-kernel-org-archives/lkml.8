Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F978C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D907206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFaXrh76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEEELO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:11:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9EC061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:11:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a31so450225pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Kwafuj2FLiD7hVlDQdKVfvKIWDdvV6WdRZYd9KEeJM=;
        b=cFaXrh76dfWB6r/YEU/zi+jGdZ26J6I6v4kRm0GtDj1dJ4ZTpI4ayxD7koxNRXxn5V
         w8R9TGNEC6Ibfli9Cb1xl0MHFO5aGtFZtDmDdZCPOuC1s/MjHhFRA04t2VwUuOK2h6qP
         z05RTc6nV62gAqiTSOImtFKluz/KiyMRguZAiQMTJuxns5jf7Y5kgm5wYuK9iu9w2FVy
         a+3xXudAznoGDKf7zEo17kb2SnE5CaKoC0kHfpzwvxMIv9kkavWw2KkfKVe1lVr6sgU2
         icGkYaa6t5J6magrEAsEpnz3h/tONGPgx5GcAYlX3/W8sHi4NCrKjbST0ox9RADc9Udu
         wWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Kwafuj2FLiD7hVlDQdKVfvKIWDdvV6WdRZYd9KEeJM=;
        b=hlWsZW8Deev8xPz28jXkHZ/UFKUy7i6aELOwVXIy1xDYgWZtidADsr4CDljF/pZd4M
         vt2VbGg76llPBUEZ35tCeFF3yrVAd/2rLFec2VvE5JHtGJwBGT45CTaN326V2UI58Avd
         3aooj18UNFVnJBj4tq/VbpKs4aQuaE9QXzk4KgcmeuZoIdyiIB6B4/Z12zhYFHhfwa2S
         vYN7Gn3OL2DyTN2csHiCSjAi0sSEAox9nS8ZX+XAh+FWty+dSzPuE321ssBrkjnjsvry
         Uxexk34PIsfN1aB1wnCaNLGws9O5ElEgqvqfz/JReJa4cBttO8jM/2moFve0f5KBunNp
         Fcrw==
X-Gm-Message-State: AGi0PuYMC/3c47tpBh/UxEXCA6I/soKiuCeFTintfTViXm7LtbVaa/sp
        AnOL/1j/DvEIS0M++jrjmusqOg==
X-Google-Smtp-Source: APiQypKcgfdv/6GH2802tYSQ/0Yc3CoiwNAxspqEkXT77WEdg5ox2gxEufLwlOFLHwDSNo/UWlQ6oA==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr924977plq.165.1588651871763;
        Mon, 04 May 2020 21:11:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id c84sm615655pfb.153.2020.05.04.21.11.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 21:11:11 -0700 (PDT)
Date:   Tue, 5 May 2020 12:10:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Subject: Re: perf build error with gcc 10 on arm and aarch64
Message-ID: <20200505041050.GA8131@leoy-ThinkPad-X240s>
References: <2869c4f6-9adf-3d55-a41d-a42865ae56f2@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2869c4f6-9adf-3d55-a41d-a42865ae56f2@mageia.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

[ + Mathieu/Mike/Suzuki ]

On Mon, May 04, 2020 at 10:22:27PM +0300, Thomas Backlund wrote:
> This is building perf from kernel-5.6.10 on armv7hl and aarch64:
> 
> Compiler is gcc 10.1.0-RC
> 
> 
>   LD       perf-in.o
> ld: arch/perf-in.o: in function `.LANCHOR0':
> /home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
> multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/cs-etm.h:118:
> first defined here
> make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/build/Makefile.build:145:
> perf-in.o] Error 1
> 
>   LD       perf-in.o
> ld: arch/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
> multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/cs-etm.h:118:
> first defined here
> make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/build/Makefile.build:145:
> perf-in.o] Error 1
> make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
> make[1]: *** [Makefile.perf:225: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> 
> 
> The same build succeeds with gcc 9.3.0

Thanks for reporting the issue.

Could you help confirm if below change can resolve this issue?

Thanks,
Leo

---8<---

Subject: [PATCH] perf cs-etm: Move defined of traceid_list

The variable 'traceid_list' is defined in the header file cs-etm.h,
if multiple C files include cs-etm.h the compiler might complaint for
multiple definition of 'traceid_list'.

To fix multiple definition error, move the definition of 'traceid_list'
into cs-etm.c.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 3 +++
 tools/perf/util/cs-etm.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 62d2f9b9ce1b..381d9708e9bd 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -94,6 +94,9 @@ struct cs_etm_queue {
 	struct cs_etm_traceid_queue **traceid_queues;
 };
 
+/* RB tree for quick conversion between traceID and metadata pointers */
+static struct intlist *traceid_list;
+
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 650ecc2a6349..4ad925d6d799 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -114,9 +114,6 @@ enum cs_etm_isa {
 	CS_ETM_ISA_T32,
 };
 
-/* RB tree for quick conversion between traceID and metadata pointers */
-struct intlist *traceid_list;
-
 struct cs_etm_queue;
 
 struct cs_etm_packet {
-- 
2.17.1
