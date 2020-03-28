Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DBDC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F95206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 17:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="P1k0Hfvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC1Rci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:32:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43350 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1Rci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 13:32:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id v23so4783400ply.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhPTIU6n0d3O11Wq7TaGqTOuV9fHfpwlilc1QaSmJpQ=;
        b=P1k0HfvqMT/LirZboobUICcpQvpWdebV1z44t8h1Ix8PyMTTrwsgiqTbe5eGdW2t65
         xDYkHMLC4zsOkc18/ulToI4l9KB/6R3jc9vwTzMECeCKm+2+xVZ3H9t8J3VFpqyRrvXR
         kso3nxeo+yFcSWVW1A/jCozUSAGFyvyyW931gu42gykYEwuB2rNyVMDWz4YF+vZWOO7a
         HpdCH+qz5iV9XsEGgYWTuTpE0tST4kTVapnDsBhg+rW2pQfY1LesWitcHNBjzHJ1PzIg
         EsloynNQn0KKzIdeZoWbU7HjEJ20ME91cXDFxuYlt9nJJt0is7EDWU/97aMdgocW14OC
         Hc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhPTIU6n0d3O11Wq7TaGqTOuV9fHfpwlilc1QaSmJpQ=;
        b=L7ZiWnfx4/a+sJyGVjAijDccaD5P5RtlJo6tQy/cDh02u8NlByhnGH8L8VxLzyCMCs
         yja1Rw7eL+aaqOX+wNzcgz5Jl7gCWWyAQDUgvyGvldS1y+IzF/LI4aiDtEtM4FOGwtTB
         hAtNhY4AuqMGUAkDg1XSp0iMRklnJOqsatsYPhw/ElpnT69Sg++9t7bYMWOf+eeZOOeM
         n6vCBPQliK0jDyc7zcVKtXhH7hb8ViFftKLWTtTFO2R8GQ09P+Le4p0I6WdnKHibRqp5
         Leq3SYi4MadxFdE2NRltMKrBa+9kCkhyWA90swt5NA1FA1qXSrGne7yhackYFRzjvWDj
         U8OA==
X-Gm-Message-State: ANhLgQ3rpGdlbzFJ8/CegJnbrjw1nXi6mIizJzCin++UxeJSlj7m6o21
        tdkgXGEwcxiq2KQ7IOFfBV++CA==
X-Google-Smtp-Source: ADFU+vtCwdClxheDTbIdAt1kuEXbadxU8E5OSbHzeZ/kjipg+VHLHpgTza9c6AmX2mrVsrup7bU/4A==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr6027530pjp.40.1585416757208;
        Sat, 28 Mar 2020 10:32:37 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h26sm6551618pfr.134.2020.03.28.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 10:32:36 -0700 (PDT)
Date:   Sat, 28 Mar 2020 10:32:29 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Subject: Re: [RFC PATCH v1 09/50] <linux/random.h> prandom_u32_max() for
 power-of-2 ranges
Message-ID: <20200328103229.132a047f@hermes.lan>
In-Reply-To: <202003281643.02SGh9n2025458@sdf.org>
References: <202003281643.02SGh9n2025458@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 02:32:04 -0400
George Spelvin <lkml@sdf.org> wrote:

> +static inline u32 prandom_u32_max(u32 range)
>  {
> -	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
> +	/*
> +	 * If the range is a compile-time constant power of 2, then use
> +	 * a simple shift.  This is mathematically equivalent to the
> +	 * multiplication, but GCC 8.3 doesn't optimize that perfectly.
> +	 *
> +	 * We could do an AND with a mask, but
> +	 * 1) The shift is the same speed on a decent CPU,
> +	 * 2) It's generally smaller code (smaller immediate), and
> +	 * 3) Many PRNGs have trouble with their low-order bits;
> +	 *    using the msbits is generaly preferred.
> +	 */
> +	if (__builtin_constant_p(range) && (range & (range - 1)) == 0)
> +		return prandom_u32() / (u32)(0x100000000 / range);
> +	else
> +		return reciprocal_scale(prandom_u32(), range);


The optimization is good, but I don't thin that the compiler
is able to propogate the constant property into the function.
Did you actually check the generated code.
