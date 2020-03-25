Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB8C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990442073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrO6LfVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCYPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:55:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57001 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727592AbgCYPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585151748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uyp5KQDbaTuA45q/Xax3q7Sq5x15XAtmyACKrevDWP4=;
        b=GrO6LfVLl077ePx2nAJeMdwHyAzt4nfUFM+MRLRJT+o/c1sV1tIBURsBNRNDw2B5ae2Zrz
        cPAOkYY0xs6guhlvQUHpWclHR3xZqy7idN7nByLv0ZxMDVQdBFxC4seeihq+/voJFzui1R
        cW3AsV9Yb0TgMxqYdLvRFtZY6MjGbaE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-MDsyuokvOIm8TxPPlzaPgw-1; Wed, 25 Mar 2020 11:55:44 -0400
X-MC-Unique: MDsyuokvOIm8TxPPlzaPgw-1
Received: by mail-wr1-f70.google.com with SMTP id o9so1340177wrw.14
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uyp5KQDbaTuA45q/Xax3q7Sq5x15XAtmyACKrevDWP4=;
        b=g2+hgrmHWh5ATYZWDc9UrE6YhA1bevJNCfFidfFvF3ktMlwxl1tobnMHPOJ+eleoCm
         L59Sv38vBGaHO61eHAHHjaSf9MThvgluP/XfAHWkDLto/fi0v5syS7QgR5qK/0VWIsKi
         tu/mVYchhkMah5Zss/uwrm22sp9vxe2nL1MrbtnH+xPMWPw35KLpGMbi0/vZv0urMcCG
         fd3ZoZxHl7dy5lRn5oKIRXiTr8pid1PG1CkKoiaY1ZxHml1ry59n+9yDJDYVm91r6Pug
         fKKSIatc0QIDj5CMm0y75fZUcqnnRyXSHE6msayZMVBXxOrVWs4CmAleMCeKpbuXjmvG
         I0sw==
X-Gm-Message-State: ANhLgQ0csItRLQCLoENA82nThE8XSWcsE/8J7zWsjbUxFoUWqRbLJjeV
        9uiv5y32lNsvsFi+mOHTNm3TkDBpu/y7bb1Fpr4WiO2vw78YhMnTxac0/CllUNANuY9oeV/Uy/s
        N2ARXFa6xchFfNKdOAbQmpmQa
X-Received: by 2002:a5d:510d:: with SMTP id s13mr4108642wrt.110.1585151742842;
        Wed, 25 Mar 2020 08:55:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtr84A74132XneFu/qdjCKJKKAo6gtWQw73ZQv5xSzVApoFiDmSQRc9YzMzr0NqEKEw83Qidw==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr4108625wrt.110.1585151742652;
        Wed, 25 Mar 2020 08:55:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id y200sm9674775wmc.20.2020.03.25.08.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:55:41 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Also cancel preemption timer when disarm
 LAPIC timer
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1585031530-19823-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <708f1914-be5e-91a0-2fdf-8d34b78ca7da@redhat.com>
Date:   Wed, 25 Mar 2020 16:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585031530-19823-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/20 07:32, Wanpeng Li wrote:
>  			hrtimer_cancel(&apic->lapic_timer.timer);
> +			preempt_disable();
> +			if (apic->lapic_timer.hv_timer_in_use)
> +				cancel_hv_timer(apic);
> +			preempt_enable();
>  			kvm_lapic_set_reg(apic, APIC_TMICT, 0);
>  			apic->lapic_timer.period = 0;
>  			apic->lapic_timer.tscdeadline = 0;

There are a few other occurrences of hrtimer_cancel, and all of them
probably have a similar issue.  What about adding a cancel_apic_timer
function that contains the combination of
hrtimer_cancel/preempt_disable/cancel_hv_timer/preempt_enable?

Thanks,

Paolo

