Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C35C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEB420848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9AsXbA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBLLtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:49:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727279AbgBLLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581508171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JnelCP0BeqCKzB5HUK/Y879g+TjBn3kcCBi0brqpess=;
        b=A9AsXbA1wEDr7zwDzw2Qa5q2DX8OkC+S/qG0kf8tCKFEmEBNXYx84+9cGSJU2jBgyr+t0m
        65DoTRfX3zHaLAHXutJyBri6TOkIUeRPr1QAR5XVoPUBkNyyLbRnnkw5ex0pIZsm6lv6Oj
        T/RIT9zaY6GiYjjwv3EJjnWyaDzJVcQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-HoYJxD8BMWmGx4LcdzvKzQ-1; Wed, 12 Feb 2020 06:49:29 -0500
X-MC-Unique: HoYJxD8BMWmGx4LcdzvKzQ-1
Received: by mail-wr1-f69.google.com with SMTP id w6so704255wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JnelCP0BeqCKzB5HUK/Y879g+TjBn3kcCBi0brqpess=;
        b=FhC6joNu3bR+t/g8xXGlEzEmzssRG+oRY0EYZhLoURoAaP1MzmyJ4GI7/J+LoATWR/
         aUemnLRL5efgVzw1LF1RxD3nrpgiTvFZGjEyEOisyx2yWk6ohx3TDqjL5VAk75+Nq4od
         T2q7n3BQ1ux/eLdpRFeUeMQJsURYl4LKIvs4lVyle4X9iSzco0rR6Uuor4xOqIyDh4wH
         /+KpJVEOMZevgelVmlV9zbfh+Bh3uO+UXbc90dC3fubSSfYIRyfQAV9mRNR+YwEgu1bP
         bRDub2AY78BhlxwLY03XELpkgzSrrIQzzQVLs3Z981Lh8N0LRmXo4VwQ9mWWDshRWF7L
         XdQA==
X-Gm-Message-State: APjAAAVEX3Tw6xhp+7ObfOjm31+2oFgiXlQd+dgYsWbT788pEBRcZLEC
        aAPiJzuhT6Dvk/UYnH8h+VO71JDbw9CSq3LQ8E/XZ2RSJjJN2d86QY8YoFcFrLaVQXLfrywP348
        K7kM3k3jbJOwZLJbi0sFK4crx
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr14147906wru.233.1581508168430;
        Wed, 12 Feb 2020 03:49:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeI48yUIlfasjczSuSSNgiv99/Z58AUwqGUMZMkVGFbIwyZAB7OqaXkxrlubZ3ZIBd8MW2nw==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr14147880wru.233.1581508168206;
        Wed, 12 Feb 2020 03:49:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id m9sm318916wrx.55.2020.02.12.03.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:49:27 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: remove duplicated KVM_REQ_EVENT request
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
References: <a95c89cdcdca4749a1ca4d779ebd4a0a@huawei.com>
 <87h802g42r.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1386ffda-37c7-aef6-2ff4-f2b753b51af1@redhat.com>
Date:   Wed, 12 Feb 2020 12:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87h802g42r.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 10:05, Vitaly Kuznetsov wrote:
> kvm_make_request() from kvm_set_rflags() as it is not an obvious
> behavior (e.g. why kvm_rip_write() doens't do that and
> kvm_set_rflags() does ?)

Because writing RFLAGS can change IF and therefore cause an interrupt to
be injected.

Paolo

