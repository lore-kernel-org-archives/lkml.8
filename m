Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908382073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/q40vuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgEVHd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:33:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728214AbgEVHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590132804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EtbHbZKdks/ocBUdzOilBq6OTiCmy87fOc1ctWzSB8=;
        b=J/q40vuvSBdOCkpqSMXBqVOQNJFyj+BZBrKXfED6n6Jfg8b6LHGivW3Roa9lq2JL7T5331
        dCRHFugb4f5CNLrtYo3rJlSpPPoVeeOaxC1er95QHFBujVzdRZrBZQpwRF2qKDli0kWWmo
        zL8NZ2ajwefdZD7uZalG00q2d4jAads=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-S600NW0GOlKzgecVSm4Teg-1; Fri, 22 May 2020 03:33:21 -0400
X-MC-Unique: S600NW0GOlKzgecVSm4Teg-1
Received: by mail-wr1-f70.google.com with SMTP id p8so4033210wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EtbHbZKdks/ocBUdzOilBq6OTiCmy87fOc1ctWzSB8=;
        b=NctEqcptSFYdc0DsIc67dhmyOGGeN633Yl/Jm+NVoA4GVyxFYerLfWUWnSrnG8dZsW
         mJwtIfpKopzKpZprDeooAICXBJvliIqKFyBm1p4TjqFyPGalCmf6mbf1KVD+C7I35Bc9
         46E3ewNSKXqRzIzbo8N/s86Jx2TFtRTe3qPurP+/YBbiw+n+Vgfej2KZS75q+C2sclzy
         Fl5Zj7Bs/qbNLIF/WDDybxOw43Kc3h5o7iLXZ2JEaUp8XpqLa0mFhMFkospG0M46FGl6
         TZo6/rrzNZxK1UOg0lAGXceAxJ+0jJtDn8cGtq60+1zBJGLYDVvDPwFZzU2HCTD+uWtG
         PxmQ==
X-Gm-Message-State: AOAM533Fd5rpWQLElKlKDDk4VZCHbBuJ9buRZF05vW2z1zc8kGDsb6jT
        RV3YSBpi2Is7UrjepLYsy7GK5Xj3qxWhz7w69xehtuVKqnsyCB5DVptaNohOw97BoLTJUSWbkbr
        VnuXCYTyumKkH3v2uOjMLzFiP
X-Received: by 2002:adf:82c3:: with SMTP id 61mr2352148wrc.326.1590132800742;
        Fri, 22 May 2020 00:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHE+96FYxJjwlkKncGlD0w505R5oIT+cQodzUqCD8Ml+XOl1XFdP5KV9lsIxGty7UQKdEwtQ==
X-Received: by 2002:adf:82c3:: with SMTP id 61mr2352119wrc.326.1590132800484;
        Fri, 22 May 2020 00:33:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:71e6:9616:7fe3:7a17? ([2001:b07:6468:f312:71e6:9616:7fe3:7a17])
        by smtp.gmail.com with ESMTPSA id l13sm8583790wrm.55.2020.05.22.00.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 00:33:19 -0700 (PDT)
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with
 token info
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com>
 <20200511164752.2158645-3-vkuznets@redhat.com>
 <20200512152709.GB138129@redhat.com> <87o8qtmaat.fsf@vitty.brq.redhat.com>
 <20200512155339.GD138129@redhat.com> <20200512175017.GC12100@linux.intel.com>
 <20200513125241.GA173965@redhat.com>
 <0733213c-9514-4b04-6356-cf1087edd9cf@redhat.com>
 <20200515184646.GD17572@linux.intel.com>
 <d84b6436-9630-1474-52e5-ffcc4d2bd70a@redhat.com>
 <20200515204341.GF17572@linux.intel.com>
 <943cfc2f-5b18-e00a-f5a2-4577472a1ff5@redhat.com>
 <87y2plqqpa.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e79fe0d3-0a73-ed84-7021-150d03a80f93@redhat.com>
Date:   Fri, 22 May 2020 09:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87y2plqqpa.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20 16:59, Vitaly Kuznetsov wrote:
>> However, interrupts for 'page ready' do have a bunch of advantages (more
>> control on what can be preempted by the notification, a saner check for
>> new page faults which is effectively a bug fix) so it makes sense to get
>> them in more quickly (probably 5.9 at this point due to the massive
>> cleanups that are being done around interrupt vectors).
>>
> Actually, I have almost no feedback to address in v2 :-) Almost all
> discussion are happening around #VE. Don't mean to rush or anything but
> if the 'cleanups' are finalized I can hopefully rebase and retest very
> quickly as it's only the KVM guest part which intersects with them, the
> rest should be KVM-only. But 5.9 is good too)

Yeah, going for 5.9 would only be due to the conflicts.  Do send v2
anyway now, so that we can use a merge commit to convert the interrupt
vector to the 5.8 style.

Paolo

