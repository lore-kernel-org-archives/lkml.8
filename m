Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F1C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511672074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M3COaVcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCYUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:22:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37516 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:22:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id x1so1251206plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PdpEIpQ/wKeSgsRAafJKurWryJo4Td2Yn8/4nS7DvLI=;
        b=M3COaVcIwpKVfcCr80swHvdh9xXacj7eY2qC2ds0xZUIr0GOt4mzJLwb1ZwbVI9+Bg
         XQEamHqFR+VeDMQ3FRvP7wohJct4eF4Q0yfFFLHyAiNgQdrXUvp5l3OBfu+dUDGlCeG8
         TwUeNQNwBIaBtP7S7OlSpq0LgGwC0BvmnAp9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PdpEIpQ/wKeSgsRAafJKurWryJo4Td2Yn8/4nS7DvLI=;
        b=j9R90nt8U5tz9jSpfrCzKYOCaNoiEzxApBegCAnpiRCM8G/u61DhdbfIyYElCKfe4E
         u1CfO6lyxrzmaik17zHz6MHjvGvFLd9it94zKW5XjjFkHCLdkfoA18sfIZ4iUvAhRpWW
         B4vMMgKQIB1sZxKRGRK9M7BMdHfp1UvehVnGuh499whtBhkcOxwAGqim0qyINzVjIvXd
         P1fe5tXHPSo5T1/lgkwI8HXZ5knkKPzT/rHnMSBTBWZCcmH7szjNll3pOs+oumro3VTc
         EN7CI6iw9PYobBVyID4fD5TDWtEsM0nP4Pmm+nf1ySpURpXpRdlUG66qdLnMRPW+EJvp
         XElQ==
X-Gm-Message-State: ANhLgQ3ZM2/5AFeYRvE1plpGyHcCGU1mjrqbJgjSUn7iOkqYXbZyQUZY
        DC4teh+31MYgAFJSirNMAn6k5w==
X-Google-Smtp-Source: ADFU+vs+9qXw30Y/gM8gDtnz4iYFAg0dyECDyKOna2Nf6+mD+qup1rem6mTHJ82584OyB/TSrpCOAg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr4491897plp.252.1585167729772;
        Wed, 25 Mar 2020 13:22:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q19sm8285835pgn.93.2020.03.25.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:22:08 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:22:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <202003251319.AECA788D63@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
 <20200325132127.GB12236@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325132127.GB12236@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 01:21:27PM +0000, Mark Rutland wrote:
> On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> > Allow for a randomized stack offset on a per-syscall basis, with roughly
> > 5 bits of entropy.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Just to check, do you have an idea of the impact on arm64? Patch 3 had
> figures for x86 where it reads the TSC, and it's unclear to me how
> get_random_int() compares to that.

I didn't do a measurement on arm64 since I don't have a good bare-metal
test environment. I know Andy Lutomirki has plans for making
get_random_get() as fast as possible, so that's why I used it here. I
couldn't figure out if there was a comparable instruction like rdtsc in
aarch64 (it seems there's a cycle counter, but I found nothing in the
kernel that seemed to actually use it)?

> Otherwise, this looks sound to me; I'd jsut like to know whether the
> overhead is in the same ballpark.

Thanks!

-Kees

-- 
Kees Cook
