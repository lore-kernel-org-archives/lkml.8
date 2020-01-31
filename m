Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ACBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7620705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2lgEB/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgAaVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:08:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50200 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbgAaVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580504897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJqW6sEGELK0trBBJMQelpgP9cat66lBv2QLm4tjtU4=;
        b=F2lgEB/OW3rhwSLd2lgb96KpQFoeDdUBuzOElPut5TSLEOBYdbQFDih8tMprE9TpRKmu5b
        0yRhUuB8guEP6H1W+4D7CmIuGP48yGE7t1wkrxUGjBhGaVLUZr3LtLoksklaRclLqr/+VM
        yZrTBl/l+hmKjYcvW07N9F7tLKttPZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-i0Feld1oM5GQ0-Gg5WqyFA-1; Fri, 31 Jan 2020 16:08:14 -0500
X-MC-Unique: i0Feld1oM5GQ0-Gg5WqyFA-1
Received: by mail-wr1-f70.google.com with SMTP id b13so3940512wrx.22
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PJqW6sEGELK0trBBJMQelpgP9cat66lBv2QLm4tjtU4=;
        b=R0GTiRUpAqN9VgRHhZb4Jy8FqFfJNgurP9kJYVO8XNytn65cvj5h7Y64t+llNWyfWW
         b4xCGazrghGqHthJmWnATGBLZurNUn+SlnbTKuYC1W89wMMmPvth/QOhVFHLW2NNTqvU
         wugQYD28BZW88eQOVpi9zPCSMzELVuy0rc+HySjB0RHQG0gPugDPRC0m4KJ4Ck9/mNQA
         T/MsoCKcMHdRg9h17YV+T6uraoxHcqd36Od8WG9NCrA2zxF5p6X1Tjvo7gmmc8a2tvoO
         wXf26C1OL07oc3I0vBP3Z9hK83PpXDhg9BQtj6EnFaUu8CrLucbc05AUnEKWDCAOI1ln
         g/fQ==
X-Gm-Message-State: APjAAAVNiPwGsp1Z4+KVsQ4Z2mNUKvsoV5hVqyjKvthKQtoWRS8MLlUf
        OZ1ZC4aF5+U/3nwJ0fcwkxl5jy9qsygxDvKWEv0XfbFJIEadpllX7ldPevAh0ugjb4Hg2gZmJ+t
        SdwYh+Ulfja8dTLfmxB328bmN
X-Received: by 2002:adf:df83:: with SMTP id z3mr261612wrl.389.1580504893586;
        Fri, 31 Jan 2020 13:08:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwO7/1pA3KrXtKIpuDB8xxaQ3mp9WxKZJ1bIVxYVH3uD7S6NgJR8bvKgUvAH/KQbMFzQnpgGw==
X-Received: by 2002:adf:df83:: with SMTP id z3mr261565wrl.389.1580504892780;
        Fri, 31 Jan 2020 13:08:12 -0800 (PST)
Received: from [192.168.42.35] (93-33-8-199.ip42.fastwebnet.it. [93.33.8.199])
        by smtp.gmail.com with ESMTPSA id m21sm12584692wmi.27.2020.01.31.13.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 13:08:12 -0800 (PST)
Subject: Re: [GIT PULL] First batch of KVM changes for 5.6 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <1580408442-23916-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wjZTUq8u0HZUJ1mKZjb-haBFhX+mKcUv3Kdh9LQb8rg4g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7038958-bbab-4c53-72f0-ece46dc99b4d@redhat.com>
Date:   Fri, 31 Jan 2020 22:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjZTUq8u0HZUJ1mKZjb-haBFhX+mKcUv3Kdh9LQb8rg4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/20 19:01, Linus Torvalds wrote:
> There are other (pre-existing) differences, but while fixing up the
> merge conflict I really got the feeling that it's confusing and wrong
> to basically use different naming for these things when they are about
> the same bit.

I was supposed to get a topic branch and fix everything up so that both
CPU_BASED_ and VMX_FEATURE_ constants would get the new naming.  When
Boris alerted me of the conflict and I said "thanks I'll sort it out",
he probably interpreted it as me not needing the topic branch anymore.
I then forgot to remind him, and here we are.

> I don't care much which way it goes (maybe the VMX_FATURE_xyz bits
> should be renamed instead of the other way around?) and I wonder what
> the official documentation names are? Is there some standard here or
> are people just picking names at random?

The official documentation names are the ones introduced by the KVM pull
request ("Table 24-6. Definitions of Primary Processor-Based
VM-Execution Controls").  In fact consistency with the documentation was
why we changed them.  On the other hand Sean wanted VMX_FEATURE_* to be
consistent with CPU_BASED_*, which made sense when he wrote the patch.

I'll change the names to match for next week's second batch of KVM changes.

Paolo

