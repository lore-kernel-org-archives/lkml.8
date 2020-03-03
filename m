Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407EBC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AB4214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZkiPaPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgCCKO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:14:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728487AbgCCKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583230466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvzf1CSZ/TEF990OeJK7NBEzQ+DyFrhGwywL/pR36+4=;
        b=FZkiPaPDDmXhm9Q3x7dsRlOPk9kPgbaf6CotVurEa4/9iuxY7rsusuEAqoG5oV74V20DMH
        o7lrfxx4PoPY4Wyjg+qjB0NXJeUmv+h5OdrBVF4mAavJU8r9zVg717Q8RcC5FaHgvlsE6Z
        aZq0eosjTX6wjR52nlOE1dBhH0IhY+g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-1zcg2TdXNSS6VN_ZR6j15A-1; Tue, 03 Mar 2020 05:14:25 -0500
X-MC-Unique: 1zcg2TdXNSS6VN_ZR6j15A-1
Received: by mail-wr1-f69.google.com with SMTP id p11so1003366wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zvzf1CSZ/TEF990OeJK7NBEzQ+DyFrhGwywL/pR36+4=;
        b=ESMbQhSZDNnhqFaiRW03qWptFX2rj3aLlG4Fbc8IUOn/ActUPOl6KouZ7gpls2s3h0
         1xtUDVHLjI9gOofYjjdFgSwEAGuTMSR7Q7TzlOqeS3cqBdIHPyyteXQ0+VSEILpEvXVG
         tr4CA1GfYgd2nMAuUuh7xTjeKjuBYhSmBlemLH2iZ6bQag3p34Go/P6kkVIncFbH0+c1
         GBTbt8JIKABaJl2XP2/xXh1fb4KnjiXvLei/Fsa8JLOjCfaDjqgE+H3Q6p3ay3Qq1TFn
         FKli24QLlYoAmwArVN5m7cc+7P15bGsDTZZ+boC7bpQ6vuwwGf9+fdIUj0g3pjEJSwIx
         M0kA==
X-Gm-Message-State: ANhLgQ0gtt7Ml04AMkn85Ygb4yNznQvJ9upnftpD8lJR7btZ36bONKmS
        LE/6lCzfa47+URqqp2P77wkJHCI3+wW66BdCxZPcVSlLr0xM4W3JMLTLtQa4j8P+AnKgk1o4FeW
        bI/4S9Yr1xOqijX7xbnfJ/xV4
X-Received: by 2002:adf:ec50:: with SMTP id w16mr4917950wrn.9.1583230464305;
        Tue, 03 Mar 2020 02:14:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vseXwzRJRWHYUIecMU54GEpHA+26DLVXnuPkKPp0bTiVWztmQVuJDvBkDCn7OgKWFO8iwxdMQ==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr4917933wrn.9.1583230464031;
        Tue, 03 Mar 2020 02:14:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id 19sm3171981wma.3.2020.03.03.02.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:14:23 -0800 (PST)
Subject: Re: [PATCH 3/6] KVM: x86: Add dedicated emulator helper for grabbing
 CPUID.maxphyaddr
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302195736.24777-1-sean.j.christopherson@intel.com>
 <20200302195736.24777-4-sean.j.christopherson@intel.com>
 <de2ed4e9-409a-6cb1-e295-ea946be11e82@redhat.com>
 <617748ab-0edd-2ccc-e86b-b86b0adf9d3b@siemens.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ddde497-9c71-d64c-df20-3b4439664336@redhat.com>
Date:   Tue, 3 Mar 2020 11:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <617748ab-0edd-2ccc-e86b-b86b0adf9d3b@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 10:48, Jan Kiszka wrote:
>>
>> I don't think this is a particularly useful change.  Yes, it's not
>> intuitive but is it more than a matter of documentation (and possibly
>> moving the check_cr_write snippet into a separate function)?
> 
> Besides the non obvious return value of the current function, this
> approach also avoids leaving cpuid traces for querying maxphyaddr, which
> is also not very intuitive IMHO.

There are already other cases where we leave CPUID traces.  We can just
stop tracing if check_limit (which should be renamed to from_guest) is
true; there are other internal cases which call ctxt->ops->get_cpuid,
such as vendor_intel, and those should also use check_limit==true and
check the return value of ctxt->ops->get_cpuid.

Paolo

