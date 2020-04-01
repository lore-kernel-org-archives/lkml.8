Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1870C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937452071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIJ+NtgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgDAScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:32:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43470 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbgDAScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:32:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id m11so1231500wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=746fvQzZ1Umztu28E3KypqCqWdptr1ovc0pRXKqEkK4=;
        b=LIJ+NtgZRdc+ieQEF7kotKoNN2N9x0kajfVWhAc+qJ/EnF/zwGPBGbWpPVUEBUknPZ
         UCzJACzFiPsXHKZXwWP/FQIF0Jopo0D7bxjZsq4iN2ARM45fQL9WGjELO6zVNyTCY3D3
         kL/2hmtWyM0eTbOrKxw3GRvBxBSUOa2FFBGznFkk4Sr7qm8szq4LkrVAoKa7ra1WU69M
         lhzPeaD+1rK9baBsc/kZSv5Ym3kB7/THZ+0I7DKhTPpBUurV01ELSkOiL7TC03i6hNSr
         3GQvpnEB5LWuGjoDXaLKfEo/mkWWFVj3cjBoAN0KEdRaoUARlQL7X7Lg7qj/kgfVVZ+q
         e6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=746fvQzZ1Umztu28E3KypqCqWdptr1ovc0pRXKqEkK4=;
        b=fvv41RyhC6zQp1E+YsEvmtOsrAF2qRBTckcvl+ydoH3stpyv+xEnZZR697pHEhtGxH
         moy0I5/52VTB65eAGHlIrYQCXBx33MJVp60puyitWseqc+5iiT1Wr/y9Ooc8DJUttMS7
         yp4w02N4HfcoSJw3yT0fdn03dteCA3IS4GHj2X8xpeZaoRzBlviW01S00W5Q7Pa6SfyH
         KsD4euSHnj860D6Y97MMUvJeUKA4RFOCIN73Dmg4shA4F4U9gA4zNlhyHtj7osLY1UtD
         XKf1D+TE7v2ypSIUAkLktbqHiGMDjSHW/XU7dZ1irTS5cng5dY5ValgM4GN7ifMDqUj/
         pVmA==
X-Gm-Message-State: ANhLgQ3dqeTxWCm1MjqWZ/sJhkdJZw18eePKvn8/gYN3ZddcohG5zHh2
        Z5d7EYaR1yvi/KknokBx6w88u1Z9cPN14/41sZXTeA==
X-Google-Smtp-Source: ADFU+vuZux8n5T9HQGOGlYd2w0bcZldegvX/dW3QqzF55YPPLoi2ejE7fh8nksHxBdPBnsxb6W1CtX7Yg9rnv1IO4Ms=
X-Received: by 2002:adf:f50d:: with SMTP id q13mr27924252wro.374.1585765968916;
 Wed, 01 Apr 2020 11:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200331205740.135525-1-lyude@redhat.com>
In-Reply-To: <20200331205740.135525-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Apr 2020 14:32:38 -0400
Message-ID: <CADnq5_NtTEMGka7vJFZLvOi7UFQkwKex_SL5Hunt61HJW1KFpw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/dp_mst: Remove ->destroy_connector() callback
To:     Lyude Paul <lyude@redhat.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Leo Li <sunpeng.li@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        David Francis <david.francis@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 4:58 PM Lyude Paul <lyude@redhat.com> wrote:
>
> This finishes up the work that Pankaj Bharadiya started in:
>
> https://patchwork.freedesktop.org/series/74412/
>
> And allows us to entirely remove ->destroy_connector()
>
> Lyude Paul (4):
>   drm/amd/amdgpu_dm/mst: Remove unneeded edid assignment when destroying
>     connectors
>   drm/amd/amdgpu_dm/mst: Remove ->destroy_connector() callback
>   drm/amd/amdgpu_dm/mst: Stop printing extra messages in
>     dm_dp_add_mst_connector()
>   drm/dp_mst: Remove drm_dp_mst_topology_cbs.destroy_connector

I noticed this as well when I was sorting out the load and unload
callback removal.  Thanks for finishing this up.  This series looks
good to me, assuming none of the display folks have any concerns:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 45 +++++--------------
>  drivers/gpu/drm/drm_dp_mst_topology.c         | 16 ++-----
>  include/drm/drm_dp_mst_helper.h               |  2 -
>  3 files changed, 15 insertions(+), 48 deletions(-)
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
