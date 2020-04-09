Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408DFC2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B1E20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH6LdExS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDIMrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:47:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38532 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726571AbgDIMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586436437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cZpoXND/3gmTzh1oxxwwcgLLTs9FadoYX5XJNUdgHA=;
        b=fH6LdExSrkljXZ2lxX4P8iaK3PU6FsYq++ql/rxBd7QsgDk9AX5Vdo4dtU9E8wcp5/nPp/
        igBheOIqvhY+1ZBSEsEQ7ZTGAPKdK36LlswVAUmRLI/a5WRZfh73WO8oZd3F2ytRAch1I/
        OIFQBgq/79alpDl0y7h3tMFj5HTG24w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-APUMeumUPxaoXylictORig-1; Thu, 09 Apr 2020 08:47:13 -0400
X-MC-Unique: APUMeumUPxaoXylictORig-1
Received: by mail-wr1-f70.google.com with SMTP id j22so3116675wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 05:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9cZpoXND/3gmTzh1oxxwwcgLLTs9FadoYX5XJNUdgHA=;
        b=BmIU5r3488ilQf2EjXzsw3mb+40gq9eAJEdEXpy5sjRa+wcp/4d93jX1bqKfa59Fbc
         Z6tsf5s7CuZ/mIELwx7wyv6UdmrNLR3r6Ww21SazJIm08Bccy1zT+5WrXrEs7b5K6roC
         Eir39/sqEZh6jo0oVUKCjNSMUwx6jfBZt8q5EbjRPUjn/9trpIOP8SYqBhpaQH/CMoAH
         sreaHMJCWb90MVm9fQzpHCJd3HDRHYCyKBEqHHnedUx5kERWomFcHnsB5GngNsR5n9qv
         XmVB0GTHJDhluFU/q++DrlrmIXkaJZ+rFprUj0DVHfL87NLwG05vH2QQdoRRMca+ozl6
         K7eQ==
X-Gm-Message-State: AGi0PuafCvSaUgHILPigJqjvo5AutwgWXPPc4eRKEjae78vwOzN0fT1j
        PS4WPFow20q/jR1goHPBpi+h8+o7XIX0eyLXsfAFOL5JFGo7AjKNNFOmU1Az12/sVTKPPxFLg2y
        kcHhb9nRnfXZSOQ0WGyzwCqz1
X-Received: by 2002:adf:de82:: with SMTP id w2mr11650494wrl.169.1586436432413;
        Thu, 09 Apr 2020 05:47:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfSpr+zznIlqiZ5jTI4LNgxdDVUTFZ2rVYdzR0Z4HJ8TlV+mOfJmxmxC04UJ8VX5gcDOs3wg==
X-Received: by 2002:adf:de82:: with SMTP id w2mr11650477wrl.169.1586436432152;
        Thu, 09 Apr 2020 05:47:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e8a3:73c:c711:b995? ([2001:b07:6468:f312:e8a3:73c:c711:b995])
        by smtp.gmail.com with ESMTPSA id f12sm40384763wrm.94.2020.04.09.05.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 05:47:11 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>
References: <20200407172140.GB64635@redhat.com>
 <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
 <87eeszjbe6.fsf@nanos.tec.linutronix.de>
 <ce81c95f-8674-4012-f307-8f32d0e386c2@redhat.com>
 <874ktukhku.fsf@nanos.tec.linutronix.de>
 <274f3d14-08ac-e5cc-0b23-e6e0274796c8@redhat.com>
 <20200408153413.GA11322@linux.intel.com>
 <ce28e893-2ed0-ea6f-6c36-b08bb0d814f2@redhat.com>
 <87d08hc0vz.fsf@nanos.tec.linutronix.de>
 <CALCETrWG2Y4SPmVkugqgjZcMfpQiq=YgsYBmWBm1hj_qx3JNVQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04aca08a-cfce-b4db-559a-23aee0a0b7aa@redhat.com>
Date:   Thu, 9 Apr 2020 14:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWG2Y4SPmVkugqgjZcMfpQiq=YgsYBmWBm1hj_qx3JNVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20 06:50, Andy Lutomirski wrote:
> The small
> (or maybe small) one is that any fancy protocol where the guest
> returns from an exception by doing, logically:
> 
> Hey I'm done;  /* MOV somewhere, hypercall, MOV to CR4, whatever */
> IRET;
> 
> is fundamentally racy.  After we say we're done and before IRET, we
> can be recursively reentered.  Hi, NMI!

That's possible in theory.  In practice there would be only two levels
of nesting, one for the original page being loaded and one for the tail
of the #VE handler.  The nested #VE would see IF=0, resolve the EPT
violation synchronously and both handlers would finish.  For the tail
page to be swapped out again, leading to more nesting, the host's LRU
must be seriously messed up.

With IST it would be much messier, and I haven't quite understood why
you believe the #VE handler should have an IST.

Anyhow, apart from the above "small" issue, we have these separate parts:

1) deliver page-ready notifications via interrupt

2) page-in hypercall + deliver page-not-found notifications via #VE

3) propagation of host-side SIGBUS

all of which have both a host and a guest part, and all of which make
(more or less) sense independent of the other.

Paolo

