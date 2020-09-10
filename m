Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BECC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7986A21941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7QvBYZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgIJCHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgIJBzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:55:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF72C06134A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:33:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so52692plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+CAnJ6K51a/Q1rf8+zN1lXgwBk9dz+8lbDuUR7mG78A=;
        b=V7QvBYZmjvIIciOiQahLDEhlA7JmdBMFkTGy7ZcJvHaxxSi0KpQ9P+trKUr4dD/1LG
         vxHXMt5Dp9uGDeOir+ebQe/qCtzp5FJTE9V3PfAiCfqYqwPOUK9ZWApBTsZpBhH6O3Tk
         g5N411ocAl+fZi1I1Wwk2ruc63dkWhLGwSsH8KDxulR8wsRnHIwcZh9IgnxNsYNZLjIk
         ZUG4xJ9Y4WNRiriQzdRqBWZ9wTfPnBbpRLj9OAu2oA+OYzQ5pfsGHH3qXY1ynwpPu8Hu
         ObQOfa/oXsi1zp7YAA3ijGpqIS/O0Vi5mc1/n52k4cb0l469pAy1VF5tQAef6qHA4c+2
         QRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CAnJ6K51a/Q1rf8+zN1lXgwBk9dz+8lbDuUR7mG78A=;
        b=HAXWvhdHPBAjccIkk1qcXP2QWOAUfaPGKIHmGAaWtB3gtQ5BTweIbGObZuhedw8u3P
         9JKAKP2rH/7/RtQJTjHCdfFyB1P7aD8vfwtDLDBJnNP8fC+gtvz+u9dl8mOi717dFws6
         3DbkPeMlILRxgPp8I7iX1nMg9K500CuTjTCq42iGDGOU31HjrVHx1TePNAhXnbhwiQud
         vXitSHh60yHjSYcSFVuaKGQzNQGljWGkxNLUhgU80XGCbcB9AOBERaHG9x/B3wxPSDqn
         RtY1kZ4HKYnEpiOSb6d1l+5byiJhbahBXf6ay8FHeu+YBCf1rtunA1NxkQq8bfxnKxjW
         JO3A==
X-Gm-Message-State: AOAM531GcDj97/XT7eOfanyogJQnONVymdEyh4bHCnlhepXH8z9Pl81E
        V55AZfGHxSzTGj696fdVkWdgKg==
X-Google-Smtp-Source: ABdhPJzSlIZZ0t/eR2XoepX7ZXStzafMl25vu8/vN0U+R8icUnYxOx9GHDnC+lOspzzpvRs1LkJaHg==
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr1684889pjr.13.1599698013824;
        Wed, 09 Sep 2020 17:33:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
        by smtp.gmail.com with ESMTPSA id x20sm3769882pfr.190.2020.09.09.17.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 17:33:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Haibo Xu <Haibo.Xu@arm.com>
References: <20200904160018.29481-1-steven.price@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8e661984-70bc-790c-8636-39dcd8b00131@linaro.org>
Date:   Wed, 9 Sep 2020 17:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904160018.29481-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 9:00 AM, Steven Price wrote:
>  3. Doesn't provide any new methods for the VMM to access the tags on
>     memory.
...
> (3) may be problematic and I'd welcome input from those familiar with
> VMMs. User space cannot access tags unless the memory is mapped with the
> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
> for the user space process (assuming the VMM enables tag checking for
> the process)...

The latest version of the kernel patches for user mte support has separate
controls for how tag check fail is reported.  Including

> +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults

That may be less than optimal once userland starts uses tags itself, e.g.
running qemu itself with an mte-aware malloc.

Independent of that, there's also the TCO bit, which can be toggled by any
piece of code that wants to disable checking locally.

However, none of that is required for accessing tags.  User space can always
load/store tags via LDG/STG.  That's going to be slow, though.

It's a shame that LDGM/STGM are privileged instructions.  I don't understand
why that was done, since there's absolutely nothing that those insns can do
that you can't do with (up to) 16x LDG/STG.

I think it might be worth adding some sort of kernel entry point that can bulk
copy tags, e.g. page aligned quantities.  But that's just a speed of migration
thing and could come later.


r~
