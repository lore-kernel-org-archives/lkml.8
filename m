Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D623FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA821208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzCNUFKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE1CRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgE1CRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:17:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D6C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:17:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d191so23582097oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoOt6AymlPyoPH2TZRaLxDLIS2AAC9L0oxTb6tMgUAA=;
        b=UzCNUFKBukHTNolB2WX4GpRLFnDXQYwsVruTl0FlcfjIW7Crzv63/yGP1ctenJgqtc
         6WFr6OdSM97NmFtj4iJ9/cCBqIjpBoRI/rogzJqTG793aMQDjEoMro9VgSj4zwm5ok0T
         Ae75GVbf9A4cps3YETFc5hbEmiWr4qryKJjZDCCM7SbCQJGf2aXLWM0Fq4VO1ELquhaD
         7/Bl+IMjw1rICkMGvMS4JSwJCI2HhoONeuQpI1usI3TnZ3SqUTHRq/KftGGYcku8VCdL
         v+p5i3qezPviEUWHOWrXYWQtINzhrd7KNlk/Kd3gdF16tDtrZnk4BSP5cLJhcCifveJM
         y7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoOt6AymlPyoPH2TZRaLxDLIS2AAC9L0oxTb6tMgUAA=;
        b=iNKmUwXbusCsGzHqWdqUm4RhoE9mDJulRFOhEzvctDqyt7cfcExz9CbLZNl1AP3swY
         FQOjffE/A+ODD1KB2yWSftuEFBTjmsWB9fwnkR6rl4fzazj60zrsrqrwcIRDJlygF3cT
         sN8voxjkDksNQi0mN66Ir3TrX80ttyudSbZMgEikORMzN/fzCjRWLAvxcLr5P5mlBPDD
         DxaEZuBfedQhQvNfXWrybZu01GDdu6YjyzfxKmAVwrORLc7jjpqLHG3Ekt9imZMa+Plt
         q5faabZf4DzJNQO98frTF6tx06+gGC6YLCzYvpK89tKEyhX1WzBBlLCz5hAn19i8+VF2
         utJg==
X-Gm-Message-State: AOAM533fWUzeCS4XWbDdl5A7cBok+lKFJUr8TLVQxsDbcEE9oAitfki1
        UYW7TKVtCbTQkVn418KFDDGJnUuBhFy8sQgPOq7Ykw==
X-Google-Smtp-Source: ABdhPJxIdSlQ2Ci80jFNGsjLog8rJaPI+zf8JNGmOaqQ/6uXIaKCREpkn5B9eonxCtIjb9116Mv579KREYT68f67cAY=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr765576oin.172.1590632222073;
 Wed, 27 May 2020 19:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200527074057.246606-1-saravanak@google.com> <20200527111750.GB5308@sirena.org.uk>
 <CAGETcx_Hr75W7VJT-2CnS=VVCW+B4ktv=4vdVQoxkhP4TAPF6Q@mail.gmail.com> <20200527203453.GJ5308@sirena.org.uk>
In-Reply-To: <20200527203453.GJ5308@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 May 2020 19:16:26 -0700
Message-ID: <CAGETcx_2W4YG+KcoDpRMRDUJ=o9GC-f=e0GSPyx=_ZpnDrFkxQ@mail.gmail.com>
Subject: Re: [PATCH v1] regulator: Add support for sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 10:17:21AM -0700, Saravana Kannan wrote:
>
> > If fw_devlink is off or not supported by the firmware (Eg: ACPI), the
> > behavior doesn't change. We act as if there are no consumers and turn
> > stuff off 30s after late_initcall_sync(). If fw_devlink is on, then it
> > makes sure all the consumers (in DT) are linked to the regulator
> > device as soon as it is added. So that solves your "we don't know if
> > there'll ever be consumers".
>
> No, it doesn't help at all with figuring out if consumers will ever
> instantiate...

It doesn't help with knowing IF all the consumers will instantiate,
but it does help put an upper bound on when it's okay to release the
"boot on" regulators/resources.

Instead of "userspace might load a module at any time and then bring
up new consumers so we can never tell when it's okay and hence we
can't do anything" to "we know all the consumers, so we just need to
wait for them to probe". And this helps a lot for systems where
enabled devices aren't going to be left uninstantiated forever.

> > The next concern is, "will the drivers ever be loaded for these
> > consumers". To handle these cases, I can update the "30s timeout code"
> > to just release all the "hold state". And I can make the time out a
> > kernel command line param that if set to 0, then it will actually wait
> > for all the consumers.
>
> ...due to this issue.  The DT describes the hardware, not the software
> that will run on it.  Making the timeout configurable is fine.

Right, but knowing the hardware descriptions allows us to put an upper
bound on how long we'll have to wait. And for cases where we don't
want to listen to hardware description for whatever reason, we can
have the timeout option to be backwards compatible.

> > Does that seem like something that'd work for you? That way, if no one
> > sets this command line param, it won't affect them. And if they set
> > it, then things work as intended when the system is configured so that
> > everything does eventually come up.
>
> This still leaves you with the problem that we're going to just ignore
> operations that happen while implementation of operations is blocked.
> If we queue up actually implementing changes to the hardware until after
> we claimed we'd done them then that's asking for trouble, especally with
> voltage changes - they need to be complete when regulator_set_voltage()
> returns, we can't defer syncing that to the hardware to some later
> point.
>
> Actually now I try to make sense of the code I *think* that rather than
> holding off on writing changes out like sync_state() and your changelog
> suggests

Yeah, I wasn't trying to suggest that. We can reword it later.

> this is only trying to defer disables.  That's a bit safer

Right.

> but then again it won't help as soon as we run into a system with a
> device that glitches due to some other change like a voltage being
> changed unexpectedly and it's adding complexity.

Which is a problem even today when multiple consumers are using one
regulator. I do plan to address that in later patches.

The idea is to keep the settings at a minimum of what the boot loader
left the "boot on" regulators at. For voltage, we can just do this for
regulators that support "get_voltage" and it's fairly trivial to do
with sync_supply. For "load" there is no "get_load" because it kinda
doesn't make sense (most regulator can't measure the load?), but maybe
we can add something like get_max_load() (current max load it can
support) and then set that as the minimum load the regulator needs to
support.

>  The entire patch is
> super unclear though,

Yeah, sorry, I meant to add a "RFC" prefix. It's not close to being
merge ready. For one, I didn't add much documentation at all.

> I can't understand what sync_supply is supposed to
> be.

It's kinda similar to "supply", it's a regulator client handle. But
it's a regulator client handle to the same regulator. It's used to put
the "minimum" requirements on the regulator.

> It appears to functionally just be a flag but it's done using this
> weirdly allocated and manipulated struct regulator.

Wherever it's used as a flag, it's just to say "if you already voted
for the minimum, don't vote again" or "if you didn't vote for a
minimum, there's nothing to remove now".

> > > > This commit adds a regulator_sync_state() helper function that
> > > > takes
> > > > care of all the "boot on" regulator clean up for any regulator driver.
> > > > All one needs to do is add the following line to the driver struct.
>
> > > None of the issues around this have *anything* to do with individual
> > > drivers,
>
> > Fair enough. I was just trying to give a way for systems that don't
> > have the "consumers might never come up" issue (Eg: Android phones) a
> > way to start using this while we try to figure out what to do for the
> > systems where it might be a problem.
>
> Drivers can be run on multiple systems, this is not a decision that can
> be made based on the driver.
>
> > > all this is doing is forcing us to go through and add this to
> > > every single driver which doesn't accomplish anything.
>
> > I don't see what's wrong with that. The kernel has made plenty of
> > changes where all the drivers using an API had to be updated in one
> > shot. This patch doesn't even require a one shot change. Anyway, if
>
> We do gradual API updates when there are actual changes required in
> drivers.  This change requires *zero* changes to drivers, there is
> absolutely nothing driver specific or relevant about it.  Nothing about
> the driver tells you if the flag should be set or not (it's a callback
> in the code but since there's only one possible implementation it's
> really a flag) so there's no purpose in having a flag in the driver in
> the first place.

Well, for a device that registers with multiple frameworks, they might
implement their own sync_state() that then calls into the helpers
provided by multiple frameworks. Or they might want to do additional
clean up over what regulator_sync_state() does, etc. So it makes sense
for the callback to go to the driver and it's not just a flag. But in
the context of this patch, I get what you are saying and I agree.

> > > Please go and look at the previous discussions of this topic, this needs
> > > to work for other users as well.
>
> > I'd be happy to, if you can point me to some of them. Sorry, I didn't
> > know what to even search for to get a meaningful list of search
> > results.
>
> The first hits I found were:
>
>    https://lore.kernel.org/linux-arm-kernel/1368076726-11492-1-git-send-email-skannan@codeaurora.org/#t
>    https://lore.kernel.org/linux-arm-kernel/CAKON4OzO427-MU4FqmF8AP5V=CXHuGdV1GTptiaJiRY7DLfDRA@mail.gmail.com/

Both of those threads are from a long time back. And one of them was
from me :) Things have changed a lot since then -- device links,
sync_state(), fw_devlinks, wanting this to work for modules, etc. And
what they are proposing is very different from what I'm suggesting
here. And some of the older arguments against this aren't valid
either. I'm happy to shoot them down if they are brought up here.

> Search around for deferred initcall, regulator_late_init() and so on.
> Please also talk to your colleagues, IIRC a good proportion of the
> variations on this have come from them.

Saw your subsequent reply :) Google is sending this because this is
not an issue just one vendor is seeing. I'll try to see if I can get
any of them to engage upstream, but can't promise that.

> You haven't mentioned an actual use case here (your changelog just
> declares the solution)

Ah, I thought I mentioned it in the "not part of commit text" section,
but I guess I didn't. In the hardware I'm testing, display is one
example of something that doesn't work without this. But it's hardware
that's on an old kernel and has a bunch of downstream stuff. I'm sure
I can dig up and find upstream cases, just haven't gotten around to
that. But this has been a recurring issue for vendors that's
definitely a real one.

> but in general these things are init ordering
> issues, if some device (typically the display stuff) is going to cause
> user visible glitches during init then things will work best if the
> system tries to ensure that that device gets started as early as
> possible.

There's no way to order/guarantee device probe ordering. The closest
we can get to that is initcall ordering or module load ordering. But
that has a couple of problems:
- Can't handle cases where the same driver probes two different
devices with different ordering requirements.
- Falls apart when a driver defers probe of a device.
- Doesn't work with async probing

Initcall can only order driver registration, which isn't really very
useful for what we need here.

> In general these things are best addressed at the system
> level rather than by bodging some low level thing.

Agree, which is why fw_devlink solves "How do I know all my
consumers?" and sync_state solve "are all my consumers probed?" at the
system level and not bogging down each framework with that. The
framework still has to do the actual steps. Which is what I'm trying
to implement here.

Anyway, I'll rework my patch to do the timeout and/or do this for all
drivers and we'll take it from there?

-Saravana
