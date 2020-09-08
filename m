Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874EDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388DE224D4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVj/plKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgIHOoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729865AbgIHO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599575163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=UVj/plKG6DRifmHMZTlUgfPoWrlDhO5hOcL37nFebFZBjBM2JajOpeMRZwFLK+9BMikk/E
        5xOawuMqdp4K0Kvxlk6KUe90Wou8YCbVFBJto0jBU9M58+ZkDLwBXaDZobqWA2E/hG1gpA
        gfUCoROtvep9rDbQpy5FpHT/R5xDupI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-ls6_zrpvNL6z6-ADJoE10Q-1; Tue, 08 Sep 2020 09:03:15 -0400
X-MC-Unique: ls6_zrpvNL6z6-ADJoE10Q-1
Received: by mail-lf1-f71.google.com with SMTP id r6so316114lfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=a5iirPEwgqn/xgcNmYmO0ss93Z8oHZlD9Jaffv2KIpC9XagPiZeRd4eoA4/I8jY44R
         FOxakqCRhX9xy6Cmpfj2nHPEnwfbRCrYbEYaGPDJXfyY3V/ga2C00XEAk8SIq3lJFmSr
         /1k6Hu+iC36K1v7fFi3WUnz4i5c1Tngvw8Rh+YRL4Nyqsu/8FxRna4iZQL2sq985OG4p
         6eRw0WHBLoZ1SbV/lny6RCnMnop/xZ/Kod+ju9W4e+QYSn5JWTTD3hVqf11DncLZrttO
         Nvhi/HkEUe+zQjnSN/Cx1R1VmE5vy2IJUEZgyWzPj3aeqPlOS7755LxPjXln2mYXgRf/
         XiqQ==
X-Gm-Message-State: AOAM533cIjp8gCk2eW+uZRWe2S5XvFuFEkFw222vGYc8w7EAGvhnyB6T
        AnpssazTMFzSa16YXxyctR7GPPZtR1SC4T16jBOyAe9rGmkIhhUtVcyOagLwD9OSOCQuS58pFM9
        IzKhiZaJvw4Xro249o7htLIvC9M27y0AUn+BnX0tU
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002419ljb.337.1599570193913;
        Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3OiZVrw0QoBLOoEdLIlQNVVb0O6eJMGa3bo/IK9ijWF8Ck46zu6UhG+8IzfVZdlckAAhTWm3SSIT9nd2q7U=
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002409ljb.337.1599570193556;
 Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com> <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Sep 2020 15:03:02 +0200
Message-ID: <CAFqZXNtEywSumid=FHLysV8jaSPXDO--3YJC6DfuGwRRZLQ58g@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 2:37 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 7, 2020 at 5:39 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
<snip>
> > diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> > new file mode 100644
> > index 000000000000..caf9107937d9
> > --- /dev/null
> > +++ b/security/selinux/measure.c
> <snip>
> > +static int read_selinux_state(char **state_str, int *state_str_len,
> > +                             struct selinux_state *state)
> > +{
> > +       char *buf, *str_fmt = "%s=%d;";
> > +       int i, buf_len, curr;
> <snip>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               buf_len += snprintf(NULL, 0, str_fmt,
> > +                                   selinux_policycap_names[i],
> > +                                   state->policycap[i]);
> > +       }
>
> This will need to be converted to use
> security_policycap_supported(state, i) rather than state->policycap[i]
> since the latter is going to be removed by Ondrej's patches I think.

Based on my testing so far, even with just moving the array under
struct selinux_policy, the RCU accessing still brings a significant
overhead (relative to the whole syscalls it is probably negligible,
but relative to the rest of the simpler hooks it is about 30%), so I
don't think it is necessary to adapt other patches to it yet. It will
be my responsibility to adapt to the newly added code when/if I rebase
and respin my patch.

>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
> > +                                selinux_policycap_names[i],
> > +                                state->policycap[i]);
>
> Ditto.
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

