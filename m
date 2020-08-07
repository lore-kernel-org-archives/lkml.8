Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18813221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDovZW0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHGDNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:13:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6119C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:13:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z20so395439plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 20:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mntt/yV9g0WantW+MFUMl7qG7fGk/Oi5dRuY6kccsYw=;
        b=RDovZW0comW5k7a9qDBhi0AemfQotZc35NVP3B/JDirQCHkb3KxYzbiNVpmHOLFuwB
         16VvF1+r+a5Uh0LqZm/NYiMCFqw5Kg84vRSFVEvGutQZxz14IrygV9VS6q8VcYGZw/h1
         dHG0UzmQ0xHz10DDkThhfDS9paQ9LrKO/PoEGFXs24VQWqcyQVSzNeshbKpJnxZ1mG0d
         5Zf92IcmPVcRjaHg0tRv1sCEKsHUa8AclgHXo1FnE9oTRiP5y2Izlfzg3fZJrgzl3sqd
         07fpIFfQH3mur+x5UUTjPLI1b9JvJd346SZpuhDJVf+98Mu6vRZ5H5WCK+dJezuiL7kq
         YLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mntt/yV9g0WantW+MFUMl7qG7fGk/Oi5dRuY6kccsYw=;
        b=YlzfvzyJeoWWSOjIFO0Q+Ndl5YgoBm9CuJtQ3dcyPFN7dB4YMrFe1YDBs1ayVtNfwZ
         SMYWyBLK/P7YNcdPBnNFl/2bGlbD06JGzK+WzsGvvXA2cjp0efrpZgYG4G/3H7ODD5DJ
         Va6jgIEx6tVWV6GrXOTgTU7esqmUdw6vAA3eFezhHelvatxhYpGqPwlIYTvG1pO2hrHn
         N8IuOvkExsRBDGoqiObNnNSpF1z/dUiLZKp4CckFd8A9xlOf8VifwcI4JtEaG5R7T6vM
         CSXUpO0ztR6GXUvBc9o8NWLwQ6BS05lHDl41ByoCVWUowO5+0YBQskbt5dsWtD3H9MPZ
         ztHw==
X-Gm-Message-State: AOAM531m3aAhGC3NgqRGDSe082gpy2iGoW5sQ9VsEg6CF8/JUx0/lhbR
        H8VB3vBCRfd7bTFL/UzqFj9ngkOZe69a+hyk8+RW8w==
X-Google-Smtp-Source: ABdhPJwHf/baXL/FshABJwVK72iC4bCenNX/IrhdV9ee/TdyaNNuV/RPDLg0FYY0/FnAyGhJKXhqedgsCLoHXEgA/TY=
X-Received: by 2002:a17:90a:1546:: with SMTP id y6mr2707909pja.93.1596770011948;
 Thu, 06 Aug 2020 20:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com> <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <f314b687-11a9-5a5e-e79e-c46dd2f16c6f@kali.org> <78ad0914-6173-f753-9eba-b7cbfbb51fd6@kali.org>
 <CALAqxLXPN9kThwF32YoWyApaWnfjthANXj3uk65Wc3ddaJQFFQ@mail.gmail.com>
 <20200807004001.GF20825@builder.lan> <CALAqxLWwY00PVUL7EM-tgbXeB5h8MsfPo7EFZTfDSzbb3P3eqQ@mail.gmail.com>
 <20200807013903.GG20825@builder.lan> <CALAqxLWmJisTA9836Rvb8f9m4hsTL7iZ=HQtz39anu2Bbgv44g@mail.gmail.com>
 <CAGETcx9Gsa9CWow8MBVPF4cgofdcK1+cFohAf_-Dqa3JT8H1bw@mail.gmail.com> <CALAqxLWR3mKrQDn5VkOV_zaaqxmwWzZwK0CCLRSfGJDU6WUXag@mail.gmail.com>
In-Reply-To: <CALAqxLWR3mKrQDn5VkOV_zaaqxmwWzZwK0CCLRSfGJDU6WUXag@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 6 Aug 2020 20:12:56 -0700
Message-ID: <CAGETcx-2mCg9K3th+HW_QjvKWmpb6yk=Cu3F3gOn3w+TD1RTzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     John Stultz <john.stultz@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 8:09 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Aug 6, 2020 at 8:02 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Thu, Aug 6, 2020 at 7:49 PM John Stultz <john.stultz@linaro.org> wrote:
> > > On Thu, Aug 6, 2020 at 6:42 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > > With all due respect, that's your downstream kernel, the upstream kernel
> > > > should not rely on luck, out-of-tree patches or kernel parameters.
> > >
> > > I agree that would be preferred. But kernel parameters are often there
> > > for these sorts of cases where we can't always do the right thing.  As
> > > for out-of-tree patches, broken things don't get fixed until
> > > out-of-tree patches are developed and upstreamed, and I know Saravana
> > > is doing exactly that, and I hope his fw_devlink work helps fix it so
> > > the module loading is not just a matter of luck.
> >
> > Btw, the only downstream fw_devlink change is setting itto =on (vs
> > =permissive in upstream).
>
> I thought there was the clk_sync_state stuff as well?

That's not needed to solve the module load ordering issues and
deferred probe issues. That's only needed to keep clocks on till some
of the modules are loaded and it depends on fw_devlink, but not really
a part of fw_devlink IMHO. And yes, that's on my list of things to
upstream.

> > > Also I think Thierry's comments in the other thread today are also
> > > good ideas for ways to better handle the optional dt link handling
> > > (rather than using a timeout).
> >
> > Could you please give me a lore link to this thread? Just curious.
>
> Sure: https://lore.kernel.org/lkml/20200806135251.GB3351349@ulmo/

Thanks.

-Saravana
