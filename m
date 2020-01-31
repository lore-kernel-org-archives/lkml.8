Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92780C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6679C214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2ypfFLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAaV1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:27:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbgAaV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580506052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FU2nxODLdOz7Yi+32+hHI/RXv+nZoblPZOI/rmsa0cA=;
        b=P2ypfFLqk1lw11BlnG/iuI5LWyVQibZOnIQbkkUKLHW4v9/V8KDpRhaZ/VbQdAsn06GO+c
        KwxRVtp/uX2qqtI0GlIh8tW8nGn69VyXZv8XO1vv/z4j5Rsm8lYjiUILmNq9qvOUnTSczp
        Kq0do7DtG95tcF4VdDG3fi5lYtJbdko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-MHrwNeVjO_eTwG2xGMwzLg-1; Fri, 31 Jan 2020 16:27:28 -0500
X-MC-Unique: MHrwNeVjO_eTwG2xGMwzLg-1
Received: by mail-wm1-f69.google.com with SMTP id n17so3392961wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FU2nxODLdOz7Yi+32+hHI/RXv+nZoblPZOI/rmsa0cA=;
        b=PSoULau9ouHkYe2il+zBxb8rkUJ4hZJjbwqXaeF0psstpQfKOKdM3mS9nZ+nAYw4n5
         TFPXHt82TGP+hqoMB6mqGsY7sCRqqdz9dB72kr2RB1v9VKFjNJdQHAeKSDG3DRE24DXJ
         17mfzHFF+2iDsnW3OEWgJJTpGqwHUOTUNrVjyEFMNRPEOMcX5u/WtVe72/pmJVJh4Rvz
         33V6i1okwPhyP2ge5XFXLSl/Cw69k9QbPiu3R4SeoRKHpWSiJKVUX/Il3/hnm54ZT5lT
         GQAsEKVlkTfpqUQhDwxVpHGogKRz0pOk0m0MswNCOIAwhtMt8m6UeiV6qSd8qodNq7LM
         Q4AA==
X-Gm-Message-State: APjAAAWFo1+XHtQUUpaFAQJHVKIsvA6ok3erJVhazo3s80OpgMM006sU
        42WR1k4u+N1k0O8szb0jk2SPqpwnjiVaEUbO3+ckaVFUew2qmAK3JiDoXpJM+KFN/24ApxVfMpM
        QX8RVS1lzvX0nA02ah2MYaTap
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr13985468wme.161.1580506047670;
        Fri, 31 Jan 2020 13:27:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDuT1Hr2oALN/34Ebj0g8Dpq0xQbqotT/kxpAEYNH3SraZ1fzxVmsS+FAPdBhXC0oAT3CUXQ==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr13985457wme.161.1580506047457;
        Fri, 31 Jan 2020 13:27:27 -0800 (PST)
Received: from [192.168.42.35] (93-33-8-199.ip42.fastwebnet.it. [93.33.8.199])
        by smtp.gmail.com with ESMTPSA id s8sm12589059wrt.57.2020.01.31.13.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 13:27:27 -0800 (PST)
Subject: Re: [GIT PULL] First batch of KVM changes for 5.6 merge window
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <1580408442-23916-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wjZTUq8u0HZUJ1mKZjb-haBFhX+mKcUv3Kdh9LQb8rg4g@mail.gmail.com>
 <a7038958-bbab-4c53-72f0-ece46dc99b4d@redhat.com>
 <20200131212404.GD14851@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0e15553-e8b6-0624-3978-d2ac02a4d06f@redhat.com>
Date:   Fri, 31 Jan 2020 22:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200131212404.GD14851@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/20 22:24, Borislav Petkov wrote:
>> I was supposed to get a topic branch and fix everything up so that both
>> CPU_BASED_ and VMX_FEATURE_ constants would get the new naming.  When
>> Boris alerted me of the conflict and I said "thanks I'll sort it out",
>> he probably interpreted it as me not needing the topic branch anymore.
>> I then forgot to remind him, and here we are.
>
> Damn, that was a misunderstanding. I actually had a topic branch:
> tip:x86/cpu and was assuming that you'll see it from the tip-bot
> notifications. But they went to lkml and you weren't CCed. And
> regardless, I should've told you explicitly which one it is, sorry about
> that. I'll be more explicit next time.

No problem, it's fair to say that we both did our best to mess this up. :)

Paolo

