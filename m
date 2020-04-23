Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C872C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3818920704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC2rkmig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgDWPni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:43:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29417 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729145AbgDWPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587656616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaSfDwhy0WkP2x8l/xKsfypjnmxH9a+M8bRe06h89X0=;
        b=EC2rkmig9ikuTPUj/5SB5MusuT0efqVfBj3OOSkzoJ7aaJaCk3+IrK6WiRpIhYqNA0Zjw8
        ShKkWp3I1fhonlrLVslKtINkFl9Lk6qvJGb7saUqnV95dseH6lUBlsLzICjD9goEOBLarC
        emF3FUI57J88as4NtJc9UvYDQBEFOrQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-1nRq_44rNkKVY9bIQkaeFw-1; Thu, 23 Apr 2020 11:43:34 -0400
X-MC-Unique: 1nRq_44rNkKVY9bIQkaeFw-1
Received: by mail-wm1-f72.google.com with SMTP id s12so1932324wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yaSfDwhy0WkP2x8l/xKsfypjnmxH9a+M8bRe06h89X0=;
        b=g9OZVX343kMHMglSgZ4WPWAVAbcchpQpI+6lfZ2dVbm63oDPdcyFZyzyWYkQci6GP1
         fzCP5nFhTSvH/03qVtVJh75DyeilEVmmQcuCkAASR3qgJZ4st0X/8sMOQIvxCJE49mcG
         OXhMSN2kit8wFgs4zTcS9F0tLH7GrkqMku8zLuLajm0eO+jSJzqHNaQehKI2xRR+0CUK
         7oMfee1IC4dch/5U65fcmq4tmqqjfI89no8O1bKAiOc62Zzeys6gp/7BhXuEOgCIkTRy
         Ujx/R31P/rcPxi37TrG2PePipBzTAhdwSHxqOZVbj6S520FsBQQff7FbLj/cxXW1ziqt
         FGcw==
X-Gm-Message-State: AGi0Pub+oEqYN+HYhoq1Gci/u82+Dwu0RjtoTa6OVgAiGZiKyJYOWBpc
        1We+JUGWSn5fKo+i1S7QTRxQjOvDaRPTVcimSvxMtJBS5AfIFcv1WoVNrpjh/g/g0Se8ioE0BWP
        QoUQFyuTnd81SqKfpnv6ZbClK
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr6090862wrn.56.1587656613726;
        Thu, 23 Apr 2020 08:43:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypLi2aeT+iCRoZnl2LY6pfEQsNNFK9xdNRsShgC3cQDvBg7qhvEgLDszJu8Ia3sgKnMcdHdlxA==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr6090832wrn.56.1587656613448;
        Thu, 23 Apr 2020 08:43:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id 17sm4119170wmo.2.2020.04.23.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:43:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: check_nested_events if there is an
 injectable NMI
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, vkuznets@redhat.com, wei.huang2@amd.com
References: <20200414201107.22952-1-cavery@redhat.com>
 <20200414201107.22952-3-cavery@redhat.com>
 <20200423144209.GA17824@linux.intel.com>
 <ae2d4f5d-cb96-f63a-7742-a7f46ad0d1a8@redhat.com>
 <20200423153531.GC17824@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <793bf6ba-a21a-02cc-c80a-05a7af37b5b6@redhat.com>
Date:   Thu, 23 Apr 2020 17:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423153531.GC17824@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 17:35, Sean Christopherson wrote:
> On Thu, Apr 23, 2020 at 05:10:45PM +0200, Paolo Bonzini wrote:
>> On 23/04/20 16:42, Sean Christopherson wrote:
>>> On Tue, Apr 14, 2020 at 04:11:07PM -0400, Cathy Avery wrote:
>>>> With NMI intercept moved to check_nested_events there is a race
>>>> condition where vcpu->arch.nmi_pending is set late causing
>>> How is nmi_pending set late?  The KVM_{G,S}ET_VCPU_EVENTS paths can't set
>>> it because the current KVM_RUN thread holds the mutex, and the only other
>>> call to process_nmi() is in the request path of vcpu_enter_guest, which has
>>> already executed.
>>>
>> I think the actual cause is priority inversion between NMI and
>> interrupts, because NMI is added last in patch 1.
> Ah, that makes more sense.  I stared/glared at this exact code for a long
> while and came to the conclusion that the "late" behavior was exclusive to
> interrupts, would have been a shame if all that glaring was for naught.
> 

Ah no, it's a bug in Cathy's patch and it's a weird one.

The problem is that on AMD you exit guest mode with the NMI latched and
GIF=0.  So check_nested_events should enable the NMI window in addition
to causing a vmexit.

So why does it work?  Because on AMD we don't have (yet)
nested_run_pending, so we just check if we already have a vmexit
scheduled and if so return -EBUSY.  The second call causes
inject_pending_event to return -EBUSY and thus go through KVM_REQ_EVENT
again, which enables the NMI window.

Paolo

