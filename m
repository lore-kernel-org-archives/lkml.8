Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB579C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9FE2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597206610;
	bh=FWGxR3p6taJf3ib+gtL++tslN6BYnHFi0l+/HsOqcDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lrLXf+syyDte9lJgR9/0LjGeKT3c8mMTxhPKSFnzrhyJzIWPRIgd0MfCuvp2w2ZGn
	 9ej8cFYqerarMeMASI/f19o99RU4oVrsowRUnTf2Cn7YH44EFZd7+soy4tKkrOQe0s
	 B+2n3s8IF9RA+SqsAAgdDqaXu+4ev6Pi7agFRXOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHLEaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgHLEaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:30:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF7C061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:30:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so735028ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDwgZeCfylHcfAPvU7+q1GMSHtKUMIYb5xnIYWrEEr4=;
        b=B3aVSgoHTMeOnptotypuxeXwzcXLQNuaXirCFngMoQkYUX18nRwhqfYkwT5muF8NNb
         UKxUK5N/shaIWvw0Xb4abZJVmXGDVkhZnbu8HKy2tFr+b4sjrnMDzzOW7KpvC5hKvofh
         644/QVacgEmv5UDIs0jX0SLrxFZRlm9Rtr+/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDwgZeCfylHcfAPvU7+q1GMSHtKUMIYb5xnIYWrEEr4=;
        b=Ki1WbBTexlZ8mvzbBJ/Tne+5JC8n0PNLDaDXfdYcL01GfgF6iWbbdVoQTf3YhJP4Ph
         UV1TLCBj+HWaNW/j/omUcIho11TdTgzfa9VDKZWR92rVgta5RJH2i1VVPejr+JHbiDyz
         ykg5DT2LRm8nNZTQjNQl2naTNED3UNZmnVVtWpPQpAf8CBlu3Jndkxb/nq+5rUVnOjdi
         7GCOZmo/ZtJO4g16IlgRn+zQrFmjdrg+ghbR8l+Atln2w6DrRNe4jGHz6gxJa8B1gglI
         uZqyQXB7rlPuLYcTeK3mHylneWDvryuUG7/ZYAPYaV262ggSVK0iPxgWEj0uHOktqwag
         c1Lg==
X-Gm-Message-State: AOAM532TKl1BZV0I6UiYX7sZUSdcRhlTcW4blCi4xCWGrrIGgyISQKZf
        jo94J+bpGU87tZ8/MF5/IVd3oETVV1U=
X-Google-Smtp-Source: ABdhPJzCYQzz6UJL6oh8w9Kwzl3d7awscI4c/xMDGe2VYT8Z2QxXfQlmuLK7tVZz2PcxDZ155yWenQ==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr173116ljt.431.1597206605295;
        Tue, 11 Aug 2020 21:30:05 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m20sm176041lfb.72.2020.08.11.21.30.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 21:30:04 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w14so745659ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:30:03 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr4153008ljh.70.1597206603371;
 Tue, 11 Aug 2020 21:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0724405aca59f64@google.com> <20200812041518.GO1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812041518.GO1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 21:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Message-ID: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Subject: Re: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 9:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> fix breakage in do_rmdir()
>
> putname() should happen only after we'd *not* branched to
> retry, same as it's done in do_unlinkat().

Looks obviously correct.

Do you want me to apply directly, or do you have other fixes pending
and I'll get a pull request?

                  Linus
