Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCA0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 00:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506B820721
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 00:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="E1AEkHox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgECAaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 20:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgECAaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 20:30:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5911BC061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 17:30:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so4597046wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V2nT+jmzW6uK6j6RNvaRunaFhSFW7qRx5cWISy3xtsQ=;
        b=E1AEkHox21046/Jzv0H2sg0BIzJvXI5WKdhrIfyzhtFbc0BBr2Jbbo4W/cz61zuCWi
         N7wfdgGQbbeddGO74JguUI2EXq4+V2iEf/49y27rGKNWMBfesVlzBgPOzVPeBAWsDjVi
         MwfyIgQ4sj5GybFYWk26pinWgUjQkfCWZ6xmmDA/YANZdJExvY+1eHRU0qsu08dgxRg4
         yba0Fz8wK4DVM4JNI9vneWIr8MwO1iTNEI1j2c8OtrlAD2zgZyVuN0UPndhOvADA09K0
         oGD9E7oaU2Xm77LaL1nDwVx5b0TQ2W5oTxfvUMvijPlQLM0HQwCdOkQFHHjX+VELIOiy
         0BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V2nT+jmzW6uK6j6RNvaRunaFhSFW7qRx5cWISy3xtsQ=;
        b=Gz3di2LFF5mxL6a7sKgO1jXr9oa2Tuo287C5qowljtGOggGq4Tq4DdeITikUotr2cJ
         /9u0qQ76ClOOPtBb8jRO/8DgxLk3MAyppRDLU7e6FA3OCOcCzFkRnA2FFBVnB/VeZKZs
         pk2cwVsIfCz31nr88r231KiamGDnnDhOZultKxVKHYYHJ5Eqa4TbZ3Y808WVe4CyEPsn
         +vCwAzojz8W2wMd/XGKGlG13sehNql2cC8jf9zcOc6YKvTR1MicXfO8lcL8yQQa/kEIY
         8Q2ySdlN9KuQw6ptc+YxMlSEDb3zhnnejFP01Yixk0Pig1cyUdo0rDV4u9KQxg6GFuBU
         V03Q==
X-Gm-Message-State: AGi0PubX85NZuGHC1yD/ZX5SDpW6AULhnaFMRLeVZT/zqBvvv9pDSkg1
        MhDomCtisXAE22scE6YctoX0YhzFUKa8AqHOoegYgA==
X-Google-Smtp-Source: APiQypK033BSVa5j3+ZhThYcEUFkwS26U4I4SJPdSG0fksA6GljM8v6NbCEY+NCeISjVSggtF2WxUBXyAZEAOTUxbUM=
X-Received: by 2002:a1c:4186:: with SMTP id o128mr6735406wma.21.1588465809902;
 Sat, 02 May 2020 17:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net> <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 2 May 2020 17:29:57 -0700
Message-ID: <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Tsaur, Erwin" <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 7:09 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> > Now maybe copy_to_user() should *always* work this way, but I=E2=80=99m=
 not convinced.
> > Certainly put_user() shouldn=E2=80=99t =E2=80=94 the result wouldn=E2=
=80=99t even be well defined. And I=E2=80=99m
> >  unconvinced that it makes much sense for the majority of copy_to_user(=
) callers
> >  that are also directly accessing the source structure.
>
> One case that might work is copy_to_user() that's copying from the kernel=
 page cache
> to the user in response to a read(2) system call.  Action would be to che=
ck if we could
> re-read from the file system to a different page. If not, return -EIO. Ei=
ther way ditch the
> poison page from the page cache.
>

I think that, before we do too much design of the semantics of just
the copy function, we need a design for the whole system.
Specifically:

When the kernel finds out that a kernel page is bad (via #MC or via
any other mechanism), what does the kernel do?  Does it unmap it?
Does it replace it with a dummy page?  Does it leave it there?

When a copy function hits a bad page and the page is not yet known to
be bad, what does it do?  (I.e. the page was believed to be fine but
the copy function gets #MC.)  Does it unmap it right away?  What does
it return?

When a copy function hits a page that is already known to be bad
because the kernel got the "oh crap, bad page" notification earlier,
what does it do?  Return -EIO?  Take some fancier action under the
assumption that it's called in a preemptible, IRQs-on context, whereas
the original #MC or other hardware notification may have come at a
less opportune time?
