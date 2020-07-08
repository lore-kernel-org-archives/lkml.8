Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C21C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8B1206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594234959;
	bh=knjfuE7oCrMT8obCWmXWt1S6HEidHvazM30Kcr9IukY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W1WTNyVpKOFGWTPDMojl51bjWx7R2G8W8iKa5JRD8lgIQI4XFhS+uTMxDo30aEjt1
	 6jD9GSbzybPE7Adse8WpXgpHgaUPy51fzHvfH1/T+rVhSnuqEh0y7pG+cj3KMENgiC
	 +RiB02YAVZYOXBAmtPKZng0nX+YliQ/0yVQb7Ldg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGHTCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:02:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF7C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:02:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d21so27496432lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5115ImYslKfjMDqc7NsPb4rG8ux/IPuWI7SmA15my20=;
        b=VfOVxnS8t9jIP6A/PhnDeZTJa6VU7WbTHxuhR/KuXFbik81hMadIMpVWzkQse/TrRV
         +MzC/V1hjDJAHrNlsTvUw3cgahsgcFeihvGEgdzKHIUgPGGRJvnI7d+frXg5sdTQDDYq
         oyqRv5ychV87bWZwfT4Kn4zxumanVZ3utiPWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5115ImYslKfjMDqc7NsPb4rG8ux/IPuWI7SmA15my20=;
        b=iH9RezpYnNc8QBKiNbTBC+OxMCLeB759WO6RL/whzcVu78Es5uqY3j8vUlNMlB4p/n
         0c4jRo4jkrONV7efmXFW/RA0eAca4P9UmKdQko9M/uLqt2Feu/0t+iRFp/e8BhMKT65F
         Fqm3aZmdZF3kDRxmlPoXcDde3pMTah3Z8O1qsaAD7fqejjOFNlmaWcvb6rkKdXw41O+N
         SzJPNKzp77APum0CPjIAwjmobps/sZchlewjMAwUzOZgS7lzTQ/PcRWZV2422Ts5OLr1
         M1cdzxjTK073Kmy0Bv00gvfOMtWtXGpIq5QcOFvt7mRufJWoYtUXD38yTeklmll5256I
         Ynwg==
X-Gm-Message-State: AOAM530qVF6k6mKd8ECBpEYdaAg1pis9mb2f/TXpv//YthGzwJ9fsxBT
        rZU08BbsIguoNqbYxeDok/+SjUVuTuQ=
X-Google-Smtp-Source: ABdhPJwmVGrqR4IKeKUgMd32UXprhFrj4GFlTHSujODruRfGeMOoIVlykmMEJYByd9P8foNGkOBc/g==
X-Received: by 2002:ac2:5217:: with SMTP id a23mr37647468lfl.115.1594234954849;
        Wed, 08 Jul 2020 12:02:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r22sm203215lfm.30.2020.07.08.12.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 12:02:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q7so42238723ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:02:33 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr20455243ljj.312.1594234953413;
 Wed, 08 Jul 2020 12:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jul 2020 12:02:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRDFAkN-KNpVWUbf=1RUGn3=nMx6aZ7z2X9OhH5db-Og@mail.gmail.com>
Message-ID: <CAHk-=wgRDFAkN-KNpVWUbf=1RUGn3=nMx6aZ7z2X9OhH5db-Og@mail.gmail.com>
Subject: Re: [PATCH] sparse: use the _Generic() version of __unqual_scalar_typeof()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 3:26 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> If the file is being checked with sparse, use the version of
> __unqual_scalar_typeof() using _Generic(), leaving the unoptimized
> version only for the oldest versions of GCC.

Side note: for unrelated reasons I decided to try to just raise the
gcc minimum to 4.9, which then makes this patch redundant. The old
non-_Generic() case simply doesn't exist any more.

Of course, maybe somebody screams about having to use some gcc-4.8
version in their environment so much that I'll revert it, but I doubt
it. gcc-4.8 had lots of problems.

                Linus
