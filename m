Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C637C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637D421D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hd6yfUDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgATQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:40:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26877 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729080AbgATQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579538412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tvpA9/Y4Qewt6OlrjGLcu0zgEePrnq1IOmYVdg2kZU=;
        b=hd6yfUDq59Gakwzp9BW/2Ps4Za4VA2P8ZxQSFzIuKMk+v9N6BOICrpG0Hg7EX5e1Ccs8hg
        vF0RtuDaAtA1UtEW3lKc2Q2bDasAZQ7DhAyLuwNeGryObubhPsrFAE2EFxA3ZRgcFrYtv8
        SUX/iFdAsNMSr1BT4hbqWOI6M6WJw2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-DjnSTrvzML-wssd3JyD-XA-1; Mon, 20 Jan 2020 11:40:09 -0500
X-MC-Unique: DjnSTrvzML-wssd3JyD-XA-1
Received: by mail-wm1-f72.google.com with SMTP id n17so7376wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8tvpA9/Y4Qewt6OlrjGLcu0zgEePrnq1IOmYVdg2kZU=;
        b=ts4sE2y+/TuXYY1TN0VHQBl4OPDVvKcB6DgF68f1T789quLJQVgGSmEjJQzpNRYdJP
         s26+VtKBZC6sH738vDzswLlym3Gwdhpy1ZeuSCbEJ7mcLPqxH9efdm1adzfp4avVLz5+
         wZ0dw8w5IdfFHEoMSgFNajv5tb8FrNwLCDUGIWM7RdR6/wA15J4gvSwwEByuGD0ZOOlu
         xTM1Iusho9joL5fgQdvYsmMB0jRsf4iZsq/P46ja4KhwlCnqOehi9NEcR6SvZDLosmud
         X4XgIaWtnCCDGYn8h/ZFzFR1FIchDeHVrbtWpIB+s9yqHPRqgoLCfh/KSNo+J+PDYrqc
         hVsQ==
X-Gm-Message-State: APjAAAXno9hqzlBw9z4R55rZ5Wb8X0PIbQukkat8Zqymvf5io1LJUU+8
        sOJiP+7/eGis2xNsJ/4Zl5mMbnNOpricGoEaEP0mEsZspNoDXf+j7958D5j+teU6BimqFHth517
        mpk9oWTwIYKXPKJGdl0Lnoxdp
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr352067wrx.109.1579538408092;
        Mon, 20 Jan 2020 08:40:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiE8pOqmjfGlid2Io78X8iGQvpRLqrU5v2S78XCSmH8UM9vg975NqPeWVl8Fhlar1IIm+pdA==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr352045wrx.109.1579538407773;
        Mon, 20 Jan 2020 08:40:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id e18sm48728888wrr.95.2020.01.20.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 08:40:07 -0800 (PST)
Subject: Re: [RFC] Revert "kvm: nVMX: Restrict VMX capability MSR changes"
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>
References: <20200120151141.227254-1-vkuznets@redhat.com>
 <30525d58-10de-abb4-8dad-228da766ff82@redhat.com>
 <87k15mf5pl.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eeef5ff3-8ca9-4f21-7e48-d6c930985059@redhat.com>
Date:   Mon, 20 Jan 2020 17:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87k15mf5pl.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/20 17:33, Vitaly Kuznetsov wrote:
>> I think this should be fixed in QEMU, by doing KVM_SET_MSRS for feature
>> MSRs way earlier.  I'll do it since I'm currently working on a patch to
>> add a KVM_SET_MSR for the microcode revision.
> Works for me, thanks)
> 
> The bigger issue is that the vCPU setup sequence (like QEMU's
> kvm_arch_put_registers()) effectively becomes an API convention and as
> it gets more complex it would be great to document it for KVM.

Indeed, it's tricky to get right.  Though this is smaller compared to
the issue of the ordering between VCPU events and everything else.

Paolo

