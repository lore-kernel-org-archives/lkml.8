Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6920870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4VKmwS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgCDHa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:30:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728216AbgCDHa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583307056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+pL0qsagmn9LfFxvyydb0rWSBt5iVBDnHKUDsA/QhY=;
        b=Z4VKmwS5MnB4I7qAuwjv3siYJ5PX/6g/bioX2sd4C/bCWM+niOvwvTtkZHKKov0v3MYSnS
        QaDAEZvjec3++9LKlP5/WAwVqEpelglZpw5pWx/yJ4KQurSgVl7yrY9XDZSSB5eRNUPQxd
        4QOuhh1lfG4a5B1iFyRQe/BDpcw3Qo4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-5D2zWrqSPGGp5ciQd4hA5g-1; Wed, 04 Mar 2020 02:30:53 -0500
X-MC-Unique: 5D2zWrqSPGGp5ciQd4hA5g-1
Received: by mail-wm1-f70.google.com with SMTP id r19so501761wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T+pL0qsagmn9LfFxvyydb0rWSBt5iVBDnHKUDsA/QhY=;
        b=lMW+EWzXnYVM8Th/r5tfqTJkUzqt966e1Mskv5MgHQHtwwQE7zgWnLQtl1kpKwXZTm
         v5fMHiTjNlf1FNtVmOnQ1zZsgmh1OJgDMdSdacMgrtJqJCSVdji2pOK/dK7VNZKt9+gh
         +VGR6ELZGZpjsiTRmoYVmCRarDcEOUazeEihRW0LPiZC87/Qs6x4LmD3UR0bi9n23U2c
         2OE7pzEQ8LzumMiTH3WZS9XW3ILs8l/3w/wFdOcSb9kd0k+37Jt8DiZvHLMgWJyI7ScU
         LYShGu5IuwIhaaypyLNtQi666atNYLXK/a2TfwL/TAJyk3/ZX1A0El8mvana6WUnO29Z
         rHJg==
X-Gm-Message-State: ANhLgQ3tOFTN9xASg/F/VcNycUmPjY2AVocUyXavSSI2Q664kSc/ILGB
        f1dc4tACRO4nQa+yjEaTN+GsJsAmluSUJgma99HKT9DLVvdcYUNaXJtGb0bsgKEhQ5NWS72VGld
        WI8fk8Qx1WxIPCQmxrmOqo1CL
X-Received: by 2002:adf:de83:: with SMTP id w3mr2620122wrl.275.1583307051533;
        Tue, 03 Mar 2020 23:30:51 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv7K67V4alYNIqMl5Oc+4PHTR4QkwUs8qWk5xxbODKt72wZPPLJw5c6TJwOAXFw7xm97bFOMw==
X-Received: by 2002:adf:de83:: with SMTP id w3mr2620105wrl.275.1583307051303;
        Tue, 03 Mar 2020 23:30:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id y3sm2982342wmi.14.2020.03.03.23.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 23:30:49 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Avoid explictly fetch instruction in
 x86_decode_insn()
To:     linmiaohe <linmiaohe@huawei.com>, Peter Xu <peterx@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <05ca4e7e070844dd92e4f673a1bc15d9@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <593e16d8-1021-29ef-11d0-a72d762db057@redhat.com>
Date:   Wed, 4 Mar 2020 08:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <05ca4e7e070844dd92e4f673a1bc15d9@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/20 03:37, linmiaohe wrote:
> Hi:
> Peter Xu <peterx@redhat.com> writes:
>> insn_fetch() will always implicitly refill instruction buffer properly when the buffer is empty, so we don't need to explicitly fetch it even if insn_len==0 for x86_decode_insn().
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>> arch/x86/kvm/emulate.c | 5 -----
>> 1 file changed, 5 deletions(-)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c index dd19fb3539e0..04f33c1ca926 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -5175,11 +5175,6 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>> 	ctxt->opcode_len = 1;
>> 	if (insn_len > 0)
>> 		memcpy(ctxt->fetch.data, insn, insn_len);
>> -	else {
>> -		rc = __do_insn_fetch_bytes(ctxt, 1);
>> -		if (rc != X86EMUL_CONTINUE)
>> -			goto done;
>> -	}
>>
>> 	switch (mode) {
>> 	case X86EMUL_MODE_REAL:

This is a a small (but measurable) optimization; going through
__do_insn_fetch_bytes instead of do_insn_fetch_bytes is a little bit
faster because it lets you mark the branch in do_insn_fetch_bytes as
unlikely, and in general it allows the branch predictor to do a better job.

Paolo

> Looks good, thanks. But it seems we should also take care of the comment in __do_insn_fetch_bytes(), as we do not
> load instruction at the beginning of x86_decode_insn() now, which may be misleading:
> 		/*
>          * One instruction can only straddle two pages,
>          * and one has been loaded at the beginning of
>          * x86_decode_insn.  So, if not enough bytes
>          * still, we must have hit the 15-byte boundary.
>          */
>         if (unlikely(size < op_size))
>                 return emulate_gp(ctxt, 0);
> 

