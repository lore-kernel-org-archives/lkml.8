Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492B4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15EF2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="adE2B2Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEJDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:03:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38511 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCEJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:03:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so5173031ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 01:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+nyhy3biY02LIl4kBkjbxJ2dWjzxv1IAt+3PKhBtDE=;
        b=adE2B2XkLqsd0IRa+nAvysANIFaAJhyJUDjsZjaeMRjhIacspUqor3sR2vgW5KxlR0
         yaeVJXmuCtcCtPd1emscrdjWgwBLEBSQlUy6X/wipkS1iU1Xrv3haU3SJuBAw58tAKXN
         ePuoeD8dpBz2YWIpZGllhhZdb1h61/uXZ7KmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+nyhy3biY02LIl4kBkjbxJ2dWjzxv1IAt+3PKhBtDE=;
        b=Dr82rTRAqA9/dBMuEorxp+Nhd+h8yOniP4868v/q3hAFii/TPIj2v0/5SGn8a+IYFL
         Aep8SWJMWDFHI/bzIiGlqvwP5oMryVESr6w7gaOSy76vWUoTvt8cD1ukck/BnoXuJmJO
         i0/SRFiJHxFQq3Zg1k1TFQVabZ3PPMd5x84K36Cdzw5tx88IzvTqLF7zJaacZo+NFTFF
         WDA+h9+rnDC6E55TmmGDSxkNEz6X7s+rzmy/tlwyXLk5RDpJZMA0Mlo/6/FiJzasPYW4
         fZEOUQSsqPgBhvFOBB+4pbWUCIQOo5hRlEazvabmY6a0dV9Y/x9jqFLK10Zp0zzV9v2C
         Mp9Q==
X-Gm-Message-State: ANhLgQ3j3lPTXQDTAh1XzBZjPs7BOb0cdEb9pqb64exDmH0BtKwsAiMw
        uVL1SQoeyKylBqkFAFKDGC7DY94l9zAKCMS/
X-Google-Smtp-Source: ADFU+vuwpeT6grWUw/3SZRIzyyguUNee5NahuOQg0T4LKxoIoY3hoMytiDSWCzR56EF00n4V1NJ66A==
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr4818202ljp.57.1583399007530;
        Thu, 05 Mar 2020 01:03:27 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y24sm17699428lfg.63.2020.03.05.01.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 01:03:27 -0800 (PST)
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
To:     Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Joe Perches <joe@perches.com>, Todd Kjos <tkjos@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <CAG48ez3sPSFQjB7K64YiNYfemZ_W9cCcKQW34XAcLP_MkXUjCw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <205aa3d8-7d18-1b73-4650-5ef534fe55da@rasmusvillemoes.dk>
Date:   Thu, 5 Mar 2020 10:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3sPSFQjB7K64YiNYfemZ_W9cCcKQW34XAcLP_MkXUjCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2020 19.31, Jann Horn wrote:
> On Mon, Mar 2, 2020 at 7:17 PM Alexander Potapenko <glider@google.com> wrote:
>> On Mon, Mar 2, 2020 at 3:00 PM Joe Perches <joe@perches.com> wrote:
>>>
>>> So?  CONFIG_INIT_STACK_ALL by design slows down code.
>> Correct.
>>
>>> This marking would likely need to be done for nearly all
>>> 3000+ copy_from_user entries.
>> Unfortunately, yes. I was just hoping to do so for a handful of hot
>> cases that we encounter, but in the long-term a compiler solution must
>> supersede them.
>>
>>> Why not try to get something done on the compiler side
>>> to mark the function itself rather than the uses?
>> This is being worked on in the meantime as well (see
>> http://lists.llvm.org/pipermail/cfe-dev/2020-February/064633.html)
>> Do you have any particular requisitions about how this should look on
>> the source level?
> 
> Just thinking out loud: Should this be a function attribute, or should
> it be a builtin - something like __builtin_assume_initialized(ptr,
> len)? That would make it also work for macros,

But with macros (and static inlines), the compiler sees all the
initialization being done, no?

and it might simplify
> the handling of inlining in the compiler. And you wouldn't need such a
> complicated attribute that refers to function arguments by index and
> such.

Does copy_from_user guarantee to zero-initialize the remaining buffer if
copying fails partway through? Otherwise it will be hard for the
compiler to make use of an annotation such as __assume_initialized(buf,
size - ret_from_cfu) - it will have to say "ok, the caller is bailing
out unless ret_from_cfu is 0, and in that case, yes, the whole local
struct variable is indeed initialized". And we can't make the annotation
unconditionally __assume_initialized(buf, size) [unless c_f_u comes with
that guarantee] because we don't know that all callers of c_f_u() bail
out on non-zero.


Somewhat related: I've long wanted a bunch of function attributes

  __may_read(ptr, bytes)
  __may_write(ptr, bytes)
  __will_write(ptr, bytes)

The first could be used to warn about passing an uninitialized or
too-small buffer (e.g.

  struct pollfd fds[4];
  poll(fds, sizeof(fds), ...) // whoops, should have been ARRAY_SIZE)

the second also for warning about a too-small buffer, and the third
would essentially be the same as __assume_initializes. Perhaps with some
sanitization option the compiler could also instrument the function
definition to not read/write beyond the area declared via those attributes.

But the attribute syntax doesn't currently allow complex expressions in
terms of the parameter names; I'd want to annotate poll as

  int poll(struct pollfd *fds, nfds_t nfds, int to) __may_rw(fds, nfds *
sizeof(*fds))

Rasmus
