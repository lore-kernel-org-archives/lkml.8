Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C1C35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFD72071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRb2aDU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA0CFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:05:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38495 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0CFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:05:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so8216453qki.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGWktXY8izladCeKTPYZjChyIF7pTTYKYvBJ6t63cho=;
        b=PRb2aDU6TRi6c9Ho9q3A9heYVWMEySZST9C3p3TAzb3lG0zVgZr3HocUO5LNrnzdpb
         70/S6MfhA3FIP6bBjyVbNwUlYu65e52WdyZuvMRaFBCMW+1yCzU8MvvjwZBHZJaalJ/v
         2cwsNZISNYi1c/Q40dagHk1nGbfdQ60SKKylTrM4P8v7gvQocpDkJRocKJ8ztX2kpNSV
         dscj5Rcx5QswsmASEw+djgj4uYP7cyQvKoBnGRxqOAmPuuzhgk7SdX36A5faPk7O3AHA
         gnLUrA25qq8dG/DlnA1QsIjr7TL0EXalXMrc9QGlkLNI32NBz1LnAad6o1De5g5NGbfy
         17Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGWktXY8izladCeKTPYZjChyIF7pTTYKYvBJ6t63cho=;
        b=Tm6xMRPb7r8nITWvHDEsFdgTYXYbL2zw6/2XBnCVcxhYGROmS93lNsdI+EYZOlt3DR
         KzNW4d7WdgJXEFW7dwoBwRBhdhxeoCEjobxG2+N6brgoG2XORzCOhw9ITTt1I2oGLPpo
         aDFvAXdixSm7pkTe/KNgcrFD+UrzX1Pe6jmTfUchoVPETxH87Ny/MZ3Ry4XACxwSrrCv
         Jqs58pQfW9uZtUpdd386KL1nh9sUkSUSI5b2v3AGpZMCGwwby5WbVklvOqNH22vu7f2u
         XQy2U+m0rvrmAjvT1IqimW3RPy4ijtkPLBCcFgIghCdgscVyL9/q6NKwY7XltzjOTpzf
         dM6g==
X-Gm-Message-State: APjAAAW7vTg8S5v7qhHfGDFrryq9qyU0oQpEy9XeRtuhGK2cc+jYJ/+a
        VJu4YOwRy4UC1QrllHYRANlUoYPhxIQfi/VTM4Y=
X-Google-Smtp-Source: APXvYqxkoQBxAkCqML4DF3HWl7yzpWJAIgoyQWj+U2oSg/xBSZ7zQ3QzoRQ1CFt/vyNR9m0il8n8AR0mFjZ+7TAPqq0=
X-Received: by 2002:a37:6897:: with SMTP id d145mr14355546qkc.398.1580090716502;
 Sun, 26 Jan 2020 18:05:16 -0800 (PST)
MIME-Version: 1.0
References: <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan> <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan> <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de> <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125212524.GA538225@rani.riverdale.lan> <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
 <20200125235130.GA565241@rani.riverdale.lan> <20200126025225.GA20804@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200126025225.GA20804@agluck-desk2.amr.corp.intel.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Sun, 26 Jan 2020 18:05:05 -0800
Message-ID: <CA+8MBbKah37goKsCxJoSD-xF7ZchKfWu0n27rN04UYiOCeXXBQ@mail.gmail.com>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 6:53 PM Luck, Tony <tony.luck@intel.com> wrote:

> So why don't we come through __switch_to_xtra() when the spinner
> runs out its time slice (or the udelay interrupt happens and
> preempts the spinner)?

To close out this part of the thread. Linux doesn't call __switch_to_xtra()
in this case because I didn't ask it to. There are separate masks to check
TIF bits for the previous and next tasks in a context switch. I'd only set the
_TIF_SLD bit in the mask for the previous task.

See the v17 I posted a few hours before this message for the fix.

-Tony
