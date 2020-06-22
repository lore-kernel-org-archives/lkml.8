Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CDD206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIzqC71X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgFVPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:23:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729150AbgFVPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592839432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGpF0Z4o98o6k0v3vIzdGQK4IxCExf5QSKDcyS94Xvc=;
        b=WIzqC71X0A5hN4gOoXemTu/J+1yvz80y1jvPYSibdSKjR1ZKagJQeRVM+YbkbwPdic1C9o
        ibBWhrgXrP9pTFWPmbMj+B3Gehohy/Tfm5IjYNjdSodvExbdGT3CCQkzHl19bPaIcXo3Mc
        GLvs6Ass6OeGnxsyzVbGpUJ3Jn5BG2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-zORpBuoTOyu4u2Yvkgs1rA-1; Mon, 22 Jun 2020 11:23:51 -0400
X-MC-Unique: zORpBuoTOyu4u2Yvkgs1rA-1
Received: by mail-wm1-f69.google.com with SMTP id l2so6985636wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGpF0Z4o98o6k0v3vIzdGQK4IxCExf5QSKDcyS94Xvc=;
        b=FCJu5bTWbcih27Y51HompCnTeQ1mS/36vZmVJk66D6+VLGjA6C5lz1PnxYcrayVj1o
         mjGULw/IA6AcI4IJV+X2aNWvz7t4DKxA4CZr+7b1FK2z/61iJL8V9fUhGmWK7yOHGTVA
         LASAR3m+cgXyLWXaSP6aFe/MseW3IQTrfGl5h8xonyZPUf8I+8JFwo3w12Hees2Wsgnx
         WUrr0BJi8pd+rpPVysTGaEFMgMY32/qet7HMhLGiz3aiGYZnlJFWqVaU4Kryg3WdPlZ3
         nw06a7GZbH1dugqC1Xyo52LEXcmqqR4VzyIkxtji5GsOYxCDWRKGK5cs9UpfABWTp1A9
         pyxQ==
X-Gm-Message-State: AOAM531fFbMWx+uzKdB/tIYGYhq3d0cyCS4pbz8I+58sdO9fE3c+CUe+
        GZPagCIOBMnYrpbD1SF0S0g9ToWeFsgMMMlsiTu9ZXiqhF5yULQUUQkf0+rTEXxZkaPhyDWXXW/
        QLs0SFSn50Sr9kLoCgB8e8SA0
X-Received: by 2002:adf:ef46:: with SMTP id c6mr1166990wrp.34.1592839429932;
        Mon, 22 Jun 2020 08:23:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJvSRmLdiYDCgpOU1rHgnpl7Ep95bf98pJLlBYjznBMbbO5UABy+Hb03Ct9Xk8BS49lBEPeA==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr1166972wrp.34.1592839429751;
        Mon, 22 Jun 2020 08:23:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id 63sm19975505wra.86.2020.06.22.08.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 08:23:49 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Mohammed Gamal <mgamal@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, babu.moger@amd.com
References: <20200619153925.79106-1-mgamal@redhat.com>
 <5a52fd65-e1b2-ca87-e923-1d5ac167cfb9@amd.com>
 <a5793938619c1c328b8283aab90166e352071317.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08594d32-9be2-b4d6-1dac-a335e8bda9f7@redhat.com>
Date:   Mon, 22 Jun 2020 17:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a5793938619c1c328b8283aab90166e352071317.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 17:08, Mohammed Gamal wrote:
>> Also, something to consider. On AMD, when memory encryption is 
>> enabled (via the SYS_CFG MSR), a guest can actually have a larger
>> MAXPHYADDR than the host. How do these patches all play into that?

As long as the NPT page tables handle the guest MAXPHYADDR just fine,
there's no need to do anything.  I think that's the case?

Paolo

> Well the patches definitely don't address that case. It's assumed a
> guest VM's MAXPHYADDR <= host MAXPHYADDR, and hence we handle the case
> where a guests's physical address space is smaller and try to trap
> faults that may go unnoticed by the host.
> 
> My question is in the case of guest MAXPHYADDR > host MAXPHYADDR, do we
> expect somehow that there might be guest physical addresses that
> contain what the host could see as reserved bits? And how'd the host
> handle that?

