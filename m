Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99099C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F752469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIv0uW1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgAROAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:00:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33077 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgAROAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 09:00:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so11444944wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E98X9864/bfJIEJe+/1iPeIORymujBg0mBrF3gq7gaE=;
        b=VIv0uW1HqN/tg7z8Y+/DuyFusoKgexT53nGya2d1RvY6y8VvIrDNaI+QNUF1qIPcU8
         jfbHDKR7Q0U1vQRVWZ8pe3QKvLdumFTxK+gptx4dt2wTw7XGH8JXj0icOHr8pYKGQZ9O
         9addS7fNNDNXJCKCxMx7XU7mW+TW137xsrIuxzjhvfi5e0RwSKQ1WdCM9vAZ6Xfm8WnT
         Fi/Rz4ceoEnMqx4iM7UXxZgK7ETo8xhPGTQP02wb9Ls+i6hzXpqW5fbyovzVHfKq0yge
         uuPLhTEAoD7XEevU3Sh57gGiVBjccVu/COUEg4lgm8tQ4bmE70EbIthl3NWrKQslRvCi
         WlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E98X9864/bfJIEJe+/1iPeIORymujBg0mBrF3gq7gaE=;
        b=RKv5gZy5rBfZIWJ6Z/ciyt1jKQvm2Z9PdDPJH+R3tZ3OeJBS3x735iXIqQctBxe+rc
         TWBfYvE2AGgFbXz9529PVCzFrroJPP5jVS9ZoifdQ5clqY6ksdkYPWVZ7xWkkEFUztyz
         FxfRGJJqptuVEyd9g/GaymYZwfkIHzTvPRzhn5Je7wsSHBo7MH6KjgOTIZqQNzpep8yy
         nSBIgj1gzYZQyNLf5aUucJhdTwxlJszKezQlRZgpXLyF2BHwVeeGOCz+OPv+eMvho2mQ
         BPx6se9mkghJH2Q8BhhGUmmhFu1ApGIrJs++M7h0qlRcdc5gl4yH/CZzOIRQZZt6PXZ7
         +LXA==
X-Gm-Message-State: APjAAAXqHlHbVpBdP4PmDTzZvP4hC3fH9P6zc7Rxf2x27/nHC2g51L8K
        wu62G50pATwggEBUR9x8pQ8=
X-Google-Smtp-Source: APXvYqwKyWZoBsa4+uUDkqTefOt8PSolkoe5BsqXzCwze3wGFiGgj0VO7ubcgNS15NskGYwA2xR9Gg==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr9741370wme.82.1579356030665;
        Sat, 18 Jan 2020 06:00:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c5sm14811705wmb.9.2020.01.18.06.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 06:00:29 -0800 (PST)
Date:   Sat, 18 Jan 2020 14:00:29 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
Message-ID: <20200118140029.z24bye6kq2yo33fn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
 <20200111223820.GA15506@richard>
 <a6a7bb3b-434e-277c-694f-d5a18e629d2c@yandex-team.ru>
 <20200113003343.GA27210@richard>
 <1cf002fa-a3cb-bcef-57dc-ac9c09dcf2eb@yandex-team.ru>
 <2020011422424965556826@gmail.com>
 <20200115012055.GC4916@richard>
 <8f335403-4a14-bd17-39da-6299dd962fc6@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f335403-4a14-bd17-39da-6299dd962fc6@yandex-team.ru>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 11:04:21AM +0300, Konstantin Khlebnikov wrote:
>On 15/01/2020 04.20, Wei Yang wrote:
>> On Tue, Jan 14, 2020 at 10:42:52PM +0800, Li Xinhai wrote:
>> > On 2020-01-13??at 19:07??Konstantin Khlebnikov??wrote:
>> > 
>> > > 
>> > > Because I want to keep both heuristics.
>> > > This seems most sane way of interaction between them.
>> > > 
>> > > Unfortunately even this patch is slightly broken.
>> > > Condition prev->anon_vma->parent == pvma->anon_vma doesn't guarantee that
>> > > prev vma has the same set of anon-vmas like current vma.
>> > > I.e. anon_vma_clone(vma, prev) might be not enough for keeping connectivity.
>> > 
>> > New patch is required?
>> 
>> My suggestion is separate the fix and new approach instead of mess them into
>> one patch.
>
>Yep, it's messy. Maybe it's could be better to revert recent change,
>apply second patch from this set and write something new after that.
>

It is up to you.

>> 
>> > It is necessary to call anon_vma_clone(vma,??pvma) to link all anon_vma which
>> > currently linked by pvma, then link the prev->anon_vma to vma. By this way,
>> > connectivity of vma should be maintained, right?
>> > 
>> > > Building such case isn't trivial job but I see nothing that could prevent it.
>> > > 
>> > 
>> 

-- 
Wei Yang
Help you, Help me
