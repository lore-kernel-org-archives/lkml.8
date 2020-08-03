Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B94C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB785206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C97O7R0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgHCMr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgHCMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:47:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DE5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:47:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so20375996lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiawdBAdSV10MNkMusk6KDvgMU6ZXm8ieLNJpzgLvRs=;
        b=C97O7R0Rfw2tGoywNIehE83jo0UdSKAdymy6KFtGYRXy2JZmpPFUHEhCPrycDtb8H3
         98g511+KDLHkvDZ9nubhDukfZAFd6z/Tkd1YMdE6aI9zaMMaPOLEyBfiNr7/o8t7ltdS
         FWQzBuzXviZRKX+mznI/YbIcG9gjXpDgfd1oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiawdBAdSV10MNkMusk6KDvgMU6ZXm8ieLNJpzgLvRs=;
        b=uP6983KfFgiWSoolOV9ED4uvyzXiC09Z3i333qv5srm3q8rzuz6twlNnGiq2WG2yCW
         gnxdbJJUVM+ffdyO9TZH57jK9lpSpZnXkyyjoO9k4Zf5hbgRtFNgwYg4c+nU9yv+kYJG
         7Afy3v0sJWA92uslD1agP9TlfXnTjOar03c+Yqgxtw6XsReZIJS2K92dCVIX021CUK2S
         s2v1BIvQCT/IUpPs06UV+huz7CNMudQ8rYWuoeYTu3Tjh4PVkGYqpjQJlwfqUyBvD/Q1
         M6jEIY8jCz2TPeRpjx38td2HGXC3h9IxMJkeHljO4dv1OyrZW97u3Szu7O6VAS7xTxTU
         RHWA==
X-Gm-Message-State: AOAM532ZgeZ2LtpbM0eJ2Ejv6UwDZnJD0Ccc1Nn0w3mJi1kx+5j84Nd+
        lwLOtt1UpdTn/Nwh0CT82auDTnmWTrVXzsI2+amGYw==
X-Google-Smtp-Source: ABdhPJxgP5BZtDN7U9WwwQIz450Z/zEXWaCSGn8z77dHbVfT6eNTzm4EDkSd3CjmFkYjwO6eTalxMtZBYfqzD1lTC7c=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr5741775lfa.103.1596458865734;
 Mon, 03 Aug 2020 05:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
 <CAACQVJqNXh0B=oe5W7psiMGc6LzNPujNe2sypWi_SvH5sY=F3Q@mail.gmail.com>
 <a3e20b44-9399-93c1-210f-e3c1172bf60d@intel.com> <CAACQVJo+bAr_k=LjgdTKbOxFEkpbYAsaWbkSDjUepgO7_XQfNA@mail.gmail.com>
 <7a9c315f-fa29-7bd5-31be-3748b8841b29@mellanox.com>
In-Reply-To: <7a9c315f-fa29-7bd5-31be-3748b8841b29@mellanox.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Mon, 3 Aug 2020 18:17:33 +0530
Message-ID: <CAACQVJpZZPfiWszZ36E0Awuo2Ad1w5=4C1rgG=d4qPiWVP609Q@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 00/13] Add devlink reload level option
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 5:47 PM Moshe Shemesh <moshe@mellanox.com> wrote:
>
>
> On 8/3/2020 1:24 PM, Vasundhara Volam wrote:
> > On Tue, Jul 28, 2020 at 10:13 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >>
> >>
> >> On 7/27/2020 10:25 PM, Vasundhara Volam wrote:
> >>> On Mon, Jul 27, 2020 at 4:36 PM Moshe Shemesh <moshe@mellanox.com> wrote:
> >>>> Introduce new option on devlink reload API to enable the user to select the
> >>>> reload level required. Complete support for all levels in mlx5.
> >>>> The following reload levels are supported:
> >>>>    driver: Driver entities re-instantiation only.
> >>>>    fw_reset: Firmware reset and driver entities re-instantiation.
> >>> The Name is a little confusing. I think it should be renamed to
> >>> fw_live_reset (in which both firmware and driver entities are
> >>> re-instantiated).  For only fw_reset, the driver should not undergo
> >>> reset (it requires a driver reload for firmware to undergo reset).
> >>>
> >> So, I think the differentiation here is that "live_patch" doesn't reset
> >> anything.
> > This seems similar to flashing the firmware and does not reset anything.
>
>
> The live patch is activating fw change without reset.
>
> It is not suitable for any fw change but fw gaps which don't require reset.
>
> I can query the fw to check if the pending image change is suitable or
> require fw reset.
Okay.
>
> >>>>    fw_live_patch: Firmware live patching only.
> >>> This level is not clear. Is this similar to flashing??
> >>>
> >>> Also I have a basic query. The reload command is split into
> >>> reload_up/reload_down handlers (Please correct me if this behaviour is
> >>> changed with this patchset). What if the vendor specific driver does
> >>> not support up/down and needs only a single handler to fire a firmware
> >>> reset or firmware live reset command?
> >> In the "reload_down" handler, they would trigger the appropriate reset,
> >> and quiesce anything that needs to be done. Then on reload up, it would
> >> restore and bring up anything quiesced in the first stage.
> > Yes, I got the "reload_down" and "reload_up". Similar to the device
> > "remove" and "re-probe" respectively.
> >
> > But our requirement is a similar "ethtool reset" command, where
> > ethtool calls a single callback in driver and driver just sends a
> > firmware command for doing the reset. Once firmware receives the
> > command, it will initiate the reset of driver and firmware entities
> > asynchronously.
>
>
> It is similar to mlx5 case here for fw_reset. The driver triggers the fw
> command to reset and all PFs drivers gets events to handle and do
> re-initialization.  To fit it to the devlink reload_down and reload_up,
> I wait for the event handler to complete and it stops at driver unload
> to have the driver up by devlink reload_up. See patch 8 in this patchset.
>
Yes, I see reload_down is triggering the reset. In our driver, after
triggering the reset through a firmware command, reset is done in
another context as the driver initiates the reset only after receiving
an ASYNC event from the firmware.

Probably, we have to use reload_down() to send firmware command to
trigger reset and do nothing in reload_up. And returning from reload
does not mean that reset is complete as it is done in another context
and the driver notifies the health reporter once the reset is
complete. devlink framework may have to allow drivers to implement
reload_down only to look more clean or call reload_up only if the
driver notifies the devlink once reset is completed from another
context. Please suggest.
