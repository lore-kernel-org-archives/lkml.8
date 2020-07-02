Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188D6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AC9206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593718978;
	bh=WOOij7zcrQ3F25W0H/8a620crI0Y+voXzhPPqY+Ohcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RF57aF7vZWf+URCK/eee15rTx7ycxFE43ooOMSaG9909Ob784wBEYYG2/Jmjc4ikP
	 UexQA+tb+hB5jPrvTzQ2j20rhbIPLoWHGUrrwfqbRqYO5YRLZpTiyj16ce+XtNXbb/
	 RMgX4D8JPpJ0XwBhyTCWyD6jEB8lOe3wvepIww9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGBTm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:42:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85351C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:42:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so30159929ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+r53KkXjZK6X/YP4U/7mih9+WzJuu5mUo2Ez1QHbKCs=;
        b=Rk4RBvhHIxqE+t63y4J9FplOopkeMM9EQgH5Tl4KhBHYcjFS04RVuL2G5TQb/4RcSC
         pArZxZMY9ot6xIrTJ7GaFWc9cau+XbYwcrHqWkjH6F+3gdtCFeoaEYVm/IEa0Z6UBBr+
         gxHLZuf9CuL986liZSn1ZkGZW8MaT8TOadzfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+r53KkXjZK6X/YP4U/7mih9+WzJuu5mUo2Ez1QHbKCs=;
        b=qn5zgEw2vdQlHaRJfVSn6sXSAFVj+z05cYyvOaNzp1eMrNEwC0dgzZAzAANG19pMiI
         0hHn+WqIfwtRe/rm+FctSVm9SnNI4HOMFOjh1cGjLzJcbeRKkJSpFEL3ecHHNFB+lexF
         +WYoTZ9p/luAuumuBsY9SmMxEkHnGTCMm/ea/1q0VP02kQhuj918ZJlcxyCHhA3JFPOT
         XYwezVnkRlnYHNzTop4DPlZQSwWnV6B30ABVUslliDzT/W5fpN9HOsTCNyfGQAeusdEs
         FlP7CM+M+Isoily66IlGUpTRx5S1Vxm3HP+wBpqfUFMr8yJ+EU+OE1L12iQg76kKxueq
         3CxA==
X-Gm-Message-State: AOAM533EcFvr/koWGm/GMS9HAOFs7gCaRwr1gsvm2KV3qn2rMfeiZdw9
        qdmKGNQzNQj2FRf0ACH3CxAeLJMIdN4=
X-Google-Smtp-Source: ABdhPJxkgTM+P/MAc6KCIelZErLLrBl3peEZVRq5W2gRN6wzsdXhDYbwq/FcSnx93KARj7UazOXMtg==
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr16413483ljf.257.1593718974681;
        Thu, 02 Jul 2020 12:42:54 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a16sm3364907ljj.108.2020.07.02.12.42.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:42:53 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id z24so8846105ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:42:53 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2490210ljj.312.1593718973053;
 Thu, 02 Jul 2020 12:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de> <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
In-Reply-To: <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 12:42:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
Message-ID: <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] moduleparams: Add hex type parameter
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 7:42 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> I'm just not sure how well this is received upstream because it only
> covers u32
>
> On the other hand that is probably also the most used.

Not necessarily true. I'd argue that "unsigned long"  is equally
possible for some bit mask (or other hex-likely) type.

So don't call it just "hex". Call it "hexint" (the hex does imply
"unsigned", I feel - showing hex numbers with a sign sounds insane).

That way, if somebody ends up wanting it for unsigned long values,
we're not stuck.

Another option is to just say that hex values always have bit _sizes_.
So "hex32" and "hex64" would also make sense as names to me.

While at it, should the hex numbers always be padded out to the size?
The example Paul used doesn't have that issue (high bit being set).

Bbut often it may make sense to show a 32-bit hex number as "%#08x"
because it really makes things clearer when you're looking at high
bits, say.

It's really hard to tell the difference between "just bit 27 set" and
"just bit 31" set otherwise, and that's not all that uncommon when the
bitmasks are sparse.

             Linus
