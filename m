Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E3C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAA421775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVrwWF2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBFVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:32:52 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39957 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgBFVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:32:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so6164561oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CZIR0O4XSSHJzQ5NKMOaMQy9m9LNXwiQasS8KWy7Rew=;
        b=KVrwWF2SKiVwKyoIsPVvbAikP44PdWvjeMhQkEtI1By6Zls5EW4B3PSNuMcCWXxG/v
         xusmhSnTOcGjtj7V7BFKf6KBGw/XRFI38EnRK/cpY6ftMFBmZV6TSFD8jSDg+m6fy/z9
         kWyh4e+ldTYzBi4iEsjBLdfXYAQLpCU5u9Vdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZIR0O4XSSHJzQ5NKMOaMQy9m9LNXwiQasS8KWy7Rew=;
        b=PEWeiontZV1l/LbbwCBZ4q5udxiT46TFP5o87baNEAr8UPzSryERpGSHimT8l5TUKi
         jG/OktsQLKfirvZ4MoGg0s9qdu9S3umv2rICn80166AqtiRAMQia4WXcP3E9pYM9fivJ
         8PZ24/Zm9bHw1irFAf6laRLPjdSLuVyN7bqDKsmmrR9henSzksv9I9Xz475F6NqWiHef
         G/4LO2jcfUl41PPWAOxzTR2kABpPYqkpgIYusZt5KrGTzekEa/5vJsIeMVMApIGSrl9U
         5/DOhHpmYuKgfdIoUuZBe6Xv9FFTFGiq8BQ2Wz0e0KpURlYlCbnsxX1cM1J//OgZIWKj
         OfOA==
X-Gm-Message-State: APjAAAU1nV3Oj+Y4gtVpMDbm5kiK81Qyv+YUVU5tx685d7opgYYYQQsB
        P1EHQDJbnagxHAjCZRzA6b69eQ==
X-Google-Smtp-Source: APXvYqwvXjFqDoHHLLlHopScWku9ff/Blk8JGx7kXOUBy8QLwy4WBSOp/2rRgo7BA84Ute5uBspIMg==
X-Received: by 2002:aca:cd46:: with SMTP id d67mr81999oig.156.1581024771067;
        Thu, 06 Feb 2020 13:32:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm286736otl.49.2020.02.06.13.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:32:50 -0800 (PST)
Date:   Thu, 6 Feb 2020 13:32:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 11/11] x86/boot: Move "boot heap" out of .bss
Message-ID: <202002061331.E5956EA@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-12-kristen@linux.intel.com>
 <20200206001103.GA220377@rani.riverdale.lan>
 <202002060251.681292DE63@keescook>
 <20200206142557.GA3033443@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206142557.GA3033443@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:25:59AM -0500, Arvind Sankar wrote:
> On Thu, Feb 06, 2020 at 03:13:12AM -0800, Kees Cook wrote:
> > Yes, thank you for the reminder. I couldn't find the ZO_INIT_SIZE when I
> > was staring at this, since I only looked around the compressed/ directory.
> > :)
> > 
> 
> There's another thing I noticed -- you would need to ensure that the
> init_size in the header covers your boot heap even if you did split it
> out. The reason is that the bootloader will only know to reserve enough
> memory for init_size: it's possible it might put the initrd or something
> else following the kernel, or theoretically there might be reserved
> memory regions or the end of physical RAM immediately following, so you
> can't assume that area will be available when you get to extract_kernel.

Yeah, that's what I was worrying about after I wrote that patch. Yours
is the correct solution. :) (I Acked both of those now).

-- 
Kees Cook
