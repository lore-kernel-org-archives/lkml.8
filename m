Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F12C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1D8206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PB5wpvCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgICI4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:56:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80AC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 01:56:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so2072150wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oXnv/3I3RNjKPd3svQVgdHEHghFe6WwwdwtXUflXo84=;
        b=PB5wpvCUWl76RLt7pM40TQUJG77WeKZVBYLnDTVgmuVyo/3WmE+MX9MLNVNJBaAcvC
         Nx63GHZnhKhtRa3vgu8ZN57HPyJcQwBbY1xfaf3hpskoTOc9zL8ghfy93mhFFP+avL6x
         N1pQNKvOSUEKkRn0GeeFr++TicApz6ccx6jR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oXnv/3I3RNjKPd3svQVgdHEHghFe6WwwdwtXUflXo84=;
        b=krEUZ4q0fZd50AS0BVOaFfH/jBJl4s7F5gEokg7q3X7pJw02/NwKUXkZ6OjkzsbyS0
         qopYKkP+FqDM2yPeidteQk83iLycD013hCsemrupSwUI2RMK9vudDLaXxuv8eWr4AMvq
         osTrb66udvOsiaNdr4Jq4skVLvqgzqee1c34INaIv+XKF/n/6uNSkbSr8OMvGJE4o2/V
         I/Lm7WAK4vc/EJCHpCaxCRM6+C5LYy77TPYINxgBmhiMPO1HPoopAG/hMvyP+uaxuprr
         yT8qxkxvsKUvRaa231gw8U2vNbQmb38G2vR7ChR7D38/M1dZxbqsOe+KszYxpWHW6PZj
         omOw==
X-Gm-Message-State: AOAM531pI/5JLUcFe1Qfmqq2jK0GD2UkxHwWJM40Yf7JOP1EGX8w2zsC
        R0ZJP7B6BYpwytKN6i6KAuTkmQ==
X-Google-Smtp-Source: ABdhPJzrsGutLlxJyzlqDyE5UjsrS4/YD+N+YvSUSIBIGm0GhcWhcqtf44P2W+xn6gde+IqEXTpcWg==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr1397695wmg.33.1599123400944;
        Thu, 03 Sep 2020 01:56:40 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n4sm3230442wrp.61.2020.09.03.01.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 01:56:40 -0700 (PDT)
Subject: Re: [PATCH rdma-next 2/4] gcov: Use proper duplication routine for
 const pointer
To:     Leon Romanovsky <leon@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200902085513.748149-1-leon@kernel.org>
 <20200902085513.748149-3-leon@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <eb874b37-3e3f-6819-78f7-bba3e684ae27@rasmusvillemoes.dk>
Date:   Thu, 3 Sep 2020 10:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902085513.748149-3-leon@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2020 10.55, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The filename is a const pointer, so use the proper string duplication
> routine that takes into account const identifier.

This commit log makes no sense at all.

kstrdup_const is merely an optimization that can be used when there's a
good chance that the passed string lives in vmlinux' .rodata, in which
case it is known to be immortal, and we can avoid allocating heap memory
to contain a duplicate. [It also requires that the caller has no
intention of modifying the returned string.]

In the case of something called ->filename, I assume it's initialized
with __FILE__ somewhere, making the above true for built-in stuff but
not for modules. So if the gcov_info can live longer than the module,
it's of course necessary to duplicate the string, but OTOH making an
optimization for the built-in stuff makes sense. So this is certainly
one of the places where kstrdup_const() seems applicable. But it has
nothing whatsoever to do with the C-level qualifiers the argument may have.

Rasmus
