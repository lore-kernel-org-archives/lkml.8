Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F89C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBAE20753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/fO0oCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgDJLfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:35:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45281 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgDJLfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:35:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id k133so447313oih.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ak/n/QFprJwiNkpwHaAXa7wOUuxlUvr0M/v9pCPaJMI=;
        b=g/fO0oCdTq+shAT0O/oiCqYJhfzIa9hGLxiBIaL3AVnIw+8BhKYMTlmfAzsAUJsbgV
         R22X9dv9TWsQIiBfWXcx4PsQ3tAjOaxFLjE+1YXXjOX/qepkvLRAUaJLAUqZ6TAdQs9Y
         LR/p85hSzVGooHUOVuolvqHl9+VP3vDiDpTeYyLhdgE61EGPaZh4JUvTsCdY2UOP4dBW
         ZyvISOBdHYMCAIvrOTmt4+EWdfwang5rzwdnmv9U+tRyw6H4WH+ig8UIwmgij3mKmN+M
         M6oL9u0bh9jTRWpV8U1ADfSvzLW6nZkTCFh0ZiQ451twPHf9VQ/sPRpJOchMhKI8mUlq
         j3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ak/n/QFprJwiNkpwHaAXa7wOUuxlUvr0M/v9pCPaJMI=;
        b=gvdvGogokIEh0zmGi6GV0i141R8tg2QRmI/Wk6INNtVEvsrHD+q+TcuWIoTYSjjY1W
         RtkvmaJx7yjYx2fJa8NAmWKrH4VUx0Zoj04H6AUeI+OGYGuLDji/Rsx9aOj1QwaLTzy/
         DG5OqTqoQ48EiiBi5763Qg9SEKCpjGbe+twzM/aYWGMsaS1iA1SKjoQgUXdyLOGfxTKG
         qzRtvS0AChzmH0eUvr/XcHP51jS9lKXWmWK1ARuS3NH7bsGUbDWr88N/eJvKUbIK437/
         UdDtGqqT8F8Y9YDohH/BNTx04/CG5mAPRvsWFZuRkWWLV4o8sAiI2zKBkMNHeOPwzQsX
         R4ng==
X-Gm-Message-State: AGi0PuaNLQLJkhh/pzONk0KAmmb3TtX8xJxsPa+Y/Xa/gJkGLB6dtPLQ
        mHwCab6WQcpmjrjNcvuMbZ89KXDl6h/KIal7ZZo69Q==
X-Google-Smtp-Source: APiQypJXW1cPgjMAWgnSQBjgRtK90ggzXpLwoUqiZ3eadrsPdiH5v/+VGC0j+noiEW7A5qZFmLxrcsb2GTkEwFQofUo=
X-Received: by 2002:a05:6808:4e:: with SMTP id v14mr3091006oic.70.1586518541919;
 Fri, 10 Apr 2020 04:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
 <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw>
In-Reply-To: <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Apr 2020 13:35:30 +0200
Message-ID: <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
Subject: Re: KCSAN + KVM = host reset
To:     Qian Cai <cai@lca.pw>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 13:25, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Apr 10, 2020, at 5:47 AM, Marco Elver <elver@google.com> wrote:
> >
> > That would contradict what you said about it working if KCSAN is
> > "off". What kernel are you attempting to use in the VM?

Ah, sorry this was a typo,
  s/working if KCSAN/not working if KCSAN/

> Well, I said set KCSAN debugfs to =E2=80=9Coff=E2=80=9D did not help, i.e=
., it will reset the host running kvm.sh. It is the vanilla ubuntu 18.04 ke=
rnel in VM.
>
> github.com/cailca/linux-mm/blob/master/kvm.sh

So, if you say that CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn works, that
contradicts it not working when KCSAN is "off". Because if KCSAN is
off, it never sets up any watchpoints, and whether or not
KCSAN_INTERRUPT_WATCHER is selected or not shouldn't matter. Does that
make more sense?

But from what you say, it's not the type of kernel run in VM. I just
thought there may be some strange interaction if you also run a KCSAN
kernel inside the VM.

Since I have no way to help debug right now, if you say that
"KCSAN_SANITIZE_svm.o :=3D n" works, I'd suggest that you just send a
patch for that. If you think that's not adequate, it may be possible
to try and find the offending function(s) in that file and add
__no_kcsan to the  function(s) that cause problems.

Thanks,
-- Marco
