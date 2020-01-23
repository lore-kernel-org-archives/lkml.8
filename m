Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B92DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB86521734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XvGvEarO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAWRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:31:29 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:34699 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgAWRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:31:28 -0500
Received: by mail-qt1-f178.google.com with SMTP id h12so3115457qtu.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rBBThgXC3RlRJATFU2MQijt5WNYWxLR5qQsGqFoA6wA=;
        b=XvGvEarOb01ZEusXNSWgTQPqXL49NPn7ZdBHl1xDJaj4P91lqVHNgPsdqyfzRxxM9q
         QWhIY6G3RfbdNuPfN3VY+KvSQOFyF3VyVufw3Whe5jToj5GHdp4dU3hgBwO1U27iO0bl
         8EzOMA1a937f6UGkiS9HfLzxNDx0Q7wVHE8wDkqCU9uZhb1bP8/k41g16s+snBOpEcTB
         HtFkVwN5Hjsi5BPTzD77DOIAwiDW/lQ74bBAey5s2Dor1BNiqRagXDcmoRbbcg11nKyG
         eNhS/2h81T5gq1KD4+K2QCr6M+0DhgoVYUXvCd1xG15NQ5iEL3qB2jKK25A5XqbTNMLm
         D5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rBBThgXC3RlRJATFU2MQijt5WNYWxLR5qQsGqFoA6wA=;
        b=uikeuhp8usSEiDJwyeuRBHt6ZFk8LMTc081ECEUsM/2N7ANw+sS+sv/EqjuW9UhgMm
         qwA6Yh1xCaq7HUUZJj9tV2zsfWnjeyCujyYTb57oQhMWCVC6qPu3FE5h02aS4XvKpfeW
         UaJfXQl5q14ylPgCWL2xRNZzzPngTnvLPu3Fu1MUlmxiwQvKx0UE5/UNDUl/U00kZDAD
         XYcd4EZ62ewEmqW7zndqujsIMkZeGbDw27WuCjZA7u7uIdxnwtUFryZBOR+2WRH6h9aB
         mWawbb2t9g6GZP7BZBKUKPKW0Ct+si88CzXKuNPko3bMrYHEc4WUKAcbpdo9RgtLtXmC
         U2aQ==
X-Gm-Message-State: APjAAAXmgKcSs+59fGq5ib9+YP768KmpGKQ0exnoXtchiCMfXBhi8JLP
        8w2de8jPeJNoCbszmaqULy6LSD5etAAgjQ==
X-Google-Smtp-Source: APXvYqwrAlyp/Lf5BA048RSQXVW/8wtLXFtugWLJuAfJ4/djDPXGUFxMFAqSZR2WzsgC17OwYTT7cg==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr16566059qtr.320.1579800687406;
        Thu, 23 Jan 2020 09:31:27 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q7sm1194556qkc.43.2020.01.23.09.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:31:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] arm64/spinlock: fix a -Wunused-function warning
Date:   Thu, 23 Jan 2020 12:31:25 -0500
Message-Id: <48DF011A-3074-422C-BFBA-1A9F2EF4A7BA@lca.pw>
References: <20200123165614.GA20126@willie-the-truck>
Cc:     peterz@infradead.org, longman@redhat.com, mingo@redhat.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200123165614.GA20126@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2020, at 11:56 AM, Will Deacon <will@kernel.org> wrote:
> 
> Damn, the whole point of this was to warn in the case that
> vcpu_is_preempted() does get defined for arm64. Can we force it to evaluate
> the macro argument instead (e.g. ({ (cpu), false; }) or something)?

Actually, static inline should be better.

#define vcpu_is_preempted vcpu_is_preempted
static inline bool vcpu_is_preempted(int cpu)
{
	return false;
}
