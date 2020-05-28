Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D2AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D4720888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2eTWFls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbgE1Kxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:53:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387926AbgE1Kxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590663211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THROXU06O8NObD/CvI2mO/QZizA3BtE1Fcaww6HOCqQ=;
        b=A2eTWFlszFZOaI3npx5B3/4av+2FHEaY7SBGNUAoW+sABNG1TqPWT6mhdeSkiMKH1D/abX
        8uCGCydKh9FU6nRIhIIA22MFCvPuf8PZ+RSOZWxU1/NFmA54i4lMhbx7kUCJcLHxGgm2zT
        3jJ25VBY1tbpDBPyDlszarNr3XZ2tDk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-7HPIga_1M1muqOSSNzSyqw-1; Thu, 28 May 2020 06:53:30 -0400
X-MC-Unique: 7HPIga_1M1muqOSSNzSyqw-1
Received: by mail-ej1-f70.google.com with SMTP id pw1so10002222ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=THROXU06O8NObD/CvI2mO/QZizA3BtE1Fcaww6HOCqQ=;
        b=Z/WvbyiWkoSivjK9refiKzuXj7hkzGCSk/RRwYZLCHu6xASCEng5fqj2JyBjUOS5O0
         7wror9lUlHZCmNM8FLJ37oc8at8ullsmCyzDEQ0Ks/IFgRdBKjSgR1zfWWgfy6x8u3qy
         z4AjPkDfD4NBrCeR/MFu0ny9JMbWYdSP+ExRsLTX07TMMLscH4IfRSi2IpCwUtuRd39p
         eoAY3b//+GgT4LHsZkGTA/9s8Bu0uUkva1/gs7T5eVyDMY0mC1NtS7uFVDq7tW1Jn7io
         FNWBcCJ9TeYH3nx7gqQLPdsCG4JliPMmcKdfkZG6tcyplzymXNkpFa92qu0N+V1Kb0cG
         Cfqw==
X-Gm-Message-State: AOAM531qll38DzsdYb2aNwLOVi0CQ5jn1QB+Fk5c/vFKBoq74MeUAO6x
        MfO1ZyPqLX4PFPgkH2IpU/8Vh6WyuQKFkWM8U5dkpnCzpZipLcn+7qRHQ2l+C8a6gcCI2cPNgkn
        cwLfrrob6InwnP/Vc6uhNQ00V
X-Received: by 2002:aa7:d0cc:: with SMTP id u12mr2450276edo.385.1590663208733;
        Thu, 28 May 2020 03:53:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxedx2WYnJYMDlOaUBBjXoew4r7E/DhBUsZ1oryjTyqUpxzgiFDrYyuhtNMmnqvf0J2iR/C7g==
X-Received: by 2002:aa7:d0cc:: with SMTP id u12mr2450257edo.385.1590663208543;
        Thu, 28 May 2020 03:53:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id z20sm3835520ejb.68.2020.05.28.03.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 03:53:28 -0700 (PDT)
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8b09c298fab15e2629c65e8ee98a8a29@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59904c11-6965-510f-4848-bc1e91af49fd@redhat.com>
Date:   Thu, 28 May 2020 12:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8b09c298fab15e2629c65e8ee98a8a29@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 09:03, Marc Zyngier wrote:
> The current state of the architecture doesn't seem to leave much leeway in
> terms of SW creativity here. You just can't allocate your own ISS encoding
> without risking a clash with future revisions of the architecture.
> It isn't even clear whether the value you put would stick in ESR_EL1
> if it isn't a valid value for this CPU (see the definition of 'Reserved'
> in the ARM ARM).
> 
> Allocating such a syndrome would require from ARM:
> 
> - the guarantee that no existing implementation, irrespective of the
>   implementer, can cope with the ISS encoding of your choice,
> 
> - the written promise in the architecture that some EC/ISS values
>   are reserved for SW, and that promise to apply retrospectively.
> 
> This is somewhat unlikely to happen.

Well, that's a euphemism probably.  On x86 we're somewhat lucky that
there's an architectural way for injecting hypervisor vmexit directly in
the guest, and we can piggyback on that for async page faults (which are
essentially stage2 page faults that are processed by the guest).

Is it possible to reuse EL2 exception codes / syndromes somehow?  (I
haven't checked in the ARM ARM the differences between the EL1 and EL2
syndrome registers).

Paolo

