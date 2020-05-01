Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8CEC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6E2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588292710;
	bh=yfdNvOY3FQ6D0dDBJmIg46Jo3Al+v8xEkzblWwevs8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MoTfPNUC3tsr539vas+525wNSnFbqm3OdbqGEz02JUQ4L3Q4uIKPiW49XLRMKD70u
	 8bW0GHNQwbsW1kRNlGAOYGIsvP7ZDK2uOPr2/dIgbrjM4l6KjmkT7ziIfNS3EL1UeI
	 EGklfua4tU3AZ+QOWJWw7Z4zTFq94AG1jd8W8TVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEAAZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgEAAZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:25:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB8C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:25:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so2773987lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDf2N8mBL2qJb74S4ITCK9fAPPmUAgvoerWrh8dXt4o=;
        b=MreruorxVqBBm3pLqSig9B5BAdyGIXSOxD6BJt2oKVTHUb1/8Whm8gIpcX16l58lSv
         QPNB29r7LEHIVU4GCCsv3CKa2gCOu0ExTOuE3vO1blHXWjouvTt8wvZBkUIdShaFwHPi
         GYDLjgWlY3m6y8KprJDmZNXjTI5GXeXGOTUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDf2N8mBL2qJb74S4ITCK9fAPPmUAgvoerWrh8dXt4o=;
        b=mw1hGCk0Zjsd8NDLxLoONMCqbeGhSB/Qj3DIh23126LaZUinAzRdDDEqPETe5BuoGv
         P/i5O1D86RsfK6Y5BnHMO5tr8V+HDVX+2iusyoouRnoIHFz0yivGfRvIlNwyMIz8xmAT
         ++r/9pnVpe6/IskAbwvzajm5KxUcI8LytcUwDKKjS05cygBCCg2jeaOaC5RHgAEw+DLq
         NM9jDd3BQaPo5J4AnHO402urob7kr8Bn4+Rwx/4bzCyU1QXw3envD9TzBCYO43thMgZS
         EdrWwEzkwxin/EISQlsVs05UbdieZP/wxZm1guMzMZ6Yfo6kX/T1cGci1jd0ygtqsmH0
         dCjQ==
X-Gm-Message-State: AGi0PubISiO6Q/ZSSdZuGOvxeCrEq+pHyoCqYZbKZek02//feDiNeJxE
        1+mcGA5HBsvoTo4hj3H3xw7VJzwnUi8=
X-Google-Smtp-Source: APiQypIANIWxlWyHLhylwcvbgLWdefh9EJxDk2FjeNEqNuCkNjg6d5rPETvbjTA52X+wxaXozk4RtA==
X-Received: by 2002:a19:2286:: with SMTP id i128mr781714lfi.109.1588292706924;
        Thu, 30 Apr 2020 17:25:06 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id o22sm892392ljj.100.2020.04.30.17.25.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 17:25:06 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id l11so2777640lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:25:06 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr783565lfe.152.1588292705876;
 Thu, 30 Apr 2020 17:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com> <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com> <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
In-Reply-To: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 17:24:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
Message-ID: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
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
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 5:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's a horrible word, btw. The word doesn't actually mean what Andy
> means it to mean. "fallible" means "can make mistakes", not "can
> fault".

Btw, on naming: the name should be about _why_ it can fault, not about
whether it faults.

Which hasn't been explained to me.

I know why user accesses can fault. I still don't know why these new
accesses can fault. I know of the old name (mcs), but the newly
suggested name (safe) is the _opposite_ of an explanation of why it
faults.

Naming - like comments - shouldn't be about what some implementation
is, but about the concept.

Again, let me use that "copy_to_user()" as an example of this. Yes, it
can fault. Notice how the name doesn't say "copy_to_faulting()". That
would be WRONG. It can fault _because_ it is user memory, so
"copy_to_user()" not only describes what it does, but it also
implicitly describes that it can fault.

THAT is the kind of explanation I'm looking for. The "memcpy_mcsafe()"
at least had _some_ of that in it. It was wrong for all the _other_
reasons (not having a direction, and the hardware just being complete
and utter garbage), but at least there was a reason in the name.

I am not interested in adding new infrastructure that cannot even be
explained. Why would writes ever fault, considering they are posted
(and again, "user space" is not a valid reason, we have that case
already and have had it since day #1 even if the original naming was
the same kind of bad implementation-specific name that "mcsafe" was).

If the ONLY reason for the fault is a machine check, then the name
should say so, and "copy_mc_to_user()" would be a perfectly fine name
(along with copy_to_mc(), copy_from_mc(), and copy_in_mc()).

It wasn't clear how "copy_to_mc()" could ever fault. Poisoning
after-the-fact? Why would that be preferable to just mapping a dummy
page? But even if it cannot fault, I can see that you might want to do
it as a special kind of copy to avoid any read-mask-write artifacts
(which can definitely happen on other architectures, and I could see a
manual memcpy() implementation doing even on x86)

                  Linus
