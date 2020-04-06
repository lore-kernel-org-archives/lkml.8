Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D433C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695EF206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586195931;
	bh=+/zqk/S0w9ALOkjzjDTL78sBRGsOjvDoRXUhg9rMuWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ywg6XllTB0mzQKiLE1eIqdul9FGypK1JaO4/w9TM+kQhqkG48Zc2u4hgyH9OX5RIZ
	 mYxs7NXpH/9Tof9Jj3N8CWsAbxXb+X4tL1P7B/pGeqKW9Bef18G5iv0HnvPMCLFkb9
	 vLHtodLeouq480C8V78/+8/H3BAUoXsSQtmIzmK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDFR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:58:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45090 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgDFR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:58:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so626228ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwJPlRCUFnxKeScoq9dq7EwMroxlXzzHMUmRogd2GBw=;
        b=KNwNWy4PqTz3d8ivjq4Wv2SVKLUlrGcnZzRu5TWm1tL4bj+xqqAC2eb1HfogpT8GzY
         awqOimgf5tSIhuRneuYUClX/pzpekyMMK3wJtqt8VBs7OdIkv3s/sLCnBMlTYKNxgYQu
         l6FhxVKpYjqBSeFRzCii+BTz3gnKU9IF2qOXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwJPlRCUFnxKeScoq9dq7EwMroxlXzzHMUmRogd2GBw=;
        b=XIQhPDyGxFHtH29LS8eM3jEoamlHPfcHSnf25JetzO6BuZTtP7NVS3+LaJpOOtdRS6
         XA9/BT8pzTP2Kk2BOOyXhd//B3LHkb8AmYgPLoOyZMMlAQa0u5qR6lWi8hxFmN+vD/DD
         jyXKUSwKC/jkY1R5PXfDUKNXJrUHIZ2/atdPhTbiuZ7ce7qk6cdEIt6w6oY7LUFB/4HL
         JznFLb2bKwoAnKLr/OtqA0IBdMZpuVROsjX3x5pwaky1asLPUjCrgNxBAuzMsVCs3DM4
         2bCN4V2jMAA1jareF0Oz4SuIke0S7bgLAlC7eQW0lvjybeFlaf7vQ6MVzF8JndBZb4xQ
         nI/Q==
X-Gm-Message-State: AGi0PuZpKjHG7jJJkeKNpIHo7OH2/fk3LyxlbzShy5HTefYKBWKPqZze
        HihHz6eJ6/osCiBsU03gerVjRpC326M=
X-Google-Smtp-Source: APiQypL2iCX5vh2rDHcT6elQVOCDTgsUBfQQ235S4uObaux3lfTzXTXu0wkLkBK+pW/jUCoN+MRumw==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr263909ljg.185.1586195926418;
        Mon, 06 Apr 2020 10:58:46 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id o2sm10424011ljm.2.2020.04.06.10.58.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:58:45 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r7so616989ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:58:44 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr273540ljm.201.1586195924658;
 Mon, 06 Apr 2020 10:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <334933.1586190389@warthog.procyon.org.uk> <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
 <CAHk-=wiPHA4XbL-CVTDBwjYzUJwaGYriGD44uvOaqQai+zOw6A@mail.gmail.com> <354824.1586195497@warthog.procyon.org.uk>
In-Reply-To: <354824.1586195497@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:58:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT6W7z-ZUB=hqx96tp+u2Hg-0KbnnWWufwVWbVgXXHXg@mail.gmail.com>
Message-ID: <CAHk-=wgT6W7z-ZUB=hqx96tp+u2Hg-0KbnnWWufwVWbVgXXHXg@mail.gmail.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     David Howells <dhowells@redhat.com>
Cc:     Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>,
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

On Mon, Apr 6, 2020 at 10:51 AM David Howells <dhowells@redhat.com> wrote:
>
> The allocation might be by vmalloc rather than kmalloc.  I'm not sure if that
> makes things more difficult.

It does add yet another place where we'd have to save the "this
allocation is special", but it's not insurmountable.

That said, I think the short-term and simple solution is to just teach
people that sensitive free's are different, and at least have the key
subsystem with sane naming.

And yes, then eventually convert the existing crypto subsystem uses
too for consistency.

            Linus
