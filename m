Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA5BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4DC2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNMZEtJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGISYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:24:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbgGISYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594319048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrUu54pau6Z14x+8fMsvL9C3uFgIczVUTJI1abmxIqI=;
        b=eNMZEtJXSjOA4jq+wFcLQYZK1NgxCDhqyiYGvcQOhRRFcVDQmln9EcZzwgCViBNndxOT0j
        cc28UNQ6UhbRjo/aAKd5/qgoI6LXG5S96EbRPHBJkje+VjldrQfkgEvnIya99EMULFVbOS
        nPzANqqWm0Vp9/ABx2sqyHVwEZVrqGE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-hWj9O6O3PxGJAAzIBE9Kfw-1; Thu, 09 Jul 2020 14:24:06 -0400
X-MC-Unique: hWj9O6O3PxGJAAzIBE9Kfw-1
Received: by mail-wr1-f69.google.com with SMTP id y16so2678958wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hrUu54pau6Z14x+8fMsvL9C3uFgIczVUTJI1abmxIqI=;
        b=cDbHU99a0uCP5USnNpyOtEVsbCL8VbO9zj2kfQNqE7qQ9nSYTmR7avx2l8gocNngFY
         L4C3lsr/huuJJyVV+cV1pqMjwpyVf77oL5QKRueFZ3bdYLCBvj4J0FGOHCr+6M4k5CdI
         em3/CzZephVsGhVBs3WFCY/NVyeIy87+j5xd/oUO/9tO2NEOxEdKrh8PJ0ZEkoj38x41
         XMw4kqbB5Ehj88VPZp6nLNra1pKddnR56BLX+LCSCv/F9/bFLh7/4vebbZa3FtvRbtIG
         VJvkMw8nQ7q8veZzIaGtOydlr0fIE2EuLf472IEUjV/ZM8QL6wQpXY3qnzW4dBW6kVU0
         YvFA==
X-Gm-Message-State: AOAM5300i5R4WKqrOnnbiaNrgor2mwwgn1aqhp0Z+9Bpi6V3g5GTYh3m
        yCS4B33juM2dqkTupRNYUib8fGsQobjryWSW/QsVlSVPfHpKdeSYpo9UG/K7uza74pm84QJ+4W0
        x6P0uqJLc5A6hHtdrIdMo+Ue4
X-Received: by 2002:a5d:6987:: with SMTP id g7mr63901652wru.79.1594319045371;
        Thu, 09 Jul 2020 11:24:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3tt18EFpY6nLsMYasMrv46UnHAWmPZe5fYgh+nyfdNuqIuyQzmxb1CgwkTn1pj3QzgppBbA==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr63901637wru.79.1594319045192;
        Thu, 09 Jul 2020 11:24:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id y7sm6668692wrt.11.2020.07.09.11.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:24:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: X86: Move ignore_msrs handling upper the stack
To:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200622220442.21998-1-peterx@redhat.com>
 <20200622220442.21998-2-peterx@redhat.com>
 <20200625061544.GC2141@linux.intel.com>
 <1cebc562-89e9-3806-bb3c-771946fc64f3@redhat.com>
 <20200625162540.GC3437@linux.intel.com> <20200626180732.GB175520@xz-x1>
 <20200626181820.GG6583@linux.intel.com>
 <47b90b77-cf03-6087-b25f-fcd2fd313165@redhat.com>
 <20200630154726.GD7733@linux.intel.com> <20200709182220.GG199122@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7aa46e68-5780-2698-67f5-425693478fe1@redhat.com>
Date:   Thu, 9 Jul 2020 20:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709182220.GG199122@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 20:22, Peter Xu wrote:
>>> So I think Peter's patch is fine, but (possibly on top as a third patch)
>>> __must_check should be added to MSR getters and setters.  Also one
>>> possibility is to return -EINVAL for invalid MSRs.
> Yeah I can add another patch for that.  Also if to repost, I tend to also
> introduce KVM_MSR_RET_[OK|ERROR] too, which seems to be cleaner when we had
> KVM_MSR_RET_INVALID.

You can use either that or 0/1/-EINVAL.  I would be fine with that to
keep the patch small.

Paolo

