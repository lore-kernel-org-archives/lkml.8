Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF8C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88285206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdL0v/ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgCPQtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:49:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44740 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731665AbgCPQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:48:59 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 12:48:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584377338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJ0Dh7UwY9/JBhA8PMSrlRvaVmrVnOei0kD1wp+5Gzw=;
        b=gdL0v/ZWNl1KsPa6+NNqOiaNdOGQl8mZ3NArBj9l3A3pN7P3HCHlJkS0RvkCBpCxJZ2Whi
        mhUJeSPpijLKsyEg2Ws12XOvTHR9ZRnktKTpMW6CXzQQJGK8mNaJtQA+2AzfTu2kKmdWzH
        5Dm0NxjHEHV8DNm/G3JKz5jCm+JyYXs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-mIG9uFeXNB6uEn8bMyH3eA-1; Mon, 16 Mar 2020 12:39:39 -0400
X-MC-Unique: mIG9uFeXNB6uEn8bMyH3eA-1
Received: by mail-wm1-f71.google.com with SMTP id p18so2002070wmk.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qJ0Dh7UwY9/JBhA8PMSrlRvaVmrVnOei0kD1wp+5Gzw=;
        b=DMgqYa0Mpesas5pRHt+nPhBvYN8J6cXWwPCJw3t2suzGTsMS5FqQfDwMay55Cyccv8
         hEw89g1pTsBw0CBIYWy9RnGbo9pTVZQOxF+YnpfQrYfOoiy3q17koAiNEP3QJpRWLxU+
         AVRYfXfinTBIGeZSU/hy2u9W0UDa9O7+Y/bLd81K9yVZmTGIE752xVTjG9yBc/mr7Uec
         ldkpcGhNZeh4cVBl0FRBvcriTQd+HmnsnOFBATSSYTQHuPM+C+i9HfE6ypbRdQhtXe4K
         Au6QLKnqrtZ04TRPxC/uSs3KyQWHKlxtj1f0hGiDhKtA7lZBI3s35CccR0vIjkNASUZq
         xtLQ==
X-Gm-Message-State: ANhLgQ1JNRA5SACNlB3cZ73osDA4l5Xa3TUWmkTQFW0dJ+YxJhRGxzMP
        AGePoISTtub0DxiKqwKh+OX2Z4Wxrp1/u09Fgmf/+yK/eFLojqES4JM5e2DRHAm8DQnHu8r5lYj
        teHE+c2Jc7vD+EHYaN+k1AB6i
X-Received: by 2002:adf:9307:: with SMTP id 7mr198223wro.171.1584376778098;
        Mon, 16 Mar 2020 09:39:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuKIEKBn5OJ0vxo6JLB1xdXH+6qMUW1IHmoNonOU1p4vkVSNPtTBCf6jdRflKCnpsGtQo6veg==
X-Received: by 2002:adf:9307:: with SMTP id 7mr198208wro.171.1584376777886;
        Mon, 16 Mar 2020 09:39:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id n10sm694062wro.14.2020.03.16.09.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 09:39:37 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: correct meaningless kvm_apicv_activated() check
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1584185480-3556-1-git-send-email-pbonzini@redhat.com>
 <878sk0n1g1.fsf@vitty.brq.redhat.com>
 <20200316152650.GD24267@linux.intel.com>
 <87zhcgl2xc.fsf@vitty.brq.redhat.com>
 <20200316155911.GE24267@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb1037c8-fdb5-4f4c-4641-915c0e3d01bc@redhat.com>
Date:   Mon, 16 Mar 2020 17:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316155911.GE24267@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/20 16:59, Sean Christopherson wrote:
>>>
>> 	if (!!old == !!new)
>> 		return;
>>
>> to make it clear we're converting them to 1/0 :-)
>
> All I can think of now is the Onion article regarding razor blades...
> 
> 	if (!!!!old == !!!!new)
> 		return;
> 

That would be !!!!!, but seriously I'll go with two.

(Thanks for giving me a chuckle, it's sorely needed these days).

Paolo

