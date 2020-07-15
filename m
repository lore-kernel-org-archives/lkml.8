Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAC42065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594854329;
	bh=3z/cHgrm84T2O4YmhIHKwlUlHCpds4FmbH21kgA7QPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RXoxOmk9KxK5J1eA7YwPw/qAr7qltwfW76xVqtRDjPk7AvnIkriLL3lRAZMm8drzX
	 j7nYKKgpJMgejNmgb+Y/Nwk5kSR/6xtS7lLQOuur96dCNs+Eu9wrR8MbHSUFtcinFC
	 /w/Nns8ws/D7MoS1g+HjE6xsudzkVUzu10u17EE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGOXFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOXFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:05:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35029C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:05:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so4696271ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7b58/h5ygcF8kKv7hgx0H1e7z/j3xwcZDk14pT0DbM=;
        b=VfbflGy/HM2cZzGH0dNGp5YQ7VcJfDItB1n+tAqhFQc6mj3d7qLNTmWwWTJdwZ9MSa
         +75uVzkhz7POD0P5pLG4XiPzOv+Iqp4wbAloW9OKLMJk4B2QaI9cbBqJkPNl5tTef6DK
         4x+iZ9WNsUegvLM+Y8yj19d7Z/iz8UalyR9TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7b58/h5ygcF8kKv7hgx0H1e7z/j3xwcZDk14pT0DbM=;
        b=jcEiOrxi3cgND/ZbqihNfkX5gw5wI+AGXPSAwPcpgcQfMlI4IrBxmGkFrTMHJkLHl5
         rIMMdciryhX4ihsqZhXYQRhi9VFOz+N7jm0CgxzEE2RYerGIGkVEiRQX4PVnEj2AtgLF
         p39UxDYMus1AKdHphI6qBPjpVzracvRVr5PiGoOsFtyHk74PZUX9//d7Pu80P0xQFMcK
         zTpjzh8l4TfwUyyqjS1D44sAam/8VJ2Fr92LKKa93833MJ8Dg4jk8ZdItsA7Z7yO09St
         SOJezmoaCi9KPoror88JNSj11EhdzJDCsM18NltVFrR3M9C3spQaxdcoXoyp6vA2G+FI
         0UbQ==
X-Gm-Message-State: AOAM530T3tes4314vCnnSwwyuPUg3nls+5YUpC/+CWNrIMebphZkRzqH
        SJZdp1pzIFj2m2lS4rYvfUR168tRVzw=
X-Google-Smtp-Source: ABdhPJzqhzcrm/bT0lO7dLiOHNkAf5pbX6r/hbSMFx5oeTKwA6ODmFgZ3h8yyn9OdxXjDP5r0hbw4Q==
X-Received: by 2002:a2e:3804:: with SMTP id f4mr612708lja.90.1594854306308;
        Wed, 15 Jul 2020 16:05:06 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l14sm768098lfj.13.2020.07.15.16.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 16:05:04 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i80so2079179lfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:05:04 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr619665lfd.31.1594854303661;
 Wed, 15 Jul 2020 16:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
In-Reply-To: <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 16:04:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
Message-ID: <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: multipart/mixed; boundary="0000000000003d291905aa82f406"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003d291905aa82f406
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 15, 2020 at 3:57 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But now I've screwed it up twice, and have a splitting headache, so
> rather than stare at this cross-eyed, I'll take a break and hope that
> somebody more competent than me looks at the code.

I lied. I had a couple of pending pulls, so I couldn't go lie down
anyway, so I tried to take another look.

It *might* be as simple as this incremetal thing on top, but then I
think that code will no longer trigger on the stack movement case at
all, since there we don't work with the whole vma.

So if we want that to work, we'd have to fix that up too.

And this might be broken anyway. My track record isn't looking so hot right now.

                  Linus

--0000000000003d291905aa82f406
Content-Type: application/octet-stream; name="patch.incremental"
Content-Disposition: attachment; filename="patch.incremental"
Content-Transfer-Encoding: base64
Content-ID: <f_kcnz23n30>
X-Attachment-Id: f_kcnz23n30

ZGlmZiAtLWdpdCBhL21tL21yZW1hcC5jIGIvbW0vbXJlbWFwLmMKaW5kZXggNjE0YjRmZmZlZDFk
Li42YzNkZjAyMmZmNjQgMTAwNjQ0Ci0tLSBhL21tL21yZW1hcC5jCisrKyBiL21tL21yZW1hcC5j
CkBAIC0yNDMsNiArMjQzLDkgQEAgc3RhdGljIGlubGluZSB2b2lkIHRyeV90b19hbGlnbl9zdGFy
dCh1bnNpZ25lZCBsb25nICpsZW4sCiAJc3RydWN0IHZtX2FyZWFfc3RydWN0ICpvbGQsIHVuc2ln
bmVkIGxvbmcgKm9sZF9hZGRyLAogCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbmV3LCB1bnNpZ25l
ZCBsb25nICpuZXdfYWRkcikKIHsKKwlpZiAoKm9sZF9hZGRyID4gb2xkLT52bV9zdGFydCkKKwkJ
cmV0dXJuOworCiAJaWYgKEFERFJfQkVGT1JFX1BSRVYoKm9sZF9hZGRyICYgUE1EX01BU0ssIG9s
ZCkpCiAJCXJldHVybjsKIApAQCAtMjcwLDYgKzI3Myw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0
cnlfdG9fYWxpZ25fZW5kKHVuc2lnbmVkIGxvbmcgKmxlbiwKIAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKm9sZCwgdW5zaWduZWQgbG9uZyAqb2xkX2FkZHIsCiAJc3RydWN0IHZtX2FyZWFfc3RydWN0
ICpuZXcsIHVuc2lnbmVkIGxvbmcgKm5ld19hZGRyKQogeworCWlmICgqb2xkX2FkZHIgPCBvbGQt
PnZtX2VuZCkKKwkJcmV0dXJuOworCiAJaWYgKEFERFJfQUZURVJfTkVYVCgqb2xkX2FkZHIgKyAq
bGVuLCBvbGQpKQogCQlyZXR1cm47CiAK
--0000000000003d291905aa82f406--
