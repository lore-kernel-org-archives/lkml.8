Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED75C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958F824650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIwqxWQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgBUBh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:37:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42759 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgBUBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:37:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so602520otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 17:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gwaIL0Zgd1393X/RibdnLwLrFqFzUdQWIreaIHF/WLw=;
        b=iIwqxWQ4u/9znwKAlwzdzQqJrZzfeBhCG70xvk1hPhL9rd/Z6fFnb9Iu0pJ4qYDHoN
         jX0C/RNrFadi4Ap+ZsjhHqbLHPVC16W7MigffpaR127jX2O5xx+lgkcMCrbKWS+Lmp2U
         uzL94HbeKvS/ekYuWJmtC01dANoCZsIjRTC7YTnloxqc/n85nkorruVF2nBPo3B/YBid
         ARdBz6AWPcm2Sbz0rJ67uVMj9s7YXUA27DyMfJxNKz2My0O62EMICBGOcvRPxKwww0BD
         HQtRD9aC9EGvyBT4LLB8TUBDgpAl3PnQgW/sbw8HCOnQb7Cn0N0kO7QcuuSaR+Mx2ofc
         TdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gwaIL0Zgd1393X/RibdnLwLrFqFzUdQWIreaIHF/WLw=;
        b=FJa2iaMD7rUgJ5uJzAmrASeJGJzBG6V7SZmZVFVQum86ulSdD0pwZzYSjwJ0mD90RX
         Ctt570v6RSMUb9NaSe5/rBU1D1kKb7BVq68yLGf3/EW8Oo4YbcpTs8845VV3jHkuKHKh
         5WSX8g1nqiLWr1fnM37E+/SLEfr8qVnfkUkunqH4UshxkS+Wk/7stNWRNU2VKHJsx/dT
         ddLUTLrV+5cVlIdKSmQF5VzS7SP6Joh7KWIgspPpTQro+u0fac6LApbmtgZ56/SQA8T4
         HKntBj6AWObgbdNw+X0JvgiwMTxOpvUQwT3Y60iepGX2uuZkLOjec8PNVfJyJX7gk9iJ
         28Bg==
X-Gm-Message-State: APjAAAUmGtApb5CslEMK8HqrbthNo6HQTa648gswIQEUHF54mTHMpPkW
        Yi/A+zsxsdU93drnSfTfIAM=
X-Google-Smtp-Source: APXvYqxy9kbr7XHBnZUt1BeLIXoaHOsii1k8aJhci8JkdsdnQNQKC4zJbiBitU6vYTO/HrluDHgCvQ==
X-Received: by 2002:a9d:21c5:: with SMTP id s63mr13555844otb.142.1582249078447;
        Thu, 20 Feb 2020 17:37:58 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c10sm460048otl.77.2020.02.20.17.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 17:37:57 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:37:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] mm: kmemleak: Use address-of operator on section
 symbols
Message-ID: <20200221013756.GA8323@ubuntu-m2-xlarge-x86>
References: <20200220051551.44000-1-natechancellor@gmail.com>
 <20200220173501.0de88326911e41b15e27b62f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220173501.0de88326911e41b15e27b62f@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:35:01PM -0800, Andrew Morton wrote:
> On Wed, 19 Feb 2020 22:15:51 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Clang warns:
> > 
> > These are not true arrays, they are linker defined symbols, which are
> > just addresses. Using the address of operator silences the warning and
> > does not change the resulting assembly with either clang/ld.lld or
> > gcc/ld (tested with diff + objdump -Dr).
> 
> I guess you forgot to quote the clang output?

Ugh yes, sorry. I can send a v3 later  or here it is if you want to
stitch it in:

../mm/kmemleak.c:1955:28: warning: array comparison always evaluates to a constant [-Wtautological-compare]
        if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
                                  ^
../mm/kmemleak.c:1955:60: warning: array comparison always evaluates to a constant [-Wtautological-compare]
        if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
                                                                  ^
2 warnings generated.

Cheers,
Nathan
