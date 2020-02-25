Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E1C35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E229520658
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXavJE+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgBYOgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:36:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730691AbgBYOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582641368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQkKAh+IMe5D8qRJbmj17S6Uf0KPiGWejl7b1aEjsRI=;
        b=UXavJE+I0aeE+wzQBV6xaT5uz/imH+stPoJKgZEiCiQ5cENnsddl4zlIOQNUrcrAphtHfS
        GW52ylMEAFctstZ2yDra4v7gU5yn2gJMvRd18RKEha2WYxEqTAW91zrK8jqEOJjJT/EaHK
        MQ8DqA7RMTSxLMKtpBCKiuOI7pdBbHs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-a7aQtcZ3MjGgKV-wFq5Vgg-1; Tue, 25 Feb 2020 09:36:07 -0500
X-MC-Unique: a7aQtcZ3MjGgKV-wFq5Vgg-1
Received: by mail-wm1-f70.google.com with SMTP id b205so1115686wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQkKAh+IMe5D8qRJbmj17S6Uf0KPiGWejl7b1aEjsRI=;
        b=qy+HjS85sF/3B3pfLv39mjkEbS+itvGkCIlPH/BYF9si1diw7eghXW4SNhEauRuYNS
         nheFJHxypC63/EfG9MpxTHEw0aMvgj1lUu36/l6zR0l6WsCh4pE/DF4j1W8GFEI6sjlo
         1pLMOUXsZ6MRD4CIyikk+o1xbdFRUWGdTClicJfWY+bKjVK4rUzxGX/CMOpQJOMOhEmS
         vvaSyYfFAUzSukubC/2eXHeQn3QequDIYwwNPhjFUghpkYMBjCxrbgsf+qfliddoIXUZ
         oSkB5XIKZpBmK71MJpz/eFQHnQn0rKkS4qeQHeKVgdZulJ8rX7+3cBJiaiyzoxip6otk
         afwg==
X-Gm-Message-State: APjAAAVYZRI8As7/nc53j6sJ1LDYsU5pvMhimfI4eA+k99hhXeELbWyy
        MQcWPkxJng3fQNiEUA/pEmS+xUnZ6XWKPmP9Umm8Qgdfyx+B+Es2WagZkWFMJOOqQu5u1gK6bLO
        QiGHPYXUGpiuve8MuY87irf64
X-Received: by 2002:adf:f84a:: with SMTP id d10mr3391694wrq.208.1582641364780;
        Tue, 25 Feb 2020 06:36:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwNMJ2AmbkFH/U1r8SRcgK5A6QxWJZNkOjGHc8bd23bJs1LK+l3gqPf3Nnw3QaxqcOOSxbRw==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr3391670wrq.208.1582641364511;
        Tue, 25 Feb 2020 06:36:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id y17sm24108400wrs.82.2020.02.25.06.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:36:03 -0800 (PST)
Subject: Re: [PATCH 01/61] KVM: x86: Return -E2BIG when
 KVM_GET_SUPPORTED_CPUID hits max entries
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-2-sean.j.christopherson@intel.com>
 <87mu9zomnn.fsf@vitty.brq.redhat.com>
 <20200203155903.GA19638@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70f9ef36-b180-79d4-7d9a-8df8d6219122@redhat.com>
Date:   Tue, 25 Feb 2020 15:36:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203155903.GA19638@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/20 16:59, Sean Christopherson wrote:
> 
>> In particular, here the change is both the
>> return value and the fact that we don't do copy_to_user() anymore so I
>> think it's possible to meet a userspace which is going to get broken by
>> the change.
> Ugh, yeah, it would be possible.  Qemu (retries), CrosVM (hardcoded to
> 256 entries) and Firecracker (doesn't use the ioctl()) are all ok,
> hopefully all other VMMs used in production environments follow suit.
> 

Also: lkvm and selftests both hardcode the limit to 100.

Both would be broken by this change, but as long as the limit is < 100
now it is fine to change.

Paolo

