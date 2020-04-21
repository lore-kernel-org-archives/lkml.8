Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD81C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A3C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbFC4S4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgDUJpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:45:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725920AbgDUJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587462301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vn871PQoRr8hKR73ojEvQDx4nU8OlY1HT3TpH6BJBpc=;
        b=YbFC4S4tMKyy+zCpb//seS8+jOYffmhNSSKp0JDvd1Hw0RS01HKVKIzc0toaNGCtQs1Xm2
        GYxanjjC3U3jI28dgkJuGxwq92vxW3GREPirttyOzc7Wdrv0gmXkpfCM9wXnr+bIRNFhdB
        py6MyJ60Hzs5BSr+ngyA1gMQH9DP2Qo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249--oc70iImMoeGtJe4C9Wbmg-1; Tue, 21 Apr 2020 05:45:00 -0400
X-MC-Unique: -oc70iImMoeGtJe4C9Wbmg-1
Received: by mail-wr1-f69.google.com with SMTP id i10so7221258wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vn871PQoRr8hKR73ojEvQDx4nU8OlY1HT3TpH6BJBpc=;
        b=dvcGR1YT+7luXmJDiIqWcgFBUjrOmXWKEks0GKIXWN6QJa4KzPkiFdbVJuzTEKVl1I
         YE7/MbvQkjZ14LhwtH6KHVizHgU/nahCt21559DzA/3UF0LckMuz79OyIqQXcLYSeXcz
         uXG1SXiu2V16l+jSy1KDU4b5PDHBHB11xwBlkop9vWS8u0DdRSrqTkqVdeCsUTqCN/R0
         YafWaPMrEnPM9BTVT8q93m/vvlAvilIhvGY9xEX65UjGiLL0N8FsMJp336G1qi4z1mgg
         BwQMxfD6j5pjy2MaSdCOF6gUu0O5CYTRJ4yfSaZR2bk2NfsVv7pcKSDqg8e45kClNQlM
         VaNQ==
X-Gm-Message-State: AGi0PubBP/98gyF57RQdqUf4h7imRPOFg9FBFewEeXQjT2bLd4+EHTGh
        1Q6TbQDakgLfKmlOSKWg3bLFQCYtFlfCttoyYIAzB4aNm/HxyiYgMDlZ4svlBCVcJhi7siGOHMw
        bJs2ndHqoaqNMVCNxTi4/zgo4
X-Received: by 2002:adf:e982:: with SMTP id h2mr22309079wrm.425.1587462299213;
        Tue, 21 Apr 2020 02:44:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLbdpxyM62zaDI9d+6FTcqhJenduGXb99s5sXM8ly8KhMH8Zk/YVGvLVp9YOKq9Pttf2tCjnw==
X-Received: by 2002:adf:e982:: with SMTP id h2mr22309050wrm.425.1587462299019;
        Tue, 21 Apr 2020 02:44:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id a7sm2684985wmj.12.2020.04.21.02.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 02:44:58 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        kvm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        peterz@infradead.org, torvalds@linux-foundation.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, linux-mips@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>, joel@joelfernandes.org,
        will@kernel.org, kvmarm@lists.cs.columbia.edu
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
 <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
 <f7cc83fe-3e91-0057-9af2-26c201456689@redhat.com>
 <20200420215014.sarodevmhphnkkn7@linux-p48b>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02e1b00d-a8ea-a947-bbe6-0b1380aa7ec4@redhat.com>
Date:   Tue, 21 Apr 2020 11:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420215014.sarodevmhphnkkn7@linux-p48b>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/20 23:50, Davidlohr Bueso wrote:
> On Mon, 20 Apr 2020, Paolo Bonzini wrote:
> 
>> On 20/04/20 22:56, Davidlohr Bueso wrote:
>>> On Mon, 20 Apr 2020, Marc Zyngier wrote:
>>>
>>>> This looks like a change in the semantics of the tracepoint. Before
>>>> this
>>>> change, 'waited' would have been true if the vcpu waited at all. Here,
>>>> you'd
>>>> have false if it has been interrupted by a signal, even if the vcpu
>>>> has waited
>>>> for a period of time.
>>>
>>> Hmm but sleeps are now uninterruptible as we're using TASK_IDLE.
>>
>> Hold on, does that mean that you can't anymore send a signal in order to
>> kick a thread out of KVM_RUN?  Or am I just misunderstanding?
> 
> Considering that the return value of the interruptible wait is not
> checked, I would not think this breaks KVM_RUN.

What return value?  kvm_vcpu_check_block checks signal_pending, so you
could have a case where the signal is injected but you're not woken up.

Admittedly I am not familiar with how TASK_* work under the hood, but it
does seem to be like that.

Paolo

