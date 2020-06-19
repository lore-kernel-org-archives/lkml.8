Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2525C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0B320776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz1i2VF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbgFSOKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:10:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731492AbgFSOKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592575850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQGcTYNZ0qd2ZL6M4exRQEolMRV74PfXhnhqE6+gOjU=;
        b=Mz1i2VF0PEpcBRCqa+5zDlCsNhfJ3YkAi8W1udqWJTnGXSQQ8aFK/oqymL0ZeKjbLQMc43
        cvW6EJpKvZaT2Y8pE0/tx8JfQGPyW+Fo7AKJkNpRClvq7tffu74qyGx5MLUTCA4YGqXFsj
        COVqkUNNU3smWcPMjEYyfkH6rp4u0Mw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-NasKLmzNMPGBZG120J0lrQ-1; Fri, 19 Jun 2020 10:10:46 -0400
X-MC-Unique: NasKLmzNMPGBZG120J0lrQ-1
Received: by mail-wr1-f72.google.com with SMTP id o12so2370090wrj.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQGcTYNZ0qd2ZL6M4exRQEolMRV74PfXhnhqE6+gOjU=;
        b=YkYXFr1LQcfAXDEHa7dP6ORtmzIGepwje3Bt64PP0rTcuNr6rX2I/qEksZFQBmG6Kv
         FKTS41LKv46+7bogjk+9W8FsHL/4rDr7HKWVdt+Ru9PrB1GrHE3Q9sN923Jab7Lx/sW6
         UdS0UDS1iOVuEj7Nj+PXo4Wyn6nOuSosTZT+unY9eIqpzTOMkpo0YFLDT9oWqUwwJQYN
         d7Z4UUJC0bhj28Q0CWPYUZw1ByeMSDgU6CrQpt3+zdOhgVKmpYspxixjzZhQCzevlCPI
         moWivZhV/zrc3NDGl4Kjr19+iF4ZUKg6jaVRLNEaQZvdBkHqRGeRpIAY8l7ftPz/rB9F
         epoA==
X-Gm-Message-State: AOAM531dSjeq6nTwQcuutRKbLOr4DHpcopJlbqjpsBHbAsZucCiu/afz
        57Vtfmbu62nR8zaR26Q7R5kYCDonhqf8Zb3kSlbSv6dlq97M4UK174g62I9NFiXF7QGM5P/Ek8n
        El9fqtuS4YQeX7qI7kmC0mz+E
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr3416507wmh.148.1592575845677;
        Fri, 19 Jun 2020 07:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2lf9yJVDZ3TMxLfmzqD+pzoOr6W+H3pQlOKmVqwKx1RlwQw91jzYg+uud8qh9pLidgwOIBw==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr3416482wmh.148.1592575845471;
        Fri, 19 Jun 2020 07:10:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id e12sm7410682wro.52.2020.06.19.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:10:44 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: LAPIC: Recalculate apic map in batch
To:     Igor Mammedov <imammedo@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1582684862-10880-1-git-send-email-wanpengli@tencent.com>
 <20200619143626.1b326566@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e025538-297b-74e5-f1b1-2193b614978b@redhat.com>
Date:   Fri, 19 Jun 2020 16:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619143626.1b326566@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/20 14:36, Igor Mammedov wrote:
> qemu-kvm -m 2G -smp 4,maxcpus=8  -monitor stdio
> (qemu) device_add qemu64-x86_64-cpu,socket-id=4,core-id=0,thread-id=0
> 
> in guest fails with:
> 
>  smpboot: do_boot_cpu failed(-1) to wakeup CPU#4
> 
> which makes me suspect that  INIT/SIPI wasn't delivered
> 
> Is it a know issue?
> 

No, it isn't.  I'll revert.

Paolo

