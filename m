Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E7C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBC22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFES00tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgGPVGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:06:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725926AbgGPVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594933579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLDq3OcxyKpCr/USzTjJkCi91v74L71ZluKPOuOKGzQ=;
        b=fFES00tj59odvbcaioAdQJlQRFCIj3hcirGioEJq0RKRdlusp98e4RvAphYJELcBhn1R+O
        lKiLDyUeAOFBBr6MEU7YeAyy9B6LxYPV7bM2JJmkxaEXuHL72s3LVChX0w/siKuU8Hc6/8
        6hO6rw7evS7E6LYfmME1wKRQk1YfmzM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-f-qcm1ZOPYOxA4SdiXg82g-1; Thu, 16 Jul 2020 17:06:17 -0400
X-MC-Unique: f-qcm1ZOPYOxA4SdiXg82g-1
Received: by mail-qv1-f72.google.com with SMTP id g17so4259365qvw.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OLDq3OcxyKpCr/USzTjJkCi91v74L71ZluKPOuOKGzQ=;
        b=S/eIe8G0n3IRUj4AyJLjXoQ+KPGMKvtvbLYQOr9QxYO/Kea801hWPcq0wyHgayxMQJ
         R0tsLKfa/H8d7Ln20Rqvmd2WxSbYv/niTEhWjZHsq8WGc033a9zYokw/uO2NGpN32OGC
         a9p0mZGBehSc7B4dyR6inbBTYMMZKl3tXxxaHwWp17hSJrb6XTJEmhKECQuRLyVvyAbB
         eelyCHW8UyZ1r06v3QfAMaxODs/H0lUB5AC2/GJE5cen2YpvSMczf2pkmegk40tz5J+G
         5mtavDqpPnOpvqRfevJR7NpNHYkveiiYUgl6ryYfMCYxq61OgFbDwEXHZ8xmufsa09WK
         DeZQ==
X-Gm-Message-State: AOAM531WXb71LEHisUqE9RDEFl0ULA9kr16PrqYgdzEJ/E8WO3e86gb2
        mOPkC46u/eUQowGgJp/nJkq/NV30r6CHmPNZGf6Umd+ct7tBKTxdr/TOvZw31ih2OZTEizelfb2
        TLPzTqbH7837MlCYUvLWmsQtd
X-Received: by 2002:ac8:1baf:: with SMTP id z44mr7415705qtj.129.1594933577271;
        Thu, 16 Jul 2020 14:06:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzCczOckQlwY1nK69Pc/C/n4qYzceHop/94SGB5gIGW9ftGNiz7RdgGl+LrXtddfGguKBnRg==
X-Received: by 2002:ac8:1baf:: with SMTP id z44mr7415675qtj.129.1594933577017;
        Thu, 16 Jul 2020 14:06:17 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id z60sm8839761qtc.30.2020.07.16.14.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 14:06:16 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        gofmanp@gmail.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, jannh@google.com
References: <20200716193141.4068476-1-krisman@collabora.com>
 <202007161300.7452A2C5@keescook>
 <20200716202234.wryj7pj7zmwcrxxx@wittgenstein>
 <202007161324.E75E01B@keescook>
 <20200716202935.yorxrz2om67r366x@wittgenstein> <871rlbjj7r.fsf@collabora.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <d0d8b5aa-757e-4306-5558-0f448db69445@redhat.com>
Date:   Thu, 16 Jul 2020 17:06:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871rlbjj7r.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 4:30 PM, Gabriel Krisman Bertazi wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
>> On Thu, Jul 16, 2020 at 01:25:43PM -0700, Kees Cook wrote:
>>> On Thu, Jul 16, 2020 at 10:22:34PM +0200, Christian Brauner wrote:
>>>> On Thu, Jul 16, 2020 at 01:04:38PM -0700, Kees Cook wrote:
>>>>> On Thu, Jul 16, 2020 at 03:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>>>>>> This is v4 of Syscall User Redirection.  The implementation itself is
>>>>>> not modified from v3, it only applies the latest round of reviews to the
>>>>>> selftests.
>>>>>>
>>>>>> __NR_syscalls is not really exported in header files other than
>>>>>> asm-generic for every architecture, so it felt safer to optionally
>>>>>> expose it with a fallback to a high value.
>>>>>>
>>>>>> Also, I didn't expose tests for PR_GET as that is not currently
>>>>>> implemented.  If possible, I'd have it supported by a future patchset,
>>>>>> since it is not immediately necessary to support this feature.
>>>>>
>>>>> Thanks! That all looks good to me.
>>>>
>>>> Don't have any problem with this but did this ever get exposure on
>>>> linux-api? This is the first time I see this pop up.
>>>
>>> I thought I'd added it to CC in the past, but that might have been other
>>> recent unrelated threads. Does this need a full repost there too, you
>>> think?
>>
>> Nah, wasn't my intention to force a repost. Seems that several people
>> have looked this over. :) Just curious why it didn't get to linux-api
>> and we know quite some people who only do look at linux-api (for sanity). :)
> 
> That's my mistake.  I didn't think about it when submitting :(
> 
> If this get re-spinned again I will make sure to CC linux-api.

Thank you! It helps C library implementors stay up to date and comment
on changes that impact userspace ABIs and APIs. This patch set was new
to me. Interesting new feature.

-- 
Cheers,
Carlos.

