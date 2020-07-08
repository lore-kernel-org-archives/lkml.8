Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D4206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9DffPXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgGHLJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:09:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728588AbgGHLJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594206566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkp2vvF47JADWAniwd4t8Rm/0+rP5emrFqHByZTUt54=;
        b=O9DffPXLLVe6BHUVlzDCSwNPOmRnUBfOTWPjZeI351JbuJqkz1eSNKtl5LDxKqJZQrWdRY
        P608dW1rJ7dMTHl3Cysa2wpHaLIGuLOvqIJwNJfmRriNC3HA8gnbTZJRvOBHpDqjlQnOY/
        IdsGftq93F0zIl7KoNqr+86eGyUeWic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-sZr6g8wiPN2Wt0kdu-QgGw-1; Wed, 08 Jul 2020 07:09:25 -0400
X-MC-Unique: sZr6g8wiPN2Wt0kdu-QgGw-1
Received: by mail-wm1-f72.google.com with SMTP id 65so2512208wmd.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 04:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bkp2vvF47JADWAniwd4t8Rm/0+rP5emrFqHByZTUt54=;
        b=MEQhkM+rmp//YoDcmXzGTnbQPzVAxdSsoLzwmd38dPZlIu+uXBwQZ26MrVAHMzvB5O
         OIHOBjMncukqKqJi4aZN+GO1nSbJClbZUH/dhNoAieNA9mYFuI3W/4vum3c6YNx3o4SN
         vKmI44egfFojAyuO24wx9p4ksfK1zSzGuK/N4VamFVTX1QLB5CdjO+PGNnZVdhVqLknX
         lgE/BaMHIgVv7QCN+ir+8DptCST0L7gz2eg+aZmCQ9qKkhXmsoB9zqtmrF6iF5gz8OhG
         ZopE7hubFUcBTgmDfGmv6qXfXVeUl2LUfSAbcqaC1fZ0qQYlPwujCkqERheH5vFQDQhx
         Dr4Q==
X-Gm-Message-State: AOAM5337maqL/Ft0yUChcmo2Mb7M4sBFBTmyAl1+QyvLzSp41Y4h6r5D
        He+HNmr8lCa9PvMWsevty+1z3AGEAo2UdMh3cVEA9USVNUF9ynquft+op7lKQFisTZ96z4YNG2P
        vm0JrV8GRNFbsXkJ70nzBzNB5
X-Received: by 2002:a7b:c3c7:: with SMTP id t7mr8321928wmj.97.1594206564112;
        Wed, 08 Jul 2020 04:09:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEEcsBpZcVOq/4PfVzjw7iAbK1Fw0+BulW9EE6scukH0TtmplhsJ9rA4gyk4IoPTBaC2Dx+g==
X-Received: by 2002:a7b:c3c7:: with SMTP id t7mr8321904wmj.97.1594206563845;
        Wed, 08 Jul 2020 04:09:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id f15sm5181481wmj.44.2020.07.08.04.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:09:23 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: limit the maximum number of vPMU fixed counters
 to 3
To:     like.xu@intel.com, Like Xu <like.xu@linux.intel.com>,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
References: <20200624015928.118614-1-like.xu@linux.intel.com>
 <8de3f450-7efd-96ab-fdf8-169b3327e5ac@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b50db05-759e-c95c-35b2-99fba50e6997@redhat.com>
Date:   Wed, 8 Jul 2020 13:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8de3f450-7efd-96ab-fdf8-169b3327e5ac@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 09:51, Xu, Like wrote:
> Kindly ping.
> 
> I think we may need this patch, as we limit the maximum vPMU version to 2:
>     eax.split.version_id = min(cap.version, 2);

I don't think this is a problem.  Are you planning to add support for
the fourth counter?

Paolo

