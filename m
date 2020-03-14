Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7746C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA9F2074A
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584146559;
	bh=fMt1LmDe8niq6cjbhyN0NHJJG4Y1yKKZ/AMTwWhYE0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kNTzGyTTmIFkqB1u4gMsnzddtnum0udZc2yAn+fB3RZsOCsABUXlST4M5voVjEsMI
	 7bvKXgYQU9nZEtjb5oPYoY8RizsaK5AQzjiuAK454TkzjNd89ExOo8RbFXwrFG/qel
	 WvR7B5YaY0ovUG3I11q7/yZEr898UUYMhA9oomWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCNAmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:42:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33051 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCNAmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:42:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so12542698ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RwsAxU8WnehWNYnYawqMDWrndD0IlWbUqTUz3Fam9I=;
        b=Iujf8nmDlOEl8DuY+scdOEaoXNtqE3/87ZkLYwqmOxxEburi8x/PvzjADUkVWiuy6t
         yu0Mw4qmnFFYOzNVqGfC3HzJwT5Xf66YvEA3e9tIjJ37wHKrLORYFkjcemchA+IRQRdz
         Nl+7RN1k830zJspW3aLfmSCT4Jr3sv7xVzmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RwsAxU8WnehWNYnYawqMDWrndD0IlWbUqTUz3Fam9I=;
        b=BeJ1TSnyJmPmiOeXLjPVl3/riOjHGdPV89nYET6+W3PEsl43VM+lRorksD6q10SSO1
         Kj+d9k0ZT8EAY9BYyEfOMGsdgjcqMwtTSHBnfJ3PAvJWvezD2IkfTG3Ne2NKNTtchdz5
         SeqQS1cD2gF/U5M1uRvTtqkXvUz4PmdhEYmdEP1hR8FftcPU52IJXYIy1rMMJKhdGeCr
         ltR5hGbYaPIwO8lSR/qB6L4QjSH+cW2izKR2JD8aUCIYqU/E+z75mZHCuxZLheXV0Nnx
         yhbVBsrWw1Bi8DQ66NDfS91+MopNHEOQzrINqEG6BRXG4uR9rIQctdpWVDUKjbuBIdSk
         djYA==
X-Gm-Message-State: ANhLgQ3Jvqiq2XEv2tzZs83Xk9Ckp74S1DjAvKHSjxB04JR+8jEQ05fC
        c/mJxN2EIbzuAAHgG/QdluDi5viT8bk=
X-Google-Smtp-Source: ADFU+vuKfG9+6c6VdRncJMQQZGO0uXP5n2GqmMv+ZjZ4KP27xsV1DMGwdKCve2VXrJSNgH6Uxdx6Zg==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr4993880ljj.58.1584146555286;
        Fri, 13 Mar 2020 17:42:35 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id z21sm21786966lfd.67.2020.03.13.17.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:42:34 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b186so9240485lfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:42:34 -0700 (PDT)
X-Received: by 2002:ac2:5986:: with SMTP id w6mr9930880lfn.30.1584146554075;
 Fri, 13 Mar 2020 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-27-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-27-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwDZc4gh8R8gszZq+2mue-686aXTgELMZq=jqmj9z+FA@mail.gmail.com>
Message-ID: <CAHk-=wjwDZc4gh8R8gszZq+2mue-686aXTgELMZq=jqmj9z+FA@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 27/69] namei: invert the meaning of WALK_FOLLOW
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> -          flags & WALK_NOFOLLOW) {
> +          ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
> +          (flags & WALK_NOFOLLOW)) {

Oh, and here you fix the implicit precedence thing I was complaining
about earlier.

Maybe my original complaint had happened at this point, and I'd missed
the original place.

Likely.

            Linus
