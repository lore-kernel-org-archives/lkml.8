Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD64C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C5E21D7F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBPoT5am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDIKNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:13:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:13:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id n13so3341349pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ynCLdXpG84c0FE+/5wf/U/eBy3GytSF4CZpZ1T22Cf8=;
        b=jBPoT5amth9HgrQf+FQdjhKLXAp03ruY0tki/CRjYxyBOLw/qyvHdJNgFd+MqDzucu
         04T/6iEjpgyvsK0+0iEPWPsv1bxapUsUrIzQPWhATJu0yvXxgZZ9VFBWi5/u7Qgfjd+I
         wphZuUxKl8PauGqwmywD26rQEQbcF8BfZf7IReu6jMl76LOS8Sx13ivU756wiLZ7XezL
         sJTBOKjrcEqZxeHmnAOZ47jG/F8+Kg7lBFDqS8J4VAPXta0kUJfKVsLOQq3W8we6B/HN
         9TjBhpVw3PQQFkr6gpEMMUM2YYSRBnquyDuxULhvc+TqhdR6ZBAgUhsQQalzv+jt2YLi
         jvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ynCLdXpG84c0FE+/5wf/U/eBy3GytSF4CZpZ1T22Cf8=;
        b=gGZ4Y1E7pTCjA4QNWWBL70ZYyuLXTf+egqZkgf4z1QaisnJltpGU+wkokY53dUo+tb
         vCR9fnGQUeQ70rZiOG51TTCfr3tQP/MahTeTnOQ+fhtbpbQ+OnTeKsCCbxeHHUQaZ/3d
         ep33ZopkHXfXFpd3wvmEWq0vg3r2JeZQTkqnd69Tw7oc4l2LKstUt4+Cy9HQIyaUa6QL
         QhZYeR1a7IQFJvld9aQdAR+BL8XXPNBh7EpwnDz06rWP5fwbP2fq3VcpEyR7XNAAoFQd
         UN+9/v1RAp58Hn7ZsSh4vsZ4hA7Zy0tJJm6sfus0ci42KhcUa+YFiQjOlYKfIiKYdnCN
         s0rw==
X-Gm-Message-State: AGi0PuYmas8gRbrIP0KonCmTEbX3rWoA4hgAVhDZILeF7vnLBhGKX/a0
        uWxGlv+Sm23YNxWKv0kzHhk=
X-Google-Smtp-Source: APiQypJrpOOf0zEAuL1BlNmfQhn4v8Rw8KqK5L2MSz+3UW+lxIu9FVX26Yj8SEYeGXMhDgZqLaKMwQ==
X-Received: by 2002:aa7:96f8:: with SMTP id i24mr12398415pfq.321.1586427214602;
        Thu, 09 Apr 2020 03:13:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4700:9b2:b5b9:a7a3:5d7d:5415? ([2601:647:4700:9b2:b5b9:a7a3:5d7d:5415])
        by smtp.gmail.com with ESMTPSA id z6sm17509552pgg.39.2020.04.09.03.13.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 03:13:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20200409085632.GB20713@hirez.programming.kicks-ass.net>
Date:   Thu, 9 Apr 2020 03:13:30 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, thellstrom@vmware.com,
        tony.luck@intel.com, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A25271A-71F7-4EA1-9D1C-23B53E35C281@gmail.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
 <20200408154602.GA24869@infradead.org>
 <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com>
 <20200409085632.GB20713@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 9, 2020, at 1:56 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Apr 08, 2020 at 06:15:48PM +0200, Paolo Bonzini wrote:
>> On 08/04/20 17:46, Christoph Hellwig wrote:
>=20
>>> Scanning all modules seems safer.  While we're at it - can be move =
the
>>> kvm bits using VMX to be always in the core kernel and just forbid
>>> modules from using those instructions entirely?
>>=20
>> I suppose we could use PVOPS-style patching for the more
>> performance-critical cases, but VMREAD/VMWRITE does not seem like a
>> particularly bad thing to allow modules and VMLAUNCH/VMRESUME have =
very
>> peculiar calling conventions around them.
>>=20
>> However, I wouldn't mind it if VMCLEAR/VMPTRLD and the associated =
kdump
>> cleanup code were moved to core kernel code.
>=20
> Speaking with my virt ignorance hat on, how impossible is it to =
provide
> generic/useful VMLAUNCH/VMRESUME wrappers?
>=20
> Because a lot of what happens around VMEXIT/VMENTER is very much like
> the userspace entry crud, as per that series from Thomas that fixes =
all
> that. And surely we don't need various broken copies of that in all =
the
> out-of-tree hypervisors.
>=20
> Also, I suppose if you have this, we no longer need to excempt CR2.

It depends on what you mean by =E2=80=9CVMLAUNCH/VMRESUME=E2=80=9D. If =
you only consider the
instructions themselves, as Sean did in vmx_vmenter() and vmx_vmexit(),
there is no problem. Even if you consider saving the general purpose
registers as done in __vmx_vcpu_run() - that=E2=80=99s relatively easy.

I think that anything that is greater than that, for instance
vmx_vcpu_run(), would require more thought and effort. KVM =
data-structures,
specifically kvm_vcpu and friends, would need to be broken into general =
and
KVM specific structures. I am really not sure that the end result would =
be
much better than using KVM user-space interfaces.

I can ask someone from the VMware hypervisor developers to provide =
VMware
point-of-view, but it would help to know when do you plan to make such a
change take, and whether there would be some transition stage. Adapting =
a
hypervisor to use different low-level interfaces would require quite =
some
development & testing effort.

