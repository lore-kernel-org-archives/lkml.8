Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2DF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PX6L81YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBFLsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:48:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43159 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:48:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so5153850oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tf7UfAXF0+7+R/0CR/EhvROtYInc8epHQipEfshPVGs=;
        b=PX6L81YYJdfK1dzYbHAtJvW+q7p3T/0pcVLlue5FeG4q7vAYgtvwTOkmic7TMKGuuO
         +Kv/qr++XIOZZEokHxFHqatEdlf/ZNap1h7uIHw40ejP2uWu7PRmNoRic/wvHYFAd3Zk
         wKRp8P+VQP4V4FtxKgDx6FYxSI0lZ5z57RMqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tf7UfAXF0+7+R/0CR/EhvROtYInc8epHQipEfshPVGs=;
        b=gbKX2IDFUwX0Eb0ND/dXAzEKTOW15thlZVcobNDqngPsqVZG3n5Og8Uz5Em1ubS3Ie
         kHvdiou+98+Hksxe+V688hwT2nkD6GPjfRKG38+0AT6xPF1O11CjPkbc1wLgsrODLZPD
         MDcWQSML8lL0ZYLsT8JCJ70C5LOjbPWZ12xCfOz97PGtavsPJ8GrsZAgxWqMAktI8PAo
         JNGRAjPzEgeoQDtqFe51xFQBr25NijerAIYKqs9/8HrBBapcTHUvU8v5ilt8kbBVA290
         JqAIrkDfU4l+Xbo8swhFpk+a42ysq4ixI8BuhLD3xyU5BfCNqfzA7dokSm1F/5bj2Wv5
         V57A==
X-Gm-Message-State: APjAAAXZ48PzwrQCmnFz8L5/334c/TztWBhdeZl9c7tCC+KJKiiw8xj1
        lQhLPCiSq5CW5/rzAYemSoTN4Q==
X-Google-Smtp-Source: APXvYqwjnYccMXUVd+n93iR5zMBTFfXt5QHWYG9PKa/8tWlaPADduZNq1u0fLkVynUJQ4it71oULeg==
X-Received: by 2002:a9d:5885:: with SMTP id x5mr29462319otg.132.1580989683562;
        Thu, 06 Feb 2020 03:48:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l207sm860711oih.25.2020.02.06.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:48:02 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:48:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 03/11] x86/boot: Allow a "silent" kaslr random byte
 fetch
Message-ID: <202002060345.FAF7517CA4@keescook>
References: <20200205223950.1212394-4-kristen@linux.intel.com>
 <B173D69E-DC6C-4658-B5CB-391D3C6A6597@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B173D69E-DC6C-4658-B5CB-391D3C6A6597@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:08:55PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Feb 5, 2020, at 2:39 PM, Kristen Carlson Accardi <kristen@linux.intel.com> wrote:
> > 
> > ﻿From: Kees Cook <keescook@chromium.org>
> > 
> > Under earlyprintk, each RNG call produces a debug report line. When
> > shuffling hundreds of functions, this is not useful information (each
> > line is identical and tells us nothing new). Instead, allow for a NULL
> > "purpose" to suppress the debug reporting.
> 
> Have you counted how many RDRAND calls this causes?  RDRAND is
> exceedingly slow on all CPUs I’ve looked at. The whole “RDRAND
> has great bandwidth” marketing BS actually means that it has decent
> bandwidth if all CPUs hammer it at the same time. The latency is abysmal.
> I have asked Intel to improve this, but the latency of that request will
> be quadrillions of cycles :)

In an earlier version of this series, it was called once per function
section (so, about 50,000 times). The (lack of) speed was quite
measurable.

> I would suggest adding a little ChaCha20 DRBG or similar to the KASLR
> environment instead. What crypto primitives are available there?

Agreed. The simple PRNG in the next patch was most just a POC initially,
but Kristen kept it due to its debugging properties (specifying an
external seed). Pulling in ChaCha20 seems like a good approach.

-- 
Kees Cook
