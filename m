Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E3420768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592260381;
	bh=TcSkE8feA1Y5hV3SRpqYFksS8VaMhXK8tXnnlRGauik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Nse0dAJvJn3WpHbChbSMIB3/kIkTxv2btx1vwhnrar6S2S9g0m/gcDoVaH7FoUDBB
	 i/WOzTRYFI9g5Lu5d9zmcqbmZxQvkaOzn2uy4m4ePeKvARG7Pcd30Ixzh6iuTHDiiW
	 Qom+HGrgEGxgF+Q5UPhTubxg57kPfSGShsfrSHUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgFOWdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgFOWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:33:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994ACC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:32:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so21150329ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vd6AIgm+IPo36EOLrgfHWggTU08p8NWiT28+L7heEG0=;
        b=gcjDZqGeH9Zuwf3pX+/VMlji/YXNA1F0wAexen6Z6HTt2gX9G5IUfBVO7vSABxCJDg
         Ey2OaU0b7tX3efR27AMqGHD23Xibbxpq9t/Reyc65DQpSmDjKiZC87fj5q5fWp4RZa+r
         xxKOHE+484EY1f6IwzY2RWcrmFqZieNm/9XX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vd6AIgm+IPo36EOLrgfHWggTU08p8NWiT28+L7heEG0=;
        b=c/4mu6yd/EaVBNZ0CJKZIJ3PLtr5jcmpMW+4z98O6/7kWSkcWJRfH6lbYT+ob6/MIt
         vh8e+8EVl8emMIlc4O7xujHecUk8Yydl6ySxaiAGnOUBDhZHsUhyuJSQ87DF/4aY2PTb
         HlYLHMfkR5QAcGX99iasGtYmqaY8e8IenVcE6es1aZtCXo/LgmvUKI8H1ygkCmW9eTvb
         jjjpjBAyVzm9/6Pib4FsxQpbIoy8PPVwHfqYsATJhP+jDd8GmcIOZvtNVF91spTPgCw2
         3plgj6URmgDvX9WCRp+cPnyeUgKYTTzgEMewgS15s+JgeFPf440TrWnHwnP7gS4lAfuy
         L8ww==
X-Gm-Message-State: AOAM531UvicDFW5KhWEnS0U4lnTBf82X/fiD5+O8wn4rwl0QosWDu3WJ
        jAKAoPQkshiRFFXm3h6dmTsR1SAFmF0=
X-Google-Smtp-Source: ABdhPJxJ1Ka550LM1wSPssCes5YbOwuU3TS/xxWNomr3z07Wieh4SBrLVudSFZelPEu92God0PJqrw==
X-Received: by 2002:a2e:8858:: with SMTP id z24mr14287937ljj.128.1592260377782;
        Mon, 15 Jun 2020 15:32:57 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 1sm4796606lft.95.2020.06.15.15.32.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:32:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c21so10553940lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:32:56 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr93022lfc.142.1592260376585;
 Mon, 15 Jun 2020 15:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-3-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-3-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 15:32:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3KYWKMPWYcyu9c-UPAwCXMcN86Wr5xyivCumWxEi7AQ@mail.gmail.com>
Message-ID: <CAHk-=wh3KYWKMPWYcyu9c-UPAwCXMcN86Wr5xyivCumWxEi7AQ@mail.gmail.com>
Subject: Re: [PATCH 02/25] mm: Introduce mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
>
> Provide this helper for doing memory page fault accounting across archs.  It
> can be defined unconditionally because perf_sw_event() is always defined, and
> perf_sw_event() will be a no-op if !CONFIG_PERF_EVENTS.

Well, the downside is that now it forces a separate I$ miss and all
those extra arguments because it's a out-of-line function and the
compiler won't see that they all go away.

Yeah, maybe some day maybe we'll have LTO and these kinds of things
will not matter. And maybe they already don't. But it seems kind of
sad to basically force non-optimal code generation from this series.

Why would you export the symbol, btw? Page fault handling is never a module.

              Linus
