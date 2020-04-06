Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA152C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86EA2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="mlZBK7K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDFUcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:32:06 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54911 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFUcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:32:06 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so361773pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s3PQnqVK/Yp5FB3uyQarAlUfZ38sT1XktoIyfn14ZiM=;
        b=mlZBK7K6tkif4LvKiDSrGiP1TfmDWE0Ch8yTetjbcKPs/ijeFgu8hv8nvJ/0md4ssI
         +a9DZ+gMb+8meffX/p88nTieoYytmRNy2jqN671tmgF9HeQsk8cMndM7JyJKCA6QNt+V
         b/fLkbBC595wMGr/qgN/G+VGcMkpGZSwQAlc8hZgib02pj1cnCaBBSbQM4VBGanNkdcR
         D4ojtK36QSI5XbiMg+nmOTGrvhDuSinSmZLyozBnX+AUli2q3DSUGToOi6n+mGeogVgo
         VMnPQXCwlL7v0cIrvYAtU/wgmUJTAWeYpUbY34JDbJV1y7cLGRHSKhd6DWiDAAVyUWdF
         6TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s3PQnqVK/Yp5FB3uyQarAlUfZ38sT1XktoIyfn14ZiM=;
        b=nljWlSEJConzbG470HXWrsBIzdEHefEDVVbHmsQqQ9STIq59iW1vPQ+T9CTNCrc/YL
         /59bFqRRIX6+Y0FgiME6FQEqvV0+YWvc1AIwE+8NfMfPznFNtf/p4IPbsa5i4a/qIx6J
         zEqs07v5dEA3Ki6dbNfMHLhw+ZyHcaryU4ZuG4oJ2ZLiqn6sXqsSEIVgmJwo4UMr7ZeC
         0U7xSoLL5Vk14TM8g5G1/HywdS0Xc6cTM7WJQc3/QIFDEI/33G1uEMDlt38elormLCY6
         vmDd0/9LgCdx5iUb+Tzw0fjlgk53K8x+FNYD8AcpN6tH6+GYNeW+ATc8bNSEDLI22E1n
         2BRg==
X-Gm-Message-State: AGi0PuZ7UvKdASbBBzvQlGLv/inoe4L8e/TKA/qkzN/KM1vPLvtq8/T/
        CPOPc0FkeSpG370OLspcLs0u7Q==
X-Google-Smtp-Source: APiQypLrft5l6a8yfyKck7ACjfTPE9IytjF/AJo+wymjrE4JINBQSMNS42wvAC5dgzya9mlw54buYw==
X-Received: by 2002:a17:90a:a40b:: with SMTP id y11mr1350538pjp.130.1586205123643;
        Mon, 06 Apr 2020 13:32:03 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:54d3:a29c:f391:9a0d? ([2601:646:c200:1ef2:54d3:a29c:f391:9a0d])
        by smtp.gmail.com with ESMTPSA id y14sm12278847pfp.127.2020.04.06.13.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 13:32:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
Date:   Mon, 6 Apr 2020 13:32:01 -0700
Message-Id: <6875DD55-2408-4216-B32A-9487A4FDEFD8@amacapital.net>
References: <20200406202505.GO2452@worktop.programming.kicks-ass.net>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
In-Reply-To: <20200406202505.GO2452@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 6, 2020, at 1:25 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 06, 2020 at 03:09:51PM -0400, Vivek Goyal wrote:
>>> On Mon, Mar 09, 2020 at 09:22:15PM +0100, Peter Zijlstra wrote:
>>> On Mon, Mar 09, 2020 at 08:05:18PM +0100, Thomas Gleixner wrote:
>>>> Andy Lutomirski <luto@kernel.org> writes:
>>>=20
>>>>> I'm okay with the save/restore dance, I guess.  It's just yet more
>>>>> entry crud to deal with architecture nastiness, except that this
>>>>> nastiness is 100% software and isn't Intel/AMD's fault.
>>>>=20
>>>> And we can do it in C and don't have to fiddle with it in the ASM
>>>> maze.
>>>=20
>>> Right; I'd still love to kill KVM_ASYNC_PF_SEND_ALWAYS though, even if
>>> we do the save/restore in do_nmi(). That is some wild brain melt. Also,
>>> AFAIK none of the distros are actually shipping a PREEMPT=3Dy kernel
>>> anyway, so killing it shouldn't matter much.
>>=20
>> It will be nice if we can retain KVM_ASYNC_PF_SEND_ALWAYS. I have another=

>> use case outside CONFIG_PREEMPT.
>>=20
>> I am trying to extend async pf interface to also report page fault errors=

>> to the guest.
>=20
> Then please start over and design a sane ParaVirt Fault interface. The
> current one is utter crap.

Agreed. Don=E2=80=99t extend the current mechanism. Replace it.

I would be happy to review a replacement. I=E2=80=99m not really excited to r=
eview an extension of the current mess.  The current thing is barely, if at a=
ll, correct.=
