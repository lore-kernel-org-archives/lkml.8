Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB3E2242E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/B5YPGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgFSXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:07:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730253AbgFSXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 19:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592608075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSUEEvPHg8lObb4w3f5YO1A3aV/mftn8qgOUKpTDcXY=;
        b=Q/B5YPGXdZORGNqWk0GIx+RV8RSzTmYiYGOq5Wv9zNdyB+V0q2gbJVg+FE6F6GZIG5OwPr
        wk0ayakO1i+6bLkE7YsYuG0C/Xplrl31uSgqOTf6Sm6oQCHMjceI353uWdEq21SDz/HXc1
        DDns6DxOBtQeS5SxZnLYUnj2FwGYfYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-322ypdpyNdyClo4eoop75w-1; Fri, 19 Jun 2020 19:07:51 -0400
X-MC-Unique: 322ypdpyNdyClo4eoop75w-1
Received: by mail-wm1-f69.google.com with SMTP id g84so4910418wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 16:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GSUEEvPHg8lObb4w3f5YO1A3aV/mftn8qgOUKpTDcXY=;
        b=V+130reXCf5w+Nm1NeipY5lLLROFyjzmsqYmE74776QiRKzUSgKKXnzjzFgZuTwUKq
         iU+fZkH3NdlDeWJ6ADqLlT8yoiYvR3htZAqFU1keggAzCt24Kvia5hyNHiS4KUFGbvgd
         F7TDH1IbgWXoOxmefSTCPvVtpj20BBEO+KctQE/W/9lNNKC7FQ6UKbJdHCZEXBe+Nh99
         QkdL2j5kICpjHFPefg2XoSQC0OA080T3Z7bYccAoHg02NS7hGnVZoBE+9pJx28hdLr2H
         1Y6KjuVb82gfubXVciABLPQWXS00gLDspKpAbG0B7lNglrGXv8/8PcJf/N+GIw4hjNqu
         IETQ==
X-Gm-Message-State: AOAM531GRuSepBOSVd3ALSaawOXgw0S+QVHhWG/4FpM5lmeVjnsFFVdl
        FxMFH/365W5+hw15Ly100oLJcOAs4cSZYJ3J/mGunDKrUHCTcseV3Af3gg9ibXjzJ5UbyoyQMxi
        LLtSiaY7nTsFvseGaNioZuOUn
X-Received: by 2002:a1c:544d:: with SMTP id p13mr6302396wmi.25.1592608070481;
        Fri, 19 Jun 2020 16:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu/JztVAYCCE55vZNqDpvaVxdrydq0oPQaM9B94p/nNj1BvYm/PY+IP5k5u5Z3b+ipgQzpGA==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr6302365wmi.25.1592608070215;
        Fri, 19 Jun 2020 16:07:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id m65sm7644751wmf.17.2020.06.19.16.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 16:07:49 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, babu.moger@amd.com
References: <20200619153925.79106-1-mgamal@redhat.com>
 <5a52fd65-e1b2-ca87-e923-1d5ac167cfb9@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52295811-f78a-46c5-ff9e-23709ba95a3d@redhat.com>
Date:   Sat, 20 Jun 2020 01:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5a52fd65-e1b2-ca87-e923-1d5ac167cfb9@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/20 23:52, Tom Lendacky wrote:
>> A more subtle issue is when the host MAXPHYADDR is larger than that
>> of the guest. Page faults caused by reserved bits on the guest won't
>> cause an EPT violation/NPF and hence we also check guest MAXPHYADDR
>> and add PFERR_RSVD_MASK error code to the page fault if needed.
>
> I'm probably missing something here, but I'm confused by this
> statement. Is this for a case where a page has been marked not
> present and the guest has also set what it believes are reserved
> bits? Then when the page is accessed, the guest sees a page fault
> without the error code for reserved bits?

No, for non-present page there is no issue because there are no reserved
bits in that case.  If the page is present and no reserved bits are set
according to the host, however, there are two cases to consider:

- if the page is not accessible to the guest according to the
permissions in the page table, it will cause a #PF.  We need to trap it
and change the error code into P|RSVD if the guest physical address has
any guest-reserved bits.

- if the page is accessible to the guest according to the permissions in
the page table, it will cause a #NPF.  Again, we need to trap it, check
the guest physical address and inject a P|RSVD #PF if the guest physical
address has any guest-reserved bits.

The AMD specific issue happens in the second case.  By the time the NPF
vmexit occurs, the accessed and/or dirty bits have been set and this
should not have happened before the RSVD page fault that we want to
inject.  On Intel processors, instead, EPT violations trigger before
accessed and dirty bits are set.  I cannot find an explicit mention of
the intended behavior in either the
Intel SDM or the AMD APM.

Paolo

