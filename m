Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9ABC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E10206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXRX1vHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgFCHyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:54:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1CEC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:54:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h7so1175878otr.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeXRt15TQGTY/w/H5jyx7Z2hUzqpKQwPq+EYur8wP5Y=;
        b=vXRX1vHTNu2fHaZQNPPtcVm/i7vtRxbZ1NmjKfe4uk3KzL4Wyo8gsaHcqg9OTCaq91
         E9Fzf5EpWmbIF78n5HyE8wE/ow8LgfPqB14FdpE1ocvVNjyfiPBvC42RDa7ngT/yaMCJ
         H+hAfiFfrKUTQe8SsyEOvqniCbFhfKRrMPKWvITqUmVU+hVDUg9DwiZtFbRyMMQRk59R
         lPP9olrhBYmIf4Rzr4DgiTKkFjuKx6ex8sjrbZaPEcMV8sltytOAHRifEDDrxk9fjnUV
         GbpwBj98PqN2TEaJt/gkO7434aftV7HqFQRcjdXuNYr4BJ0yzDShi4Y09SIdmUiCU67s
         aXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeXRt15TQGTY/w/H5jyx7Z2hUzqpKQwPq+EYur8wP5Y=;
        b=HP4tU0tEYV/zbijg7O9vsxLzid0YF8zYZtdA/eyiw0DFZZBaQnInLYe1/2Cj1Klac+
         ZqN34EB0h/MGJ20ykPBY9R5BQhEAinnB7fRCbUlSFb0wj+dCSK3lemYJYMG6LRQDONiT
         d4liClzKe1dEKTs1otSN26OcRy+98hzJ9eNYsreYl1fjoutVg46GO0oDYJ1bQgChG3UL
         2E0ND+IKag53xHH2av7/iFztgwt+GFZWN95a0ej4M7KjCHGbYbwZo/J/RrduC9q/WKAH
         aGdMA3Fsb3ilawmX1lIa2oFCyfFJkTsnWCfGHU1i9sLpf7RDalte2/77OjjIuL06wf3I
         s+kg==
X-Gm-Message-State: AOAM53096s2xCO3J+VW0dI92FgBdZ3GOaAyyMTNu+S3PctTCx4PAq6Il
        juhctlUf17o1sJpDlSo7hcFIcWdEZ7hOCfmSaMA/gw==
X-Google-Smtp-Source: ABdhPJwkRQdvwDqJkKJElvYZgzFEVoJKUVbn2DRKbAcySmQOqrsmLhVVf4QDcIlI5PRR5MKor0LlvjdSdy83Rc9oDH0=
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr2096456otn.251.1591170846129;
 Wed, 03 Jun 2020 00:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200602143633.104439-1-elver@google.com> <20200602204821.GI29598@paulmck-ThinkPad-P72>
In-Reply-To: <20200602204821.GI29598@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Jun 2020 09:53:53 +0200
Message-ID: <CANpmjNO_V9iOrcAunehJW7XLzzk5pyS6VQEx0pARsjO0pvA6bw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Prefer '__no_kcsan inline' in test
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 22:48, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jun 02, 2020 at 04:36:33PM +0200, Marco Elver wrote:
> > Instead of __no_kcsan_or_inline, prefer '__no_kcsan inline' in test --
> > this is in case we decide to remove __no_kcsan_or_inline.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >
> > Hi Paul,
> >
> > This is to prepare eventual removal of __no_kcsan_or_inline, and avoid a
> > series that doesn't apply to anything other than -next (because some
> > bits are in -tip and the test only in -rcu; although this problem might
> > be solved in 2 weeks). This patch is to make sure in case the
> > __kcsan_or_inline series is based on -tip, integration in -next doesn't
> > cause problems.
> >
> > This came up in
> > https://lkml.kernel.org/r/20200529185923.GO706495@hirez.programming.kicks-ass.net
>
> Applied and pushed, thank you!
>
> Please note that unless you would like this pushed into the current
> merge window, it will not be visible in -next until v5.8-rc1 comes out.
> Which sounds like you are aware of already, just want to be sure.  ;-)

Thank you! Yes, that's fine. The test and this patch I'd expect will
go into 5.9 earliest.

Thanks,
-- Marco
