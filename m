Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8FC206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQbv/4QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405290AbgFYUvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405069AbgFYUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:51:47 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD59C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:51:47 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m21so452806vkp.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPPK3kBNKaygr37eIBL2NH14o8ojaSRKAXG3ZctXctU=;
        b=DQbv/4QS3JFQnnim4jVc7bYne+sHKObOWgW8nD4EHwy+k4GMvGoWohiuqp+LqFW62O
         wOznO3U9/OM34V2dW3i4FiVZQOzvD6nWJRGDHFtdwWigQ25rndz92UpUBC8g0+AVLoPZ
         vLgKZi5q0c96GF0m0VGVSSRnCIjXWCfhHS4eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPPK3kBNKaygr37eIBL2NH14o8ojaSRKAXG3ZctXctU=;
        b=sESS4IWgoyG8SP9C5RJ+MImPsLGRu09f/9hfHJJjwhWOI/jQ93LsunuqpG9gQdt9Zr
         kpExpRemnVvtEylr5PHQ7rkTm25F/bBatFXyox/IduJ+xpj2iHROqmgBzVbJSpL2OVYu
         DfVXZvAONT9PlkIErfniBw4BcPFSFqQkSVdxhqTlCE/a5qWPa8R3jYGBdfaODGWjJc++
         CZkYT2yjajozbOJjXy06Z9Xvn86aiY2alCZqytk0H4hLAGH2K1dpsMh7m2KvyGdZKmDK
         lQEkBAW2nt2ey6AbDiMNzdU+WsHlDdLzDe1zEK01REKtc3hsj5IuwGC53wX98mVUACW0
         sOtA==
X-Gm-Message-State: AOAM530zwdnEtL+P8fXEEzKssvyQcqQsldB+8sblYTolHPIAxMuj+qzM
        FfDwpsZ9quDkFEIa66Q47fA2NRzvVD1E0izK/ZfEFjPq
X-Google-Smtp-Source: ABdhPJy+N3p/6spNaAlBumv6lwUKYBxdKbGnljQKsabxevrxqLTC60doiZVgI5dgJo0JECaO/F7UAMxakt6ty1Xmq3c=
X-Received: by 2002:a1f:b44d:: with SMTP id d74mr8530827vkf.59.1593118306307;
 Thu, 25 Jun 2020 13:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
 <20200407082923.2001556-2-patrick.rudolph@9elements.com> <159306873839.62212.9311861115757727633@swboyd.mtv.corp.google.com>
In-Reply-To: <159306873839.62212.9311861115757727633@swboyd.mtv.corp.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 25 Jun 2020 13:51:34 -0700
Message-ID: <CAODwPW9Gp+sjt7hdTrDmU-KnfpbXNkuQL52+v_FxwSzSSTH_yg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] firmware: google: Expose CBMEM over sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Coreboot <coreboot@coreboot.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/address
> > +Date:          Apr 2020
> > +KernelVersion: 5.6
> > +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> > +Description:
> > +               coreboot device directory can contain a file named
> > +               cbmem_attributes/address if the device corresponds to a CBMEM
> > +               buffer.
> > +               The file holds an ASCII representation of the physical address
> > +               of the CBMEM buffer in hex (e.g. 0x000000008000d000) and should
> > +               be used for debugging only.
>
> If this is for debugging purposes only perhaps it should go into
> debugfs. We try to not leak information about physical addresses to
> userspace and this would let an attacker understand where memory may be.
> That's not ideal and should be avoided.

This is memory allocated by firmware and not subject to (k)ASLR, so
nothing valuable can be leaked here. The same addresses could already
be parsed out of /sys/firmware/log. Before this interface we usually
accessed this stuff via /dev/mem (and tools that want to remain
backwards-compatible will probably want to keep doing that), so having
a quick shorthand to grab physical addresses can be convenient.
