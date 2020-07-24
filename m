Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C253C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCAF206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="oCF2bACf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGXR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:29:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855DC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so4862370plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=oCF2bACf0J3wi10Mkevj6a1lx9ZJ2XYqftXol/Y5C3BUVETOi1ThoRhsL2OxKFCyb4
         LGJ3ZE9QuRoT+dYLR9CdhNjE9P+KA1F0J34lD0z4Rjmsdl1uULCFsHQh/kjIrw/3yYIN
         MIxEx6ObahD1W2wfYbyu5J04MgrODyT6hzuLM3mpaqgWNY1btI1HYMmRRqfrG327H9oM
         z5+CURUIEaZafgf40maNhBKcXiwP+sIOTIqvFURURI9WNSOzDt9L7YckftzfASDKb67X
         c6S0yxsINqy7Fs9MCqKwbe5ZznH0YewS4KMFQ8V9Fo2+D3qH4LKoiOb9hjdKp/ooZMns
         71UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=q51pGQQ1L6ab44si/yp1oeuM4PJCcd2nEKziDwUnTQqyrF02e+OU13htdf9RD7c9ct
         QNk7OGEoEnmW5OWB4f9GIEOKbzNZpS1lk+lg9dc6FclRuTUhXg55WBxjy930A8dEUws2
         rnnopmUpSV7Aecuy+7NjQHQ3jKN4IUWvxBfb5M2eiOYC/9pru26YT6VsN/VsGfWQZZMJ
         0eBmhqnBX6+pLsITSg6rc4QoTSNZAbkCsIBkrcKtMejO68N9D5/s7QiHyw2EcEglOoXP
         CKwtyQlI/lN23FNWNxtJYPzdMsFs7PN1NEquW0HyWp277puXAHr9e7jr2wpeUeslQH9Y
         cLRg==
X-Gm-Message-State: AOAM5335qrPFhLFzsZ17+dd5eNxU7pLNULxTxWyc8mFFF0+yZp6tGR5d
        pRb8ETGCTj6tp0a3BuzvjmGGig==
X-Google-Smtp-Source: ABdhPJxgGZkOO3kQzBrpxCwHwlk1F6DYD0lzx0NwksvJwkCVThBWugwQYsACXzFP/Kw/IrlXRyq2VQ==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr6495292pjq.195.1595611767681;
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:cc1b:c95e:6185:cfc7? ([2601:646:c200:1ef2:cc1b:c95e:6185:cfc7])
        by smtp.gmail.com with ESMTPSA id x66sm6882326pgb.12.2020.07.24.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date:   Fri, 24 Jul 2020 10:29:23 -0700
Message-Id: <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
References: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
In-Reply-To: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 24, 2020, at 10:23 AM, Ira Weiny <ira.weiny@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Jul 23, 2020 at 10:15:17PM +0200, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>=20
>>> Ira Weiny <ira.weiny@intel.com> writes:
>>>> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
>>>>>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
>>>>> I've been really digging into this today and I'm very concerned that I=
'm
>>>>> completely missing something WRT idtentry_enter() and idtentry_exit().=

>>>>>=20
>>>>> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}=
able()
>>>>> with trace_printk()'s.
>>>>>=20
>>>>> With this debug code, I have found an instance where it seems like
>>>>> idtentry_enter() is called without a corresponding idtentry_exit().  T=
his has
>>>>> left the thread ref counter at 0 which results in very bad things happ=
ening
>>>>> when __dev_access_disable() is called and the ref count goes negative.=

>>>>>=20
>>>>> Effectively this seems to be happening:
>>>>>=20
>>>>> ...
>>>>>    // ref =3D=3D 0
>>>>>    dev_access_enable()  // ref +=3D 1 =3D=3D> disable protection
>>>>>        // exception  (which one I don't know)
>>>>>            idtentry_enter()
>>>>>                // ref =3D 0
>>>>>                _handler() // or whatever code...
>>>>>            // *_exit() not called [at least there is no trace_printk()=
 output]...
>>>>>            // Regardless of trace output, the ref is left at 0
>>>>>    dev_access_disable() // ref -=3D 1 =3D=3D> -1 =3D=3D> does not enab=
le protection
>>>>>    (Bad stuff is bound to happen now...)
>>>=20
>>> Well, if any exception which calls idtentry_enter() would return without=

>>> going through idtentry_exit() then lots of bad stuff would happen even
>>> without your patches.
>>>=20
>>>> Also is there any chance that the process could be getting scheduled an=
d that
>>>> is causing an issue?
>>>=20
>>> Only from #PF, but after the fault has been resolved and the tasks is
>>> scheduled in again then the task returns through idtentry_exit() to the
>>> place where it took the fault. That's not guaranteed to be on the same
>>> CPU. If schedule is not aware of the fact that the exception turned off
>>> stuff then you surely get into trouble. So you really want to store it
>>> in the task itself then the context switch code can actually see the
>>> state and act accordingly.
>>=20
>> Actually thats nasty as well as you need a stack of PKRS values to
>> handle nested exceptions. But it might be still the most reasonable
>> thing to do. 7 PKRS values plus an index should be really sufficient,
>> that's 32bytes total, not that bad.
>=20
> I've thought about this a bit more and unless I'm wrong I think the
> idtentry_state provides for that because each nested exception has it's ow=
n
> idtentry_state doesn't it?

Only the ones that use idtentry_enter() instead of, say, nmi_enter().

>=20
> Ira
