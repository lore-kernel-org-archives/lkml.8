Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA96C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ED52072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SB5vQ4kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgCFFc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:32:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40825 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgCFFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583472774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Dg5l40fFklgiXW3Pi2JeGrXIz1t8W6lNvDgLqT7nN8=;
        b=SB5vQ4kWMcIfpkT9Nn0oXRqInC/tiI8mcC71YHZWuCM5YHDd0O/u7lezP+6JofVX+0JbJB
        kZYtXQ7vpaSHSqx7QS+3+eKrD6XOCni5DzVrCs9HIej2X8CNMnbI1CNxEU3AqhUIgVS8Co
        SS8HcIR5I5tvntG9GTgXiup6PC9Aqeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-4efOdl5kMQqWKF88EemGuQ-1; Fri, 06 Mar 2020 00:32:53 -0500
X-MC-Unique: 4efOdl5kMQqWKF88EemGuQ-1
Received: by mail-wm1-f70.google.com with SMTP id e26so221168wmk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 21:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Dg5l40fFklgiXW3Pi2JeGrXIz1t8W6lNvDgLqT7nN8=;
        b=KAuPr2EZloesi+7n9QxXA+26Y18e0LP429f3U1nM9p4zWMJGdmZfyjWYhstxEkJ7v9
         29a9wcwv4TQ6aLghkBZYxixlNAjLJk1atrHvW1BA1G7EZwOP01AIDX+kgPpm8KPKyMiK
         CF+EPPfOUvtLvM8JSZ+r8HZwK0p4TbqrDDUCoM1/1dfjg8uM77f2Q4Ez6U70d9ozc+sa
         XPJmHEA5qhfF5X8f2lhrpxU7mVNrdCQmFfDtrrZQ/VIEyusTKCUdq7gRfXaVrgfOBMYe
         AazjD/t80a0sk7Gi3ROmt4ud4nRtTWhBZ/rvwLAYX8S4lLSgcgtPOlK9vPX3lI33H6wR
         qRig==
X-Gm-Message-State: ANhLgQ3c1lGew62T7pv0g6JQrPhlCSLhf56hzLjdozPD+w/qON+co//W
        B44RR6/2Ci4xPJd11vawD7A7gzUPK1b5yShMeSsQLE/zw9FpFc9mGExIMA4i2nanHQdkUTXAxPN
        ON/ZNEqIidXpzcehyxzsrPCCa
X-Received: by 2002:a5d:4902:: with SMTP id x2mr2045481wrq.301.1583472772190;
        Thu, 05 Mar 2020 21:32:52 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsk/wfYFESgN2vEQJ3IVYE/ThGeS0U1JqD+oUUhMbb4iHplVb00stFd0EPUaYUZcTYTgaTK1Q==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr2045463wrq.301.1583472771981;
        Thu, 05 Mar 2020 21:32:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id b13sm12635205wme.2.2020.03.05.21.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 21:32:51 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: Use wrapper macro
 ~RMODE_GUEST_OWNED_EFLAGS_BITS directly
To:     linmiaohe <linmiaohe@huawei.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <f1b01b4903564f2c8c267a3996e1ac29@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e3f7ff0-0159-98e8-ba21-8806c3a14820@redhat.com>
Date:   Fri, 6 Mar 2020 06:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f1b01b4903564f2c8c267a3996e1ac29@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/20 03:17, linmiaohe wrote:
> Define a macro RMODE_HOST_OWNED_EFLAGS_BITS for (X86_EFLAGS_IOPL |
> X86_EFLAGS_VM) as suggested by Vitaly seems a good way to fix this ?
> Thanks.

No, what if a host-owned flag was zero?  I'd just leave it as is.

Paolo

