Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27987C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0594D2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWJo8TxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgEUNgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:36:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbgEUNgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590068204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/siY53tjkun6MuLncCOGE+QWvInBPs5eGByYgtd/XlU=;
        b=GWJo8TxPwtoFjvuDZZu5wCm9Jk37AghXOScgyaSqizOEy4pq01PeXf0MVW8cLfipL0oMSp
        eqc2zME6bzrvRWgfJrgyjaDNdXXwbq5doCtYIwkwYZ4TnUqaYm/E18HX4oK41nFXTYUxZP
        iBtwmsk/SdBBuMSejlS+V0aVtGhgL7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-SyuBraAaN1CmJVCIVzVmRQ-1; Thu, 21 May 2020 09:36:40 -0400
X-MC-Unique: SyuBraAaN1CmJVCIVzVmRQ-1
Received: by mail-wr1-f71.google.com with SMTP id z5so2912511wrt.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/siY53tjkun6MuLncCOGE+QWvInBPs5eGByYgtd/XlU=;
        b=mUwJ7bI9YjDahaRs7p9+ssMXnOgo7Ug4gdPbPtfO3gq0uZQuPHvWkq7xp1upSy/fEi
         iyNmBucq3zNu7G/wB8juKVUPxPweD23WZbQS96z2IGwbK8qjpFaWnhj0dW28nWwFNMX6
         mUntfyFEUt8n2eAhgQJj4LsxtnAP8vpB1WVvVa+Fl1VsoSjEtbwY1vWLx6HjKUujEXF5
         pNbnPUX/TCToX5XRglealR/hZNme1N0JHFLR+5Al/zSyESBI1fkunT+B1VB0vQr8EGNF
         BYHN52AKUUa1bUjQUe4gCYBZW+COvFTubOt7XrvS+MyXH6QilowswzR//YYkv2HspmM8
         ZMHA==
X-Gm-Message-State: AOAM533fAuKWLxqIsILolW2tQyh/A4RR6Iud6MhgzOhzUZbVvHvKoE+R
        iqEhY6HbeQ1XZUBHgjbdis3Flc7khptDVlqS2kRlPQFQfMCeHRUnRIMUtKa1n/gsXysWpIugzH4
        pvEzKbXzLRmLNA4oELgBI7chc
X-Received: by 2002:a5d:560c:: with SMTP id l12mr8376244wrv.309.1590068198820;
        Thu, 21 May 2020 06:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeIwRP/CqWrfPTPPPgHp/nwnuQ1RJeRbxx6qoua72G1WzxTHQr3LB6Ba62DOfYsQHz+Q0nXQ==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr8376228wrv.309.1590068198484;
        Thu, 21 May 2020 06:36:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
        by smtp.gmail.com with ESMTPSA id c19sm6723507wrb.89.2020.05.21.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 06:36:37 -0700 (PDT)
Subject: Re: [PATCH v3] kvm/x86 : Remove redundant function implement
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <HKAPR02MB4291D5926EA10B8BFE9EA0D3E0B70@HKAPR02MB4291.apcprd02.prod.outlook.com>
 <87h7w9skmr.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <629b1ca1-66a3-f616-71a9-3fda3b03aeb4@redhat.com>
Date:   Thu, 21 May 2020 15:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87h7w9skmr.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20 11:27, Vitaly Kuznetsov wrote:
> 彭浩(Richard) <richard.peng@oppo.com> writes:
> 
>> pic_in_kernel(),ioapic_in_kernel() and irqchip_kernel() have the
>> same implementation.
> 'pic_in_kernel()' name is misleading, one may think this is about lapic
> and it's not. Also, ioapic_in_kernel() doesn't have that many users, can
> we maybe converge on using irqchip_*() functions everywhere?
> 

Richard's patch was my recommendation actually.

PIC is not the LAPIC and not the IOAPIC; even though right now the
implementation is the same for pic_in_kernel and ioapic_in_kernel and
irqchip_kernel(), that's more or less an implementation detail.

Paolo

