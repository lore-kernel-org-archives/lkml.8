Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9384320757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHGwL9vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgCRPVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:21:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45461 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:21:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id x143so4504568lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjNBXmlZoIrN3q2R+0N0U+vPceC5x2t2cgobLHksbD8=;
        b=sHGwL9vlgSbAcKLpDif5C6eANsbkh0er1kRifUICtKSB6FUThYFQoHW2UERi6YfFqJ
         akMziW2xR3eFzQ9LnlI7Wql8KTCujug/ONZuuFhQM88rhTHIqGjCy/iX0/Q/aPFf/WLU
         6Jsu7LRNuWG0yDkXr80lZiwFUWuKLG7hKj9Q249rHHudHqDuxux3oiq+e06fW/nf2Tzi
         SaqjJjJDLWovL9cZFW28MPT4cxlHUnbAgIFH4ge2WJji6VnsUariQcJPGpGwe6npwq7B
         d4Hn1E40HCqvLZKMltCttNmcd/9bhe48aiiqCch63HeetZqgHEqg9Kkll9nbnmdk03+i
         huHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjNBXmlZoIrN3q2R+0N0U+vPceC5x2t2cgobLHksbD8=;
        b=oTe8RnqNpakqrcCXCKxfW+QXvDV53yNuwyNOlvCE9806sVy2UxlBrDZI/41zmrYhhU
         xJop/u54HRRfnlYyAcc0tKhNME6shyDT8Ek/O8L6n0ZpjeY29UPh37RzdYwv51C1O8VC
         aAcjPyTbii1S3yE+2DkeH6sZ75aiz50TyDLj1KaqA+ILZ1He8vD8PKNB7vluUTG0OsdM
         4ZCBe7kpm/muJhpKTOQml5rQn6k6uptFwtAIkfFzZw3k9bwDiIcxzh62A9br2OutT09A
         oiWiKIfX3xU2T+ytADDRuG3sOE4obHCDLPc9YYrM6GlfPmkM1L5na7tyzB1/LUNAmBdk
         eQFw==
X-Gm-Message-State: ANhLgQ0Tpx+to5J/9GOO34tQ6BijZ8pbM3Awk8MYgAF1+7AXqZJZGeSd
        voYNqjRowd+1f1GAJzZVA8Y/OzNwEHMafjVyd6SOAg==
X-Google-Smtp-Source: ADFU+vuGy/L7+Jlprxze4ydqODFOtG5APuX0DpeWbhdi3fXZld7NPYXabqmrjEfg1sMQRzYnOCAdXjtc24sXBOM01JA=
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr1512366lfb.167.1584544865110;
 Wed, 18 Mar 2020 08:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz> <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
 <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
 <CAHuR8a-PbmthrKYpY5-SM-MH39O39W2J1mXA48oy9nASmys0mg@mail.gmail.com> <20200318095710.GG21362@dhcp22.suse.cz>
In-Reply-To: <20200318095710.GG21362@dhcp22.suse.cz>
From:   Ami Fischman <fischman@google.com>
Date:   Wed, 18 Mar 2020 08:20:53 -0700
Message-ID: <CAHuR8a-0R318DUK4n3tyug2n6D8+pKVUHbN0mwQcFbgy4gGTOg@mail.gmail.com>
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Robert Kolchmeyer <rkolchmeyer@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 2:57 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 17-03-20 12:00:45, Ami Fischman wrote:
> > On Tue, Mar 17, 2020 at 11:26 AM Robert Kolchmeyer
> > <rkolchmeyer@google.com> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 3:54 PM David Rientjes <rientjes@google.com> wrote:
> > > >
> > > > Robert, could you elaborate on the user-visible effects of this issue that
> > > > caused it to initially get reported?
> > >
> > > Ami (now cc'ed) knows more, but here is my understanding.
> >
> > Robert's description of the mechanics we observed is accurate.
> >
> > We discovered this regression in the oom-killer's behavior when
> > attempting to upgrade our system. The fraction of the system that
> > went unhealthy due to this issue was approximately equal to the
> > _sum_ of all other causes of unhealth, which are many and varied,
> > but each of which contribute only a small amount of
> > unhealth. This issue forced a rollback to the previous kernel
> > where we ~never see this behavior, returning our unhealth levels
> > to the previous background levels.
>
> Could you be more specific on the good vs. bad kernel versions? Because
> I do not remember any oom changes that would affect the
> time-to-check-time-to-kill race. The timing might be slightly different
> in each kernel version of course.

The original upgrade attempt included a large window of kernel
versions: 4.14.137 to 4.19.91.  In attempting to narrow down the
failure we found that in tests of 10 runs we went from 0/10
failures to 1/10 failure with the update from
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/74fab24be8994bb5bb8d1aa8828f50e16bb38346
(based on 4.19.60) to
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/6e0fef1b46bb91c196be56365d9af72e52bb4675
(also based on 4.19.60)
and then we went from 1/10 failures to 9/10 failures with the
upgrade to
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/a33dffa8e5c47b877e4daece938a81e3cc810b90
(which I believe is based on 4.19.72).

(this was all before we had the minimal repro yielding Robert's
61/100->0/100 stat in his previous email)
