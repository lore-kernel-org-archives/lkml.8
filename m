Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB008C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8302077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585864841;
	bh=6+Kdza74u4E/tZLzJ4COL1wTZ1wIH+lLoigD3UGOtUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N6lthRM9qKoPc2z72c2Hgh91WyDiMWPBqX/A7rQiH0+Oko9BrMiliDhcoTo4Y7J2T
	 PKN5p8LHHvOnMwcmEqgMmJDHcrEgDZmhfKxVYJQSNeBi+AqRoDTlGi8EC05cY2otOa
	 xBQAfiJOiXo4gTyfKwFyGjZjrCBbOUojNpGb4Dos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbgDBWAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:00:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34835 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:00:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id r17so518618lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB+l1j4dO52z3YbtfHoJHZT4ToBoHZLUTUnUIBUmjJM=;
        b=aJqgPyE0TgD3LkLpm+0uIkcZOYtF3HI6kRDeJNKsNDJv5fVW1VWp1gJ0o+0C2J2ry8
         6758MJF7Qp/b8OgvWKaKDtbZtpEodTkPdwOlflYuxIlQO2Vum1ycLmVLx7ED2JzgxXJn
         nzabIxe49Gc9la8vY2W1J5LdRpKl8iUVGktT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB+l1j4dO52z3YbtfHoJHZT4ToBoHZLUTUnUIBUmjJM=;
        b=R7bSlcaI5Ec1IREL3aqTwmTuUSuiLeYM9mkNhd6E31p+t4FtBiw0vsCFR5RITHZ942
         DgMGyYVYi1jezy4MnHgcND2lmWb8E+UVqR9KGPBQlYuF/Gk1jVtISYwgoawn/fhcI3qb
         KnfiRtRSpiOSnZ3I/esBonCHq49VQmV1rsQlnHtPe2gAyAVXCHQneJFDaAHQ7tQTwe69
         Se1wf0dxWfV+XcArvC30He6KosBSDijiRggIQThxORLqysbnOPG/ICozhlqYfd02eHTk
         F4BLlLUiaoPsVm+TRW0JKP0BWzFW2EJDolcT7RvFBulH6kbIXwbIz9Se630rR653SG/y
         ogNw==
X-Gm-Message-State: AGi0Pua5E9kXQ2jJU/T15jaH1U85CxjTqDiA9lc5GjUEUX1k1FAMjqL0
        W1Sgbq6uU/Y0Q2IfF8PPYTYC+cstTuQ=
X-Google-Smtp-Source: APiQypK1VKacWu43z6+w6VvUs3lOOamfMGbFMMxbjNTwsm4mCK/usFpoIPsGbsiZNMYFuUjDUnB84w==
X-Received: by 2002:a19:2d1d:: with SMTP id k29mr3353262lfj.46.1585864838394;
        Thu, 02 Apr 2020 15:00:38 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id c22sm4622431lfi.41.2020.04.02.15.00.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 15:00:37 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f20so4972070ljm.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 15:00:37 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr2934399ljc.209.1585864836977;
 Thu, 02 Apr 2020 15:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200402095125.GA21592@gmail.com>
In-Reply-To: <20200402095125.GA21592@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 15:00:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAz1T9+NENL-yH1oPk=H22T6-BRhOMHAv-hAhfGACbcg@mail.gmail.com>
Message-ID: <CAHk-=whAz1T9+NENL-yH1oPk=H22T6-BRhOMHAv-hAhfGACbcg@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 2:51 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> The only slightly annoying part for the scripting was to extract the
> contents of the signed tag into the draft email, which I did with this
> rather inelegant hack:
>
>  git tag -l --format='%(contents)' $TAG | gawk '/-----BEGIN PGP SIGNATURE-----/{exit;}//{print $0;}' | head -n -1
>
> ... but I couldn't find a better way.

Yeah, you're supposed to use the existing code, but I guess your
approach works too.

I think git request-pull just uses "git cat-file" instead to show the
tag contents, but yes, I guess you can use "git tag -l --format" too.

[ Goes and looks up ]

This is what git-request-pull does:

        git cat-file tag "$head" |
        sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p

but admittedly "get cat-file" is a really low-level plumbing thing.
It's basically how you get the raw data out of any git object.

                 Linus
