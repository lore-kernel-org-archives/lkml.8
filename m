Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FEFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8C12053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrLyLTY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgAPGzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:55:55 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33317 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPGzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:55:55 -0500
Received: by mail-ed1-f47.google.com with SMTP id r21so17957915edq.0;
        Wed, 15 Jan 2020 22:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MtnVpKpg4yme77WQSKJ0ALip8EFeD1YBGjDv6aco++Q=;
        b=HrLyLTY38JMp/f9eq14bOZ6unkQFYufDLNo+QZ0iCm3ljF9V7b7H7HF92Jz9MKuS+C
         /HWEJMuiMFGyzIQdVdhIjaiM7GHcAu6aNRGa/RxRs8/drjjUl/HmSuMxbFHIzCBB1jaY
         NDhLzfBxI20lnEOhpUD4QD2vfVW0eYj5uX/+dtRf2ydlS7oeCN0kom0h1g8KKUhPFSxV
         XpuloJ8dfYwFQYgDEWaCP395RDBy+PdAvZrc1J0JtPK/bxpb2MlHDjMrYColpPNTvJzC
         IK1xC8OLJMME5wlOXOhadACNG2/RJIkQTU0P3jQzBAZrTrbKqwmQOz9Ry5V89XdzqpDT
         lKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MtnVpKpg4yme77WQSKJ0ALip8EFeD1YBGjDv6aco++Q=;
        b=hBPnhLqCYoYxzAeiJqhGChF9NiFCN3aEMdH4ra+4z25vWGomY7YncLq9HsJbbLyUML
         EnnhwFjoE/ZcNL9+a0ovkUN9xzVTgPZrgbbkY9LLu4+cfvJQ6yWq6FjZZ0hc53h8O8Ce
         692CMFjkO3Vm5UJpNm41glP1kGrw+sv1/DfEkLXULp8AOgMVJNdpi6gLEUVVm2WD0DRw
         5a47d+F5ur/jDeMyff2chg7X/EM3ZLQvYA0gA8Kw3cktM58jp4tc7uRuqQ9SAgnMMGAW
         0KNZ9vPEi3lztfc9ALn2QwrnMRwBrmBODF75/CnR4ViTpEqaoHK6MYj39v/HsnPfSapk
         hnpA==
X-Gm-Message-State: APjAAAWpljKPUWNP7aR1w+AyacVDGbWeoaxvDuE0Hy7CzJKk7AA9eYPF
        i/wwPy2nKqkvJ6sclWqIFXQfayln/DXG0tP82zc=
X-Google-Smtp-Source: APXvYqyCBsj2+U8TE8b/WZd/7VuAcHu4x+AAHJ2ktOFKkjshdhxcCFyDFdP9LHvKHy+NaR3nytPkswm/I+lSVUuOf2s=
X-Received: by 2002:a17:906:1b07:: with SMTP id o7mr1354122ejg.131.1579157753386;
 Wed, 15 Jan 2020 22:55:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:1c11:0:0:0:0 with HTTP; Wed, 15 Jan 2020 22:55:52
 -0800 (PST)
In-Reply-To: <CAHk-=wiqPHc=BzSYO4N=awucq0td3s9VuBkct=m-B_xZVCgzBg@mail.gmail.com>
References: <CACMCwJLJCA2iXS0QMKKAWQv252oUcmfsNvwDNP5+4Z_9VB-rTg@mail.gmail.com>
 <5C216684-6FDF-41B5-9F51-89DC295F6DDC@amacapital.net> <CACMCwJLogOH-nG7QEMzrXK-iJPOdzCrL05y0a6yAbtPsfdRjsQ@mail.gmail.com>
 <CAHk-=wiqPHc=BzSYO4N=awucq0td3s9VuBkct=m-B_xZVCgzBg@mail.gmail.com>
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Thu, 16 Jan 2020 08:55:52 +0200
Message-ID: <CACMCwJL+kdkJRfRhG6bt_ojU0UeipqxVL3vwS3ETqVEjnWL1ew@mail.gmail.com>
Subject: Re: Fix built-in early-load Intel microcode alignment
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>, johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> However, the most likely cause is that you have a borderline dodgy
> system, and the microcode update then just triggers a pre-existing
> problem.

For that particular processor model, there appears to be microcode
updates for four steppings: 9 10 11 and 12. My model is stepping
9, so it appears to be early commercially sold version of that
model. Probably more problems on it than on later steppings.

> But it might be worth it if the intel people could check up with their
> microcode people on this anyway - if there is _one_ report of "my
> system locks up with newer ucode", that's one thing. But if Jari isn't
> alone...

I'm not alone with latest Intel microcode problems. Debian for
example reverted microcode to older microcode version on some
Intel processor models because of hangs on warm reboots. Those
reverts were not for same processor model as my processor, but
they do indicate "not everything OK" situation with latest Intel
microcodes.

https://lists.debian.org/debian-security-announce/2019/msg00237.html

My laptop computer was made by Dell, and Dell has been really good
at providing new BIOS updates (that don't require Microsoft OS to
update). More than once they have provided new BIOS to fix some
security flaw that was still embargoed. The information about that
security flaw then became publically known later after embargo
ended.

Now that I have learned about the instability of latest two
microcode updates for my laptop's processor, it isn't difficult to
connect the dots why Dell is still shipping 3rd latest microcode
in their latest BIOS update for that laptop computer.

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
