Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="K2kWQODX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:50:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36897 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:50:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id 130so2545702qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ngAyglUW6GXylRlLf8NoeOB2cXhi0dD+XxTxvWca+JA=;
        b=K2kWQODXWLuYx5R27QDJ/1YBbK+LdcmowXrNptveX2l/RRJTGBA5u7KLRWjt17zNXL
         /QjyFOThqQfqtasPrjkGjpOg71A6aJ9TVgjPOuyIbe4YxmEYBDyCkAbgsWMFHYy/PFG6
         kHsPRqtqm76RasWplqB7SvdyTmfaOrplCG73DT+tBEvWJvM0okK2oKDC7hbOzw+RGwz1
         7Ob46NxTz3aro3/g6NTAzBXLMNMS0FSpQ8U7ipa+jo2EJC9ntFdPF0Tt3wqS1HDYF5F5
         WA21Oza8jeY/pL4MaqgX6NI44qhss4GPx4+Xv0oUhqj8UTCW7mR8GKbqAWMwJwFhhKe7
         tisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ngAyglUW6GXylRlLf8NoeOB2cXhi0dD+XxTxvWca+JA=;
        b=GjpOjfgeFseLaPmDe/acCKjkuisH6OiUKnijBo1OS6gGTBLOlc8IyWUXKktiCiqUsu
         1izq/hZeefWWL/W0y/gzOSHgEjv1LBnk11GIpxB2rpkrdDi/4f6XACZvkdQ9s+cOSvlb
         AvQA4AN5AnHCmJLssW3AIAPER3V8MnjJ+BxmXHWMHFCX9Qdy79A8ZFlth+LN17qLewQ7
         2QlF62K+YnaiwzC7hKAqAeY0JWvyT6HAYclPZcXuwacqIDhxsCYITE+w0OnMJdW3EGAQ
         3f9f/GRUBNbZ4/4SyY/zC99Hd1PCA1LnWV/U0iXsCD9JvJI9lCnTAjrvx5XNfMUj8of3
         MPoQ==
X-Gm-Message-State: AGi0PuaIuoqDdgymNavMgNVEzRcbkyxMYeir0Bc5pSaXxgyJx+0yCVUR
        xeDKT5bLVILq4aNB9Vn/eYVA3GnPt/U0fg==
X-Google-Smtp-Source: APiQypLFOkY2MclQ2lu0q6f6QboQgyR0N7WDHwSzvVZfEn5RgSTVV9jckZIxYvSmg1o+CRpa/sHTMw==
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr4535161qke.294.1586533812612;
        Fri, 10 Apr 2020 08:50:12 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 206sm1897059qkn.36.2020.04.10.08.50.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:50:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: KCSAN + KVM = host reset
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
Date:   Fri, 10 Apr 2020 11:50:10 -0400
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B798749E-F2F0-4A14-AFE3-F386AB632AEB@lca.pw>
References: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
 <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw>
 <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 7:35 AM, Marco Elver <elver@google.com> wrote:
>=20
> On Fri, 10 Apr 2020 at 13:25, Qian Cai <cai@lca.pw> wrote:
>>=20
>>=20
>>=20
>>> On Apr 10, 2020, at 5:47 AM, Marco Elver <elver@google.com> wrote:
>>>=20
>>> That would contradict what you said about it working if KCSAN is
>>> "off". What kernel are you attempting to use in the VM?
>=20
> Ah, sorry this was a typo,
>  s/working if KCSAN/not working if KCSAN/
>=20
>> Well, I said set KCSAN debugfs to =E2=80=9Coff=E2=80=9D did not help, =
i.e., it will reset the host running kvm.sh. It is the vanilla ubuntu =
18.04 kernel in VM.
>>=20
>> github.com/cailca/linux-mm/blob/master/kvm.sh
>=20
> So, if you say that CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn works, that
> contradicts it not working when KCSAN is "off". Because if KCSAN is
> off, it never sets up any watchpoints, and whether or not
> KCSAN_INTERRUPT_WATCHER is selected or not shouldn't matter. Does that
> make more sense?
>=20
> But from what you say, it's not the type of kernel run in VM. I just
> thought there may be some strange interaction if you also run a KCSAN
> kernel inside the VM.
>=20
> Since I have no way to help debug right now, if you say that
> "KCSAN_SANITIZE_svm.o :=3D n" works, I'd suggest that you just send a
> patch for that. If you think that's not adequate, it may be possible
> to try and find the offending function(s) in that file and add
> __no_kcsan to the  function(s) that cause problems.

This works,

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3278,7 +3278,7 @@ static void svm_cancel_injection(struct kvm_vcpu =
*vcpu)
=20
 bool __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
=20
-static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
 {
        struct vcpu_svm *svm =3D to_svm(vcpu);

Does anyone has any idea why svm_vcpu_run() would be a problem for =
KCSAN_INTERRUPT_WATCHER=3Dy?

I can only see there are a bunch of assembly code in __svm_vcpu_run() =
that might be related?=
