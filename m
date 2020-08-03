Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920C120719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U5IJ1EiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHCKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:25:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCFFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 03:25:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so26108206ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/DGzoF6CXxtHgCXxPInKWoutLOVz6raFMjHyyz/ipo=;
        b=U5IJ1EiF6Tz96U8sH967hVgdN6eea3a58Qqz9un8vqypSnbKs2aEJ4TPhcj1Axgs9/
         1vxUi7H9lgsLV8PGg1dvx+3ltT0XFwCopKDQ5rjEEYofaDDuabSk5w8/vgRL7llBhkha
         DYLLhHKEFW1YWXEC87G8XM88E7pFxgfH6ObLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/DGzoF6CXxtHgCXxPInKWoutLOVz6raFMjHyyz/ipo=;
        b=Hkch2t+/sgTMpKv/43FlXfF5DAMcHwRegiXlbDDk0G8fuOTXF+KEFZYmJ2ZyckUaU3
         gzHvq+PYzcirjNCnn4eHigliwX7gAxHPXAka5x3SI6TUfxYcoDbuCq822X2EZHZQY3al
         QgLbyOPnrSXpFqZ5xycVla2kUxZ54NBcOIiwBCrPg3IE69YNSQ56Z/MIQLmtfnQS25Jo
         AGscK7vD4SuD8QtsuCQK7aTrngw0qIuJwjvySKIo8A4bngof7ycEVIoJTx/qUu/FAbZX
         r7vwz2Ydyhnij630+Dsy9piTPlMsreQ+2XIlccH74IfRmUVUhVLkW/QEhz7yzFyqmuhy
         Hnzw==
X-Gm-Message-State: AOAM530ZnviCmUG35AgAjTPdTXzeDsE67LkhpLtOV/BkSyTySpJAZeZG
        RBdkR7Uo9JZDRxdZJ7mWSaTVgzuFICmgZZHlK9Q5qg==
X-Google-Smtp-Source: ABdhPJyj+8rgkMKUp5BqiqiKv+fCWAPz11haw9k4LqSF1romGZ6qE4LKnPblwZYsWksqykQbw9g8AR3k1d/be/o+C3w=
X-Received: by 2002:a2e:9010:: with SMTP id h16mr2737548ljg.316.1596450311318;
 Mon, 03 Aug 2020 03:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
 <CAACQVJqNXh0B=oe5W7psiMGc6LzNPujNe2sypWi_SvH5sY=F3Q@mail.gmail.com> <a3e20b44-9399-93c1-210f-e3c1172bf60d@intel.com>
In-Reply-To: <a3e20b44-9399-93c1-210f-e3c1172bf60d@intel.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Mon, 3 Aug 2020 15:54:59 +0530
Message-ID: <CAACQVJo+bAr_k=LjgdTKbOxFEkpbYAsaWbkSDjUepgO7_XQfNA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 00/13] Add devlink reload level option
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:13 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>
>
>
> On 7/27/2020 10:25 PM, Vasundhara Volam wrote:
> > On Mon, Jul 27, 2020 at 4:36 PM Moshe Shemesh <moshe@mellanox.com> wrote:
> >>
> >> Introduce new option on devlink reload API to enable the user to select the
> >> reload level required. Complete support for all levels in mlx5.
> >> The following reload levels are supported:
> >>   driver: Driver entities re-instantiation only.
> >>   fw_reset: Firmware reset and driver entities re-instantiation.
> > The Name is a little confusing. I think it should be renamed to
> > fw_live_reset (in which both firmware and driver entities are
> > re-instantiated).  For only fw_reset, the driver should not undergo
> > reset (it requires a driver reload for firmware to undergo reset).
> >
>
> So, I think the differentiation here is that "live_patch" doesn't reset
> anything.
This seems similar to flashing the firmware and does not reset anything.

>
> >>   fw_live_patch: Firmware live patching only.
> > This level is not clear. Is this similar to flashing??
> >
> > Also I have a basic query. The reload command is split into
> > reload_up/reload_down handlers (Please correct me if this behaviour is
> > changed with this patchset). What if the vendor specific driver does
> > not support up/down and needs only a single handler to fire a firmware
> > reset or firmware live reset command?
>
> In the "reload_down" handler, they would trigger the appropriate reset,
> and quiesce anything that needs to be done. Then on reload up, it would
> restore and bring up anything quiesced in the first stage.
Yes, I got the "reload_down" and "reload_up". Similar to the device
"remove" and "re-probe" respectively.

But our requirement is a similar "ethtool reset" command, where
ethtool calls a single callback in driver and driver just sends a
firmware command for doing the reset. Once firmware receives the
command, it will initiate the reset of driver and firmware entities
asynchronously.
