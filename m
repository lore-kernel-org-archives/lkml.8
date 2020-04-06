Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4CDC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E752496E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586191314;
	bh=sbzK/GiHlKcCRP5N/mvwv31tyiCzUQex8iMtM0Qcj38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=REbASOwC13mifqmZ//vb9EW0Awn5VaBvlUHbn2uix9l/O0nxyBoR25wIb0yJDIZ8R
	 xO6jo0+8r7iA42vtVifj2wZeJX4kCAbobxF+aZMZ3t4oAxk42zJi+7vi8LzUbZr8dI
	 b0lsf3/XpCLs06BGEwvVuZx1jhZgv7E4msHz7X1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgDFQlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:41:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37076 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgDFQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so400426ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Imdp89Sb0+OtYzgCpw3IcqTUqEKq3zexZbxvNKGejvc=;
        b=TUDiV7orONaSuZs35BQ1mawth0kHmPPUSDaWUc61FjLb/6pFGQBIyQceMCqczVlLuF
         mQUZ4NQktXHOHP07O9tK8dQGGfgRoZsmJ5GzKHbZpqurg7mKkrY7MYTCAAZGVXJrRCHG
         ddaqR5NSXTSjop3RFyga75kOxzIQpqbjG4OKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Imdp89Sb0+OtYzgCpw3IcqTUqEKq3zexZbxvNKGejvc=;
        b=EQIwO9zkXOCAUqOF7OGLYbSfYB51yr7PYHgmNSNx2ezNcVBx4O1rIGFOcUXAUQcOpX
         TeKLMxgb/1AYsOfeGUmGwYy/tkHDNHAuhyBgDjaWBQQRfODT5Vz+rjqzxVVeIAOigxww
         6wPilhKOnJdcRi4pjrhkxTPK0tDmKO070O/gdkJjkXbkSRm/sywJ+oL6MOPua8KTPNEY
         cuxarLp7cgQ2+YvWpZraE0wJ+7fPFs1t3J3fRNCW66Mgtc2un9+o3oACw1Z7ApCvXyjk
         8C5uZZMKpXH+p1fLtyXY/ILwgqJz6VnsSpIVW+mJtv8QnjSHhvFnZX4xGd6+tfkX0gj2
         ZhDQ==
X-Gm-Message-State: AGi0PuaCwEB/3tC5L6jV79GVaXkkxx3Z36ZYXwiyRvEkdQEEWOybJ5pU
        yJ77F/H2A4l8K+hyOLdgc4CXRaze678=
X-Google-Smtp-Source: APiQypKNs/rPitbQARNzloPT7srn+6qKRN3aW2SIXFrUg6GWoRpj6twXb73T+hhGm8HyZnvvv+mqYw==
X-Received: by 2002:a2e:3a16:: with SMTP id h22mr62635lja.81.1586191309130;
        Mon, 06 Apr 2020 09:41:49 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o4sm11713936lfl.62.2020.04.06.09.41.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 09:41:48 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t17so335047ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:48 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr101988lji.16.1586191307660;
 Mon, 06 Apr 2020 09:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
In-Reply-To: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 09:41:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
Message-ID: <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:12 AM Joe Perches <joe@perches.com> wrote:
>
> While I agree with Linus about the __ prefix,
> the z is pretty common and symmetric to all
> the <foo>zalloc uses.

Yes, we have a pattern of 'z' for zero.

But the _operation_ isn't symmetric.

"kzalloc()" has absolutely _nothing_ to do with "kzfree()". They are
not some kind of "opposite symmetric operation".  They are totally
different. They have absolutely nothing in common.

So using the same naming is wrong. They have one implementation detail
that looks superficially similar ("zero the area"), but even that
superficial similarity is actually completely false. They may both use
"memset()", but in one case it is correct and makes sense, and in the
other case it's actually a bug waiting to happen, and you really
should use that "memzero_explicit()", which is a very very different
operation from a normal memzero().

So even the implementation isn't really validly similar, but even if
it had been, the _reason_ for doing so is completely different.

They simply don't really pair up in any way.

             Linus
