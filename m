Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F8C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2532082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCZGIOTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEGWVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:21:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25135 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgEGWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588890067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZoTGnbCXcMKyRQ9mPxmL7dzgnwDNH85/mAMTGS95ms=;
        b=aCZGIOTDCKV5xrC6ZjWZPgsnbX6Jw2wEKCKX3Y8XWDe4/j8Q8UJXfIPIFMhxrcNsWvpOY+
        D7AG/Kc5WfjRdpIw/ENZ1gy66nGosboZuWKSOhtCNqqApTKEhUrOJZTGtzVbNz+pNDaGFy
        8yEHCNz/CTpNu6drkem/94MSA7JLAXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-PRuNiEe5MlqPNDW4a1h3fg-1; Thu, 07 May 2020 18:21:05 -0400
X-MC-Unique: PRuNiEe5MlqPNDW4a1h3fg-1
Received: by mail-wr1-f72.google.com with SMTP id q13so4257008wrn.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AZoTGnbCXcMKyRQ9mPxmL7dzgnwDNH85/mAMTGS95ms=;
        b=F8DB1PpAMWCsS6wyzMBGJrTcI+8KsA1CKAR2zCnMJ27UMPl8bMuOY1spaYrGasuc37
         wtWSip0916mpB3IQ/ECVDd0HNue7QwHJ3nGrfROp8yoBPV4/9QcBhBRWkp14f/vvNBHV
         SvRn24qr08mjxRzMcDIgpWNYniMKQgsEyUeepmgUQvwgM9qdvZcuk6hfNpHlwfpPYvpG
         2K0gUJRbqM1UZY7vk3X3MDbe12G7/vPoFzRyUrBSeZYzZcHDF85Vj7dq1Qqpb6Y4J93H
         hQ9veHB7XUkaQtf4gtv3fm4ZL1MMNGre13Ff0UHzp9/EOtphGYtTNXALseFxGGuy6nkA
         pdSg==
X-Gm-Message-State: AGi0PuZGr2LXTegBgKfVUviinaVJizleTWUAnqkBZBuZVHY7hFv55Jwh
        eqikeX5+pT9L6K/IE4eJFNxgFt+uLDgqIc/1AVFS06CBEDKPIwoeW2TTXFZcz8vVhFcWY9ECR9w
        P02j2eGXCmpfd3jtNP0MSF50b
X-Received: by 2002:a5d:510f:: with SMTP id s15mr19666486wrt.103.1588890064409;
        Thu, 07 May 2020 15:21:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLUV4HMfiKwgurDoaoGbriEeAIIhW/Gxxjg07T2LtNMBH9vWdh9mS5ffncMlq2akBCU6Erg8g==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr19666469wrt.103.1588890064128;
        Thu, 07 May 2020 15:21:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id z132sm7704638wmc.29.2020.05.07.15.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 15:21:03 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] KVM: SVM: keep DR6 synchronized with
 vcpu->arch.dr6
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-8-pbonzini@redhat.com> <20200507182220.GI228260@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6e61be1-f1e0-59a5-f5a0-538c739d0805@redhat.com>
Date:   Fri, 8 May 2020 00:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507182220.GI228260@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 20:22, Peter Xu wrote:
>> -	svm->vmcb->save.dr6 = nested_vmcb->save.dr6;
>> +	svm->vcpu.arch.dr6  = nested_vmcb->save.dr6;
> The rest looks very sane to me, but here I failed to figure out how arch.dr6
> finally applied to save.dr6.  I saw it is applied in svm_vcpu_run() in the next
> patch, but if that's the case then iiuc this commit may break bisection. Thanks,

You're right, this needs a call to kvm_update_dr6 (which would go away
on the next patch).

Paolo

