Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1345C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C18A206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq6Ri3LT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFAIqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:46:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57027 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725290AbgFAIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591001212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C02MG+QK6H+u53KSuGOiYPyl9UBkarcNf8ZS3cPl7w4=;
        b=Iq6Ri3LTOeaX94iGhTm1zRdlgXLeDIyn6ohvxkr6dz4u0pRUEeOmHW/XM8XPOz9lHp6Tsq
        yBkKrDH/N3f1L7mZA9K7TJKDlMRIn6wfKqkAStRn40Kl5vqvAoB6j2G9ZWVpLm/ATGE5EP
        Q1qjSnrdOfBzqyigpAXbG51mFy/Z1Aw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-UXHr-a8dNFWjCp-B5K1k2A-1; Mon, 01 Jun 2020 04:46:50 -0400
X-MC-Unique: UXHr-a8dNFWjCp-B5K1k2A-1
Received: by mail-wr1-f72.google.com with SMTP id c14so4600239wrm.15
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C02MG+QK6H+u53KSuGOiYPyl9UBkarcNf8ZS3cPl7w4=;
        b=XhCBWDmb+eh4xwRF6KuhuzhxzWPMn1cBS+Gr/0d7EU0CTqrMkkpCuKWMNie43MCs2n
         W5Zx8b690LutwFeDlc5cvLd2SnIqeHeULpR5SlPseYu6pHEXtqU+cVONy5qh9bt9lmTl
         8QByMSya939fltNCIshaB5hRYuRjijW6oJ2i2gZdUad3GXdNwgGyDc/Foi+4a8gIXt0C
         2faPpdDk8MopSR9aLWtn0SZluIYJ4VJethtiZZy0IgjtmfeRu8sbnKlR1v01xG0yf3Qa
         /gqFfkyu8yItSrp/RBJHQgfNQFplKUF/pOOIkwiJaWPOiNfDc1MJNTK6fUMyBOaiSB6Y
         S7SA==
X-Gm-Message-State: AOAM530JkCek/TVrnImZ91phFXwZlYpZJSBgJJXqiSG2DhFRrPSdXFDv
        8inmN5ZK8P+3lLQ8zC23HWcXUtSC0lkHLbj004g0gixyB5zHNuh4osca+rPL72uhNFSXcY78BnP
        dJukiTcb820kJej3XtT9cL/s9
X-Received: by 2002:a5d:6305:: with SMTP id i5mr13517768wru.268.1591001209376;
        Mon, 01 Jun 2020 01:46:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEYY8mkL9Gi6Wprd77cQqEWyWHRjuAU8MMixFROUGrmjIE9m2xWDMlSexm+nSaLiFIQTBeWg==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr13517755wru.268.1591001209199;
        Mon, 01 Jun 2020 01:46:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e044:3d2:1991:920c? ([2001:b07:6468:f312:e044:3d2:1991:920c])
        by smtp.gmail.com with ESMTPSA id q1sm10003248wmc.12.2020.06.01.01.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 01:46:48 -0700 (PDT)
Subject: Re: [PATCH] KVM: Use previously computed array_size()
To:     Denis Efremov <efremov@linux.com>, Joe Perches <joe@perches.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200530143558.321449-1-efremov@linux.com>
 <0c00d96c46d34d69f5f459baebf3c89a507730fc.camel@perches.com>
 <6088fa0f-668a-f221-515b-413ca8c0c363@linux.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbf8741e-ede4-af17-309c-666b52883b17@redhat.com>
Date:   Mon, 1 Jun 2020 10:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6088fa0f-668a-f221-515b-413ca8c0c363@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/20 19:28, Denis Efremov wrote:
>> On Sat, 2020-05-30 at 17:35 +0300, Denis Efremov wrote:
>>> array_size() is used in alloc calls to compute the allocation
>>> size. Next, "raw" multiplication is used to compute the size
>>> for copy_from_user(). The patch removes duplicated computation
>>> by saving the size in a var. No security concerns, just a small
>>> optimization.
>>>
>>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> Perhaps use vmemdup_user?
> vmemdup_user() uses kvmalloc internally. I think it will also require
> changing vfree to kvfree.
> 

Yes, it would be a good idea.

Paolo

