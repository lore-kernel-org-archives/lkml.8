Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0394EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99C721569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrzLAhDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBLMD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:03:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgBLMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581509035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SxLHhpjAQEJ0JP7IaO9lFnJo84SkkSk2cpXsVcdcUU=;
        b=LrzLAhDAmw0i6p6XnWITaLNmQyDHGH8Ws3q0caVKeQUyJQUnQ9cjehzgNBUniYUkdfyY8x
        i6AdHIA5N4GX39KFl5rgR5+errdeEKrX3KuVOz1T2q43S2XVujlGdiUxiUjTMAQr4wRa+P
        JniPs+aI2frfzjEH8CuJhkzHY1nwsuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-SyfMZ5WsOJijChX1u6fHRw-1; Wed, 12 Feb 2020 07:03:54 -0500
X-MC-Unique: SyfMZ5WsOJijChX1u6fHRw-1
Received: by mail-wm1-f70.google.com with SMTP id p2so864892wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SxLHhpjAQEJ0JP7IaO9lFnJo84SkkSk2cpXsVcdcUU=;
        b=gj+NOnEXVSO2lmTbQF+NcEnbd/8izPawwoAlCezHD+GIviiixZMREYPFCkcjg5/oYZ
         eLAIGp+ouXmfInHC+/Nhl9P4aXNCPZBiwg7uXn6aajPwhXymC0SrOgpjlrR+zuitQwzS
         sM3X+h9mdG//OHJemuT5+dR9UXZ5qyXPZmnK2xzfbbSKU4CAjd2ICtv+WncPobwBLILt
         +qpdaxeGd7CjO56OpD+VFExPS6AtYWlWnUSxm6oX7Sv+CL5tdrjm1ZK5nFza75ig5/xG
         lJwL9RC0ZMZokk+bgvChOIZWBanmJnRYhu+qC8/OmdYs/EsPyRDG0DumLJ3+knnzeWpp
         mWzw==
X-Gm-Message-State: APjAAAWhGWCvLe7CCdPmgAz54URuzqIOgLWkzRDLBbbiyVyUkjZlCn2m
        RceFKSwx4oy9MsVbGgbhCJNJ6Ip0rx5VMkLPZEt6dRogit5jGPWFsyVXvScIDd45HOatxOZYbDx
        iQ1cgT5qSKE0kib3x4IQlJ9Es
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr6424522wme.183.1581509032965;
        Wed, 12 Feb 2020 04:03:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFU8+3CC0ZZTfJ8QSvJAdfRn7RiZT5y+sES9vhIzRMzK18UI+o5Gg8Z/AzdcUapBUasMkkZg==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr6424501wme.183.1581509032767;
        Wed, 12 Feb 2020 04:03:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id e22sm418585wme.45.2020.02.12.04.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:03:51 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
To:     Eric Hankland <ehankland@google.com>
Cc:     Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200127212256.194310-1-ehankland@google.com>
 <2a394c6d-c453-6559-bf33-f654af7922bd@redhat.com>
 <CAOyeoRVaV3Dh=M4ioiT3DU+p5ZnQGRcy9_PssJZ=a36MhL-xHQ@mail.gmail.com>
 <c1cec3c8-570f-d824-cb20-6641cf686981@redhat.com>
 <CAOyeoRWX1Xw+iPX52uCZef6Rqk44d-niUTikH1qL-fRoaYJeng@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4445badc-ca82-e9db-2893-ff2a2a961160@redhat.com>
Date:   Wed, 12 Feb 2020 13:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOyeoRWX1Xw+iPX52uCZef6Rqk44d-niUTikH1qL-fRoaYJeng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 23:15, Eric Hankland wrote:
>> Yes, please send it!  Thanks,
> 
> I sent out the test a couple days ago and you queued it (commit
> b9624f3f34bd "Test WRMSR on a running counter").
> Are there any other changes that I should make?

Nope, thanks!

Paolo

