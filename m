Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC3AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD5A206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQnQ/Pjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgGWQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:21:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59694 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726632AbgGWQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595521269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xm8Gwy5ngihHCS6QCYYSXxX1Hk7bq+Zu3h9/fGUbCOg=;
        b=VQnQ/PjnYShtGAl+0oFMKksNNZltxeakRW+4KIf07YtT+QkHSLpfN4QkQobRbL7zxjaRgK
        +jQGsHIgKxBuGqZXb1gWz3UmgH9udQXcnrH2OGOrsixFdFP/TRcWY70Vk9lkA8/ICJVH2O
        +/MzjcX5pXykqglIpuqpRWbWTSg9EpA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-9WAAPpuwNl2XqacYRMwOfw-1; Thu, 23 Jul 2020 12:21:07 -0400
X-MC-Unique: 9WAAPpuwNl2XqacYRMwOfw-1
Received: by mail-qv1-f72.google.com with SMTP id j8so1399832qvu.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xm8Gwy5ngihHCS6QCYYSXxX1Hk7bq+Zu3h9/fGUbCOg=;
        b=qPiibAwWE1/EvIKtXkSfjEvAVE2U/DL+426C3gtMpdsH44o4xcrgdKipQdeDJADb5e
         kJgDEC7jON/cGtg4/52lEmlXY8xHy6qPKkByQCZ+GoBj7Nd7oMBgUuuiC7mwZzhJwsJT
         LyqVpNEPON4JzADcysFm5QX3VIKQAg9bQoTOgTxX22RzEpA99Hgk1yWLVtvskJXlmTKq
         NC8az7doCnXQw+OEpjyFUWNyfoQKEU2WXmAtpF+Z5WosK3nay7kt/vaqHpvxOkt2hYNQ
         eAzkcuwfmU0OMDhyaqvlDjwKkZBlMQHR2vxT+967InT30SkzpFWmk/rlwuOm+X12cYWX
         x6BQ==
X-Gm-Message-State: AOAM531Lu/7VD0XbfTD6sRJCKJxK4Yko/q7/coS99OhlvtXK8Wq4PlN0
        TAxvgWxZyf2ANhsBvjvqDctP2qY8GvnPYsqMJIiplwKEOr2sUvsWG9QpoH8d8ha0CmXAbk2qBDe
        N0xv14ZJx45Pha7zZM3mPFc6Q
X-Received: by 2002:a37:6d47:: with SMTP id i68mr6113268qkc.74.1595521263838;
        Thu, 23 Jul 2020 09:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaX6ObApGhH0vkIFqvVT8seNfWZRsfMGlpKQFK3E141apDdMNGSGfgch9WELF3Pab7cuqbqA==
X-Received: by 2002:a37:6d47:: with SMTP id i68mr6113249qkc.74.1595521263624;
        Thu, 23 Jul 2020 09:21:03 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j31sm2785738qtb.63.2020.07.23.09.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 09:21:03 -0700 (PDT)
Subject: Re: [PATCH] bpf: BPF_SYSCALL depends INET
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, krzk@kernel.org,
        patrick.bellasi@arm.com, David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20200723141914.20722-1-trix@redhat.com>
 <CAADnVQJYsqosZ804geM1Urrz73+z1fMZu1w76KN-847S3CL+nQ@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <85785371-f0e9-5c85-959f-b9830b4eb06a@redhat.com>
Date:   Thu, 23 Jul 2020 09:20:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJYsqosZ804geM1Urrz73+z1fMZu1w76KN-847S3CL+nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/23/20 8:27 AM, Alexei Starovoitov wrote:
> On Thu, Jul 23, 2020 at 7:19 AM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A link error
>>
>> kernel/bpf/net_namespace.o: In function `bpf_netns_link_release':
>> net_namespace.c: undefined reference to `bpf_sk_lookup_enabled'
>>
>> bpf_sk_lookup_enabled is defined with INET
>> net_namespace is controlled by BPF_SYSCALL
> pls rebase. it was fixed already.
>
I guess it hasn't shown up in linux-next yet.

As i rebase every day, i'll get it evently.

Sorry for noise.

Tom

