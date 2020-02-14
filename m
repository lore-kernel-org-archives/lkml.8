Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FAAC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6D20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjSTP/HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgBNTd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:33:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42755 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729320AbgBNTd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581708836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPIixaZTo637w7gbAg5h94awMsbkxhmjz3SnYWa8Jks=;
        b=bjSTP/HCFuhaecWzhahd+F/5gqhCxIeE8GEg7+e7gp2l2OFCM1ch2bhvwLSNNkLtbdGxtl
        2N5LCI+3P4agYa+i6wgLNl+tZdjgtXGZ7ikTTC+mhGrFaKh6Fw3XHOZiySqYKR96cCuA3A
        9gIVovTezzb10hhVFLzUEQnUd9riIQw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415--ygJutY7OAOLG-oYDvBUAA-1; Fri, 14 Feb 2020 14:33:53 -0500
X-MC-Unique: -ygJutY7OAOLG-oYDvBUAA-1
Received: by mail-wr1-f69.google.com with SMTP id 90so4575568wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPIixaZTo637w7gbAg5h94awMsbkxhmjz3SnYWa8Jks=;
        b=YZ7XdznA1j2E2HmHoP7xM8fIIskza+d8+CKuTmy7rd26+9KZJQoXOGyNugvPoWLjFS
         hnPwPdZ4UO4t/HaS21YECBpze9ZW1+lgOLsQS7ktJJWrZ+5RKzJ68sOS28rt2i5xrr44
         O8KiCx6CMF9Mt58+h79k1u6lDZR8A4mhSr7WGpQZPFYpMw4UtNErrktZP9ayVlFbYCjp
         X8NGQ9FtjXmOjKi0gnxFQYZ4GjgCMb/V93rKHAZ2okPO5hCVaCfeGveKRAsSSnHFnOg7
         FZi2LNLoSVXOOCFISwR+T9+9t35hzBMlTdUIZyC90AdH6eNFPm+BE9CWN9ki793YQDtY
         X9Hw==
X-Gm-Message-State: APjAAAUvdNSeCu7Zak3EMjEGZzr01jZIUKHxtM8NWJn63ovOq7ZOpNMi
        ePAI7BLe4WVQbG9uwE5l31TCwmyE0erw/Im25vruk99Up3djMyefzsPYGk7OfNxQwtnkWIfDw2x
        TSkAEj+nEArY+CI6gnD6MSFS+
X-Received: by 2002:a7b:c851:: with SMTP id c17mr6052190wml.71.1581708832401;
        Fri, 14 Feb 2020 11:33:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsT15BbBlGYbrQrK/pBOJv6OOjWJfid3u8re60HHU3WUA4qE5D4E03zTsBQdyB9S0kA4ZJKw==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr6052168wml.71.1581708832179;
        Fri, 14 Feb 2020 11:33:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id t81sm8513936wmg.6.2020.02.14.11.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:33:51 -0800 (PST)
Subject: Re: [PATCH] kvm/emulate: fix a -Werror=cast-function-type
To:     Qian Cai <cai@lca.pw>, Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1581695768-6123-1-git-send-email-cai@lca.pw>
 <20200214165923.GA20690@linux.intel.com> <1581700124.7365.70.camel@lca.pw>
 <CALMp9eTRn-46oKg5a9h79EZOvHGwT=8ZZN15Zmy5NUYsd+r8wQ@mail.gmail.com>
 <1581707646.7365.72.camel@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28680b99-d043-ee02-dab3-b5ce8c2e625b@redhat.com>
Date:   Fri, 14 Feb 2020 20:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581707646.7365.72.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/20 20:14, Qian Cai wrote:
>> It seems misguided to define a local variable just to get an implicit
>> cast from (void *) to (fastop_t). Sean's first suggestion gives you
>> the same implicit cast without the local variable. The second
>> suggestion makes both casts explicit.
> 
> OK, I'll do a v2 using the first suggestion which looks simpler once it passed
> compilations.
> 

Another interesting possibility is to use an unnamed union of a
(*execute) function pointer and a (*fastop) function pointer.

Paolo

