Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EAE2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592591242;
	bh=1EL+u17XS9wjA8YvtZff5yi/B7Uu39Klh9NWFH6a7I4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lnZ2ExGjuX/SxDZzyuPImu+arUKppc92Q4nPyX8y00KWSa4QcQqzMLCZb1Uk6bw81
	 H+GcLhBs1wjoEmj1BXYEgmEPj2gI/RxjokgFHn0n9ThA7LyJc4LRM0DQL+1Ky7b9lG
	 MtirxzVgK2OpjxmAcQ1wwsajY1zM9y+e/r6zoEN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgFSS1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbgFSS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:27:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC0C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:27:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so12579161ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPN24ZGnqztPM4FOkPhmPyAo8SUoUCZo8eSXyO4ELE4=;
        b=XrKhVqRHyXwP5vFRsxb1kUqnP9yLGw6d+GvNxr0aSX34pOZL7YV4KFcKYc6e/Z+ceF
         Nn8VRCtlC4+rY8ZpMO4JWD0sLQNfZJEfeVV/0k7qm9QMYmDC4uRdL67mZsqmkw8A5JHU
         SOJDALaARZOlF9TXQohaFKyPLGUPJdD5WROAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPN24ZGnqztPM4FOkPhmPyAo8SUoUCZo8eSXyO4ELE4=;
        b=RFqbCU+jn6rvUsxyeHlV/V3E4w6ri2+GZNO8K4pJfJ8s3afQRBBa9EKT0QHKXM+nzP
         0mpJvF3WHqKpMYJ4YTXVswE1bOuvFHeab0nx0ApwtNPkl0OhTgOG+OjNwTUaZ72Tc8Z3
         Lni0zLzqvXAUzdPlTcjuGDTHaDGr7eTvG/9kOd3enhdkU5KjH4k2i0BW8c4GmrVEejII
         bJZSh7jijE08HyXZL2+j2G9KrZ0WFc+WdTPy5+xwvS7eicWhMpNAv6v5bYeosIl8fgZI
         TCPO/Ruv+mWWFZZikVndPQa8uYdzvxQcDNuVllCF7wOUgTqUG+H2TXByH81pzkMUPXEG
         6v5g==
X-Gm-Message-State: AOAM532oppptjxZMbvL/W1OmYwYuBLO6MRB+9bkyvGr0jGrh9f7qz/u7
        Yk3YdfxoVwm9pqV1JjP43+0aw9Q15ak=
X-Google-Smtp-Source: ABdhPJz4M1ItSCyWmP/FJcLPQYqi9dvTHfvgAGDHsGfOJRl3xuFtEO7bv5AylSks8zsk9/tfzLQuFg==
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr2645697ljj.221.1592591236901;
        Fri, 19 Jun 2020 11:27:16 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h15sm1277884ljk.24.2020.06.19.11.27.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:27:15 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y11so12585688ljm.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:27:15 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr2412750ljj.102.1592591235422;
 Fri, 19 Jun 2020 11:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Jun 2020 11:26:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg04jR4PdocoLaYE-tL1-=pAdxwaPp1n0iKhcORqYY8Dg@mail.gmail.com>
Message-ID: <CAHk-=wg04jR4PdocoLaYE-tL1-=pAdxwaPp1n0iKhcORqYY8Dg@mail.gmail.com>
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
> Note: a recent version of sparse will be needed (minimum v0.6.2-rc2
>        or later than 2020-05-28).

Ok, it sounds like this turns out to be even more recent than that,
with the fixes for _Generic.

So i think I'll delay this until 5.9. Mind reminding me?

             Linus
