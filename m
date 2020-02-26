Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A07C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94F206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6aoZy/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgBZLgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:36:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728134AbgBZLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582716958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1z8Vnv+ZSGKmMU3hkE2Z0QKdlZ3TU8dOb0I4zJBvWvE=;
        b=P6aoZy/fZybr3A83bkYucI7wEAa1POYZDg8i5YG7SGHr5o2yAP8SIFywrUWixA9ycVAFnu
        NIXHHCKjb1dwuA/vANab9L0B+OCuOrK25XF7lajwnApDZxQejps+M3mUDfPoLoXHryrFfh
        YZV5g7eQlIA9OWjYGq5/69Vd5dqnDZM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-u9a-ilMmMru25u6gV50_HA-1; Wed, 26 Feb 2020 06:35:57 -0500
X-MC-Unique: u9a-ilMmMru25u6gV50_HA-1
Received: by mail-wm1-f69.google.com with SMTP id d129so802711wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1z8Vnv+ZSGKmMU3hkE2Z0QKdlZ3TU8dOb0I4zJBvWvE=;
        b=krCZGSYlwshlTNLZ7yBxrEOAC4KQrTWAyvTeM4Ctz7iYLU/8IOlQDB7kSt7lCQfTfQ
         eHNBW2zyfGQWeDnP78GVER6xKLWZ1LVrlJRTm7XbJKpf+kc0qZVV585Ur0v0LfRd6m0F
         rRBbrrnn5CrK4tLTkV7Ocuo4KcRU3+hgGJ7bk00Pp7+tFaxJLYCgu7O3gcZcFQMY6c9k
         kJuciDdBDoTCN750zqrnGIhQQqReMi+oAvY8owv8sctZUnARNFFI3anoT5d7Nn5/gShR
         PvNJ2JiS37luRfx9nmfZiKBXmJA6jVaOjsaQ5FNEfg7CxMXPVjYEC2NQzZY2bKvnmJrt
         2JwA==
X-Gm-Message-State: APjAAAVkpl6mIqttL3Rc8meDJZpXuhB0Z4rjDU8gXQMHBG4tcw9ukUIf
        zrAznoYcMSItk6CA0My/27aL3RzTWiDTzMiJa1JCAvEa+NAHfVsWBKr9tOt9vf/AxK2hWwQKhG8
        I84+LGb7hELUW6w5NqHOGV7NH
X-Received: by 2002:a1c:610a:: with SMTP id v10mr4982383wmb.44.1582716955503;
        Wed, 26 Feb 2020 03:35:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBgaEfEsjp6JTaDjZIQy0AvKC++lUWandMWYKVxP0enkxb4qDBtTT08vOTi53OgQm1W9G99Q==
X-Received: by 2002:a1c:610a:: with SMTP id v10mr4982359wmb.44.1582716955261;
        Wed, 26 Feb 2020 03:35:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id e8sm2888683wrr.69.2020.02.26.03.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 03:35:54 -0800 (PST)
Subject: Re: [PATCH 43/61] KVM: x86: Use KVM cpu caps to mark CR4.LA57 as
 not-reserved
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-44-sean.j.christopherson@intel.com>
 <8736azocyp.fsf@vitty.brq.redhat.com>
 <66467dd7-09f0-7975-5c4e-c0404d779d8d@redhat.com>
 <20200225212242.GJ9245@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a214484a-f946-aab9-e503-fcd2cc4dbc0f@redhat.com>
Date:   Wed, 26 Feb 2020 12:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225212242.GJ9245@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 22:22, Sean Christopherson wrote:
>>> I know this works (and I even checked C99 to make sure that it works not
>>> by accident) but I have to admit that explicit '!!' conversion to bool
>>> always makes me feel safer :-)
>> Same here, I don't really like the automagic bool behavior...
> Sounds like I need to add '!!'?
> 

Either that or "!= 0", as you prefer.

Paolo

