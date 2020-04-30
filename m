Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACBC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1980F2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvzkadaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD3NcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:32:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726692AbgD3NcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588253541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+aTxk90D7+j/ZxikiZm7htr7ihgz4RE8XZxOaPVLGY=;
        b=VvzkadaBT+qn7TSfrLnw0ja+C+Zg/U+re4yRmexhPHXN4FPLB6KTtnM9J3MDyM7Ac0LCNO
        QEzB3Tym0WQjGwE8H+Ib422K2AXAYtATfOFpQ94/uhpRUCeTSvSkoIrkCSIqF89Y6+eZD0
        WK4NGETX0aUnv+SkAMq/YhCBeEFEbSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-ArhEU26BO125W0CCvV0s8A-1; Thu, 30 Apr 2020 09:32:19 -0400
X-MC-Unique: ArhEU26BO125W0CCvV0s8A-1
Received: by mail-wm1-f72.google.com with SMTP id w2so858255wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+aTxk90D7+j/ZxikiZm7htr7ihgz4RE8XZxOaPVLGY=;
        b=GM+Gip8/Cs+H7bGjKg3x2fuFn25j7ak2CvyzAbmjvNUQddVZrSuxFdMJ4qD+zAMaav
         P355Pz0f2GlwqOa95NjakLeJ8BFBQLieCG9b3d/VIAcYLZTZh/OWME9OiNZwQTDdEwzZ
         5LgJOJG5I3ObXBz9/XgQFdHU60CG1Aw+pALAMcexf/OKBqn3S/dsG3dSVB9WFHyAxaV7
         Ut6xfx3HMqnix2DwRI1r5RI86EtlrGY12w9GrLOlLpz/Cl7K4SM6NSikX9Km7nJeNUcv
         EnXyLuwroWZfpPSDIEpR+eHx3fCML5PSRRywTTaKBYAVfai3KXz065JqF7lQ/rnotxLw
         Ntdg==
X-Gm-Message-State: AGi0PubvanZMAYUVQL1/+W6ZM0pl3d4oZpXImfkqpTqbQYMYH6MJ716n
        45KaZLWfKBhZgiCwUcjHp2gCJ+ZpWMdz1ovgM+NJs1rsa/CTmHnZo7w36TKJKuY4Bzj1Zra5vQF
        L/jSJ+TrcoiHTmasvpsDE8rjz
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr3164041wml.133.1588253538321;
        Thu, 30 Apr 2020 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLZwuDOopSSlnP92U8HygTNBmhhTn4PWDpNdu4eD+Pq/bkj6FBcQrWnMY670cOB2vZJ5e/KIA==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr3164026wml.133.1588253538120;
        Thu, 30 Apr 2020 06:32:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id s6sm12332481wmh.17.2020.04.30.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 06:32:17 -0700 (PDT)
Subject: Re: [PATCH v4 5/7] KVM: VMX: Optimize posted-interrupt delivery for
 timer fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1588055009-12677-1-git-send-email-wanpengli@tencent.com>
 <1588055009-12677-6-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66fd6180-8e8b-1f9c-90f1-a55af1467388@redhat.com>
Date:   Thu, 30 Apr 2020 15:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588055009-12677-6-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 08:23, Wanpeng Li wrote:
> -	if (exit_fastpath == EXIT_FASTPATH_REENTER_GUEST &&
> -	    kvm_vcpu_exit_request(vcpu))
> -		exit_fastpath = EXIT_FASTPATH_NOP;
> +	if (exit_fastpath == EXIT_FASTPATH_REENTER_GUEST) {
> +		if (!kvm_vcpu_exit_request(vcpu))
> +			vmx_sync_pir_to_irr(vcpu);
> +		else
> +			exit_fastpath = EXIT_FASTPATH_NOP;
> +	}

This part should be in patch 3; not a big deal, I can reorganize that
myself.

Paolo

