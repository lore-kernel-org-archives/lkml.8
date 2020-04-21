Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7620C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FFC20724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587494602;
	bh=I5Jcm7RMeCJ3bgoZs2RhR3gPOsn0ZDDQjq0QwlKiJhI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ivOlYWEQS7UhuKBpywHf5s9SqiSVkgm1eT2Yzt5hJj9UpB9tugcpougICDdmnRtjr
	 EPgUY31VZUleQtZUyRa+aG3tN2TGOGytkQr9eJsQpNnfZ49TV8t8dzD+g0U671VSUR
	 VrX9SoEXZZAVFNBe1Imc0Sxi8O8MwWV3wh0c8BgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgDUSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729562AbgDUSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:43:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14FAC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:43:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so11724691ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3kAvJO++eguajRXsG/n5n7oYF1JgCMF+hUCYrN1/xg=;
        b=OrV75sJ7JQKXSTP33LjV3QbwQ+1OpDpShCbzluaAml47IaJlXUCvCFVNh0dT2ICaOR
         tP0ellSgXMcc5k5ikER9Nrb93hnp/fuQwpjpJAgKovwu7iy+//ZOUhUHick8HqdJW50T
         eqBCUYMnjMNZdxRwIOyjYkSeElTNWpr5H0uG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3kAvJO++eguajRXsG/n5n7oYF1JgCMF+hUCYrN1/xg=;
        b=rCPZGTFQYZbpkHnInoZFjZShuqasnElLDH9v4NHXV/MS7xoZ68sXS+vrVCn7iK13fH
         QzBAgU22eSjtgH+IveL7HFCjM4+quEhBLzHjpYacR6DEmECHppSzBUPXABR9IU2IzDkl
         XWNUMmt/WdyBiXDePHs2JjYEDmSuc4NVzaJ9K3Oc1SY7gIkwQxgiCvVgKe6w+Md8wDTK
         GXsrEOZu4MXqyPECuvlHm75yPuksoxxwEejzFKfxJ5tve6FMRSVZp3N2mzumf/jPCG92
         GINTwR65vVETlKcqGoC9CTP3LqcS8uJw1UfZVJ1K0HL+mwVxwL9EZ5J5Lib6ucBHuVLg
         cKYw==
X-Gm-Message-State: AGi0PuYdOiYsBhtAh9N/fzVTyV0K8iPlfi+gB96dYd+eBqa0Qn10k9XM
        5DbvPxW4IstdnMLy/73+astysjugjB4=
X-Google-Smtp-Source: APiQypJvDlQtIDd+4OKeZFCXS07TkV2wZ3dLXGfmf9NrT/asxq0feSfzbMIFvdbdGRhunEsu8p6FKg==
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr4771724ljj.176.1587494594193;
        Tue, 21 Apr 2020 11:43:14 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id w19sm2759113ljo.54.2020.04.21.11.43.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 11:43:13 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t11so11942997lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:43:12 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr14821322lfd.10.1587494592604;
 Tue, 21 Apr 2020 11:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200421151537.19241-1-will@kernel.org>
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 11:42:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Message-ID: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
>
> It's me again. This is version four of the READ_ONCE() codegen improvement
> patches [...]

Let's just plan on biting the bullet and do this for 5.8. I'm assuming
that I'll juet get a pull request from you?

> (I'm interpreting the silence as monumental joy)

By now I think we can take that for granted.

Because "monumental joy" is certainly exactly what I felt re-reading
that "unqualified scalar type" macro.

Or maybe it was just my breakfast trying to say "Hi!".

                 Linus
