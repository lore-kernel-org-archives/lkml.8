Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0FEC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1024220757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586458436;
	bh=CE6acfwNeHaV/lJf/UXhAdEoWKT/WT0OEfSJjB60KZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vtw6Fuz8F+uSBdGSzFH9r+PxMVP2utVv2qUAjxgkRD0ItCX850SeKNhIbSxmGkUCk
	 SCEEwbA4G4ZwHUnsT7tVPSJkY6c/+8mLD17MgCKJx+9NQaG/UQ676VJhG27V/jQJP8
	 +tvl7HF2tE+7y2Kj9ZK7kULQOxuayz6iJtmByX8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDISxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:53:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37796 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDISxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:53:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so836915ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7pgtbN/bt+wE8Ws38NyRuakwTLrAMG8t2S0BXvD8Z8=;
        b=P50K6S2laGjgCC5+kYm3mykzNY17WZYpwmlVAcvOJsih0C8vmt3wdXVfUWsjxOtnOW
         55tUmPNRbSk+0+B8DTDZotd71RaMrDZx6ZsRIWWgMSTD34KVq+xBWs8tcuIyfAxP+p9s
         LaRXf2CemY6uyqojUc8AdLQzEbePvrXQvUgKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7pgtbN/bt+wE8Ws38NyRuakwTLrAMG8t2S0BXvD8Z8=;
        b=ev3BTlfqFhY1BWgd5fASBfarvaFy7OWX84yNfQAK90p2K+uDkuSmoo3lgKBKZQbj1I
         hFn7YU+zG5ggv9B28wK5Q+QADkTZklkt1TPzwh6ZY5CUlAL9BkofU8Y0t/zjSftDo906
         JbWPg3VG568QE5pOrlNiQBJG/Q+i7Ca/VBL2kVOxmXYJ8OyPTpY8Zfcp08iCeTg3+XeU
         IgjNpG0q/F8M2o8u2UtbY30nTJIvXBzZwdWxaGbhwnYWGtL3LzIGDy94m5Rfm5Ii94aH
         Qg2/cXPBUhmMVegI59CFl4BcRNHAwY2Ul4IGmqJuvkjlsktw1qe1hM1WoYUL4eIxlScH
         8dLw==
X-Gm-Message-State: AGi0PubI/z75D+kmxSU0fCAAwB21ihVjZhxTmzqu1917Yc1F8mwrkTNh
        xVDgBbaYRPPtrInRLsvfX1zBsLPRa1g=
X-Google-Smtp-Source: APiQypJSQWF01L+Bi6MYWmloch+Sb84V6UNyxmt5G3yAfwuUccb6YkX3J/ZqWb9SaHPR+dF5/DjUJQ==
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr718923ljn.125.1586458431237;
        Thu, 09 Apr 2020 11:53:51 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u19sm1367363lju.83.2020.04.09.11.53.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 11:53:50 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m8so853187lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:53:49 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr781915ljn.150.1586458429138;
 Thu, 09 Apr 2020 11:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org> <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
In-Reply-To: <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 11:53:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
Message-ID: <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 11:16 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Could I please direct attention back to my original question regarding
> the problems we've recently discovered in 4426e945df58 ("mm/gup: allow
> VM_FAULT_RETRY for multiple times") and 71335f37c5e8 ("mm/gup: allow to
> react to fatal signals")?

What earlier question? The "how could this happen" one?

Dmitry already answered that one - are you perhaps missing the emails?

linux-next has apparently not worked at all for over a month. So it
got no testing at all, and thus also all the gup patches got no
testing in linux-next.

Only when they hit my tree, did they start getting testing. Not
because my tree is the only thing getting tested, but because my tree
is the only tree that _works_.

           Linus
