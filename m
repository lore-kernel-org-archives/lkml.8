Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA7AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AC82070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRHiR+J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgCZJqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:46:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43155 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgCZJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585216001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmP9/4eydnX5iyBBhajAJRXc7M9FYD0cP2/UdQw5GkI=;
        b=MRHiR+J1zotW8xiZgga/2oNeSOAcIq5XIoH47Ca/b5pMTPl+qkqn11UDtnFA+Z+t3hd7aX
        +PE4YZ+xUp4ZumvfaG2fsVLEFy+YdMq1l3wqzJbbBYLmjBhr3RfSST8+N55QVeH3m+utub
        LG6z2kPNgzr3vBoJa52QnqGD2HAMYD0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-SDGffcIuPMSP9ZgLIpgrkg-1; Thu, 26 Mar 2020 05:46:39 -0400
X-MC-Unique: SDGffcIuPMSP9ZgLIpgrkg-1
Received: by mail-wr1-f71.google.com with SMTP id v6so2731200wrg.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nmP9/4eydnX5iyBBhajAJRXc7M9FYD0cP2/UdQw5GkI=;
        b=GkIeUuxrMpt3QL1FSoo9oqRvlXmbf/TICkSM7LZuh+PPG4E2dqpAHFLylAmhcsWBUL
         y0PhKlGJMpMJhM1ZoWl527qGSmNGCKvt3PSraXTjX7khaPzlCy+0qTlF1b60ERaLRGgf
         xqpaomNI7+v2dA+4YtorWXIpwIWLoPPlCxQ+QB5UMB5svajyJkdp7bBc8T95yDgF9p4i
         hitdXGghSAy9UIQm08fT0ehMqoH5PN0oINYwlkan7CBYbC/cpV/g4S9sbSLzGqAj4fde
         FtUpOVME7eilj2D2WHi/ElkG0vVMAovsUTW1UtMMJLUQGFbRIMqoHVGNm/U9SAD123zt
         EzuA==
X-Gm-Message-State: ANhLgQ2LJSoE3j4GJQApkvCTLoVmjCcK0xKACyU2B2MRdkf3qicJQKFN
        MWlvGz1Ncy0p14yVAUvBUyCBxME2O1QS3jUdg9m/pS5idtb6isOXLAYgs3gdKB/VSGtthC/BzbB
        LQuarCWUL/KDO4sbxdCPLYDYH
X-Received: by 2002:a1c:6885:: with SMTP id d127mr2260420wmc.33.1585215998425;
        Thu, 26 Mar 2020 02:46:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs2HiEIlBvxuqoG1NPUwv2DHm8ecXV4uGGxlIvnY/ct/LrMTIIEN3SuZPLvHBRJ1XX4In36cg==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr2260399wmc.33.1585215998141;
        Thu, 26 Mar 2020 02:46:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc? ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
        by smtp.gmail.com with ESMTPSA id y189sm2854521wmb.26.2020.03.26.02.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 02:46:37 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: X86: Single target IPI fastpath enhancement
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1585189202-1708-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <353a0717-4c97-9945-caa9-10037274f4a8@redhat.com>
Date:   Thu, 26 Mar 2020 10:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585189202-1708-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 03:19, Wanpeng Li wrote:
> The original single target IPI fastpath patch forgot to filter the 
> ICR destination shorthand field. Multicast IPI is not suitable for 
> this feature since wakeup the multiple sleeping vCPUs will extend 
> the interrupt disabled time, it especially worse in the over-subscribe 
> and VM has a little bit more vCPUs scenario. Let's narrow it down to 
> single target IPI. In addition, this patchset micro-optimize virtual 
> IPI emulation sequence for fastpath.
> 
> Wanpeng Li (3):
>   KVM: X86: Delay read msr data iff writes ICR MSR
>   KVM: X86: Narrow down the IPI fastpath to single target IPI
>   KVM: X86: Micro-optimize IPI fastpath delay
> 
>  arch/x86/kvm/lapic.c |  4 ++--
>  arch/x86/kvm/lapic.h |  1 +
>  arch/x86/kvm/x86.c   | 14 +++++++++++---
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 

Queued 2 for 5.6 and 1-3 for 5.7, thanks.

Paolo

