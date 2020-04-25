Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6DC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3555820767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAw4PsmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYHVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:21:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgDYHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587799295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLnr0m2mVETKPeWfL0iYJ5elKQI3FKKirhJwNjsAap0=;
        b=IAw4PsmKvVqIb0sgcqESJbr1yewRHYspQhznWmWCCVYU+/7IkztRIc8b8xhS4pP2bUTP8F
        SiiVkL3k9hNEoy5cWZe529WHUjIAIekVL19tcX7m3RubB/4BtaY1PAa9AdwUeNqhvmWViT
        BCge8gJPr1s2EbREmxLp49hESUW2xF4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-IWcl8bnQNTG45zJE7g6zkg-1; Sat, 25 Apr 2020 03:21:34 -0400
X-MC-Unique: IWcl8bnQNTG45zJE7g6zkg-1
Received: by mail-wr1-f69.google.com with SMTP id s11so6317521wru.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 00:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLnr0m2mVETKPeWfL0iYJ5elKQI3FKKirhJwNjsAap0=;
        b=fQcXA4vDOMqOWgWmAQTETe98bEb5n6VxsrvUi9yChEtFMc1+nrLpW8lTPPrNlfZpF9
         i+nxA4yIK0yI7Cze2INeJGLRtQ8f7S2yMusXo0w6uFZW03e7YmfM1mJuBeue4Qqu5YE1
         /kmiKWxTnvzs2Qo4NTdFuIEVUo9ZCdqcqPuOX4JYldaIZsQ1pT369vewSLcEHt8mBWi0
         kyWDpcHPGTDCdhFgu5S1EuZtY3Jsno0/EjbJeDWeti76Ym4fqdWKM6zaQvaNxgIbmrTX
         /zlSOT66y+UO5938Ubs9+Be09K4AbeeUUXUsqQXn8MD2GNdaVnmzgWTtA/fFXafaBvo1
         pvMQ==
X-Gm-Message-State: AGi0Pua+phDtMehjKC+ICXAtorkJJG2h8vWQz7ht8kR76UCcidbgqdQ3
        cMaTveoE4oc2Xe/oqZLXFwceJ35Xy4fZiJhNqO5+A3scV5WfZJkqeQ1PIbGEr4lcndjUkr3+Asp
        I7Wis4lCvgUINxyYprLmU6mme
X-Received: by 2002:a1c:6402:: with SMTP id y2mr14852978wmb.116.1587799284859;
        Sat, 25 Apr 2020 00:21:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4JnN8XmD5Fqhx0zlOQUyNh6Q7sMfKC21sn7xaAJ7eING3tm0vPSCkfvnXY3alByn/09trCw==
X-Received: by 2002:a05:600c:218e:: with SMTP id e14mr15366922wme.140.1587799276137;
        Sat, 25 Apr 2020 00:21:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id w18sm11290918wrn.55.2020.04.25.00.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 00:21:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/22] KVM: Event fixes and cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Jim Mattson <jmattson@google.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
 <20200424210242.GA80882@google.com> <20200424210539.GH30013@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c92b29db-14a1-21f3-5484-23e308af4e99@redhat.com>
Date:   Sat, 25 Apr 2020 09:21:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424210539.GH30013@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 23:05, Sean Christopherson wrote:
> On Fri, Apr 24, 2020 at 09:02:42PM +0000, Oliver Upton wrote:
>> Paolo,
>>
>> I've only received patches 1-9 for this series, could you resend? :)
> 
> Same here, I was hoping they would magically show up.

An SMTP server, in its infinite wisdom, decided that sending more than
10 emails in a batch is "too much mail".  I sent the remaining 13
patches now (in two batches).  Thanks for warning me!

Paolo

