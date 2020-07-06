Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C788C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1177320747
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="IVgCIdZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgGFDNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 23:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgGFDNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 23:13:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9016C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 20:13:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so40343044wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 20:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nr50V7tn4Q86r235t3i6fTqGi0eaGxnf83LBZQTEWJ4=;
        b=IVgCIdZ1fdyJ/ueZWXvNLujhD/ItQZmfywlnzlVUzj+QJMzwEGuIugD99RDKVCO8yD
         BbF9C4isTrmHGMPCIPtVz7K6fslSXe0FsAuDoDkrcH1HIHWVzh2ytCipq/wdVlMLI6jT
         QdGrlarHQN7K13Wb/uTZell3eXj7NOvl5N8yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nr50V7tn4Q86r235t3i6fTqGi0eaGxnf83LBZQTEWJ4=;
        b=cvgpCqZ2rup6vp4xKpAeAjmhEMo0MAbDw/nGK/sxQgINQ3f2MB9X/n3umbI1Y9AneE
         yv8rIJC3alfCKBwvriMcM1MONrBD5wDEBxUeQ6co92TzIkYktE6MR/VlSULjuq6xHfEi
         kbHL+GTgF8oeRuPXLvFjztqw01HpwhTMxL7pm4nxkRnUpOMjmzpQoksM6Fgdwe+ifTkD
         hk/i2Lrd5dEXw6XHuAkwFCoEQ/XrPKV/ZUgda2Rk+kag955WR6qgfl8+hF/9pLJk759J
         /60+KBQDer+F5lNRsAIoEoBoBecyrt8uYC4j5Y6mUQP3qPnhYg2mb3fA2TqtpS7mrYdk
         x2fw==
X-Gm-Message-State: AOAM533AzO1zELPopHRxeB3EZ8StP4Ia/gKBfzLjy/+H2Wafed7mxBoR
        785nMjtjyfpjbd2eNKuKMea7NNVJogOYmPtTIKWPQQ==
X-Google-Smtp-Source: ABdhPJyN99BeGm9A2Rz/YYoo8bjGijPt5/+BN2tFGB56CztqStsKXLo+n5eHwOgVVwENrY+PfxE1PRUw1XTAhP2rD14=
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr49533729wmf.137.1594005212447;
 Sun, 05 Jul 2020 20:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu>
In-Reply-To: <20200705045505.GA2962@1wt.eu>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 6 Jul 2020 12:13:21 +0900
Message-ID: <CAFr9PXnr0R71_o_0-Xmw0tcN9UUTMu1ahgp3ig5kE0LG=6N5WA@mail.gmail.com>
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
To:     Willy Tarreau <w@1wt.eu>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Sun, 5 Jul 2020 at 13:55, Willy Tarreau <w@1wt.eu> wrote:

> I'm personally thinking that for a non-native speaker it's already
> difficult to find the best term to describe something,

I'm a nobody in the kernel world but this point made me think.

I'm a native English speaker but I don't live in an English speaking
place and my experience is that a lot of technology terms have been
directly imported from English into the local language almost as-is.

In my case master/slave have been directly transliterated into
Japanese as masuta and sureebu and exists like that in technical
documentation for example:
https://www.analog.com/jp/analog-dialogue/articles/introduction-to-spi-interface.html#

I can imagine that by changing terminology that has been in use for so
long that it's been imported into other languages directly or is
common enough that non-native speakers know what it means might have
exactly the opposite result by excluding people that aren't native
English speakers and can't decode synonyms that are obvious to a
native speaker.

Cheers,

Daniel
