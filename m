Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6EA208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKvHhnMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbgE1KtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:49:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30487 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387981AbgE1KtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590662940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSHyppY1XpO/9eGOXVmynSt7C5Mi1ApHOoRfoxA27gc=;
        b=UKvHhnMey7MZMsuOgjOKK5UHyC/6qJHXqPvF5GGcnLXBPW52pScZfO2nB+D6U3Jr0+6rme
        9ogVN9AS2zKFBTPJmAX37kR2pWRWb33yKLp6pZTkAHBi+aZhMMib65AKNLiCyM4MzpS0iO
        fAvxs1Kw6P0DQalireQJ2GaYAqvDD3w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-8VQyFMT7M3uPWSn_DcnL7w-1; Thu, 28 May 2020 06:48:56 -0400
X-MC-Unique: 8VQyFMT7M3uPWSn_DcnL7w-1
Received: by mail-ej1-f71.google.com with SMTP id h17so3654048ejo.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VSHyppY1XpO/9eGOXVmynSt7C5Mi1ApHOoRfoxA27gc=;
        b=GnRZ3H5LaDCuaNMD8L8daLn4DOhSKR057IeB5yKicumqAPKKrvojzn6xsRE5wTKTU8
         chaquT1GwK/whm+GgZkhY8jUWJyNDHsErnhFrAp3POAewpEeTDsSZgxiey13fRX7gtMC
         aHfEMwteY6ihXdNfj5fJKWNUbQwODkTJqi37q0D+zqvjKJBV+i2Eju7b6UlGkNamqeZ4
         Afhc2nvXpBJ2fIdIt/kHb4BuQYujcK2ueAQ4rWXdYdOet/tBPC14ZRVsBKsCCnO4mjXJ
         sFVABfjL/B1Q4bviLdWu17CnTfrXbBATW+Wz5cH1yCROaKMBsHaqRyswu7KfzAiqrAaa
         OheQ==
X-Gm-Message-State: AOAM530vFpGlCBVgCQSEklRMKXnTUxJS1Gp1j0PYJ+lJdJTUADzUlsXR
        Q2zcgDlgThUqKYxPnylW8vcntxFZgjj9XnNaILjwBdL5eSG7qRVyxQ8KHKgpMtmqgHEbcIR1b9s
        Udl90GJd2nLSjojgxVu9iW8OX
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr2342892ejb.406.1590662935580;
        Thu, 28 May 2020 03:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFdxMkqeLHcH4ajH7tF56oPdNndquNFDl+4l5rFf/cP02xjCMi5+crYKrNqwLkTxQeEQjKEg==
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr2342873ejb.406.1590662935381;
        Thu, 28 May 2020 03:48:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id o21sm4709127edr.68.2020.05.28.03.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 03:48:54 -0700 (PDT)
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
Date:   Thu, 28 May 2020 12:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 08:14, Gavin Shan wrote:
>> - for x86 we're also thinking of initiating the page fault from the
>> exception handler, rather than doing so from the hypervisor before
>> injecting the exception.  If ARM leads the way here, we would do our
>> best to share code when x86 does the same.
> 
> Sorry, Paolo, I don't follow your idea here. Could you please provide
> more details?

The idea is to inject stage2 page faults into the guest even before the
host starts populates the page.  The guest then invokes a hypercall,
telling the host to populate the page table and inject the 'page ready'
event (interrupt) when it's done.

For x86 the advantage is that the processor can take care of raising the
stage2 page fault in the guest, so it's faster.

Paolo

