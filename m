Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15CC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148E3206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrZhM+tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDUQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgDUQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:52:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70817C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:52:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b12so15694061ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlOb0J7u43lP1vjBfG9ZcRxUmvLKf3oV1hkoW2i8cGM=;
        b=GrZhM+tCKzL1/Y+RU646etnWXZpICHRv95JyZbGoFtaynACb3kja9TbFXHwyfJ6clF
         QK4TE5ORpEjlYwAaNMtCTaQ0Fr37EW91RCdPtfUjF7YZg6IS4r0yiYPxFv89oO1YsUEs
         sfJQC2NVx1nMhCeABHLCYCQvnSG3v3zBKq2fDASijSPyWNRl4+se6mFV9bxORXgt3Dq4
         lKa/m+X3XK47LUGuWzU7d+THc/bou5LPZ1n+5/fUZ/J+hzUQbaW6iaw5HYBHb3wr3lnk
         bT+A/luGfcKzEKJA7Qqa8CPqBhFKmdtlDqcKlsSjrAnIu8srH0lXgRZ1T7RbFBjAw6fO
         eGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlOb0J7u43lP1vjBfG9ZcRxUmvLKf3oV1hkoW2i8cGM=;
        b=p6ZEepShOiPjktl5XCGEIMBUjqTEdk8fQNknYYfKJ3vmkGC/us+EbLqI+MpHTVxF6y
         a7HmNtRLMHS5Vvku7JY9R3Z9+cF1ffDPQHzMtqkFgnY1U8dCbF6LKciTHg3CjyOgDIfG
         JpMUMT8Td1p+O/EWDKaYEKoig/RQwNXZQCWwYtJ3fo4y5X0BM1+Gkd1H7bddAO5dnoJl
         5jl2YliktUw37BbaODS8JjwgLrAZBcAsoPDTmWXqzjRw40eH1uWvdb+4bVAxXcYy4ZiG
         tvXgNEfsZVsyfqVA5WifWE/qVnHbMOj7Gjjamdh+UKOMf4Qdpjus7zEoX0lhmpz8e99g
         clbg==
X-Gm-Message-State: AGi0PuYyaaEw27btv7Qp9MNJI/Ufhtv9Nr3878qd5HavWzR8EAWNpm69
        Yz6Njy0RY6pQyM6tetm61v2E190so3C2ERqhRQilug==
X-Google-Smtp-Source: APiQypI+utw7ltzeZh5aJ7/aORHVDbVXhkpIjaJ0I86IY9cM5PP2nsrE+DOOUQBRofXFDA/oNhPIXVRxmNA50ocvX5Q=
X-Received: by 2002:a02:90cd:: with SMTP id c13mr20914233jag.83.1587487933216;
 Tue, 21 Apr 2020 09:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200415201420.15958-1-mike.leach@linaro.org> <20200417021113.GB5426@leoy-ThinkPad-X240s>
In-Reply-To: <20200417021113.GB5426@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 21 Apr 2020 10:52:02 -0600
Message-ID: <CANLsYkzx_DeXcJ_dBju_OWWRiREAqzG6opeQAuXf5gTsdgZtQQ@mail.gmail.com>
Subject: Re: [PATCH] perf: cs-etm: Update to build with latest opencsd version.
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 20:11, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Wed, Apr 15, 2020 at 09:14:20PM +0100, Mike Leach wrote:
> > OpenCSD version v0.14.0 adds in a new output element. This is represented
> > by a new value in the generic element type enum, which must be added to
> > the handling code in perf cs-etm-decoder to prevent build errors due to
> > build options on the perf project.
> >
> > This element is not currently used by the perf decoder.
> >
> > Tested on Linux 5.7-rc1.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index cd92a99eb89d..da4737cbc2ab 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -564,6 +564,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >               resp = cs_etm_decoder__set_tid(etmq, packet_queue,
> >                                              elem, trace_chan_id);
> >               break;
> > +     /* Unused packet types */
> > +#if OCSD_VER_NUM >= 0x0E00
> > +     case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
> > +#endif
>
> I don't think use macros to distinguish OpenCSD version number is a
> good idea, this will get more and more code to checking version number
> if later have more these kinds improvement and finally it's hard to
> maintain.

I agree.

>
> Sugget just simply add the new case for
> OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH, considering if user uses an old version
> OpenCSD and doesn't output this new element, the new added case doesn't
> introduce issue for old OpenCSD lib.
>
> Futhermore, suggest to change the code in
> tools/build/feature/test-libopencsd.c, so can reflect the kernel 5.7
> to require OpenCSD v0.14.0 or later version when build perf.

As Leo pointed out, I think we should just continue dealing with new
versions of the library in test-libopencsd.c.

>
> Thanks,
> Leo
>
> >       case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> >       case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> >       case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
> > --
> > 2.17.1
> >
> > _______________________________________________
> > CoreSight mailing list
> > CoreSight@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/coresight
