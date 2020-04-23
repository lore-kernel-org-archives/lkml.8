Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30541C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DB12098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0n8gvqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgDWPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:10:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728551AbgDWPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587654650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IQojHe4J/6k3qfeiWdzY68BgNr3d6Bt4ImpMFFIpDM=;
        b=g0n8gvqByRemSBNfL6MVXTSX6Yw7iUXQlgGd0QuTFAD11wAj3IxeJ9xn1OfAX9PYG86J3D
        60UdX+5m03ITp+6vJZ+Aufj4xbuU/pYise8dKOv5HToca9q2+M/vTlXd2jqwJs6I+6VxyW
        hhKFyisIrIzv+TlWrS4U49hlNEE4LaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-3yHZFWMCNTWl8-_Wf4Mnew-1; Thu, 23 Apr 2020 11:10:49 -0400
X-MC-Unique: 3yHZFWMCNTWl8-_Wf4Mnew-1
Received: by mail-wm1-f71.google.com with SMTP id u11so2461792wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6IQojHe4J/6k3qfeiWdzY68BgNr3d6Bt4ImpMFFIpDM=;
        b=gpHEo/Hw0rqXiy+HNiIlI8hndjaZpBFxLjJ6EZHZKYQqzv4mQXmNfiz/j0VIQdzIbP
         7hdA3P7jSHn1IRSTWzGQNauKWM6ofJ6Nvq0IzAg46E2orHAhCLZQeGVZ8ytrn4+cCAuO
         t1sv7O0jxOj/xdDP9gvJkQvWvo+RlU3xSQ+lI8gTaReHNUvofRS9rtIah2tFI/ICSoLJ
         hHgUvgI/2M1V4Rq7wr8lvOpDeSEm6wXwYUAndzEWXmYfoaMmflPFboCmvrgdWEDP54x/
         T/bQn+fx5L9OAh3eFpDKDmP0704yfnfXQgqPd4Ny/LNB2RnMHvCxO7STYaxMuLQ25CBt
         0BqA==
X-Gm-Message-State: AGi0Pubx1basDVpEeBC656YuNX2V7NP46y3T2OVg0uT+ECnJifQ68yoJ
        R3avIHK51Sgq2Vh4S/oTypan4kyduYemOQze2f0JMhubS6aS9/PnBSkm7oCNYBjsRswqkY7P7TH
        yDOLOC+th4XTIlTpwmqZ8GI9s
X-Received: by 2002:a1c:4989:: with SMTP id w131mr4817219wma.137.1587654647739;
        Thu, 23 Apr 2020 08:10:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBRJkol6+EEfdoUivoCv0K3f//jt7ca68U8BmQbf6RxQwuLwAzr8W2Z3WR0idg+KG9HTTMhQ==
X-Received: by 2002:a1c:4989:: with SMTP id w131mr4817197wma.137.1587654647460;
        Thu, 23 Apr 2020 08:10:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id d7sm3994249wrn.78.2020.04.23.08.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:10:46 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86: check_nested_events if there is an
 injectable NMI
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Cathy Avery <cavery@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, wei.huang2@amd.com
References: <20200414201107.22952-1-cavery@redhat.com>
 <20200414201107.22952-3-cavery@redhat.com>
 <20200423144209.GA17824@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae2d4f5d-cb96-f63a-7742-a7f46ad0d1a8@redhat.com>
Date:   Thu, 23 Apr 2020 17:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423144209.GA17824@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 16:42, Sean Christopherson wrote:
> On Tue, Apr 14, 2020 at 04:11:07PM -0400, Cathy Avery wrote:
>> With NMI intercept moved to check_nested_events there is a race
>> condition where vcpu->arch.nmi_pending is set late causing
> How is nmi_pending set late?  The KVM_{G,S}ET_VCPU_EVENTS paths can't set
> it because the current KVM_RUN thread holds the mutex, and the only other
> call to process_nmi() is in the request path of vcpu_enter_guest, which has
> already executed.
> 

I think the actual cause is priority inversion between NMI and
interrupts, because NMI is added last in patch 1.

Paolo

