Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1147A207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeLcycul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgFIIJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:09:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727937AbgFIIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591690179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmBfFa1okgL8mK6WpRu2kczX17zWDHtWXMl37dV2NG8=;
        b=GeLcyculw4muJ8iWPI1MzbbGOnkR3O7gNoD+cNL/NQhoiHqbejNIajeejhDwhZ1t8Krnxa
        ebkbRKFIf1pZhH1NmEWo1yiOjbtYpQDjkGB4DwY0rRcFaPTyXt8tis92TO84FfvE+N/Jgf
        B2LWHiIbjq/dkUspI4FkXYlhWoakFIs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-JNq6qwa5O-OVUh_0vNuWKw-1; Tue, 09 Jun 2020 04:09:37 -0400
X-MC-Unique: JNq6qwa5O-OVUh_0vNuWKw-1
Received: by mail-wr1-f69.google.com with SMTP id e7so8317487wrp.14
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 01:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmBfFa1okgL8mK6WpRu2kczX17zWDHtWXMl37dV2NG8=;
        b=LDNzuEiuywz0VYJzmgR0rPTh6U+F8BrF29hlztn3Y/ss6S0vXJofPXlp+kfIpTSb33
         DXt5w99Ay9rdfjf5DCBkzJerv1IM2EXA/DhR5Btk1+ptWA8yFQp51jrG50ZSM6A7dyTN
         bSJa2D3aqn6oC7hBjUys2+WxNAtWb4FKww0CEgYbqQbA0BFLi40NL+HBKF6J9au4cALR
         GofNcLOE+DoBBTJD7krorPk3WAeMnloasv59YUBWeGyc9Wj82BtSwiBDn2L6mxJJIHs0
         CNauiJwegu5q0ymCPekx1NWSO4h2qZmvq8RV8vHedHPsxzqqFJvgQ8/5oozuFFEpcl0Q
         FcLg==
X-Gm-Message-State: AOAM532vIgqY3WHBzIBdt7tseKJBDTrKQx5k4ezbuYCgs9NDb4y+pgzZ
        CH8lBy8obFWVQSjXkp80WCiszl9aCvGcCMTKfdDG7dOqcU2HLgvjcdTnOw1qSj6HcfHyhGsVPuM
        Qp700ViTyg8OMrSm+ZtbHTYm6
X-Received: by 2002:a1c:b654:: with SMTP id g81mr2738166wmf.128.1591690176235;
        Tue, 09 Jun 2020 01:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZUyacbcjJw4tmav0I1ZZnOB3ijdGOGFXBb6eJoHNcLp5aBfqt/RQaHL3CrTNgSXo1NaZNWA==
X-Received: by 2002:a1c:b654:: with SMTP id g81mr2738142wmf.128.1591690175960;
        Tue, 09 Jun 2020 01:09:35 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
        by smtp.gmail.com with ESMTPSA id w15sm2030017wmk.30.2020.06.09.01.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 01:09:35 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: fix calls to is_intercept
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200608121428.9214-1-pbonzini@redhat.com>
 <87wo4hbu0q.fsf@vitty.brq.redhat.com>
 <500129791dd00349acb5919d75fa9de7e0c112d1.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <196ae774-7237-94b7-3b50-399571f255d8@redhat.com>
Date:   Tue, 9 Jun 2020 10:09:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <500129791dd00349acb5919d75fa9de7e0c112d1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/20 09:30, Maxim Levitsky wrote:
> And if I understand correctly that bug didn't affect anything I tested
> because your recent patches started to avoid the usage of the interrupt
> window unless L1 clears the usage of the interrupt intercept which is
> rare.
> 
> Looks correct to me, and I guess this could have being avoided have C
> enforced the enumeration types.

Yes, another possibility could be to unify SVM_EXIT_* and INTERCEPT_*
enums.  For example we could have something like

	union {
		u32 all[5];
		struct {
			u32 cr, dr, exceptions;
		};
	} intercept;

and use __set/clear/test_bit_le() in set/clr/is_intercept.

Paolo

