Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E725C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D684E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwQrjz6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCIIkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:40:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbgCIIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583743211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJSpyr7luHC5gmOgZtB7q0gqS7e3sos2ucW8TuRhnqw=;
        b=HwQrjz6HAu2zSvjlKV5R6Kq5xuMd2Ud/n6jfyDaz0gPXvmwfSsZ3Z7IjHqCZ6YMaXXp96s
        2kQOK1X64vODLC1xT2B/SO/EvGY6MeZkRXGLYBxs/z5Sh1eKf+QSqPdDfwciZGV4IMOlr2
        LuaNm2gOCtCmVWGKXA9B2wvecsaeHlM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-umNDM4B2OBSAMcgbqn2LlQ-1; Mon, 09 Mar 2020 04:40:10 -0400
X-MC-Unique: umNDM4B2OBSAMcgbqn2LlQ-1
Received: by mail-wm1-f69.google.com with SMTP id t8so1827577wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJSpyr7luHC5gmOgZtB7q0gqS7e3sos2ucW8TuRhnqw=;
        b=mMbQZCAQ6P5ZiTd5nqqxFEMYA4vitCmEDVQ+r3vJvtgxyVnh57Ax2/SogQhMv+bILd
         JtjBIUVQIbNe6V/nTOUt6NInu1nW27669ysYMdlC1QFZpvnOyd3JikqfPEBZEL8cMPdQ
         qRQEqIowweSDzdT+SQ3c0CoBhh7rwyNntLFLnvIZ4hvjNZiGVMOjUdQS/PT5GoK+hssL
         AQIfjvGET+8P8r8xiSCa2JSiijMF5kz+SqMmJGA+V6guj9/Kf5uBNqwuqtpsXydNmaZD
         L3IxSQvDoDaOh2NrOXNf7rWtWf/vIrf+I8UQpj3cZyqcNdw6/TMI1Db0fQ3PrxvTQLp7
         WnSg==
X-Gm-Message-State: ANhLgQ1cEY8X8n8zB2hUeMpJdzebx+yDDfkSwJzrPyWX538E3k8x/Z5y
        1FuczODXwPBe2/VeYYgeKNWhu25UgzJC2FnDPoc+XZOSK5IDueMUQ1B+MSe2dNCHzE7wm4BwkMo
        v6Neo33hN/Ubg1RXdO3Mot8Eb
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr15876277wme.172.1583743209082;
        Mon, 09 Mar 2020 01:40:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsXM2dy9yL7nesp7zcPCTzXD1JQsxvHew299Rlk430F8GQGQJUvV3VoV5en67YytjGcWtt50A==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr15876245wme.172.1583743208779;
        Mon, 09 Mar 2020 01:40:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8? ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
        by smtp.gmail.com with ESMTPSA id k2sm29528088wrn.57.2020.03.09.01.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 01:40:08 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <ed71d0967113a35f670a9625a058b8e6e0b2f104.1583547991.git.luto@kernel.org>
 <CALCETrVmsF9JSMLSd44-3GGWEz6siJQxudeaYiVnvv__YDT1BQ@mail.gmail.com>
 <87ftek9ngq.fsf@nanos.tec.linutronix.de>
 <CALCETrVsc-t=tDRPbCg5dWHDY0NFv2zjz12ahD-vnGPn8T+RXA@mail.gmail.com>
 <87a74s9ehb.fsf@nanos.tec.linutronix.de>
 <87wo7v8g4j.fsf@nanos.tec.linutronix.de>
 <877dzu8178.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37440ade-1657-648b-bf72-2b8ca4ac21ce@redhat.com>
Date:   Mon, 9 Mar 2020 09:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877dzu8178.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/20 07:57, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> Andy Lutomirski <luto@kernel.org> writes:
>>>> On Sat, Mar 7, 2020 at 7:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>> If MCE, NMI trigger a real pagefault then the #PF injection needs to
>>>>> clear apf_reason and set the correct CR2. When that #PF returns then the
>>>>> old CR2 and apf_reason need to be restored.
>>>>
>>> The host does not care about the IRET. It solely has to check whether
>>> apf_reason is 0 or not. That way it knows that the guest has read CR2
>>> and apf_reason.
> 
> Some hours or sleep and not staring at this meess later and while
> reading the leaves of my morning tea:
> 
> guest side:
> 
>    nmi()/mce() ...
>    
>         stash_crs();
> 
> +       stash_and_clear_apf_reason();
> 
>         ....
> 
> +       restore_apf_reason();
> 
> 	restore_cr2();
> 
> Too obvious, isn't it?

Yes, this works but Andy was not happy about adding more
save-and-restore to NMIs.  If you do not want to do that, I'm okay with
disabling async page fault support for now.

Storing the page fault reason in memory was not a good idea.  Better
options would be to co-opt the page fault error code (e.g. store the
reason in bits 31:16, mark bits 15:0 with the invalid error code
RSVD=1/P=0), or to use the virtualization exception area.

Paolo

