Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B52C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 01:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE887206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 01:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpWAYO0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCGB2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 20:28:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35318 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCGB2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 20:28:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id a12so4147508ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tM5rNBDzDBfUzH8FigDCfHhd1rXYSHwTeF/Tvps25Ao=;
        b=HpWAYO0LOjmlNMsNvaoN+lgWUHGKA8P4Sdwn1m2ycN0+57X7bxCNbb4H/jMrbdlkFG
         O+tISKs7zkNKeaL26enQ0oB+/d1pULikT52MHYmfhd/C+qFMjwppkxxHiwwOgoLtO49n
         OIFjOgVCPylgn+ZSTR/4wEnhsRFMXOTd3FBSDy+a2A+Bbk0uEww0vtON8gfJMNvMmrOz
         mm9+lyc7fLEYhWUT0UxiVLifqQClK0Bj3Ese/LbI0Po2RpPpEtEx7AI5CIcKCLBkBBx9
         pQYXoRJ2Eu63G0SPdGTbc5Y6ygn1lRPtwhCC1MQk4h00NyIOehUvSzO4UXnAZDUT4KDv
         c35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM5rNBDzDBfUzH8FigDCfHhd1rXYSHwTeF/Tvps25Ao=;
        b=oDDbhZtWk4ivZUWGJMan2UxII5A6HDj+JL2J0zmqTCL2zUl9n50nr+AMKx+nh8jjUn
         cpf79WWZ52FanuqEEQZWNdX9VGv0Esj3enc/H4UQkINffPu4sMYo0HMlNzPjJAwN9J6T
         jS2VnWiVtTMAx9x2X+KGYce9dX1Bc4VdRJIaeO4qW5LBSoP2RAT+aN6gC+8WAXKTZOxI
         Fnp/POs5QGxT3lx9IuVAmiHfMRLd8NgemEpNp//d6o4YiIoUkBkiYX4pwj6f+orE/w6b
         07UNiSUOwM3sMvZyhBoX1BYs2id1T/DbRbHxNvj+zkjPsE0n7GjalE3JwlwIx7O4D3mg
         t7QQ==
X-Gm-Message-State: ANhLgQ16O5jgPhvTpzKqJTFnUerzDglFuQB9pCogNY3rgs8OzsWrt0QX
        xH6eJkSPybK3xoxMWrdJNBobxSwjoMV76E+39L76gg==
X-Google-Smtp-Source: ADFU+vswaj44TqozErjCWa7iRzdIsg2d5K2y0B3N/jpQwQkIl3T1+K9wNnp5/KhPTopivHokdBJHWhLYsjVl7GpbTvY=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr3340787ljp.66.1583544477713;
 Fri, 06 Mar 2020 17:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-4-rajatja@google.com>
 <87k13znmrc.fsf@intel.com> <CACK8Z6ERZpZaSXsxrk_yGrRAtrgwytb5TEpyt1sX+V40U7m0sQ@mail.gmail.com>
 <87pndpoklz.fsf@intel.com>
In-Reply-To: <87pndpoklz.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 6 Mar 2020 17:27:21 -0800
Message-ID: <CACK8Z6G1y+osmBeOFmGyFgC2SX=HoY=rogKxk=F6D2GPxoMt1w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/i915: Add support for integrated privacy screens
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>,
        Guenter Roeck <groeck@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jani so much for the detailed explanation.

I was able to write the code for this, but I am facing one problem, see below.

On Fri, Mar 6, 2020 at 2:15 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Thu, 05 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > OK, will do. In order to do that I may need to introduce driver level
> > hooks that i915 driver can populate and drm core can call (or may be
> > some functions to add privacy screen property that drm core exports
> > and i915 driver will call).
>
> The latter. Look at drm_connector_attach_*() functions in
> drm_connector.c. i915 (or any other driver) can create and attach the
> property as needed. drm_atomic_connector_{get,set}_property in
> drm_atomic_uapi.c need to handle the properties, but *only* to get/set
> the value in drm_connector_state, nothing more. How that value is
> actually used is up to the drivers, but the userspace interface will be
> the same instead of being driver specific.

Understood, done.

>
> >> > @@ -93,15 +97,18 @@ int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
> >> >       struct drm_i915_private *dev_priv = to_i915(dev);
> >> >       struct intel_digital_connector_state *intel_conn_state =
> >> >               to_intel_digital_connector_state(state);
> >> > +     struct intel_connector *intel_connector = to_intel_connector(connector);
> >> >
> >> >       if (property == dev_priv->force_audio_property) {
> >> >               intel_conn_state->force_audio = val;
> >> >               return 0;
> >> > -     }
> >> > -
> >> > -     if (property == dev_priv->broadcast_rgb_property) {
> >> > +     } else if (property == dev_priv->broadcast_rgb_property) {
> >> >               intel_conn_state->broadcast_rgb = val;
> >> >               return 0;
> >> > +     } else if (property == intel_connector->privacy_screen_property) {
> >> > +             intel_privacy_screen_set_val(intel_connector, val);
> >>
> >> I think this part should only change the connector state. The driver
> >> would then do the magic at commit stage according to the property value.
>
> Also, this would be the part that's done in drm core level.
>

Yup.

> > Can you please point me to some code reference as to where in code
> > does the "commit stage" apply the changes?
>
> Look at, say, drm_connector_attach_scaling_mode_property(). In the
> getter/setter code it'll just read/change state->scaling_mode. You can
> use the value in encoder ->enable, ->disable, and ->update_pipe
> hooks. Enable should enable the privacy screen if desired, disable
> should probably unconditionally disable the privacy screen while
> disabling the display, and update should just change the state according
> to the value. Update is called if there isn't a full modeset. (Scaling
> mode is a bit more indirect than that, affecting other things in the
> encoder ->compute_config hook, leading to similar effects.)

For my testing purposes, I'm testing this using the proptest utility
in our distribution (I think from
https://github.com/CPFL/drm/blob/master/tests/proptest/proptest.c). I
notice that when I change the value of the property from userspace,
even though the drm_connector_state->privacy_screen_status gets
updated and reflects the change, the encoder->update_pipe() is not
getting called. Just wanted to ask if this is expected since you seem
to imply this update_pipe() might *not* get called if there *is* a
full modeset? (What is the hook that gets called for a full modeset
where i915 driver should commit this property change to the hardware?)

Thanks & Best Regards,

Rajat


>
> Ville, anything I missed?
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
