Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB7A206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlgRQi64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFAJVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:21:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725838AbgFAJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591003305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuLK2sSn5CddFiGq7dQ41qvUoboLyFr4AuyNbWpmRVE=;
        b=WlgRQi64rupsUZsIt6GXIWniHTN0ge0W3L8al0gH4s3zbWjpUGH+AKn5spVU8fDUy+OIVn
        POmPE7zyvImjhFh2JSN8HS/BBfc+v7SRv7Iuj8qL5QkasZ9zuSF/p19YZ6/iFl5PbvVgJq
        FxcroLykBuTDHTvKTe72U7s64XHx0xw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-OKM_6Na_Pm6SCQu5GwgpWg-1; Mon, 01 Jun 2020 05:21:44 -0400
X-MC-Unique: OKM_6Na_Pm6SCQu5GwgpWg-1
Received: by mail-wr1-f72.google.com with SMTP id l1so4646309wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuLK2sSn5CddFiGq7dQ41qvUoboLyFr4AuyNbWpmRVE=;
        b=Wa54Zs8aEZNn0bV7+/wpAU2GUVLpTWcUeR7PPQdobSbEOpAXUNMwnUcHd8uVB+nrz+
         Y0joIKRrYoyMHY+WJoewYDCSdpMNSXj+RtoUnaDw5axBpgswybGE4SMUBTAv1Ft9OY2g
         XEMt9yTqZtIJmpijX/vTsUwaTacvGsMtPnwmpdTObw1wCSfhqNF7a1MTJNKA3EMGDHZi
         0cXqmM1fk3cGKs7Q3DUQokm/Ke1jGbN/RtYccGZPSjnevMKQEDhGFoi/OHrgt8MfDgsB
         YOYt02gqlWEKrV/o/Jfhw3nEVb5msmuhQ3HcfGeq7wCnCx08+NaLzPczj2SJku9qvE6M
         ekWg==
X-Gm-Message-State: AOAM530dPmvDZEMpPT/hUi+QrYLMNY1eT5ulYkdrPkDTjtyTo+E790K6
        HfuJ+zl2KHqN0LOWH7tEia4UgUSbimSkLzqtpSCyiiVIYzGzJdcDJCnORnUm4qV4f7KnO06bGe0
        ND8BuCe2TJWZmhL4vS+XOgzgM
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr20301256wme.71.1591003302913;
        Mon, 01 Jun 2020 02:21:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZjBowPYwC+DKgI4BRKZhXw+nZFZK73A3GMy1xVVIrdJTX5qghOe0isbEbZkUkMPrdG2E5KQ==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr20301235wme.71.1591003302659;
        Mon, 01 Jun 2020 02:21:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e044:3d2:1991:920c? ([2001:b07:6468:f312:e044:3d2:1991:920c])
        by smtp.gmail.com with ESMTPSA id d4sm19487104wre.22.2020.06.01.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 02:21:42 -0700 (PDT)
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Marc Zyngier <maz@kernel.org>
Cc:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
 <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
 <6965aaf641a23fab64fbe2ceeb790272@kernel.org>
 <d0bfb944-b50a-608a-7dcc-5a409cdc4524@redhat.com>
 <4337cca152df47c93d96e092189a0e36@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c72c597-732e-7dbf-d056-665674ec1792@redhat.com>
Date:   Mon, 1 Jun 2020 11:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4337cca152df47c93d96e092189a0e36@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/20 14:44, Marc Zyngier wrote:
>>
>> Is there an ARM-approved way to reuse the S2 fault syndromes to detect
>> async page faults?
> 
> It would mean being able to set an ESR_EL2 register value into ESR_EL1,
> and there is nothing in the architecture that would allow that,

I understand that this is not what you want to do and I'm not proposing
it, but I want to understand this better: _in practice_ do CPUs check
closely what is written in ESR_EL1?

In any case, the only way to implement this, it seems to me, would be a
completely paravirtualized exception vector that doesn't use ESR at all.

On the other hand, for the page ready (interrupt) side assigning a PPI
seems complicated but doable.

Paolo

> with
> the exception of nested virt: a VHE guest hypervisor running at EL1
> must be able to observe S2 faults for its own S2, as synthesized by
> the host hypervisor.

> The trouble is that:
> - there is so far no commercially available CPU supporting NV
> - even if you could get hold of such a machine, there is no
>   guarantee that such "EL2 syndrome at EL1" is valid outside of
>   the nested context
> - this doesn't solve the issue for non-NV CPUs anyway

