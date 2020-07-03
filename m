Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA918C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE66D20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJlOthlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGCRvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:51:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48522 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbgGCRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593798665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7N8C0ylSkVt52CpPmDfK6oXLgMs/h4S3a8iKhtYc04=;
        b=OJlOthlkmStdZ5Zia/kp8X2rr3Yv/6KcfngloQywAdCOosF/VY65Oty+wIRfUDbGE9MDEl
        9xv+A/DZsGA30A1Y39Ifi4JKmJ+ulVEG79xjnzYLoheCVa7HAhOuoS3WjSuDKVPU4iEZ9u
        CtDFqShLMQbpKm+l0TbFFLvHmm29P0A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ht0SAi4cPPK833S_lia4UQ-1; Fri, 03 Jul 2020 13:51:02 -0400
X-MC-Unique: ht0SAi4cPPK833S_lia4UQ-1
Received: by mail-qv1-f70.google.com with SMTP id cv20so10098404qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+7N8C0ylSkVt52CpPmDfK6oXLgMs/h4S3a8iKhtYc04=;
        b=pmm168i3AaKN521GllJm1omJedegTOLRMtNcagK9HFua/olp1l/d7N89M09lRxtw/q
         2h7MTEIULChGc/DiDrgASp2/ZtvmIHwzs6OHmJ0AwdQYup9l8aZFPJO2NZ7Yrl/pkNfh
         88UUSOgXgSzael+H+3iuhF23pq3wku+2hGyzbQSCRNqbwFhaRbkj6qIBtz2i+/TQ2xdR
         ZEwSY0dMVDtgyxX2l8tnvv25DWXQehBczMzgNuOdn9FYdEW3jQfNSE9q1KxiqgE+V+Rt
         uIOzSCSF/09ISU/FDkRoLhsBVG3NA2rZ4A3jUVfN3cWbjxmj8tQGk1W/JqSdNsWZIoPW
         MNpg==
X-Gm-Message-State: AOAM533mHdxnarKM+HXDpYY41smgyL5PtTZp8UDFtfjkyGXzC0f6oKMb
        yy0lgy/h0nHU122W+0ipUvDWxCwL2K3KU72rOCE4Rufqg46u7Mr2DoXgUsYEbBEBxxZMx5SuTt7
        oIh+rjqRkBb1oLfvEQVcSDAMG
X-Received: by 2002:ac8:24e8:: with SMTP id t37mr38245604qtt.319.1593798662264;
        Fri, 03 Jul 2020 10:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqygbCTvDXxs/+iL1FjRBTGhWsR6PP3NMzt2MJgrawQtn0tIyhC9vS0/XAMiNz4Fz7HmbA/A==
X-Received: by 2002:ac8:24e8:: with SMTP id t37mr38245582qtt.319.1593798662026;
        Fri, 03 Jul 2020 10:51:02 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id t36sm12209686qtj.58.2020.07.03.10.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 10:51:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and
 thread creation (v22)
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>, linux-api@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com>
 <20200629190036.26982-2-mathieu.desnoyers@efficios.com>
 <87o8oy9dqe.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <ac7b3d44-969a-c5bb-0b33-c997d29ea142@redhat.com>
Date:   Fri, 3 Jul 2020 13:50:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87o8oy9dqe.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 10:46 AM, Florian Weimer wrote:
> * Mathieu Desnoyers via Libc-alpha:
> 
>> Register rseq TLS for each thread (including main), and unregister for
>> each thread (excluding main).  "rseq" stands for Restartable Sequences.
>>
>> See the rseq(2) man page proposed here:
>>   https://lkml.org/lkml/2018/9/19/647
>>
>> Those are based on glibc master branch commit 3ee1e0ec5c.
>> The rseq system call was merged into Linux 4.18.
>>
>> The TLS_STATIC_SURPLUS define is increased to leave additional room for
>> dlopen'd initial-exec TLS, which keeps elf/tst-auditmany working.
>>
>> The increase (76 bytes) is larger than 32 bytes because it has not been
>> increased in quite a while.  The cost in terms of additional TLS storage
>> is quite significant, but it will also obscure some initial-exec-related
>> dlopen failures.
> 
> We need another change to get this working on most non-x86
> architectures:
> 
> diff --git a/elf/dl-tls.c b/elf/dl-tls.c
> index 817bcbbf59..ca13778ca9 100644
> --- a/elf/dl-tls.c
> +++ b/elf/dl-tls.c
> @@ -134,6 +134,12 @@ void
>  _dl_determine_tlsoffset (void)
>  {
>    size_t max_align = TLS_TCB_ALIGN;
> +  /* libc.so with rseq has TLS with 32-byte alignment.  Since TLS is
> +     initialized before audit modules are loaded and slotinfo
> +     information is available, this is not taken into account below in
> +     the audit case.  */
> +  max_align = MAX (max_align, 32U);
> +
>    size_t freetop = 0;
>    size_t freebottom = 0;
> 
> This isn't visible on x86-64 because TLS_TCB_ALIGN is already 64 there.
> 
> I plan to re-test with this fix and push the series.
> 
> Carlos, is it okay if I fold in the dl-tls.c change if testing looks
> good?

I have reviewed the above and I think it is the correct *pragmatic* fix.

The reality is that to fix this fully you must use a two stage loading
process to pre-examine all audit modules *before* setting the fundamental
alignment of the TCB.  This isn't easy with the current loader framework.
Therefore the above is a good pragmatic solution.

There is always going to be a bit of a chicken and an egg situation.
We want to provide a fundamental alignment requirement but we haven't
yet seen all the requirements on alignment. So the best we could do is
look over DT_NEEDED, DT_AUDIT, LD_PRELOAD, etc. get the best answer
and then fail any subsequent dlopen's that load objects with higher
fundamental requirements for alignment of the TCB.

The audit modules are problematic becuase they are loaded *before*
anything else is loaded, *before* we've examined any of the actual
objects we're about to load because they can influence the search
paths. Again, this means the above solution is a perfect pragmatic
choice. The real solution is to rearchitect the early audit module
loading into two stages and that's work we can do later.

OK with the above change.

-- 
Cheers,
Carlos.

