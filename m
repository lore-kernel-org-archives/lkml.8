Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC252082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IM7SwiKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgA3T2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:28:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41133 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgA3T2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:28:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so1990710pfw.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWfrZ/xjnp4Ak3zEcjYTfRHaTAYKUcqb9pMEB5EKCt8=;
        b=IM7SwiKq1+WKnW7tzkjGOWGm7quhPQSUwZCtVZ+zyJSGAvSLHvqr/P9aTRY6yJTUam
         IuFDtAXfaJxv8V8DnZnGfhMc0nL9NXW6QJp4lDqOBK0AhZcY61+OCM7OuUf4LZUMmRvz
         uF64Ssb5/OxRKUZLOQ3gRuBRC7D8IA8NZAQ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWfrZ/xjnp4Ak3zEcjYTfRHaTAYKUcqb9pMEB5EKCt8=;
        b=IFB2YyCRSSfyBg0VnE1HVDy7ADvYErn/qMULyGgRK6DU2lswsTm5G3oePPP8IT6+ve
         WKrLSI4ysSdV2jE83U5TrKciOP87GuO3Qhjd+th8swaIYQ0biT7ToKcUzGrKVDXvskzh
         fITv5eZa+B5zQ3X36oNHjjiIYNmPvQNNvipq9n6dU8ZrtKVe2yNQWnp98aVc7ZJJG6wC
         TiHUXo/LuB0SCf2tmkSDzixQT9w9qM8mMf3ZPUpEGCji3Mm68B40ZoS63M0yCPd3pOX9
         q33qBzqx757Tw4AWUh6LKdxYQjVSgvzIdgJrWjQ2TocWQf6xQDIYG713XbPpI7SP2QMM
         IjMw==
X-Gm-Message-State: APjAAAUE7phxuuzOMjkCqG7Dc9RI/2XjrfYgtZw3aseIHv4n4vCJiQ5c
        TksVM7YXLzT9Q8oGyHInJDAotdPivSM=
X-Google-Smtp-Source: APXvYqy8iWU4ETKdPcgtnjQ1dePHwCv/Fs0E3cGiUhU9Pn9+s/NNubhU8Y96pkpWrUj3gw0/lS0VpA==
X-Received: by 2002:a63:c511:: with SMTP id f17mr6141537pgd.198.1580412527278;
        Thu, 30 Jan 2020 11:28:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e19sm7197844pgn.86.2020.01.30.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:28:46 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:28:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Grzegorz Halat <ghalat@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ssaner@redhat.com, atomlin@redhat.com,
        oleksandr@redhat.com, vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
Message-ID: <202001301128.1CBD1BA52@keescook>
References: <20200129180851.551109-1-ghalat@redhat.com>
 <d47a5f31-5862-b0a9-660c-48105f4f049b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47a5f31-5862-b0a9-660c-48105f4f049b@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:44:50PM +0100, Vlastimil Babka wrote:
> On 1/29/20 7:08 PM, Grzegorz Halat wrote:
> > Memory management subsystem performs various checks at runtime,
> > if an inconsistency is detected then such event is being logged and kernel
> > continues to run. While debugging such problems it is helpful to collect
> > memory dump as early as possible. Currently, there is no easy way to panic
> > kernel when such error is detected.
> > 
> > It was proposed[1] to panic the kernel if panic_on_oops is set but this
> > approach was not accepted. One of alternative proposals was introduction of
> > a new sysctl.
> > 
> > Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then the
> > kernel will be crashed when an inconsistency is detected by memory
> > management. This currently means panic when bad page or bad PTE
> > is detected(this may be extended to other places in MM).
> 
> I wonder, should enabling the sysctl also effectively convert VM_WARN...
> to VM_BUG... ?

There is already panic_on_warn sysctl... wouldn't that be sufficient?

-- 
Kees Cook
