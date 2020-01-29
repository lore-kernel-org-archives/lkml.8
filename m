Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28716206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580319681;
	bh=fjifcePPtlIyvBkA/K3j1WYBoijltRnpMklePcRk3mM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ulhdFIrHhzOnX7CS8z7/cLisdUHELc/tFN9NpZ5HTSQa4hylATpoli7unQx0Ixm/t
	 3p0pyHMHtk1pFyt4CSVM9uut4Hq5zeasHSOEcUQ642/LrUBVRHQEjCLOuI9q1D4nkj
	 bXRwRsbi7N0ed1XBIs2VF88QcKNSGg2s9imiKD+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgA2RlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:41:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37384 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2RlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:41:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so268315ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzs29JuQG9++PU2+nVCtLhiO0+B6uu2BSoJd1SQI/+8=;
        b=ZDNjBOoofmM2bds+jVfTEyLsLeyDbhxcaAyiKBnrSn4Xan7211Upqh8nXpEeFDwuyf
         IddxBvFqfzrjXn57FCei7ld78d8HXdBDP59mRVWlDUrlx9QRuZC3pUiGXrWG+zWw+K6Y
         s6j6nsO7YVwFHN8zWZDB8QmMfJDQ41htP6RlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzs29JuQG9++PU2+nVCtLhiO0+B6uu2BSoJd1SQI/+8=;
        b=kz78aJnMZKbuTi8KEQOfoI7XbeBeodJXqzzc+VxAViOFJ2jkBnkv29x7ePilvUxq09
         d8/Egp0kdlSf5kyYBHw83t5I2QkH6wD4xMRPDU7NEsnHXNd6L/knUMoaKRKuCQrJgeKS
         vJrKij5VeifD+wuN+yp0K/0WJdq5W5m2SeX3si/947yP2go3Fk5G8Otb6WJ/k4vnBtNu
         1sKWApXPlSpJLALWXJaxoU7tiGuqiNTg1yIrgexLffxpFb1E3t+wdHWTGKF2s/X6n/Wb
         4IJ509P5gF9ZAqI7agc9i71iwfWe4sMsE09RvL6H6+mUSrDqO9JoVWxl3dQKaJ3GklNY
         KndQ==
X-Gm-Message-State: APjAAAWPcr5pQFAUvKIbv80eJpYC/BjSSiZ7RQgMVBnr9Vc3XpaYg6Nb
        ZwrvDiggqJx80PU7Fus9qkrqtY9o1U0=
X-Google-Smtp-Source: APXvYqwBXX4wKUtTPf14H0IlkeiFuSYwdKnFHPdO89+h3IUNgUj3b+1DnwhneIGk8sKNRtFZQP6zFQ==
X-Received: by 2002:a2e:b4cf:: with SMTP id r15mr181057ljm.52.1580319676414;
        Wed, 29 Jan 2020 09:41:16 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d24sm1336093lja.82.2020.01.29.09.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 09:41:15 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id n25so308807lfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 09:41:14 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr256499lfo.10.1580319674390;
 Wed, 29 Jan 2020 09:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20200128165906.GA67781@gmail.com> <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic> <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jan 2020 09:40:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
Message-ID: <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 9:07 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> This returns "3" ... not what we want. But swapping the ERMS/FSRM order
> gets the correct version.

That actually makes sense, and is what I suspected (after I wrote the
patch) what would happen. It would just be good to have it explicitly
documented at the macro.

> > And yes, your idea makes sense to use ALTERNATIVE_2 but as it is, it
> > triple-faults my guest. I'll debug it more later to find out why, when I
> > get a chance.
>
> Triple fault is a surprise.  As long as you have ERMS, it shouldn't
> hurt to take the FSRM code path.
>
> Does the code that performs the patch use memmove() to copy the alternate
> version into place? That could get ugly!

That would be bad indeed, but I don't think it should matter
particularly for this case - it would have been bad before too.

I suspect there is some other issue going on, like the NOP padding
logic being confused.

In particular, look here, this is the alt_instruction entries:

   altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
   altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b

where the arguments are "orig alt feature orig_len alt_len pad_len" in
that order.

Notice how "pad_len" in both cases is the padding from the _original_
instruction (142b-141b).

So what happens when all the three alternatives are different sizes?
In particular, we have

 (a) first 'orig' with 'orig_pad'

 (b) then we do the first feature replacement, and we use that correct
original padding

 (c) then we do the _second_ feature replacemement - except now
'orig_len, pad_len' doesn't actually match what the code is, because
we've done that first replacement.

I still don't see why it would be a problem, really, because the two
replacement sequences don't actually care about the padding (they both
end with a 'ret', so you don't need to get the padding nops right),
but I wonder if this casues confusion.

I do note that all the existing uses of ALTERNATIVE_2 in asm code that
might have this issue (REP_GOOD vs ERMS) has an empty instruction in
the middle, and the final instruction is the same size as the
original. So _if_ there is some padding confusion in alternatives
handling, it might easily have been hidden by that.

So I'm just hand-waving. Maybe there was some simpler explanation
(like me just picking the wrong instructions when I did the rough
conversion and simply breaking things with some stupid bug).

               Linus
