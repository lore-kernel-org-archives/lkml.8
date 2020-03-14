Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0DFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBD32074A
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584146429;
	bh=6XBzNk9f4cBp+6gsTMIq5tmmgeRde+XSt+QOe7pklG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ahPSLFgPqG2Qi3wrA4YiOsrs/LQ0yjLs0xKYjudcJUM0i0ybqRHMkvFBHzZw+bPhy
	 tUWbibAK6KQHxNDQU0COXhwmawcpHwE3us0ihSr55+MJ840JcB2o4cezEko7fJ8SKC
	 IlyPZ3Nsb4bjCNVwBC2ihTsa+JhEHoZW8Rm0Yqd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCNAkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:40:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43493 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCNAkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:40:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so12514487ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqSpkfWgbM1F3EW77t+yz+x0olHI1MIS3rmLQvUjsfY=;
        b=h0Tz0gWq3PbDuwAlu8mqUD6SjZrPMaRqc/j4UZj9jQmUowcFOJJIi9ZCL8z83J1tXE
         7Au04VqmCECr7JqBbrxgltGl9GD8U4c5Fd2GyuYbKWoDz44wGtx5f6hrTX4vk7/Z25K2
         eP89+Og4D6pSQCoVRZqpyW94FiDJOnuSc0uxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqSpkfWgbM1F3EW77t+yz+x0olHI1MIS3rmLQvUjsfY=;
        b=kr0zyuVIsdSLASlCpQIEb3azy2Jc1Ml3WPvBS1SCbrqpAD48T6tYlXLjVdB5jTzzF1
         eWt6id5Ee8+hrEcaJv2qJzgwQIkLmXA/c2TYvzJ79OKsfdDI7/u4LQyFC3+2LEXtiRVd
         8bqlvEUC5Npm6dS0zSXf8LWL4J2JeIWi/0Pui3cIsRiAFCndB4L5l72HMuiTxQazN39M
         Gi/xRANYVgdlqWydqfHaBKmlm1vp970e7q74Dr/hk3VoyBX/9OzePya6H/8tOT4OcYZE
         v9bwuXwsMx3yhfEORPctjuDj4Lma83Q5ckYAy8292G0KxfzqysyWaNPRHjbk7GSIca/0
         +SVw==
X-Gm-Message-State: ANhLgQ2m0bEgor2rp3E9TyW89Epcaqne5M6t8PHJA6jp2RsmLd9D/5Wz
        dTzVqGo4nV50EnIH6MMAXOFKsO6+1Hs=
X-Google-Smtp-Source: ADFU+vuOIPTrogx32ItSzjOZoa5s5+y/1NTk/C+CFkxSdLXPvMCUC2QApnqDYeByFOjSeCeSH6dxoQ==
X-Received: by 2002:a2e:9949:: with SMTP id r9mr8216866ljj.135.1584146420366;
        Fri, 13 Mar 2020 17:40:20 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r15sm3217009lfp.93.2020.03.13.17.40.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:40:19 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 5so2226332lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:40:19 -0700 (PDT)
X-Received: by 2002:ac2:5508:: with SMTP id j8mr10082934lfk.31.1584146418864;
 Fri, 13 Mar 2020 17:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-20-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-20-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:40:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQjL+W66NZ=+Rc_ibEznmt9bcY5MjxgLkqV1DtrFM4ow@mail.gmail.com>
Message-ID: <CAHk-=wjQjL+W66NZ=+Rc_ibEznmt9bcY5MjxgLkqV1DtrFM4ow@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 20/69] merging pick_link() with get_link(), part 2
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm..

On Fri, Mar 13, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>@@ -2370,10 +2375,9 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
> +       while (!(err = link_path_walk(s, nd)) &&
> +              (s = lookup_last(nd)) != NULL)
> +               ;

There's two copies of that loop (the other being in path_openat()). Is
there a reason why it's written that odd way?

Why is the loop body empty, when the *natural* way to write that would
seem to be

        while (!(err = link_path_walk(s, nd))) {
                s = lookup_last(nd));
                if (!s)
                        break;
        }

which may be a few lines longer, but a lot more legible.

I don't think you should use assignments in tests, unless strictly
required. Yes, that "err = ..." part almost has to be written that
way, but the "s = ..." part doesn't seem to have any reason for being
in the conditional.

And I'm only reading the patches, so once again: maybe I'm messing up
by mis-reading something. And maybe you have some reason for that
pattern.

                     Linus
