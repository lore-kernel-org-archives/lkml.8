Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5698C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C42B207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+3Jq24P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFEIJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:09:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44844 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbgFEIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591344569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrVbv0LAvfoDVrxdU1Wp4ZS7+oUmRvbMHHEQQfIJrYQ=;
        b=d+3Jq24POlPaVoQ7KymsVIV/Rhuxw2/ApIfFv0S0ho4BUCb90ZTkrJX5AywNBgbdiJLDOn
        cSj42Ww1KSVYkf59rYciRCENbkigy4JGN2LSskrarJfkyYdmyhxbINgvr32HY0sNP93Zg8
        rA86o8ykPdPq/JZGFW19yxFmuI/nVY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-_g3o_KtqNdKZsXrJ-1xJmQ-1; Fri, 05 Jun 2020 04:09:27 -0400
X-MC-Unique: _g3o_KtqNdKZsXrJ-1xJmQ-1
Received: by mail-wm1-f72.google.com with SMTP id 11so2459519wmj.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 01:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QrVbv0LAvfoDVrxdU1Wp4ZS7+oUmRvbMHHEQQfIJrYQ=;
        b=fszq9fn6fSLB1fQRLbjthhfqZM8S012g9scoejwAXl/suwYJBzWq2wJKU7IZeFa4rT
         0gtEbbJyMeSAQf3VXhbjU7FyAbueAqOmd6XcH3mSAXSSdEK78XrTsfF/5qHRohtLDwZi
         69E7Wmm6rpCYNYxBSki/9W5dmH7odV5OmYU6ZegktV/OSNDdNPZe/nCu4ofrnufwvQ+A
         BbUq9qZC0kEd2+zobu/ElhQQkf9EBYQb3CizTrA6PtrLoPdtzyGTqfhzZ65LX3i27xt3
         Ejr50xL0uNlIr3rmaucKNmbmHciYzbJc++bb6KPQKT96+pUUkXgGr59t4GpteH3QaMaj
         TkjQ==
X-Gm-Message-State: AOAM530KOlmAK2Gic79RxgrGCEHWrC0fdSJwsloKtGYMW8U8E51wHSMi
        yu1AFZxq9NTE8tVYSEDqTsR/zJu+Xr+e65rwJ53o2nu2+ga6ewYTpJliSae470+0z0QRm++qRI6
        uaTdZL8B4tq10Ptbqnmg/3+DX
X-Received: by 2002:adf:910e:: with SMTP id j14mr3063156wrj.278.1591344566572;
        Fri, 05 Jun 2020 01:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIuVyoaDb2G7McATYKVs9RHDnOjJKTbctGFe7ylZ0JJN3Ab9BRicQxXsudMj+hwx2qABEvPw==
X-Received: by 2002:adf:910e:: with SMTP id j14mr3063139wrj.278.1591344566346;
        Fri, 05 Jun 2020 01:09:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id l18sm9796731wmj.22.2020.06.05.01.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 01:09:25 -0700 (PDT)
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <87pnagf912.fsf@nanos.tec.linutronix.de>
 <87367a91rn.fsf@nanos.tec.linutronix.de>
 <CAJfpegvchB2H=NK3JU0BQS7h=kXyifgKD=JHjjT6vTYVMspY2A@mail.gmail.com>
 <1a1c32fe-d124-0e47-c9e4-695be7ea7567@redhat.com>
 <CAJfpegvwBx49j9XwJZXcSUK=V9oHES31zB2sev0xwS4wfhah-g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c3c4a5a-e11b-1a27-0e25-9696e407bd0a@redhat.com>
Date:   Fri, 5 Jun 2020 10:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvwBx49j9XwJZXcSUK=V9oHES31zB2sev0xwS4wfhah-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/20 09:35, Miklos Szeredi wrote:
>> time(2) instead should actually be gettimeofday(2), which just returns
>> tk->xtime_sec.  So the problem is the nanosecond part which is off by
>> 2199*10^9 nanoseconds, and that is suspiciously close to 2^31...
> Yep: looking at the nanosecond values as well, the difference is
> exactly 2199023255552 which is 2^41.

Umpf, I was off by 3, it's not related to 2^31.  But yeah the cause of
the bug seems to be the botched nanosecond part, which I'm sure is not
supposed to be much bigger than 10^9.

Paolo

