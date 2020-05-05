Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32554C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E3F206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOCKK9qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgEERWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:22:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35152 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730122AbgEERWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588699319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLBNUm/fluAXkFzdIYicKdp0CV+hI9Whe6Z74OvWRXA=;
        b=WOCKK9qmAGW/W4kNPJifS6UNnAdyf/8ruDXkpiSDUXTI6gSlgE78zW6SAngdQvE7eguELz
        cHdIl7Hzxd6k6XO/TvXP7znXxa034cV660rLiqOJvNvCU+RIvA5i1SZo9gkjx+CcY9WZlt
        nxxkkylpPT9htV70byFQ+RbUBMg6FWo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-Le0twJd5NsKJcygzbYXdcg-1; Tue, 05 May 2020 13:21:57 -0400
X-MC-Unique: Le0twJd5NsKJcygzbYXdcg-1
Received: by mail-wm1-f69.google.com with SMTP id w2so1381027wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLBNUm/fluAXkFzdIYicKdp0CV+hI9Whe6Z74OvWRXA=;
        b=sTtp2j3OzuJCBQRl2JvvCKU/q2SpIKq83Id56jAi54o3isOAbEfYR7TJVwLo0Pt0xY
         Rt0Dz/BONKxJoniQRFPR2HyISc2+mL8HA/TVEORKvMgogbJHidWr4MVydrigTExjc0pb
         90SO825rDymy1qeLCGVqO+6yM0AICdt5RMdinO2fVlO77JYXdzeFA3xFV6tYu0K/P2Tc
         u8Qz/r9ODAeUYoKxF0wgJETGG+5KWfuj/GCAB6mnPHXMQdnGRNLaqWFOSMK6syuttej8
         gNm/cgsm41IEECXHX7QLQE7qdegnn25s19Gkp6mMvWXoFDhk19Mh6R/qc0UDIgMiwayd
         7fuA==
X-Gm-Message-State: AGi0PubgEuBecv+nrSYCwQWRbTMoj5T2gRkJz2H4FTP1RmWBho0hflBF
        LqXKOiOr6j0TMR7UkmybxMIKo90WFpC+/AHfb0y5j2WAQpz1RteBNoriabN2rmwbMrOcwcv3S43
        0ML16Zd868jP32W+9c6q08Dnp
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr4600166wrn.137.1588699316440;
        Tue, 05 May 2020 10:21:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIVV+df8r3YAEgu8Bx29AN2Dhx6gB2SP3zMh8KI8zL75cn1CSbSYF73IUInRaU7M6AlZnT4Aw==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr4600142wrn.137.1588699316221;
        Tue, 05 May 2020 10:21:56 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id q17sm4693287wmj.45.2020.05.05.10.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 10:21:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     David Rientjes <rientjes@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jonathan Adams <jwadams@google.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200504110344.17560-1-eesposit@redhat.com>
 <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
 <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
 <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
 <alpine.DEB.2.22.394.2005051003380.216575@chino.kir.corp.google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6cfdf81f-caef-2489-0906-25915d9d58ff@redhat.com>
Date:   Tue, 5 May 2020 19:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2005051003380.216575@chino.kir.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 19:07, David Rientjes wrote:
>> I am totally in favor of having a binary format, but it should be
>> introduced as a separate series on top of this one---and preferably by
>> someone who has already put some thought into the problem (which
>> Emanuele and I have not, beyond ensuring that the statsfs concept and
>> API is flexible enough).
>>
> The concern is that once this series is merged then /sys/kernel/stats 
> could be considered an ABI and there would be a reasonable expectation 
> that it will remain stable, in so far as the stats that userspace is 
> interested in are stable and not obsoleted.
> 
> So is this a suggestion that the binary format becomes complementary to 
> statsfs and provide a means for getting all stats from a single subsystem, 
> or that this series gets converted to such a format before it is merged?

The binary format should be complementary.  The ASCII format should
indeed be considered stable even though individual statistics would come
and go.  It may make sense to allow disabling ASCII files via mount
and/or Kconfig options; but either way, the binary format can and should
be added on top.

I have not put any thought into what the binary format would look like
and what its features would be.  For example these are but the first
questions that come to mind:

* would it be possible to read/clear an arbitrary statistic with
pread/pwrite, or do you have to read all of them?

* if userspace wants to read the schema just once and then read the
statistics many times, how is it informed of schema changes?

* and of course the details of how the schema (names of stat and
subsources) is encoded and what details it should include about the
values (e.g. type or just signedness).

Another possibility is to query stats via BPF.  This could be a third
way to access the stats, or it could be alternative to a binary format.

Paolo

