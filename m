Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF38C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814CB217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhJ8EG6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBEOaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:30:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbgBEOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcBQTT6GLODG/bayLzSATYtu3RyNvIBwuV6XGUJB/88=;
        b=ZhJ8EG6tlK3+x7USJaSlwA0z/h+Np7Fjr8cgg1dnSiJNco3cW6yZHN/wlAc4DpwElDPATU
        BeF1uGg5LwYZa9RwiOY6MlxQ0r+Jrbj8UXpvWnXdzRa1U9gJhqO1yHuNuz4HGzw7xRNdQE
        PgHERMiVDPRVMVakQ8Rh7MUKLv4zp6k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-81hWvs_cPJ2d4O5Mf8IlWA-1; Wed, 05 Feb 2020 09:30:09 -0500
X-MC-Unique: 81hWvs_cPJ2d4O5Mf8IlWA-1
Received: by mail-wr1-f72.google.com with SMTP id x15so1257898wrl.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RcBQTT6GLODG/bayLzSATYtu3RyNvIBwuV6XGUJB/88=;
        b=HFM/59vSUoEtjydrJmIWLDb320sva3C9PKekCvQdHt4+uvKMHYwk6B1iCoIMC4q22Z
         gANM0vpLIQk8MLKLpHjxOcB/0K1i5ETQgId+E2brsHlOYuAYswBJqYIKjx6QRa/XNy6V
         apPotqZ0uUpJcRPCdOuXDnB4yfgNFlkk04nak37ccR8qqye/CrQyEhN0RS/1YvVVzLLI
         2TBDHfZZKTPWxh+6nj6W3fpISUBR+0fc93dOHGaGxy+FQrJKZbtGYeHsJl1L1I1d4Y5P
         Ji6otsACVzWh03f1fkiqwSa7YzdmTpclrMuyUv02HmuYlVzOKWK+6OtrLpCj1tixi1S/
         ztPg==
X-Gm-Message-State: APjAAAW1L27N6f2ZOuHGenUxbev42ADu2ohUpRFhOoBgseZgffq89KKf
        2lv+HdA9EYtmmWA0qCmwI4e1a5RptMWdxvAFfo8IIItPXJJlzNeYUQaGfjPhKTdAA/j3gP6k2Rv
        2AmNz9s223WJf8jgEpI0Y+y8i
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr28458456wru.173.1580913007777;
        Wed, 05 Feb 2020 06:30:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPyNlBB+QY4QitNu3rZNQx8P+4lrTaxsMdCLh9PQg7zNm4xD+igmbXS51wFovwRHZ40ooAKQ==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr28458439wru.173.1580913007609;
        Wed, 05 Feb 2020 06:30:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id v14sm16285wrm.28.2020.02.05.06.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:30:07 -0800 (PST)
Subject: Re: [PATCH 0/2] KVM: MIPS: Bug fix and cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20200203184200.23585-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b35c83d-07ed-00da-9fcf-d0d5594a1310@redhat.com>
Date:   Wed, 5 Feb 2020 15:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200203184200.23585-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/20 19:41, Sean Christopherson wrote:
> Fix for a compilation error introduced by the vCPU create refactoring, and
> a patch on top to cleanup some ugliness in the relocated code.
> 
> Untested, really need to setup a cross-compiling environment...
> 
> Sean Christopherson (2):
>   KVM: MIPS: Fix a build error due to referencing not-yet-defined
>     function
>   KVM: MIPS: Fold comparecount_func() into comparecount_wakeup()
> 
>  arch/mips/kvm/mips.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 

Queued, thanks.

Paolo

