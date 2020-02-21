Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DCC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599902067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/tOdnvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBUQub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:50:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725995AbgBUQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582303829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NHqowpj9sFTIlaqI5W3sqbjgCgVgH/qVpq549i91vE=;
        b=H/tOdnvTlFn1uaQW5Vtlu/WXVJTJzjwAYaHQffgqYZ2asaM2s6N9QX2/x/dIo/MM4tgccs
        0whFU285wrQqqCHXIcyoD4EDjyHuAbFJQM20dHhcttewJukbgV5uxWhvuDzC5btuVl6GFc
        7tXa7a2Vwzv/FJZw/j5ocisOYvnNsyk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-Xqt5wManMemqtAWyAeLvhA-1; Fri, 21 Feb 2020 11:50:27 -0500
X-MC-Unique: Xqt5wManMemqtAWyAeLvhA-1
Received: by mail-wr1-f71.google.com with SMTP id o9so1266504wrw.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NHqowpj9sFTIlaqI5W3sqbjgCgVgH/qVpq549i91vE=;
        b=GjXtkTONGAiGR0oZGAdiJ59wDU6HGvIh3UDE60qB6L/uYe1xHAIo5ubOVIY5MMQDo3
         RatKyFw2L/r40F7jr41vzni0G6EBRk0sqZOnUaQ1Umj+HtCzKd/9GiE7PJrIb/R+jrHd
         uobjpYx8c8K9qAf8S5OQZDI8CC7pUNf/6D+qZvbHHCj06YoTGkHChg8FwdC8AG1EugFt
         bLjpsT5di/z6iQ/F85GB3FcsBJU7O9+AGk5fdC0IA5PJWciJqTsCRsmKH44kI9aVGy8d
         zNcspwEEwAFcgGwJTTHxyJ4EnAzNf6PgX7opZjWhrzFn+RTgsMQfiq7Z8de1Pp7ECKka
         4CRg==
X-Gm-Message-State: APjAAAW7nABv+lF40A34d8+0WYDhQb79gobxfqy7AaDBZeLDw6nRbhbY
        FWYm22SnWgNPG3NdSfEyJ5xTeDtjnhjjeJTjxErDnE6sfMArhVTcsSvtmDDz6YkQfIHzOgP/SZh
        DplXC6E8X5r7x9b7F1eEdVAxm
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr4736974wmz.105.1582303826390;
        Fri, 21 Feb 2020 08:50:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqymKzX64TWzubc4hSzd0fMC8UpF6S1vGssgHLycf1GMTwxlUdeu3kddyaomcTMKsPX4HPf04w==
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr4736951wmz.105.1582303825996;
        Fri, 21 Feb 2020 08:50:25 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id f1sm4614872wro.85.2020.02.21.08.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:50:24 -0800 (PST)
Subject: Re: [PATCH RFC 0/2] KVM: nVMX: fix apicv disablement for L1
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-kernel@vger.kernel.org
References: <20200220172205.197767-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71921ae9-56b2-2f1c-410b-f61c37db1a17@redhat.com>
Date:   Fri, 21 Feb 2020 17:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220172205.197767-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/20 18:22, Vitaly Kuznetsov wrote:
> 
> RFC: I looked at the code and ran some tests and nothing suspicious popped
> out, however, I'm still not convinced this is a good idea to have apicv
> enabled for L2 when it's disabled for L1... Also, we may prefer to merge
> or re-order these two patches.

I swapped the patches and queued them.  The basic observation is that
APICv is only about virtualizing the APIC, without any interaction with
the hypervisor's APIC apart from the IPI path.  So if L1 turns it on it
wants L1 and L2's APICs to be completely independent, and SynIC is
completely irrelevant.  All that matters is again whether the IPI path
works, and that is what patch 2 fixes.

Paolo

