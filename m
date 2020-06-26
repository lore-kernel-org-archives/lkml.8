Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2208C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5A32076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StgvoN4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgFZH1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgFZH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:27:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A03FC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:27:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so4582895pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=rVE2gGMcdBTrZylPbNiSgsk7HUdCF2EQnvGkDTn3LJ4=;
        b=StgvoN4F8FU5QTAnNsQGhYge/1G6HeXMbO3EDr/y8YcUT/7iIRgkYkr2LS8QBA0+TE
         aJwJQv38n1h859JcK+L/dM1GkWzwdB4cWujivrbEAJohF3f6qy9RifDqB6igGuyw/80j
         nrjyxLykAs8ADjUkxPYD3Ye+qol0g0rNMpV7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=rVE2gGMcdBTrZylPbNiSgsk7HUdCF2EQnvGkDTn3LJ4=;
        b=HqRJhRWYEr+O0ADAlgvtUBRus4BTA1M/eiGIxxQMSXS0gwbrYnbk6v8LI8gBSRb1ve
         2KasfNDGdYmJxf8shdjtjDRjyuOYgdR3xlVU4LXrupYb3UfRjx6A4ZNp6iGXJt0rQM7U
         dc65dSlMJxfnatuix04f3gWAJc0M96l3oWPh6B8ygaHrvhCqX1yzTYx/va2kDeg5JykJ
         Pct7/FucWWFT4DCm452sV55Zt9GMAzb/qmIApB1L8mkd/UkJUJPpvKt0IPBovbIjh4zh
         4HQJ0YAjVeYW7juxKztITXsm1l1uON0OIeudOOpB/+Mb5nmqFKHkEYR7pkmZ8jyoUBnf
         zDCw==
X-Gm-Message-State: AOAM5331Y3cHQAgtGyS74XjgkKLC9GA+3Qca6Mgc//I3GlUGol3+59S8
        UIoOFzVxlP20KYEeZokYYAiogE00yig=
X-Google-Smtp-Source: ABdhPJy3QTnrjHmytYSAo2vMdiB1gRFjkDXC77YICclekAoyNkjxmCy06GCMeccAjXJbVOuLBh7q8A==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr1438095plb.185.1593156428885;
        Fri, 26 Jun 2020 00:27:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n12sm21216319pgr.88.2020.06.26.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:27:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAODwPW9Gp+sjt7hdTrDmU-KnfpbXNkuQL52+v_FxwSzSSTH_yg@mail.gmail.com>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com> <20200407082923.2001556-2-patrick.rudolph@9elements.com> <159306873839.62212.9311861115757727633@swboyd.mtv.corp.google.com> <CAODwPW9Gp+sjt7hdTrDmU-KnfpbXNkuQL52+v_FxwSzSSTH_yg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] firmware: google: Expose CBMEM over sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Coreboot <coreboot@coreboot.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
To:     Julius Werner <jwerner@chromium.org>
Date:   Fri, 26 Jun 2020 00:27:07 -0700
Message-ID: <159315642733.62212.13203844825360378214@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2020-06-25 13:51:34)
> > > +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/address
> > > +Date:          Apr 2020
> > > +KernelVersion: 5.6
> > > +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> > > +Description:
> > > +               coreboot device directory can contain a file named
> > > +               cbmem_attributes/address if the device corresponds to=
 a CBMEM
> > > +               buffer.
> > > +               The file holds an ASCII representation of the physica=
l address
> > > +               of the CBMEM buffer in hex (e.g. 0x000000008000d000) =
and should
> > > +               be used for debugging only.
> >
> > If this is for debugging purposes only perhaps it should go into
> > debugfs. We try to not leak information about physical addresses to
> > userspace and this would let an attacker understand where memory may be.
> > That's not ideal and should be avoided.
>=20
> This is memory allocated by firmware and not subject to (k)ASLR, so
> nothing valuable can be leaked here. The same addresses could already
> be parsed out of /sys/firmware/log. Before this interface we usually
> accessed this stuff via /dev/mem (and tools that want to remain
> backwards-compatible will probably want to keep doing that), so having
> a quick shorthand to grab physical addresses can be convenient.

Ok. Regardless of the concern of the physical address is there any usage
of this attribute by userspace? The description makes it sound like it's
a pure debug feature, which implies that it should be in debugfs and not
in sysfs.
