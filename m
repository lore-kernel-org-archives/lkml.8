Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AEC206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qh0queby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgGBPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgGBPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:07:33 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:07:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p7so12812193qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwjTcE9AB3lHB1l2CsQFQTvyIOX/+r8AdYJzECU/66k=;
        b=Qh0queby7v7wR84UVBBPZgmKhsMZ6EUviWjBkzPvzOaYmzkLE/7Cb48nYN1fKM1dEP
         RIjY37L54/+aNHRDAdX73WDl/w32GJXpjo/fftx4FoNc30PZJxAskQs2chORu7+heSI6
         RtAleEaaKvIleusQYZ4sVYmv0JvkVY7zPY/7mQ2zN3oO2c/bpfb14G8CYP26ef+2a+K+
         aTnup/4rU7HDxpTrSoDuqKy2t2qgjyLxn0nGQz639B2WWteBulgI5V0j0g+kuvvp9/0r
         EjemCobxfgkkVUe/FTgg31STbDLHABItM3gINiPEp9nA39A3I5feDcW60XE/SnQ4tOXv
         9RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwjTcE9AB3lHB1l2CsQFQTvyIOX/+r8AdYJzECU/66k=;
        b=T7XNK8f1Sj3Of3HCKr2oKyaYVMbhcejdx8UYywcsBnThyhkwWdGJF60/JCm21WNfK8
         fv/9MZQGfwFerERXrEUszsTB/5pAR3UWwKxdLarQi3KLB80lpKr+8quxUblgMPmb2Q76
         VwBIPKePO/+sGP+d/A9+L3t+vKrJnxyAzSOtCChW5i4UnfJGWfLrr6+zlFbYf0l4vXDD
         qI4p9+OvuPayxXC8ox6g2kIFG996VaKKddHmvVLMSJqksdxPRZb1LA4KNkKObIziPZ5K
         P7mOj9RTWKFwX58cU765xUJ42/tX5EX3pDWbmG6cNIKX86D2gZ3qUnIYIh7ELB8CvFXY
         ubtQ==
X-Gm-Message-State: AOAM530FaZDi2Pi22BW4YGYnT/RoJVG8dJ4uD3Zqb72r89lId8u3gtWR
        j8/FB8RPpQjOTeZ8XwjpvRZEIeIZmEo5drAoJ2xT9w==
X-Google-Smtp-Source: ABdhPJz0RXsbLR/522U+sQlDSxlqhG40ODpQ41EJiiCzWsKIo/gVFRdlB1gDTkyVhyfrzUh+mVIY1r90zeQcaUlAodk=
X-Received: by 2002:a05:6214:2d2:: with SMTP id g18mr30162630qvu.215.1593702452178;
 Thu, 02 Jul 2020 08:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-5-will@kernel.org>
 <CAJWu+oqs-d0oDswB2Owyh-4Zo4WXAqKhKU0L=1HEwEfQbc1izw@mail.gmail.com> <20200702145532.GB16999@willie-the-truck>
In-Reply-To: <20200702145532.GB16999@willie-the-truck>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 2 Jul 2020 11:07:19 -0400
Message-ID: <CAJWu+ooEsf70ri4J+M5+Fkz6VrH1kN5541j71LE8=y=rmSLDJQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered implementation
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 10:55 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 02, 2020 at 10:43:55AM -0400, Joel Fernandes wrote:
> > On Tue, Jun 30, 2020 at 1:38 PM Will Deacon <will@kernel.org> wrote:
> > > diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
> > > index 92ec486a4f9e..2ecd068d91d1 100644
> > > --- a/arch/alpha/include/asm/barrier.h
> > > +++ b/arch/alpha/include/asm/barrier.h
> > > - * For example, the following code would force ordering (the initial
> > > - * value of "a" is zero, "b" is one, and "p" is "&a"):
> > > - *
> > > - * <programlisting>
> > > - *     CPU 0                           CPU 1
> > > - *
> > > - *     b = 2;
> > > - *     memory_barrier();
> > > - *     p = &b;                         q = p;
> > > - *                                     read_barrier_depends();
> > > - *                                     d = *q;
> > > - * </programlisting>
> > > - *
> > > - * because the read of "*q" depends on the read of "p" and these
> > > - * two reads are separated by a read_barrier_depends().  However,
> > > - * the following code, with the same initial values for "a" and "b":
> > > - *
> >
> > Would it be Ok to keep this example in the kernel sources? I think it
> > serves as good documentation and highlights the issue in the Alpha
> > architecture well.
>
> I'd _really_ like to remove it, as I think it only serves to confuse people
> on a topic that is confusing enough already. Paul's perfbook [1] already has
> plenty of information about this, so I don't think we need to repeat that
> here. I could add a citation, perhaps?

True, and also found that LKMM docs and the memory-barriers.txt talks
about it, so removing it here sounds good to me. Maybe a reference
here to either documentation should be Ok.

> > BTW,  do you know any architecture where speculative execution of
> > address-dependent loads can cause similar misorderings? That would be
> > pretty insane though. In Alpha's case it is not speculation but rather
> > the split local cache design as the docs mention.   The reason I ask
> > is it is pretty amusing that control-dependent loads do have such
> > misordering issues due to speculative branch execution and I wondered
> > what other games the CPUs are playing. FWIW I ran into [1] which talks
> > about analogy between memory dependence and control dependence.
>
> I think you're asking about value prediction, and the implications it would
> have on address-dependent loads where the address can itself be predicted.

Yes.

> I'm not aware of an CPUs where that is observable architecturally.

I see.

> arm64 has some load instructions that do not honour address dependencies,
> but I believe that's mainly to enable alternative cache designs for things
> like non-temporal and large vector loads.

Good to know this, thanks.

 - Joel
