Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF4EC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E34720936
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586638699;
	bh=mzd9xiYuQ4TF3mDij9j6H+hjlJv5sIDNKl/shBTBV3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zXoxmTsPhbUeZp9PGZopWHEY3VYlI+pNyA3aZ9nCN/Zs4G2UXtu5bOX5xElN/W4Pw
	 aSCcMVepM6Z6qTqxZqf8ulw8u/FRu9q9bBWMn6llNxij5yHCNms8mtWDYehySLt3JI
	 efefksxeoCMfCQHN2yQQzBe3AH8bJ/VzCnMhw1qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDKU6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 16:58:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47051 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgDKU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:58:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id m19so3721231lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWYOxbXFRnbNvAiB3r8nYDFiXyRHEzA+YDF9hheoCek=;
        b=d38VMacm5CC5OO6PkiOjO+BmV1qUgyaDDCExE9nJj04S8R8ZwUN0ijSLBpjR9kG73i
         e2H+lVwaVML/nJgrm+owTR9pLMhaaGbA+Fp3vWA06siDzigMBK4wCw4Vmyc4WCSJaqxE
         J1zxKymqjHSdEO1H49jzOWxRMaUDOJSreZ3oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWYOxbXFRnbNvAiB3r8nYDFiXyRHEzA+YDF9hheoCek=;
        b=RQdLeOq/FUYCdYJyuuTNwjyUNeKuhbXDiTfOvlhA0ROP2Z+aULxLqSjerDnlMhbcwT
         ddyuShLJayho7qwdZ3BEbEISDJMvz/8A1Zh8H+iGBl/qvAeaqb1z1UC1F6Kdo0k795Fg
         AcN5gfvCEgzwdnUnto9kX3WWzD2du4An9bxSw3TTFifbgX0LDw9Zf2r12699HlPrTNNp
         LMWYharKDlqLhmm6pniKV5wglFKds88DUqJCfUkErC+m5MMwykTEsL1pdmFiWoi6WUR5
         rfYYrfmP2ij+NJ5YlkfoRsdqfB55bL6oXqpDb2s6QkgpKueGq1rwM88FtWWQ20OlTboT
         IXZg==
X-Gm-Message-State: AGi0PubWOKvC0CtWqelkrNFdyr0ZLti1C3vXTvPRfBgBlX94ZDKglwdc
        D+yG8iEAR3aYYeBeHF01KwzO1ZXkiZc=
X-Google-Smtp-Source: APiQypLW/Th8UZrxNdQkf+BXlcpWPI0e+VhMQ7Oc/OQ37lI2akf7pVkV/jCnXfkyR5a5spVXrW2zbQ==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr2997930lfh.87.1586638694284;
        Sat, 11 Apr 2020 13:58:14 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u7sm4603141lfu.3.2020.04.11.13.58.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 13:58:13 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id m19so3721198lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 13:58:13 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr6058553lfc.31.1586638692669;
 Sat, 11 Apr 2020 13:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200411203220.GG21484@bombadil.infradead.org>
In-Reply-To: <20200411203220.GG21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 13:57:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
Message-ID: <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 1:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> We've had some trouble recently with page_offset() being confusingly
> named.

This makes little sense to me.

I don't find "page_pos()" to be in the least more intuitive than
"page_offset()".  Yes, you have some numbers of "offset" vs "pos"
being used for the position in the file, but they aren't _that_
different, and honestly, if you look at things like the man-page for
"lseek()", the byte offset you seek to is called an "offset".

The fact that somebody was confused by the current name is a red
herring - there's nothing to say that they wouldn't have been confused
by "page_pos()", except for the fact that that wasn't the name.

So honestly, i the confusion is that we have "pgoff_t", which is the
offset of the page counted in _pages_, then my reaction is that

 (a) I think the truly confusing name is "pgoff_t" (and any
"page_offset" variable of that type). Calling that "pgindex_t" and
"page_index" would be a real clarification.

 (b) if we really do want to rename page_offset() because of confusion
with the page index "offset", then the logical thing would be to
clarify that it's a byte offset, not the page index.

So "page_pos()" to me sounds not at all more descriptive, and having
two names (for stable kernels, for people with memories, for
historical patches, whatever) only sounds like a source of even more
confusion in the future.

If we'd want a _descriptive_ name, then "byte_offset_of_page()" would
probably be that. That's hard to mis-understand.

Yes that's also more of a mouthful, and it still has the "two
different names for the same thing" issue wrt
stable/old/rebased/whatever patches.

But if there are enough people who find "page_offset()" to be a source
of confusion, then I'd at least prefer to _truly_ remove any
possibility of confusion with that longer name.

I'd like to have a few more people step up and say "I find that name
confusing enough that I think it's worth the confusion of renaming
it".

We've had the "page_offset()" name _forever_, this is the first time I
hear it being a problem (it goes back to 2005, and before that it was
used inside the NFS code).

Of course, we've also had "pgoff_t" forever - that name goes back to 2002.

But unlike "page_offset()", I do think that "pgoff_t" is actually a
truly bad name.

Which is why I'd much rather change "pgoff_t" to "pgindex_t" and
related "page_offset" variables to "page_index" variables.

            Linus
