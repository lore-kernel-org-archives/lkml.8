Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD091C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9528C2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKGNSNHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDWJlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:41:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgDWJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587634877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azl4EOKrk5ieu/X3rC1ejOH/OCp4GqTP+vS6TG0Ikm0=;
        b=EKGNSNHzdn910QtysBG+jUTJj05EHFgXatnTcLIXVUkIejJtchvoxUv92jGSUH6PPVfh+W
        ifSrncinOyDXQcf6af6evlaUIPmCedIMrq8rwZQJY4JI+/XMCJu8p103Dh1Fi0cCe41lkb
        rJeO48qJ8zx51IDuOQ8WA4dlsoa8jFk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-F539PVjpMOO15hY5ToiJjQ-1; Thu, 23 Apr 2020 05:41:15 -0400
X-MC-Unique: F539PVjpMOO15hY5ToiJjQ-1
Received: by mail-wm1-f72.google.com with SMTP id l21so1858396wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azl4EOKrk5ieu/X3rC1ejOH/OCp4GqTP+vS6TG0Ikm0=;
        b=btPp/ApB2f+ipIPto+bkLFtIziPbN+uDDXaThmFLWOCeFFD54WsolVDqdHmU6+BEbc
         m5WlkZySanAWpEafJ3eoDWoagnzW4YAeT/UwKNqDj0oQtrJXlMc13v0XnFpLOH+hkY2m
         Y4T7gK1lWEPRehwEdjbMvuQt9sXLsviGvFzzHf7OVeEeJh/CNWowCns8JNHxxKoqfSoh
         9MXlfUMlJn5PzwRaYeBzUmtXStTiw5zy0B/7o+/ITzn2swwRTJeD5MtSC2f50029Ak5w
         J7KsURkNeAD+uiaUi8wPBRA/2wvoHG+jXftVCPry+PgT9aNwg/AxmImMIhvOb/6zMQQr
         22sw==
X-Gm-Message-State: AGi0PuY4aCHPpO1Qs0HFGVrq4DlAAXmIfBh9MC700JoPnr2WXD5FKwrA
        IIjgrzImupmf1COL+sA0NlozBp6M3V640tYZecuQxZhhucjS6iFOHOeJp9LEXZXGIeRT4x7N3rr
        WSu0xGlf7unSk5zvxPyxskTIs
X-Received: by 2002:a5d:4645:: with SMTP id j5mr3833208wrs.282.1587634873996;
        Thu, 23 Apr 2020 02:41:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKmS21JtTUsn1ahG9txOKjxAk/HDnRTv0ERS+dV5m610jdf8hdz/jbKFEmKVINrb0EQb/vgsA==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr3833184wrs.282.1587634873822;
        Thu, 23 Apr 2020 02:41:13 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id h188sm3135576wme.8.2020.04.23.02.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:41:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] KVM: LAPIC: Introduce interrupt delivery fastpath
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-2-git-send-email-wanpengli@tencent.com>
 <09cba36c-61d8-e660-295d-af54ceb36036@redhat.com>
 <CANRm+Cybksev1jJK7Fuog43G9zBCqmtLTYGvqAdCwpw3f6z0yA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a29181c-c6bb-fe36-51ac-49d764819393@redhat.com>
Date:   Thu, 23 Apr 2020 11:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+Cybksev1jJK7Fuog43G9zBCqmtLTYGvqAdCwpw3f6z0yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 11:35, Wanpeng Li wrote:
>> Ok, got it now.  The problem is that deliver_posted_interrupt goes through
>>
>>         if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
>>                 kvm_vcpu_kick(vcpu);
>>
>> Would it help to make the above
>>
>>         if (vcpu != kvm_get_running_vcpu() &&
>>             !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
>>                 kvm_vcpu_kick(vcpu);
>>
>> ?  If that is enough for the APICv case, it's good enough.
> We will not exit from vmx_vcpu_run to vcpu_enter_guest, so it will not
> help, right?

Oh indeed---the call to sync_pir_to_irr is in vcpu_enter_guest.  You can
add it to patch 3 right before "goto cont_run", since AMD does not need it.

Paolo

