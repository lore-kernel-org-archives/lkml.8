Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D722520CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE5R4gxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJPPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:15:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbgDJPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586531712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kg3Cf5xpoeA5lpq5U1vo0Nk9i509WBxxcW23+OUzrmo=;
        b=RE5R4gxwVgJegReqwCcTHk253c5SvBzZZmVBlScUCvp+yjkeKJavmQXUxO9N7qCfs1pRy+
        TtJi04oA3p6UJZ6RcSSxVApa0ImySm0+qiL4LgmyiGOsuE99/ugD9Jx816qzk3AB3mz6lY
        6csDYNeNuwsqkaESm/lV8SUrhQtVZjU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-ZQ7UUZkANyOIfEc5DiG1vA-1; Fri, 10 Apr 2020 11:15:07 -0400
X-MC-Unique: ZQ7UUZkANyOIfEc5DiG1vA-1
Received: by mail-wr1-f70.google.com with SMTP id t13so1355583wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kg3Cf5xpoeA5lpq5U1vo0Nk9i509WBxxcW23+OUzrmo=;
        b=lUpWkSfJQXvzdDJgAG/ZgvdOH8OB30lckWVUO/dkSJlY5Ed/cgDIej7t+zvjivBJ+z
         r8mOWxKUGtKmc/VsXrpu+d02kwHIYgD/EzMWnKld68GAoyELRVoa8z9uh3fZswKwdcJX
         08NUH7+KSGDvS3GlMgUJwo7n7/OdkiERCPfHmi15wZKWhNu7N/0UhYs/e8zf/mVjzn9u
         ztiQ08zpJXH3SUnAylCo3CAh4bRZ1yzjkqw6ldBuSrI8c8TwXRBmKE7LMi+cAypkF2mY
         p7eg6ruttpIXFaGy/2KcbBbt7YN12LOPu3j2SibLOWkaWJg93Af9eZyH6YjrHGRf4qNb
         eHVw==
X-Gm-Message-State: AGi0PuaeTj6Lw0OWxRa1ApSiTwhSbcTzhvmOa96T/PjWmLbIISvvoDz0
        24iUASgbgcltRvfCp3c1Wj4+3G6necbqVQzbTKYZHbtnw0ZszMjb/Ownk9Ce20P3k6ygYTJdvMa
        jsIS+OvgGwDHNfPItswDgqqI3
X-Received: by 2002:a5d:4306:: with SMTP id h6mr4851084wrq.234.1586531706362;
        Fri, 10 Apr 2020 08:15:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypIkApPOhslOv9luoNK+BaxRR3fe3ho995HLdYUz7YcwAwwR4Ekt9zKSdav/3z7JIk465lFInA==
X-Received: by 2002:a5d:4306:: with SMTP id h6mr4851055wrq.234.1586531706077;
        Fri, 10 Apr 2020 08:15:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b7:b34c:3ace:efb6? ([2001:b07:6468:f312:f4b7:b34c:3ace:efb6])
        by smtp.gmail.com with ESMTPSA id r5sm3336970wrt.8.2020.04.10.08.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:15:05 -0700 (PDT)
Subject: Re: [patch 0/3] x86/kvm: Basic split lock #AC handling
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20200410115359.242241855@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb60a842-9154-02b8-baab-62bef1951b87@redhat.com>
Date:   Fri, 10 Apr 2020 17:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410115359.242241855@linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 13:53, Thomas Gleixner wrote:
> This is a reworked version of the patches posted by Sean:
> 
>  https://lore.kernel.org/r/20200402155554.27705-1-sean.j.christopherson@intel.com
> 
> The changes vs. this are:
> 
>     1) Use a separate function for guest split lock handling
> 
>     2) Force SIGBUS when SLD mode fatal
> 
>     3) Rename the misnomed helper function which decides whether
>        #AC is injected into the guest or not and move the feature
>        check and the comments into that helper.
> 
> Thanks,
> 
> 	tglx

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Or just tell me if you want me to send it Linus's way.

Paolo

