Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AA920691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK60Uv+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFKAHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:07:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726820AbgFKAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591834028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG1f0DEkS8GNLNtqNZirTqogQo8gFsAlps/puTKPgPA=;
        b=AK60Uv+5qz8XB8721z0baPURuQmaafU/aQyaInK+IONIgQPc67OApzMeaXPIdgAUn+GuDK
        SbG76QzPuj5wzcXIALfP8V33WJl5whbw/cqtsqdQzQXqkWHn5ATUzTkufgFrvelzqFejoB
        xlhfMrsworK36QaRqXnS/1fNtKEIDu4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-yc06NXITOjGXp2g7QjSikQ-1; Wed, 10 Jun 2020 20:07:07 -0400
X-MC-Unique: yc06NXITOjGXp2g7QjSikQ-1
Received: by mail-wr1-f72.google.com with SMTP id e1so1784790wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bG1f0DEkS8GNLNtqNZirTqogQo8gFsAlps/puTKPgPA=;
        b=pQuyMwvQeg1zYVQVLCcBjh6FjwroM1BPQYlOAhisBwvOzFwazThmIQt5ne2gNNa6jD
         oDy/a6FjGmd/qDqV/U8IbdJcgjG3rbczo8dPh5bh9qFUEWe0otl4dqZ0xSIzEDlSd2Qu
         v/ybuhpdYkej7QVk6QZ7rN4datqfGAFiy9jeSJJuRHbXMXa1wsjpQE9RWur047eQdJKS
         b84uzzpyGtTuUu3bcnqzjtMZ5bRAOvnrC8/lKEU9p0Lkxq/wdNhleNKuRtK/wqgEQW0q
         16btHOp8QoyATtYScmeTdXPL5d2vinZ3ACVCMHxDSuW3qiOv4YRs97jM0kHvOhz0GdPz
         vbQw==
X-Gm-Message-State: AOAM530tyzMvyvvgQrdRDPPexihErobJx/3AO1K0qSbc2u3Y4SxvjMvZ
        +1csPkH5E+NWf/rqBDbTWhj3WYYxfiLhBDuTUxi4I0U2DwZYPB1Ah7xjIiqgX2H3qB3KGGnB8X5
        W3h0p/HrQuT3WYxO64h1hdxjd
X-Received: by 2002:a1c:1d94:: with SMTP id d142mr5500424wmd.42.1591834026141;
        Wed, 10 Jun 2020 17:07:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyERZxGXMtunnFSc+m5agcYq7aVk8aBfHzDqaphsJnY9S7fHd1kWpGwVRoNb/LyjwtNx/2Xvg==
X-Received: by 2002:a1c:1d94:: with SMTP id d142mr5500407wmd.42.1591834025935;
        Wed, 10 Jun 2020 17:07:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d? ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
        by smtp.gmail.com with ESMTPSA id v28sm2194252wra.77.2020.06.10.17.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 17:07:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: async_pf: Cleanup kvm_setup_async_pf()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org
References: <20200610175532.779793-1-vkuznets@redhat.com>
 <20200610181453.GC18790@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42da32b0-6cb0-58e4-dbb0-484afbd48757@redhat.com>
Date:   Thu, 11 Jun 2020 02:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200610181453.GC18790@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/20 20:14, Sean Christopherson wrote:
>> -	/* setup delayed work */
>> +	/* Arch specific code should not do async PF in this case */
>> +	if (unlikely(kvm_is_error_hva(hva)))
> This feels like it should be changed to a WARN_ON_ONCE in a follow-up.
> With the WARN, the comment could probably be dropped.

I think a race is possible in principle where the memslots are changed
(for example) between s390's page fault handler and the gfn_to_hva call
in kvm_arch_setup_async_pf.

Queued both, thanks!

Paolo

