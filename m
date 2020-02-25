Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9310CC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C6E20658
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVOC0V3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgBYPSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:18:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57681 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729817AbgBYPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582643896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3UhdeKT+krjNlC+LM3bZB+rdh00isF5DS1fbUlbjE0=;
        b=YVOC0V3B483AQKOb8o4zuvHfoE7c5mrEhS+hKUEYDGlVN+XchFOGZUfmEdk0Le6kZbaecT
        u3C+svwmEqUHXyVwN7lVuEjEw3F5hdUMRPqF4DhxHYH/Hk+eK5K76lGjd5GIwvOe8Ko/dX
        btdjX3Rwi3bphnuC6n/lNT7kUX1jgGU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-B1HJkvyWNsCqbgLdAfjg_A-1; Tue, 25 Feb 2020 10:18:15 -0500
X-MC-Unique: B1HJkvyWNsCqbgLdAfjg_A-1
Received: by mail-wm1-f70.google.com with SMTP id 7so1150063wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3UhdeKT+krjNlC+LM3bZB+rdh00isF5DS1fbUlbjE0=;
        b=GKNQMw23UFL/6FnEfQXJtSyNKfK4VeO43AmJZz6PmHyqlIQL9to8TgEXU5GwI77PoT
         7tk0ud0okObxJ7GT+heTHqUWmDXSh9wbU1lhttwZzpCq07Gwh/qFa9tq/mwSiVRKqX6n
         TLWjCIJEQH+b/UyqNz0Y34xrULnYVMhzEEjF0VXavw7QHMgn6BPkS7kHFFgaOx5WUji4
         P4XkTdUblUp2oPnzVQLh6Fsmd0dNzUHeu3E0pHYCwl7w9Xwzf4Gu3Z87xpsQSFFMYgFX
         FGBPbUnmtbS7/s0kCfYuGQy0dPHw8pa5BEDfcdV0L8d3SIMzO1YmbmQZ7PKjUW9j73dS
         R63Q==
X-Gm-Message-State: APjAAAVDPnsY6UvmTyAH1PnOI8xcacCXyAqKMGQu2rWBCy5Zk1xJxsDk
        d8kBz/YhM1Wxo+DQ6bSkpLSOkR8imcbCJo8Jt64xZfZ+YuhTh3q9eQ8KSjk02BUqs+N0lkgUZhP
        PGwgzs1jhXwQTzMUAV7AkWmgL
X-Received: by 2002:a1c:a382:: with SMTP id m124mr5758512wme.90.1582643894057;
        Tue, 25 Feb 2020 07:18:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQ4GB2bbPWgq4zi3drCuNanKtM0d7Lh04HjmIfnH07Op+Coz/HCusYRfj4lHibPbvl/9iiKg==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr5758499wme.90.1582643893839;
        Tue, 25 Feb 2020 07:18:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id a198sm4577277wme.12.2020.02.25.07.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:18:13 -0800 (PST)
Subject: Re: [PATCH 48/61] KVM: x86: Do host CPUID at load time to mask KVM
 cpu caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-49-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd7c8e54-b5e1-fa0c-02c7-d308ecfbac80@redhat.com>
Date:   Tue, 25 Feb 2020 16:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201185218.24473-49-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/20 19:52, Sean Christopherson wrote:
> +#ifdef CONFIG_KVM_CPUID_AUDIT
> +	/* Entry needs to be fully populated when auditing is enabled. */
> +	entry.function = cpuid.function;
> +	entry.index = cpuid.index;
> +#endif

This shows that the audit case is prone to bitrot, which is good reason
to enable it by default.

Paolo

