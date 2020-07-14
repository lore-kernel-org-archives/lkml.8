Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A880C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F108920658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG3F4bV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGNVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:31:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43927 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727101AbgGNVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594762273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2jjMlQNGljDKhczKBKSdNL0F7/+3pAMGrpUsxclRjw=;
        b=TG3F4bV69A/sXIHC0vLWa8qXNzt3LLCklHYcD69hRDZf+Kfp/ThO7WhAXipHBnnPT+A0JW
        eZcEclgwuIHMLGZ7ZS8vbT9IUkD2iulYLGoa7QvtIf3eitaYE1kd4vsDyuIixv8CKCDK1X
        DeU1Go1l6mQteYxchRyTJ5LdaawOems=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-6O96uBO8PVy_396vys0hUw-1; Tue, 14 Jul 2020 17:30:52 -0400
X-MC-Unique: 6O96uBO8PVy_396vys0hUw-1
Received: by mail-qv1-f72.google.com with SMTP id m8so30845qvv.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P2jjMlQNGljDKhczKBKSdNL0F7/+3pAMGrpUsxclRjw=;
        b=BU5RHZ6ZEsBeRt/zOK8AMs0yIuRjVygerRygdjVyvQMsO18JkgUDNYGMdOOICR/MG1
         AtZ2EaYWcXMQwDimuwdQLrmgYBHtd1Hrbedpj9+Xl+yo5PFik1Pkca4EtYdhQm1J4M5P
         C9g8L+8Nq1lN7hlt0usxNoayJlpVlnmKO/FcnPXuWsQ5BKpnPNeCvolKd2AtzcLeF+AR
         GkfDv2x7ALdRkMQLlJGTbtP+ySmmGtbl3z91wrz1EAI+SzoZu4p6MTc+VFJS/qNoLWgS
         EQwpLiD3h1qgAElNrxPjmSpvhlDEgvFaFEuEF4k07PF536LXO4ypSca4LnRw+xH3u/vA
         zztQ==
X-Gm-Message-State: AOAM533XbBdp5Aml8vaWc+SP8JdVtyjuaPnNS+aFI024/zxdoTzUd0ko
        4Ouyqim2szV4sfI5WBiX6RyPn6m1MsgsTiHDip3BmPLU6TtLezPrWVTI18PMwdhuxIPSa8qymY1
        eBK8dlSib+AVIVRIUuGQSftn7
X-Received: by 2002:a05:6214:b88:: with SMTP id fe8mr6538662qvb.244.1594762251500;
        Tue, 14 Jul 2020 14:30:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy37EnGkXWH29/is0Rnyzb85M4QGYNcVEtSjI8TXgMm71R1QkncAoCqNse2QQbDKv4E0v71Gg==
X-Received: by 2002:a05:6214:b88:: with SMTP id fe8mr6538645qvb.244.1594762251246;
        Tue, 14 Jul 2020 14:30:51 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id q5sm360934qtf.12.2020.07.14.14.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 14:30:50 -0700 (PDT)
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
 <87mu42bepq.fsf@oldenburg2.str.redhat.com>
 <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
 <87a7028d5u.fsf@oldenburg2.str.redhat.com>
 <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com>
Date:   Tue, 14 Jul 2020 17:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 9:19 AM, Mathieu Desnoyers wrote:
> Is there an arch-agnostic way to get the thread pointer from user-space code ? That
> would be needed by all rseq critical section implementations.

Yes, and no. We have void *__builtin_thread_pointer (void), but
few architectures implement the builtin so we'd have to go through
a round of compiler updates and backports. All targets know how to
access the thread pointer because the compiler has to generate
IE-mode accesses to the TLS variables.

I have filed an enhancement request:
Bug 96200 - Implement __builtin_thread_pointer() and 
            __builtin_set_thread_pointer() if TLS is supported
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96200

We have glibc internal macro APIs to access the thread pointer,
but I would rather the compiler handle the access since it can
schedule the resulting sequence better.

On some arches setting the therad pointer needs a syscall or
equivalent operation (hppa), and for some arches there is no
fixed register (arm) hence the need for __builtin_thread_pointer()
to force the compiler to place the pointer into a register for
function return.

-- 
Cheers,
Carlos.

