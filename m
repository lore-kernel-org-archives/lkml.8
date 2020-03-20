Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6021AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E762051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtbQTnt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgCTKdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:33:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25000 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbgCTKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584700413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+O0TKG7RluopsB5+yUxCz0n+VTKJBvttmlO7TI6cs8=;
        b=DtbQTnt4IsPB4QlHKgfFf6Le7IYNGGWRnkk5iRzhRpPlNNroeYH8DpiBIRR94yoLmTBn4v
        uWZ4kZ4bAWifmMO658DnKq93YQeuPbYRPfwHkAv1tERtPV1HYGdgCtRhjc6qcSGuUW/lq3
        K7ebwtQu9Wfm99Dr8OZfLD/ioFZK97E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-5bzP6Y-IMg-H2SKmG-VkOA-1; Fri, 20 Mar 2020 06:33:27 -0400
X-MC-Unique: 5bzP6Y-IMg-H2SKmG-VkOA-1
Received: by mail-wm1-f70.google.com with SMTP id g26so2202727wmk.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 03:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v+O0TKG7RluopsB5+yUxCz0n+VTKJBvttmlO7TI6cs8=;
        b=LOkFKfC2tEgJxql0EG7GH9R8Unm+uyjQ513TQTPk0msfz4PLzx8b5QZKELdrL3JIqW
         Vep3pzXtl2xfbVDXPLIXBVXfxjHVV7dXBB2940Gi/6fp8Ly6CuLnLoxxYrlCRRvHa1Kj
         5VIz+Llrbf1RUmEuIRmeLofUworTvhONeXuU4DKjl0RHwd6VsCU+VvrWEqpDMAduaQjK
         qX+x2S3MmPp658KkKrKKAB1Fzyl5rG+ew0MdPcO1AJ7v4LXS6DUy/rYHpsRCrvSEpV4d
         MdFC/Pqi9rHNznxpqJNKewN4T0EQCW8lafXdLhT4Sy/arqvy5t/FoAtIOnkY33dyzUye
         CFPQ==
X-Gm-Message-State: ANhLgQ3DDuKJ+e/O3GZpDk9AGGsYciWO325ftxxfJIDRDI/pK5+wSJJ9
        /hmYRook1p9gE7MyLSAVOKq3OsWblqkqB2dfunnBkuuPz4c71m6W5lexvYwHH4w1D1oZHcbiq6R
        DeMvDvPltZN8M4e/g/AiE0ap+
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr9754279wmj.156.1584700406057;
        Fri, 20 Mar 2020 03:33:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt/QEmQN3xweTWPa2FLy03BaS+TOE+v1glMmu3TqcsJub4MqPOEiz7Nyx/IluChnKlphGwSIQ==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr9754249wmj.156.1584700405771;
        Fri, 20 Mar 2020 03:33:25 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id 61sm8303356wrn.82.2020.03.20.03.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 03:33:25 -0700 (PDT)
Subject: Re: WARNING in vcpu_enter_guest
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     syzbot <syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org
References: <000000000000f965b8059877e5e6@google.com>
 <00000000000081861f05a132b9cd@google.com>
 <20200319144952.GB11305@linux.intel.com>
 <20be9560-fce7-1495-3a83-e2b56dbc2389@redhat.com>
 <20200319173549.GC11305@linux.intel.com>
 <20200319173927.GD11305@linux.intel.com>
 <cd32ee6d-f30d-b221-8126-cf995ffca52e@redhat.com>
 <87k13f516q.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6686bde5-c1e8-5be5-f27a-61403c419a91@redhat.com>
Date:   Fri, 20 Mar 2020 11:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k13f516q.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 01:18, Thomas Gleixner wrote:
>> No, it is possible to do that depending on the clock setup on the live
>> migration source.  You could cause the warning anyway by setting the
>> clock to a very high (signed) value so that kernel_ns + kvmclock_offset
>> overflows.
>
> If that overflow happens, then the original and the new host have an
> uptime difference in the range of >200 hundreds of years. Very realistic
> scenario...
> 
> Of course this can happen if you feed crap into the interface, but do
> you really think that forwarding all crap to a guest is the right thing
> to do?
> 
> As we all know the hypervisor orchestration stuff is perfect and would
> never feed crap into the kernel which happily proliferates that crap to
> the guest...

But the point is, is there a sensible way to detect it?  Only allowing
>= -2^62 and < 2^62 or something like that is an ad hoc fix for a
warning that probably will never trigger outside fuzzing.  I would
expect that passing the wrong sign is a more likely mistake than being
off by 2^63.

This data is available everywhere between strace, kernel tracepoints and
QEMU tracepoints or guest checkpoint (live migration) data.  I just
don't see much advantage in keeping the warning.

Paolo

