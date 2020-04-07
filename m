Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF13C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C20A20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586290631;
	bh=0+v4SXWFjVfBsKDdWBzpGoJN3jfuHQ+Unyyghkdf4+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o1cO3F0ShwpHgwkgjzpaQLW4VqCXfzcOL3I4rtSdjcIJk6Pof/KC5mjKwPyQnLDLm
	 GECwyJTvL7XvReLR4OHGDGVMLELqpaRaCCdAb5dOVWuD0vZVGG0oH0lEH7WKTeQSeK
	 K91yqRBzW1GDUObZ1b1He23FQdFyMNMA7rlAg7jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgDGURK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:17:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38985 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgDGURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:17:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so5195266ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqNU/lPOQShoDviss5cOicvqhvwtlk4dqmmrGpr1nC4=;
        b=AestyY1vTqwruS2SjIrVNUtcv5M8Rgu+CcoXa2Ec6+EMfNUym7BLVuLaqMEg4Qo83h
         Qnr6k3woR88ywv52t7EjGWsxUFiyzpMnJQ7/9g74RK12uuMuQBryg8i26qgkAh6zrbEf
         bvModrsMiA1tyaJ0cX/reQrpKDKOb9pKz3p18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqNU/lPOQShoDviss5cOicvqhvwtlk4dqmmrGpr1nC4=;
        b=IHl8wC4A6Ciul5jMT3kat3IvtkD5Fx2t8ZOowm4ehcNSbHCrY6nlFv6R2cgQRV/1Bg
         N1z5nj3cNuO8bsNp/2I6ZzhFyF7O87jwzvG2f31TPDUTAV4Aincmg4hJyQ+kHKxEJeB3
         MtIyYbki6NkhubVke/GB4+Z7LRPXTrgBGyyAgADKcPao4QXmLlJ4VpjwGa71rY4LEWAE
         jYE3IQafedDgM/ed+0b0f/zV/naLvq/VA2jutVT29j+2YE0fYTicTg3/0XmVIfcF/6iP
         9KH1snQ9C8tB0SPIwqcs2fLxsnyTfEc+U6VCRDY0ypENGbYo2n7Zrd6/SKntfasnTF0y
         uLOg==
X-Gm-Message-State: AGi0PuYqEPAerfqpLoGmbyXF1RFCbgzNAMRmn0NzTnFerpAfTKd2XuVN
        7UkUUOel05BP6Ci/nQm3zLnmU9m8HGE=
X-Google-Smtp-Source: APiQypJWLWy00ET6fRIq+eC8sM1mbnZxo3t3cFyGIyi7nsxc5ZVbxM+yEifw4lR/M0fJzjx39MKR7A==
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr2790266ljc.42.1586290626452;
        Tue, 07 Apr 2020 13:17:06 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 4sm12198367lja.56.2020.04.07.13.17.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:17:04 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id m2so3399999lfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:17:04 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr2511760lfd.10.1586290623763;
 Tue, 07 Apr 2020 13:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
In-Reply-To: <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 13:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
Message-ID: <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Joe Perches <joe@perches.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 12:40 PM Joe Perches <joe@perches.com> wrote:
>
> 2.1.44 changed kfree(void *) to kfree(const void *) but
> I didn't find a particular reason why.

Because "free()" should always have been const (and volatile, for that
matter, but the kernel doesn't care since we eschew volatile data
structures).

It's a bug in the C library standard.

Think of it this way: free() doesn't really change the data, it kills
the lifetime of it. You can't access it afterwards - you can neither
read it nor write it validly. That is a completely different - and
independent - operation from writing to it.

And  more importantly, it's perfectly fine to have a const data
structure (or a volatile one) that you free. The allocation may have
done something like this:

   struct mystruct {
       const struct dictionary *dictionary;
       ...
   };

and it was allocated and initialized before it was assigned to that
"dictionary" pointer. That's _good_ code.

So it wasn't const before the allocation, but it turned const
afterwards, and freeing it doesn't change that, it just kills the
lifetime entirely.

So "free()" should take a const pointer without complaining, and saying

   free(mystruct->dictionary);
   free(mystruct);

is a sensible an correct thing to do. Warning about - or requiring
that dictionary pointer to be cast to be freed - is fundamentally
wrong.

We're not bound by the fact that the C standard library got their
rules wrong, so we can fix it in the kernel.

             Linus
