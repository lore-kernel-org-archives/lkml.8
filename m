Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ECC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A592253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY3sGpvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgAUKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:25:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57410 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728792AbgAUKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579602333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTqyG9FV9F3Gftaw3MKdGBixjFpBO7jrDVlvtMm1XMI=;
        b=cY3sGpvdGP/yFrKeUX0RJTYa9ttK061iidnPkZDRRwkP+Pdk2IAH4geordMpIPUEkDdqYC
        Ufpe3GdRUabRr78IgtuCaEgjSnA1HdDv/3YRXsWeg/e/mgggQh/WyxUSJYnZcFBp84cXlS
        w6/mFg1XFABqWFx1oNoG/IyTXryrADE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-8r-xqDCqMl-4zjJqYrLoJQ-1; Tue, 21 Jan 2020 05:25:32 -0500
X-MC-Unique: 8r-xqDCqMl-4zjJqYrLoJQ-1
Received: by mail-wr1-f69.google.com with SMTP id d8so1100671wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 02:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTqyG9FV9F3Gftaw3MKdGBixjFpBO7jrDVlvtMm1XMI=;
        b=bup0mopU3cg8fb4aPs4fwbIKA/4yH5Mv74eQVhpvDPfMA02rVfbI2+sqD07icRBf2k
         Pv0MYo9wPgd92FlgI0v/HuemnT2ZqnA+tOSx8/iWX3NkUY+/9Xll88WCmgquE99Mi0H7
         y9ty5knC26d934sqBsvZ+0K+9v6xFVzYHr1aGo/7xeD6jdMuMFjAqiPotWlknKkHvN7l
         wal7kxOUZ1hmHLN1qgMb5WAdX8LQW4mkb8I7aqqwBwjK3AqrE8whme+71SYj5aedSYM2
         geHftK5mIy8UexLY/V6cXpiT3Ow9TAg4yo8f4nLGAWi144YbUgRT8hCf+YbPThYhNc2f
         dHYg==
X-Gm-Message-State: APjAAAXldHXXte9a7ABskBG+c8BQfzRsqqlM5UEwJMfmEFAkxQpfRFlF
        uIAHEydWL1bCVYVXgrGNAwuIculgg90yFg7PcA+D6zMVPQY7I0xK+na9C0zuzHh59orxU8WvFic
        05bE2nVRntZDmWMFeLGgVNPmw
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3638752wma.103.1579602331150;
        Tue, 21 Jan 2020 02:25:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5TapOgQyy7Hd7YKdK3/8GL73X+vODGmGxX65zJSEY6VdLBvTxmNhberwnJtChT/tzehYexg==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3638716wma.103.1579602330847;
        Tue, 21 Jan 2020 02:25:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id a14sm55297165wrx.81.2020.01.21.02.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 02:25:30 -0800 (PST)
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
To:     Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <22bcd5fc-338c-6b72-2bda-47ba38d7e8ef@redhat.com>
 <20200119051145-mutt-send-email-mst@kernel.org>
 <20200120072915.GD380565@xz-x1>
 <20200120024717-mutt-send-email-mst@kernel.org>
 <20200121082925.GB440822@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb6cb50e-738a-b1e6-a407-42c1228a6d22@redhat.com>
Date:   Tue, 21 Jan 2020 11:25:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200121082925.GB440822@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 09:29, Peter Xu wrote:
>>>> If we are short on bits we can just use 1 bit. E.g. set if
>>>> userspace has collected the GFN.
>>> I'm still unsure whether we can use only one bit for this.  Say,
>>> otherwise how does the userspace knows the entry is valid?  For
>>> example, the entry with all zeros ({.slot = 0, gfn = 0}) could be
>>> recognized as a valid dirty page on slot 0 gfn 0, even if it's
>>> actually an unused entry.
>> So I guess the reverse: valid entry has bit set, userspace sets it to
>> 0 when it collects it?
> Right, this seems to work.

Yes, that's okay too.

Paolo

