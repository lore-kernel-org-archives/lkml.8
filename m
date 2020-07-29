Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD64C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795722074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596066207;
	bh=z/IRjCSO+knMWd3bg/xAbGNuaCEIdQLrdJuFLnoJYys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f6SFBqehI4q3hHE2YOlag+WTQt9yzvKvm6QrBZEmlDzWUGsdyHjx+F3uCqVfrtRN9
	 wSXwf8/AlUKHboHx9lsea5vi9WfUbnXRPOP8cqZ6NOf1ZPEVmDjbdKF7urzdMCgTCr
	 RqNUrIsxQLQHkNFCECxGbEBmbTqpnZ56f3MuhBv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgG2Xn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgG2XnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:43:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E613C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:43:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so3394859ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLb39v1oq5FRSvzH9bhk1WYh4C3cI/mPlFpmehg+P8U=;
        b=bJY1IJETI9mZ6ooPJU+FDg9B7jzap0h2Yz93SPYM9zKJ9Wdg5rhq1Q38+uqHFUftp6
         yXS3OWEtQE+ECx5vOXCBAGIp+ZFWxHA4xV5cJeTIyP54f59CP+/hvMrC1NPhC8s3Ij31
         Sk8Hf3X7mT+6eSMW+Rv2JLhvzWZAuA8ve65jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLb39v1oq5FRSvzH9bhk1WYh4C3cI/mPlFpmehg+P8U=;
        b=TFbRTVtGQiR49Ul/7IIDRP9bbmkcm7BCZqMk1d8C/89MlV6qGy03lIWVS2GPpOD+yC
         VExxvh2p7aJTEqTapz6x3zSy/53kaW1QBVua0h+fru/XVyUsM6b4ShmadI2b4Wd9Kajd
         Y4DBClYT3fsJYdsAQ4KZc5Yl/mikcidv9DkWDNRoQr+lBsMZxLCejWzvuYCnEwe6oZgW
         hV991qiPPo33JuhIJ6OFpGeGPAlu6IYp/dil9sMc5W2OabrP0P7e87nO6ZhDj38v5ocH
         mNYYHjNrEmPjwSpULaOLV8S8rFtz4EtTFHGtPTDRpYW1oCJhGx2SJ0sYiKkrbbtGy/5g
         tCBg==
X-Gm-Message-State: AOAM532nEzd2qouSa7nwmUxrUCwJ/OSTVW6ibyrkhBN+cwVlgvXtYeT+
        6PxBobvq7TVIC9QswZwsrcF/txZGjnY=
X-Google-Smtp-Source: ABdhPJx3Xq2AerslklrMh7aiLx8bmRRrLdeZY+o3uhH1zfzioX3eq2R/ZWR75fimIiqyQ6Kdz4ItZQ==
X-Received: by 2002:a2e:1641:: with SMTP id 1mr119858ljw.73.1596066202099;
        Wed, 29 Jul 2020 16:43:22 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y26sm660612ljm.132.2020.07.29.16.43.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:43:21 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i19so13965710lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:43:20 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr171970lfo.125.1596066200379;
 Wed, 29 Jul 2020 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200730090828.2349e159@canb.auug.org.au>
In-Reply-To: <20200730090828.2349e159@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 16:43:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
Message-ID: <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Emese Revfy <re.emese@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 4:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> include/linux/random.h:123:24: error: variable 'net_rand_state' with 'latent_entropy' attribute must not be local
>   123 | DECLARE_PER_CPU(struct rnd_state, net_rand_state) __latent_entropy;

Hmm.

Ok, this shows a limitation of my allmodconfig testing (and all my
normal builds) - no plugins. So that problem wasn't as obvious as it
should have been.

That error isn't very helpful, in that I think it actually is very
wrong. The variable really isn't local at all.

I think what the plugin *means* by "local" is "automatic", and I think
it uses the wrong test for it. IOW, looking at the plugin, it does

                if (!TREE_STATIC(*node)) {
                        *no_add_attrs = true;
                        error("variable %qD with %qE attribute must
not be local",
                                *node, name);

and what I think it really wants is that it has a static address - so
a global variable is fine - as opposed to being an actual static
declaration.

Also looking at the plugin, I suspect it is going to be very unhappy
about the fact that the attribute is there both on a declaration and
on the actual definition. The code later seems to really only want to
work on the definition, since it's creating an initializer..

IOW, I get the feeling that the plugin is confused, and it so happened
that the only variables we'd marked for latent entropy were static
ones. But I haven't done gcc plugins, so...

Adding the gcc plugin people. Otherwise the only option seems to be to
just remove that __latent_entropy marker.

                    Linus
