Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924D220723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3AQZf/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgE2THv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:07:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbgE2THu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590779269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sj1og6Hwf3Hcvb9x+uY+l3GZoDhuJDM+q+4231YgpSA=;
        b=e3AQZf/GzRUcW8Tju1mLVt1RRVVYKzu0/PU0b37t9YawjSi7CETu/RXHOMwAizG8woMteF
        70vEpvqLCsS6yv6PHESRkxaEnzl2mO8ZEq+ocSpjD51y8vEr+oefUyIJLGDUFxcSZvzB3L
        Vb75VVm8W/FH9gHvAh1Ik8IEkfptgZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-YSXPmR4CP8WkWKjH-SF8DA-1; Fri, 29 May 2020 15:07:45 -0400
X-MC-Unique: YSXPmR4CP8WkWKjH-SF8DA-1
Received: by mail-wr1-f69.google.com with SMTP id e7so916372wrp.14
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sj1og6Hwf3Hcvb9x+uY+l3GZoDhuJDM+q+4231YgpSA=;
        b=jEYk7U24k2J2FEGCd1A9L7DjBo07uK6QcDy3XfSio/nB2lxbgGTodmO03bycWK04s1
         1/ntAds+fA1h290zl/0qWKJSKEBeGht2yuo3sobnD8m9qNu+MlXBsdgCDwUWH4XfTcQw
         JaC18wJDmn+nCGgu0Cb0nVLi8wateaQujKX4ywPkuT4Wfw4wti2EJRLD2jB0A9w6rAMR
         3/mmIi2SrGwF8kTcwiyAPf+5m50gkvRp7a7AMbG/UW7rU3yqbH+XlBjPq1vwD6zTLOcW
         478N1xISIRemKA0liddOa5TLCusAhzKJBhTLrR/oVU8FXtbId35ErusKPrRZuiXROAAb
         he0g==
X-Gm-Message-State: AOAM531rOjsoM7h0oZN13eVDiXVOOzBjDBdLanoMI0nczJhVudAVMOja
        hTj+dK+EqehnNFeJRcQX7jUbJ1FOv+pnkW0GBsOWCMebK/pI8cfmtxcc29CZMfPfmdgrk6mwQgy
        cv7umGirqZZh5WIvnN/aW88gT
X-Received: by 2002:a5d:4404:: with SMTP id z4mr9192642wrq.189.1590779264296;
        Fri, 29 May 2020 12:07:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJkiQVQRTm18QU+h2D02Bj+MAqj5rinTPXbInhtXnOTLdFsdU3oA0YRnoOfJ7PgrsXkB8Vow==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr9192627wrq.189.1590779264089;
        Fri, 29 May 2020 12:07:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id d13sm498222wmb.39.2020.05.29.12.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 12:07:43 -0700 (PDT)
Subject: Re: [PATCH v3 00/28] KVM: nSVM: event fixes and migration support
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529175939.GC1074@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff010a6b-e67f-1b09-db7e-c0985f3fcfb5@redhat.com>
Date:   Fri, 29 May 2020 21:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529175939.GC1074@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 19:59, Sean Christopherson wrote:
>> [PATCH v3 00/28] KVM: nSVM: event fixes and migration support
> You've got something funky going on with the way you generate cover letters,
> looks like it doesn't count patches authored by someone else.  The 'v3' is
> also missing from the patches, though I suppose some heathens do that on
> purpose.

No, I simply had a draft of the cover letter ready, and when I decided
to include Vitaly's patches I didn't update the subject.

Paolo

