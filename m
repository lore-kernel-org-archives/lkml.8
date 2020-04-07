Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65946C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3588F20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdhJMCgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDGVWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:22:17 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34450 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:22:16 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so1477598pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hVx3sh2GK2wusgv8a/PlfL3asnMbGqdITsqZ+CSRnPY=;
        b=tdhJMCgw+f1ilVFD0pIN0Jty0JGGM7Mp3sQjJCFKR+OyvrK1L6HYmZ+ih5ffJQcyxt
         zGcZQOp9qtTlpjizF8VictViF8wXZgZrc7EZK7I/R4L1O1DZWcDgBoMuTPi3yew8ZxE6
         IRwzXJ/kD6IkbQUAcKkDvLe5kyGSf2BSBzCfoQjs3k+F33uZD5zT7xuxDiFXXVLo7qVP
         NPUfzucyy6fAm71/o6cfyAocruYYW2R7TMnLCa/BhFemyUBLKf4gOnfiiJWpVATD0Isk
         TNNq/66qtH5sZ0Xb03zMTfnWx0AYq3KjJZMuDTARSOKL2wMZxVpGbR/i3Zvr5JMxtLno
         9fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hVx3sh2GK2wusgv8a/PlfL3asnMbGqdITsqZ+CSRnPY=;
        b=cok3xMCjpKAH3CAH+M9TKaTbztm6fZfkMXc7SY9Y9YPT+bMPXA1taq9noHETN8aEk7
         944Z/JiYm8m4SlNjAWo/ErVowk3UIXD0vo5SjRjVhmUcIZmsfdoUOWvZWkp22QhGJR0h
         Qksv6Mx43AO3ZUCNk4Kuhznj4R8y4bZSGMZJtn8cduw8SCM4piksLTvQaHg0KtUbo+t8
         yVGacIcdotscf59S5Hyo1GnzUlPXjNxIc9GZXukFRYhnrEPtS6Gje+/+zSMBJSwx5ouB
         nS8nvZJ/KSSv7lLI9d/2B0syFbZDr41I1YKLv2uFB/yBm4My9i7bhQs3I4FdIuu5ZRrj
         M9lg==
X-Gm-Message-State: AGi0PuaVV4qhitlcmJTa3BdWgsqIoilvb1WzPWxV1IsQAr9jqjP6G8Sd
        OQgYUav4LuuSIBs0bf/HYzI=
X-Google-Smtp-Source: APiQypItmFLeJGZErDlb+O19bXCcXb28V1iDpjZ20hApaRjGi3wSeEHDFLRTq766bNdBZ5CvK6A7/A==
X-Received: by 2002:a17:90a:8a08:: with SMTP id w8mr1423402pjn.119.1586294535352;
        Tue, 07 Apr 2020 14:22:15 -0700 (PDT)
Received: from [10.0.1.60] (c-24-4-128-201.hsd1.ca.comcast.net. [24.4.128.201])
        by smtp.gmail.com with ESMTPSA id d5sm14773871pfa.59.2020.04.07.14.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 14:22:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20200407205042.GT2452@worktop.programming.kicks-ass.net>
Date:   Tue, 7 Apr 2020 14:22:11 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 7, 2020, at 1:50 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Apr 07, 2020 at 01:27:45PM -0700, Nadav Amit wrote:
>>> On Apr 7, 2020, at 12:38 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Tue, Apr 07, 2020 at 11:55:21AM -0700, Nadav Amit wrote:
>>>>> On Apr 7, 2020, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>>>=20
>>>>> Since we now have infrastructure to analyze module text, disallow
>>>>> modules that write to CRn and DRn registers.
>>>>=20
>>>> Assuming the kernel is built without CONFIG_PARAVIRT, what is the =
right way
>>>> for out-of-tree modules to write to CRs? Let=E2=80=99s say CR2?
>>>=20
>>> Most of them there is no real justification for ever writing to. CR2 =
I
>>> suppose we can have an exception for given a sane rationale for why
>>> you'd need to rewrite the fault address.
>>=20
>> For the same reason that KVM writes to CR2 - to restore CR2 before =
entering
>> a guest, since CR2 not architecturally loaded from the VMCS. I =
suspect there
>> are additional use-cases which are not covered by the kernel =
interfaces.
>=20
> So I'm not much of a virt guy (clearly), and *groan*, that's horrible.
> I'll go make an exception for CR2.

Clearly you are not a virt guy if you think that this is the horrible =
part
in x86 virtualization ;-)

Anyhow, I do not think it is the only use-case which is not covered by =
your
patches (even considering CRs/DRs alone). For example, there is no =
kernel
function to turn on CR4.VMXE, which is required to run hypervisors on =
x86.

I think a thorough analysis of existing software is needed to figure out
which use-cases are valid, and to exclude them during module scanning or =
to
provide alternative kernel interfaces to enable them. This may require a
transition phase in which module scanning would only issue warnings and
would not prevent the module from being loaded.

