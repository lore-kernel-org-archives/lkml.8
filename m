Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750972098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592352440;
	bh=AIeCcNEUbjZIbmg0xuy637fpESdlR87uGma6r2v2FWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gXCCKXPGolSC6bxECCvD4lDubJUNu57XgVOaDbmeYFWPjT1lTaK9jZMnHDO0/yvzk
	 pIk7iEBj/0K0IiXTPoauUFvNnfFDfBkjLgLoxrVZT6XaRZjjDkib4R17393rT7FPJh
	 oh9rDjI4EJtway1j1tDwt3bIt2q/O9XRSg2RQggM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFQAHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:07:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:07:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y11so641440ljm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HP1uFW4sLGpGIoEXTGEFuCHmhwb0G5+9yO9YHFU+ats=;
        b=B9RvaNNfw2XkhWkqlRQ3PtpGYvSfdqW+PwRggujQQq4AZ2B7b5X7/BnqV3v4c/2PkZ
         ENTqIwC62xfVi9KUmaVAVUpoXme71+DSirnDrOWf9H+TaASjGvOPKPcZe01K2pTusWK4
         hfjPILq5L217zE2mGrEFMskNrCCGRfMLIg/v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HP1uFW4sLGpGIoEXTGEFuCHmhwb0G5+9yO9YHFU+ats=;
        b=e3woq/vb2y7Fq4H+FbkZUSYiC/XZewSPM8T98qWqkwCdOHAh81A5p4a+cy2pbQNY6T
         jUIiyz6FP4UkTNjVQLkYO+sIS+uORe74c+05TF2GONBNp4dVELSGv+C4r7dnmKUma3/p
         QPzqXhAhdOllAqr/OU9hRp/HHd7hxVtF9wjTESvHhZzSRTbsDCd3Ukf8lzX3+TvLTSIM
         9Xv99st4dL83Nlbd7nfTHXuTEDhCvv9Hce8JS8+XujVCanLGuXhLC3yRtq2GNYAoBIJO
         B+L5hNoLbhZzPZVKVyS5F6qHBambns00vZiQnw4AQj5gtUlxcJ6d4cFKy3DteyJLhlic
         /76Q==
X-Gm-Message-State: AOAM531Ts9shK2FlHBDnBdyPjZttwFeHYqg10OQfrpGYSG4dzXKM+DJl
        EL3tP77faT8Kpdp9qhScc9lRqQGBJkY=
X-Google-Smtp-Source: ABdhPJzOKhAhWkLFl/w8V2XxK2+9ZyTGDxihj9kh415TD2TNwZIXFz8O5H6Rp2JpDZuUoShKz7IkRA==
X-Received: by 2002:a2e:7219:: with SMTP id n25mr2719491ljc.164.1592352436509;
        Tue, 16 Jun 2020 17:07:16 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v23sm4646611ljg.122.2020.06.16.17.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 17:07:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i27so613367ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:07:15 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr2751552ljj.312.1592352434877;
 Tue, 16 Jun 2020 17:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
 <20200616222547.1979233-1-nivedita@alum.mit.edu>
In-Reply-To: <20200616222547.1979233-1-nivedita@alum.mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Jun 2020 17:06:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_1mQmG5H4ZVcNudjhQyxTNTtni6hV1nTkEY2QQJzgAg@mail.gmail.com>
Message-ID: <CAHk-=wj_1mQmG5H4ZVcNudjhQyxTNTtni6hV1nTkEY2QQJzgAg@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Add -fno-stack-protector
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gabriel C <nix.or.die@googlemail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 3:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The purgatory Makefile removes -fstack-protector options if they were
> configured in, but does not currently add -fno-stack-protector.

I took this directly, since the build failure seems so annoying if you
happen to have an affected compiler and config.

Maybe that's not very common, but ..

              Linus
