Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D826A20738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxbhIJef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgFVOhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:37:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729421AbgFVOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592836631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhaA+I0JFMBynaEViVLcWDggNAbJpIVf0sPk39R0QYE=;
        b=CxbhIJefeK3bdc/WWmnlvyaf6C0IoQgUcZghuuGvriXly0fWvDUNcPeUHHOKJKxtD7wb3L
        Rv4ZZq7luH4TPs0dBDHrsQKKl445CidVt8NCz0CCqh+GpCB70anyVr2EldKSaqZlqR6kkw
        sIrPw12Ifx0RRpEw1vR+bdd6u1bXPJY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-iB9V-ThKMAuTj8PJhdwxHw-1; Mon, 22 Jun 2020 10:37:09 -0400
X-MC-Unique: iB9V-ThKMAuTj8PJhdwxHw-1
Received: by mail-wm1-f72.google.com with SMTP id a18so6872035wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rhaA+I0JFMBynaEViVLcWDggNAbJpIVf0sPk39R0QYE=;
        b=jtRMJ3AVj1FVbAmPmU6a1uKkoNEWP4SqinkkG2yP4H01jZd2ggcFo3mzffnrnbZrog
         QTyzp/XiYe7I7tURaAFuBLtjdHTMzEDAUNi+GjX8u1+pT9oiiU6+5eFPfWaGa0haUMb3
         udbqtas99388Gqk8Lw/a/eysgIFGDQp//5fFA+eplpYVNZiB+gJpfXc4XSwgyQ0B+Wd6
         +Rd2Zo4avnpCZNWy9rkO8EPdHyFD4wLGJTbtS06+NOx+M9UUGaapDcj6antGnAjG0fCz
         T5Kcy2BqDu1hm9OneK6WQQWYpcwPs6Tqa1SWWtgDoEMb/FLl2wwzVIWP7cBNVVORdg/J
         HUkw==
X-Gm-Message-State: AOAM533wQ4O2i0kSWRQPLN21C1wnxPL7u+eFlaB1LqTPIxGOM8TEPo/T
        nMADX1bd/Ip18cLeWys28rTpcEevaEmcEjL/XROBfh74cv/iHKSrO9NEruk8n0wpP6C91jzMJeQ
        7wXrsHT4B9rY/opVNEkwy/7QG
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr19095316wmo.139.1592836627931;
        Mon, 22 Jun 2020 07:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztqu1oKbzSSjrl7L3+QyPP72A21fy7XJuosE7miCXFYthUAfyXzD1V8PIxlT2RSA76DOqswg==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr19095292wmo.139.1592836627759;
        Mon, 22 Jun 2020 07:37:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id w7sm12908477wmc.32.2020.06.22.07.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:37:07 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: LAPIC: Recalculate apic map in batch
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1582684862-10880-1-git-send-email-wanpengli@tencent.com>
 <20200619143626.1b326566@redhat.com>
 <3e025538-297b-74e5-f1b1-2193b614978b@redhat.com>
 <20200622002637.33358827@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc8b429e-74dd-70f1-8f1c-8893a5485e76@redhat.com>
Date:   Mon, 22 Jun 2020 16:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622002637.33358827@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 00:26, Igor Mammedov wrote:
> 
> following sequence looks like a race that can cause lost map update events:
> 
>          cpu1                            cpu2
>                              
>                                 apic_map_dirty = true     
>   ------------------------------------------------------------   
>                                 kvm_recalculate_apic_map:
>                                      pass check
>                                          mutex_lock(&kvm->arch.apic_map_lock);
>                                          if (!kvm->arch.apic_map_dirty)
>                                      and in process of updating map
>   -------------------------------------------------------------
>     other calls to
>        apic_map_dirty = true         might be too late for affected cpu
>   -------------------------------------------------------------
>                                      apic_map_dirty = false
>   -------------------------------------------------------------
>     kvm_recalculate_apic_map:
>     bail out on
>       if (!kvm->arch.apic_map_dirty)

I will post a fix for that.  Thanks for the analysis!

Paolo

