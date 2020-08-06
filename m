Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358D5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9742173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBRNosgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHFBFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgHFBFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:05:17 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4FBC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 18:05:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so32078664qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=LkxSeINbwCCH9ty24BhSH/ImEcPheAOucERD1Y3zZ3w=;
        b=VBRNosgbiIFhAeYFW+zF6atgu23gJ71NtnUHecY4GaRXDaNVwIp9dVlg9XsI/m9zfo
         eskS+qS3ROoQt0JD7mDEedLyz1+tOwGm80hn9lqHPfrbf3gcjgIudJEJZFBUJCfM/cXq
         1fn5XhZobnbevbK/4GEPEc17JZh2e2hn7l+hyj/74bziVWSKtMqGFG4UJa2o582wK9bv
         hXMySkB+Ezzv5G8PiET0fB52+Lu++wws10E7TuOwl4YT2ldKm4G/Jf1ldO5bw5SgCYBi
         A+W9g4WTwvQHbw3Qx9rJ49l5EFbLlzupLH+GESWMYU2+sJANuCXBNNrnXIrWIIoOMDoH
         aoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=LkxSeINbwCCH9ty24BhSH/ImEcPheAOucERD1Y3zZ3w=;
        b=nBPSUZHT5Lhz2CsWPFHNKlClWIgqQ/Ytk8hkbq9a0ftOMjUdoFxw4StsR4ch6GsH4C
         MXU50SfE3/MAiBJkLGKmpCsnyhrfjWySDv9ABmnnVImNtC9mOFq3zaWPpShtf7RrFAwD
         jzWMZs9cykh8HyZtZinqsjlDPR4Y1mLp4pHPULjMTsn28AOK2hGh5S9lzaaJKiPRaB7S
         7/03VQ0iT2pcHEgjuWuQrm9GpBTtkT5qwMl85enVQ9GkEJMHPa8MN26ZMf+T3G4PEQCK
         y0TovgMQpO5uyi844EtRTrB3eGvPLbh9uIVeP6NLQtvPEBUqTUs9I/Wn+NZcCl5X0fVc
         jUvA==
X-Gm-Message-State: AOAM531hn63SX8cekgTylA4+SNBKMTNhOUnz2sp1HLP6KZ1XTCIyXdEn
        wcshxOjMxzWLcCkztKyiX1CHRSNIMHk=
X-Google-Smtp-Source: ABdhPJwNPaVZCRPxi6w9nfS4xJi7eWe8U4u/KlnBsFsnmHW8d8wFKfump+D6C0ys54ZEwrtBKgiQuA==
X-Received: by 2002:ac8:6b04:: with SMTP id w4mr6698007qts.364.1596675916561;
        Wed, 05 Aug 2020 18:05:16 -0700 (PDT)
Received: from RedmiNote8Pro-Redmi.localdomain ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q2sm3644777qtl.64.2020.08.05.18.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 18:05:16 -0700 (PDT)
Date:   Wed, 05 Aug 2020 22:05:03 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200806001448.ln2u7qyc4fnuk5lh@mail.google.com>
References: <20200718064826.9865-1-changbin.du@gmail.com> <20200718064826.9865-2-changbin.du@gmail.com> <20200804125115.GF3440834@kernel.org> <20200806001448.ln2u7qyc4fnuk5lh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 01/18] perf ftrace: select function/function_graph tracer automatically
To:     Changbin Du <changbin.du@gmail.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <E69D6A9B-D2F7-43EA-AD6F-3164F199A6E4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 5, 2020 9:14:48 PM GMT-03:00, Changbin Du <changbin=2Edu@gmail=
=2Ecom> wrote:
>On Tue, Aug 04, 2020 at 09:51:15AM -0300, Arnaldo Carvalho de Melo
>wrote:
>> Em Sat, Jul 18, 2020 at 02:48:09PM +0800, Changbin Du escreveu:
>> > The '-g/-G' options have already implied function_graph tracer
>should be
>> > used instead of function tracer=2E So the extra option '--tracer' can
>be
>> > killed=2E
>> >=20
>> > This patch changes the behavior as below:
>> >   - By default, function tracer is used=2E
>> >   - If '-g' or '-G' option is on, then function_graph tracer is
>used=2E
>> >   - The perf configuration item 'ftrace=2Etracer' is marked as
>deprecated=2E
>> >   - The option '--tracer' is marked as deprecated=2E
>>=20
>> You should try to be more granular, for instance, I think the
>decision
>> to change the default is questionable, but could be acceptable=2E
>>=20
>> But why deprecate the perf configuration for the default tracer?
>>=20
>> Say people who already use 'perf ftrace ls' go and use with this
>patch
>> and see that it changed the default from the function_graph tracer to
>> the function tracer and disagree with you, they want the default to
>be
>> the function graph tracer, know that there is (or there was) a
>> ftrace=2Etracer in ~/=2Eprefconfig, and then try that, only to find out
>that
>> it is not possible, frustrating :-\
>>=20
>> So can we please remove this deprecation of ftrace=2Etracer so that
>people
>> used to how it was can get that behaviour back?
>>=20
>Agreed=2E If no -F or -G is given, we can use the ftrace=2Etracer as
>default tracer=2E
>Let me update it=2E Thanks=2E

Thanks, I'm general try to be as granular as possible, doing one thing per=
 patch, this way the reviewer can do some preliminary cherry picking and we=
 also improve git bisectability=2E

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
