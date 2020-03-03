Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29631C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6E22051A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4yCaacc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgCCQVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:21:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33820 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729382AbgCCQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583252475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCeZj5j9NdL7UBpxH3v0lLKGG3Zlc6FhMXze5Z03xF8=;
        b=T4yCaaccmNxkAIVlKsp1WIjbZjGsfQvFL9OOLfrUr3dPcogt1mjlZfuvEH47kBJGT/NQgL
        HQ4jsceMX4DwJJrsLWaIbfDRGjxWeAJHg1ekX1dVTZldjBStgJ5kCIJce4dLsId9b+GsCV
        vLvSL7CzQlai0XOyEt1DAESFBW49x0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-dj9gmoiLOFiDN80aXb1ckA-1; Tue, 03 Mar 2020 11:21:11 -0500
X-MC-Unique: dj9gmoiLOFiDN80aXb1ckA-1
Received: by mail-wm1-f71.google.com with SMTP id g26so858940wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DCeZj5j9NdL7UBpxH3v0lLKGG3Zlc6FhMXze5Z03xF8=;
        b=Dyyz6s3thC1SjDAdriZ282CsHV+bjuwOkgw9HIKunnYz43eZxJBk0EL5xfirW+FJHr
         8EXMg9IUNIdkLNgplXZLp+CjiXjsGHgMzAJuzotNaVvnpXiUOnGCflMDkUrdRWyfUEJL
         LXUmtoYo5r47XwnQRtyUMtjiydYwBkekgrQPiGpLwsdr247XF4QVVs6tLmrVz47mNb9P
         Uka3K2aFuFNSSkSKIhehFddumwBYjbtPyzJ1JsEhCbCvDYFOsCDt1YkNSS9QkAGQzmCi
         5ul8mp02dmGZEWr35NDBmXZe3euTE0uDPKuACgWis4zIMizc+YACTHPoQBEqxvgoa5WS
         Jd2w==
X-Gm-Message-State: ANhLgQ2fYd3N1JgdmNCQe/2YRMR33Iceq9jE7KSwZ12PXfrOZqnnW148
        qQwXTA7yHO0LrqVWk2sPcyG/wXj5p4OSojLY03IXLWQVoyZLPyEf9Yw0ZqkZst2KLPZxvAuL9RS
        1BUEIpm/cD5A7GC9fMq3dnlJF
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr6141666wru.293.1583252470205;
        Tue, 03 Mar 2020 08:21:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvsutRpekH5hSIMUkCUQL3Af25B6EYt6WV4MX0oXaABfru5qSw5Hb/cPaoCQBFFCRN89HfuKw==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr6141655wru.293.1583252469994;
        Tue, 03 Mar 2020 08:21:09 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id z14sm31327373wrg.76.2020.03.03.08.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:21:09 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: x86: clear stale x86_emulate_ctxt->intercept
 value
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Bandan Das <bsd@redhat.com>, Oliver Upton <oupton@google.com>,
        linux-kernel@vger.kernel.org
References: <20200303143316.834912-1-vkuznets@redhat.com>
 <20200303143316.834912-2-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f933f77-6924-249a-77c5-3c904e7c052b@redhat.com>
Date:   Tue, 3 Mar 2020 17:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303143316.834912-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 15:33, Vitaly Kuznetsov wrote:
> Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
> init_decode_cache") reduced the number of fields cleared by
> init_decode_cache() claiming that they are being cleared elsewhere,
> 'intercept', however, seems to be left uncleared in some cases.
> 
> The issue I'm observing manifests itself as following:
> after commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest
> mode") Hyper-V guests on KVM stopped booting with:
> 
>  kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181
>     info2 0 int_info 0 int_info_err 0
>  kvm_page_fault:       address febd0000 error_code 181
>  kvm_emulate_insn:     0:fffff802987d6169: f3 a5
>  kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
>  kvm_inj_exception:    #UD (0x0)

Slightly rephrased:

After commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest
mode") Hyper-V guests on KVM stopped booting with:

 kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181
    info2 0 int_info 0 int_info_err 0
 kvm_page_fault:       address febd0000 error_code 181
 kvm_emulate_insn:     0:fffff802987d6169: f3 a5
 kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
 kvm_inj_exception:    #UD (0x0)

"f3 a5" is a "rep movsw" instruction, which should not be intercepted
at all.  Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
init_decode_cache") reduced the number of fields cleared by
init_decode_cache() claiming that they are being cleared elsewhere,
'intercept', however, is left uncleared if the instruction does not have
any of the "slow path" flags (NotImpl, Stack, Op3264, Sse, Mmx, CheckPerm,
NearBranch, No16 and of course Intercept itself).

Paolo

