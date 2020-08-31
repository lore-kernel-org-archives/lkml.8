Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7950CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4792420866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AS5SvMiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHaOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgHaOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:16:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:16:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so2998293ejf.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D+jgYWCECokgeMoKCt+yMfDkGgoonOPi28LQb80zcoc=;
        b=AS5SvMiYtSI+CWXRGuTYCefWuAmJ0GhXJnEIwQxverbnwHsolVx/ZJLdUle6ekYccU
         aezPLF97GJEFqFILdvEgTTXvTMFslz6HQy//DP71I52yu6xKQQJFiz1KFA3PfHyAOS3O
         nrYdTuLFZUxQ8tydHhHNYDwPnSTAQU1e3byQXu/Oo96+i7pr2hxGrmL97/ehnXtijEFP
         Lsk/qSQ88coc7yz+QAY1lEJzKN+9u4eha26bJ3oIetiKzomepuUDrvQvKMBauCO4DShK
         rPJQl3yNo8WRpHPgnVVHC9T0HPNI6Qj4gy3nRCGcKRIx1p9OFs0fVfM3GrxPGkHfnPis
         KgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D+jgYWCECokgeMoKCt+yMfDkGgoonOPi28LQb80zcoc=;
        b=UNdm+e2z8oLyLG82n9nvscFqyiyFoSIrDYkwhg7mfe5yMO8/2y6GXJkzOtIhAoxlXq
         G6kBiwmwhJSMwIHNXl2wGJ2d6Uhy8wtsKYCuFFhza3gc9XrSbthyno5J0rqyOqhHpp5e
         tH1XBE+jWeb/IWPiNudeMlE4JjBUrG4OKSJIY8+hy/7lianGQ/Lri0teWwObVcatV5yM
         si1akuxvexMiYkvwk9GN55KCdSGbOgfizoSgqRi/7zILB/k4gkcYEq0+a9xlgFA5aqbK
         +y6qOIoCtEgrKH3+5uyeU/pg/YBUC3wjHlIA076NnMAy8S9M+PHwuXYL9V9sqwvvGbEX
         mWMw==
X-Gm-Message-State: AOAM530DD+7oE0lisULJPe9dYPydY4beDefojgKPBNN2GiJh5+kwMW8I
        Zsm+WMXp3nCHrLW9uxC7nvXsJkkZ3UDPgXMDcj4f
X-Google-Smtp-Source: ABdhPJwIso00QLAdjPOq4tzXvgc5uH2zepJ3/DauXdwi15tf2jlFLGiFg5rP7DTBTffmKAZKoGlcfC+9MqLExZY94wY=
X-Received: by 2002:a17:906:bc52:: with SMTP id s18mr1294329ejv.398.1598883393485;
 Mon, 31 Aug 2020 07:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com> <20200824132252.31261-2-peter.enderborg@sony.com>
 <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
 <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com> <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
 <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com> <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
 <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com>
In-Reply-To: <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Aug 2020 10:16:22 -0400
Message-ID: <CAHC9VhRi87H2GhsKQN9iMOQeSw3g5_qwok9jpx+pfFSouQ9d5w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:04 AM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 8/27/20 3:30 PM, Paul Moore wrote:
> > On Wed, Aug 26, 2020 at 11:06 AM peter enderborg
> > <peter.enderborg@sony.com> wrote:
> >> On 8/26/20 4:45 PM, Paul Moore wrote:
> >>> On Wed, Aug 26, 2020 at 10:34 AM peter enderborg
> >>> <peter.enderborg@sony.com> wrote:
> >>>> On 8/26/20 3:42 PM, Paul Moore wrote:
> >>>>> On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
> >>>>> <peter.enderborg@sony.com> wrote:
> >>>>>> This adds tracing of all denies. They are grouped with trace_seq f=
or
> >>>>>> each audit.
> >>>>>>
> >>>>>> A filter can be inserted with a write to it's filter section.
> >>>>>>
> >>>>>> echo "permission=3D=3D\"entrypoint\"" > events/avc/selinux_denied/=
filter
> >>>>>>
> >>>>>> A output will be like:
> >>>>>>           runcon-1046  [002] .N..   156.351738: selinux_denied:
> >>>>>>           trace_seq=3D2 result=3D-13
> >>>>>>           scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.
> >>>>>>           c1023 tcontext=3Dsystem_u:object_r:bin_t:s0
> >>>>>>           tclass=3Dfile permission=3Dentrypoint
> >>>>>>
> >>>>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >>>>>> ---
> >>>>>>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++=
++++
> >>>>>>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
> >>>>>>  2 files changed, 62 insertions(+), 2 deletions(-)
> >>>>> My most significant comment is that I don't think we want, or need,
> >>>>> two trace points in the avc_audit_post_callback() function.  Yes, I
> >>>>> understand they are triggered slightly differently, but from my
> >>>>> perspective there isn't enough difference between the two tracepoin=
ts
> >>>>> to warrant including both.  However, while the tracepoints may be
> >>>> We tried that but that was problematic too.
> >>> My apologies if I was on that thread, but can you remind me why it wa=
s
> >>> a problem?  Why can't we use a single tracepoint to capture the AVC
> >>> information?
> >> The problem is parsing the event.
> >>
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2=
020_8_18_842&d=3DDwIBaQ&c=3DfP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=
=3DoO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=3Dqmi2ROWsLC_0mLLhHkpb71j1=
YoicydLh-7l4cOsLYcY&s=3DiS3eZr3TFrN5I7BbnvPFYOKd6DfW1FHTFcwI7joS_fk&e=3D
> >>
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2=
020_8_21_526&d=3DDwIBaQ&c=3DfP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=
=3DoO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=3Dqmi2ROWsLC_0mLLhHkpb71j1=
YoicydLh-7l4cOsLYcY&s=3D9OsLN0Y5mUWxEAAqUE6K4PS57Pn1XyZz7GXak6uc_Ls&e=3D
> >>
> >> and the "single list" version
> >>
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2=
020_8_17_1346&d=3DDwIBaQ&c=3DfP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=
=3DoO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=3Dqmi2ROWsLC_0mLLhHkpb71j1=
YoicydLh-7l4cOsLYcY&s=3DtWSY2ry2IT6RcT5BIUwMuqBL_yPObDE1VljbLqI1zrA&e=3D
> >>
> >> With this patch we follow standard message format so no plugin should =
be needed.
> > I'm evidently missing something very fundamental (likely), and/or I'm
> > just not communicating very clearly (also likely), because the above
> > links don't appear to make any sense with respect to my question.
> >
> > Let me try a reset ... Why can't we basically take the
> > "selinux_denied" TRACE_EVENT implementation in your patch and use it
> > to replace the "selinux_audited" TRACE_EVENT in the selinux/next tree
> > (of course with the necessary changes to the AVC callback code)?
> >
> > If the "selinux_denied" implementation is valid from a tracing point
> > of view, why can we not do this?  Of course if the "selinux_denied"
> > implementation is not a valid TRACE_EVENT then I'm not sure why this
> > was suggested for SELinux :)
>
> Im happly fine with replacing the selinux_audited with selinux_denied.  H=
owever it is the case where there are more than one denial at the same time=
. Im not sure how and when it might happen.

One thing I wondered about was why not build up a single string with
all of the permissions instead of generating multiple trace events?
In the previous discussion it was implied that this was due to
limitations in the tracing subsystem's filtering, and based on the
discussion thus far I'm guessing there is little desire for this
information if it can't be filtered on?

If that's the case then I think we are stuck with the tracing code
that currently lives in selinux/next, as I currently have little
desire to add more than one tracepoint in the SELinux permission
checking codepath.

> When that happen we got more than one event. I have no problems with that=
, but im not sure if the debug tools and perf can make sense of that.
>
> A other feature with the selinux_audited event it might be inserted on ot=
her places in the code too.  A denial is sort of final.

--=20
paul moore
www.paul-moore.com
