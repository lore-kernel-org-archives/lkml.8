Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024C9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09232074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrXlumne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHYQwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:52:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725947AbgHYQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598374333;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GH3XQPFWbt0lqGRNQZepy/lyen7L04oI1NtwwdbRf3c=;
        b=NrXlumnecMEHxwDwn5rsp9Ui8UGR+Qz/VL2uyOKCAPTxCpKnAktJCLNa1uYWTACXU3Cjfj
        FBIDQwDatcXhkFtRYfHFf/YAQH9fL3gDrD1OXX5mvuj9YPG63R1ZZVap1pwtBkTESFYwh9
        YeE1CgnRV9XeAAEUX90m4d1rvGbqRIc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-l_VdJnjNOFeSdR2bdQk5Dg-1; Tue, 25 Aug 2020 12:52:07 -0400
X-MC-Unique: l_VdJnjNOFeSdR2bdQk5Dg-1
Received: by mail-qt1-f200.google.com with SMTP id c8so3174571qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=GH3XQPFWbt0lqGRNQZepy/lyen7L04oI1NtwwdbRf3c=;
        b=QhOFNfQTwSxbYDPHsky/TU0cC8MeN9YzIin+d6Po+M+GYGhCIeb0FsMjh2xe4K/f9E
         DZKz/50yokE5SOYYFypgq1xbh7t/PiHMqKcaGivPGxLJ8rxgpa8GoQerwy7XfCt+ZRrg
         hZ3NyRooNjlDiGENmWf0j4rlvxjm0zFHVzBCPRqNjRcuJGLjPCxSiTJn4uo3UUL8aXJO
         aB6zluOa2S75AeXTtA3xeMcL2UbllePjlhI8JTABJ1CQCzpfLXuY89aDg5FTKKO5DaRF
         wUzuPzvwc1DzkAbVZHMNOGvai0+fw+Y7pJTjohi8tpma//yo7Y/Yh3u5Jadgp5CE3ayo
         a3FQ==
X-Gm-Message-State: AOAM532t/Mjk9ZZetG5MUHYJwhW8ENCBWP8CNPFmKC2MAPgnzVYke3Sy
        z4HMyp8lF21K/dEt5YtIi2bSFDQbe0Crzv2jPnNQd/HpVyzPJeUBflCF9a4gpIKOnbHuKt5pO2O
        eMDZKAyLF4KMC7FP6X7YAcset
X-Received: by 2002:ac8:1773:: with SMTP id u48mr9877466qtk.259.1598374327296;
        Tue, 25 Aug 2020 09:52:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPR44U8niNebYvUrKITYg+kbJjP80i+hSedazIwkyueDHLFtKe3ByC0Rxwfw2DlIYaJ18R6g==
X-Received: by 2002:ac8:1773:: with SMTP id u48mr9877443qtk.259.1598374326949;
        Tue, 25 Aug 2020 09:52:06 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id k3sm12047360qkb.95.2020.08.25.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:52:06 -0700 (PDT)
Message-ID: <76392bff28359a88fbdf0857f011e0ed9f666dc4.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/2] drm/nouveau/kms/nv50-: Program notifier
 offset before requesting disp caps
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Date:   Tue, 25 Aug 2020 12:52:05 -0400
In-Reply-To: <CACAvsv6hymdcGkEcigL3fWACZ_1POpB+aefq9d9ChnYv_dHnVg@mail.gmail.com>
References: <20200824183253.826343-1-lyude@redhat.com>
         <20200824183253.826343-2-lyude@redhat.com>
         <CACAvsv6hymdcGkEcigL3fWACZ_1POpB+aefq9d9ChnYv_dHnVg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 08:28 +1000, Ben Skeggs wrote:
> On Tue, 25 Aug 2020 at 04:33, Lyude Paul <lyude@redhat.com> wrote:
> > Not entirely sure why this never came up when I originally tested this
> > (maybe some BIOSes already have this setup?) but the ->caps_init vfunc
> > appears to cause the display engine to throw an exception on driver
> > init, at least on my ThinkPad P72:
> > 
> > nouveau 0000:01:00.0: disp: chid 0 mthd 008c data 00000000 0000508c 0000102b
> > 
> > This is magic nvidia speak for "You need to have the DMA notifier offset
> > programmed before you can call NV507D_GET_CAPABILITIES." So, let's fix
> > this by doing that, and also perform an update afterwards to prevent
> > racing with the GPU when reading capabilities.
> > 
> > Changes since v1:
> > * Don't just program the DMA notifier offset, make sure to actually
> >   perform an update
> I'm not sure there's a need to send an Update() method here, I believe
> GetCapabilities() is an action method on its own right?
> 

I'm not entirely sure about this part tbh. I do know that we need to call
GetCapabilities() _after_ the DMA notifier offset is programmed. But, my
assumption was that if GetCapabilities() requires a DMA notifier offset to store
its results in, we'd probably want to fire an update or something to make sure
that we're not reading before it finishes writing capabilities?

> Ben.
> 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: 4a2cb4181b07 ("drm/nouveau/kms/nv50-: Probe SOR and PIOR caps for DP
> > interlacing support")
> > Cc: <stable@vger.kernel.org> # v5.8+
> > ---
> >  drivers/gpu/drm/nouveau/dispnv50/core507d.c | 25 ++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/core507d.c
> > b/drivers/gpu/drm/nouveau/dispnv50/core507d.c
> > index e341f572c2696..5e86feec3b720 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/core507d.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/core507d.c
> > @@ -65,13 +65,26 @@ core507d_ntfy_init(struct nouveau_bo *bo, u32 offset)
> >  int
> >  core507d_caps_init(struct nouveau_drm *drm, struct nv50_disp *disp)
> >  {
> > -       u32 *push = evo_wait(&disp->core->chan, 2);
> > +       struct nv50_core *core = disp->core;
> > +       u32 interlock[NV50_DISP_INTERLOCK__SIZE] = {0};
> > +       u32 *push;
> > 
> > -       if (push) {
> > -               evo_mthd(push, 0x008c, 1);
> > -               evo_data(push, 0x0);
> > -               evo_kick(push, &disp->core->chan);
> > -       }
> > +       core->func->ntfy_init(disp->sync, NV50_DISP_CORE_NTFY);
> > +
> > +       push = evo_wait(&core->chan, 4);
> > +       if (!push)
> > +               return 0;
> > +
> > +       evo_mthd(push, 0x0084, 1);
> > +       evo_data(push, 0x80000000 | NV50_DISP_CORE_NTFY);
> > +       evo_mthd(push, 0x008c, 1);
> > +       evo_data(push, 0x0);
> > +       evo_kick(push, &core->chan);
> > +
> > +       core->func->update(core, interlock, false);
> > +       if (core->func->ntfy_wait_done(disp->sync, NV50_DISP_CORE_NTFY,
> > +                                      core->chan.base.device))
> > +               NV_ERROR(drm, "core notifier timeout\n");
> > 
> >         return 0;
> >  }
> > --
> > 2.26.2
> > 
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

