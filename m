Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A22C83008
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939382072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euDAA9Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgD2Kxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:53:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgD2Kxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588157618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gj8fIWPa2CeyWIO94x3oC1OAlW1QijlTfsM+igUr3wo=;
        b=euDAA9LcrfMGYE5h3ub1k8IglrRuu15cOPI6Ub6HFqWpkbBoXlY0LrUYcvM9OEDMkIabo5
        I33liij2mPD1WxDF80Jy7011Qi+xxpHs9CAa3Z99sFBojfNmN//TMTsgK4NUrTVgFpMixF
        uXsFrAjqgiC+cMvyAvLGgZxS/IdsI9c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-hjzCj0HGM4i8Jz5Yj7H8Kw-1; Wed, 29 Apr 2020 06:53:36 -0400
X-MC-Unique: hjzCj0HGM4i8Jz5Yj7H8Kw-1
Received: by mail-wr1-f71.google.com with SMTP id m5so1517078wru.15
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gj8fIWPa2CeyWIO94x3oC1OAlW1QijlTfsM+igUr3wo=;
        b=k66dTSD6f57uk2lpSC3RMwr/Ps0orzmG+pjn/TMqSVsmJNzUCFZnwj8OeAJT02yg88
         x0kmjoV7NA0ZbTHLg1pJAuebjU5t9zdJ+8mQXqxeJhLmCh5AbA0J9HQNhd/OVhPQgl/f
         ZGdXtWQK39lHBfHYJtx3YoXSkwbH1pa1YoMNxhLNIaaLHkxvTIe+HW9vBrM9gG0LU05T
         svEbRwo/w8T2+Nbj1HATmv1KLvG8v0CqFXRcqTOzc0ITGp896/wADNhNRGfc8f96PUgM
         nNws5/AW0BSz74goPJWtmDNliYqY5zpeKoI12jTQnIslKf4IP9GqWS1KR8E7NLBlwIht
         De7w==
X-Gm-Message-State: AGi0PuaLNo4jbiHJcyyLnjfws5BT6dhwMvlcg3UC88zKmSKPeuA8jo5A
        l6DSjpqV47Hx3hTqyN45Z/zsb9FqmT5H0hGLFY4CATWd/VItG55hvM7ChtL7Wd3z7T1ZqKSysz+
        Q5owGt0k8GentZEVOqMUZYqV0
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr2726812wml.133.1588157615287;
        Wed, 29 Apr 2020 03:53:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypIpa3WPxNCQZbis9Xa4WSbuWEW/EHTeU5IyoGtjsiOXu0kixJo8iOl1+UjOd46HemWzC0wBrw==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr2726791wml.133.1588157615060;
        Wed, 29 Apr 2020 03:53:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id v7sm7016551wmg.3.2020.04.29.03.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 03:53:34 -0700 (PDT)
Subject: Re: [PATCH RFC 6/6] KVM: x86: Switch KVM guest to using interrupts
 for page ready APF delivery
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-7-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee587bd6-a06f-8a38-9182-94218f7d08bb@redhat.com>
Date:   Wed, 29 Apr 2020 12:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200429093634.1514902-7-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 11:36, Vitaly Kuznetsov wrote:
> +
> +	if (__this_cpu_read(apf_reason.enabled)) {
> +		reason = __this_cpu_read(apf_reason.reason);
> +		if (reason == KVM_PV_REASON_PAGE_READY) {
> +			token = __this_cpu_read(apf_reason.token);
> +			/*
> +			 * Make sure we read 'token' before we reset
> +			 * 'reason' or it can get lost.
> +			 */
> +			mb();
> +			__this_cpu_write(apf_reason.reason, 0);
> +			kvm_async_pf_task_wake(token);
> +		}

If tokens cannot be zero, could we avoid using reason for the page ready
interrupt (and ultimately retire "reason" completely)?

Paolo

