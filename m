Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A039C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40356206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC1E/NSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgBURnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:43:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29152 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727655AbgBURno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582307023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRklp/EGbzKFbnLcWYfCTJYwspK96XjQokoDYirC2jo=;
        b=BC1E/NSYqNzfUh0RxMW6yxKtLq3K9WtvVA4og79JnwQCCL3SOa46rlgD1J/hvl5HJxwuKO
        VL/8hDJiMzD74rSHywZtCWnQkLHJ1cWnoNyi2WnzoiKN0lASV2MNERS7b2bI31Uqt81jal
        3Sy0x+6IsKl1ysmfReqrZB9DPq0hSxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Qe5uJ_sQNbOwbd1hyQSpUg-1; Fri, 21 Feb 2020 12:43:42 -0500
X-MC-Unique: Qe5uJ_sQNbOwbd1hyQSpUg-1
Received: by mail-wr1-f70.google.com with SMTP id u8so1332130wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRklp/EGbzKFbnLcWYfCTJYwspK96XjQokoDYirC2jo=;
        b=A7KmJgkvpenG5fm8JiichfI1Hb1OStX19BxMUbcwLlvCH2buL72+Xdmscl1tRj51kQ
         BapD4FHwLL4IonSq3YwfoFtdNlreK+L42H8sNzUzuFSC0RIdCPA4b1/AvJzS4E7yPqiJ
         u5oZxna+kRO7/NZSv2W6gyfBGMQgzFJSXisOQGiHmobHNoeohNnVs5nUZvdozM5w5oa7
         tJyGtdVk21Uismeuyh2ZriA6hXKBJS1aPAb/uIVvUwFtTCmlpEVXNchghe5txq/+AoYR
         Ajy+uChSA9Vw4CQ8GziQ0GRSBbwS0mMqwVhAMmebZMdwTyqR/WR5+5yAVEuW3TcAnxvC
         jx9A==
X-Gm-Message-State: APjAAAUyTGJrpZwFa9J58W3KhOa7jdu5Q0P5Pfc6bCIuAzIyqzH72+uI
        jXezEe5+JZkZJ6PcYkJpSM13kV4upRfjnjuVM9PmPlbbPmqcJjv//CZrAje2S7msd1MuOW9mIEk
        lZb7asmnwojXPhhFmRgEcnpPU
X-Received: by 2002:a5d:4289:: with SMTP id k9mr51196993wrq.280.1582307017029;
        Fri, 21 Feb 2020 09:43:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2hj716qxeeRUnhWk7oLWJU5fIlTs2+zZOl+uuyj1LRQkzfullhSLke4OG8g9MBweopRblWg==
X-Received: by 2002:a5d:4289:: with SMTP id k9mr51196974wrq.280.1582307016828;
        Fri, 21 Feb 2020 09:43:36 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id l131sm4908318wmf.31.2020.02.21.09.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:43:36 -0800 (PST)
Subject: Re: [PATCH v6 14/22] KVM: Clean up local variable usage in
 __kvm_set_memory_region()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200218210736.16432-1-sean.j.christopherson@intel.com>
 <20200218210736.16432-15-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1467b8cd-3631-b5da-b285-dbdf31b75af7@redhat.com>
Date:   Fri, 21 Feb 2020 18:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218210736.16432-15-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/20 22:07, Sean Christopherson wrote:
> -sorted by update_memslots(), and the old
>  	 * memslot needs to be referenced after calling update_memslots(), e.g.
> -	 * to free its resources and for arch specific behavior.
> +	 * to free its resources and for arch specific behavior.  Kill @tmp
> +	 * after making a copy to deter potentially dangerous usage.
>  	 */
> -	old = *slot;
> +	tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> +	old = *tmp;
> +	tmp = NULL;
> +

Also: old = *id_to_memslot(...).

Paolo

