Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26070C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044B3206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aufUOzGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgFEPPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:15:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbgFEPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591370148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LZ042NKXuZSk37xPV2YBjm3wEqnukBdV4tzmVILjAs=;
        b=aufUOzGbpZm91by/wlUfWz2/OlIntzJ+56srz7ktxFQn9hBCB0k3YUpdydLQYEFWtTn5J1
        x49I2rT02lJlBqf9gS6O6AtK2dD1hF+95tTnXnz6q6M+7nOiuxs7L2RvXxEec3g2+1iTfV
        jJCzwpTvqjnOJ8KjY+oHtGwzRTZ7AQU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-6w4pgFvVO6ufVQ2BJQ49Vw-1; Fri, 05 Jun 2020 11:15:44 -0400
X-MC-Unique: 6w4pgFvVO6ufVQ2BJQ49Vw-1
Received: by mail-wr1-f69.google.com with SMTP id c14so3867778wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LZ042NKXuZSk37xPV2YBjm3wEqnukBdV4tzmVILjAs=;
        b=WQDNGP39QD1bafKyDBTWJR6YyK+YXGmqYLYwl5vNNSgx7fQfBUcDmCnfDZ18dkIMfJ
         rfY/lIXHxKZk3JY/kgnBF5pkYclhDcAtFdgdsSHwyn2nq6asraHNf2DfUffdN1VvarR3
         8GQWI2NnRcbA1/xM+EKzHGMQ9+hIhCIPvH5gC9nDiV2S4RXK7pQYlFbQ0vOCi9227neD
         r9NdTZdz8bl+SB3HhLL0TjITw53mM4ly32GkgcXmfeJhFHenEm4omnMAnpIZzgYERciP
         8+5hAYsX+RxryxWXf3Nb8AY8zHxDuD6eb1m+vYGz/0WSmkwFyT3jIIb63f0WIDJ/cROG
         LdUw==
X-Gm-Message-State: AOAM532WlwY+09WyNO5IoY2lOtBuYeeWlnYULQGSpZ8XynPql07ShqXM
        evqMbYD1HvLP3kNa91MBYdEgnXphTo8jq1BMPcrnnWnUzJlSh7y5gJfGOKNFny/f1EiUBeG141J
        HqXaJPBn7oetfkF97Slkh1lS6
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr9823894wrp.305.1591370143035;
        Fri, 05 Jun 2020 08:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXxwZl8T7LVrTQ8PhwkZAl8jHVWXIG49L1Dn2Zy1Lxyv0P2h706pufSNF6CZ9zbfegOCGfxw==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr9823862wrp.305.1591370142776;
        Fri, 05 Jun 2020 08:15:42 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id z25sm11517310wmf.10.2020.06.05.08.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 08:15:41 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix "make ARCH=x86_64" build with
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200605142028.550068-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a229624-c452-c86d-395d-2baa7392cb62@redhat.com>
Date:   Fri, 5 Jun 2020 17:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605142028.550068-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/20 16:20, Vitaly Kuznetsov wrote:
> Marcelo reports that kvm selftests fail to build with
> "make ARCH=x86_64":
> 
> gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99
>  -fno-stack-protector -fno-PIE -I../../../../tools/include
>  -I../../../../tools/arch/x86_64/include  -I../../../../usr/include/
>  -Iinclude -Ilib -Iinclude/x86_64 -I.. -c lib/kvm_util.c
>  -o /var/tmp/20200604202744-bin/lib/kvm_util.o
> 
> In file included from lib/kvm_util.c:11:
> include/x86_64/processor.h:14:10: fatal error: asm/msr-index.h: No such
>  file or directory
> 
>  #include <asm/msr-index.h>
>           ^~~~~~~~~~~~~~~~~
> compilation terminated.
> 
> "make ARCH=x86", however, works. The problem is that arch specific headers
> for x86_64 live in 'tools/arch/x86/include', not in
> 'tools/arch/x86_64/include'.
> 
> Fixes: 66d69e081b52 ("selftests: fix kvm relocatable native/cross builds and installs")
> Reported-by: Marcelo Bandeira Condotta <mcondotta@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index b4ff112e5c7e..4a166588d99f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -83,7 +83,11 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
>  INSTALL_HDR_PATH = $(top_srcdir)/usr
>  LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
>  LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
> +ifeq ($(ARCH),x86_64)
> +LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
> +else
>  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
> +endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> 

Queued, thanks.

Paolo

