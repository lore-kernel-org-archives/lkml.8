Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAEFC3402A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0F620725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgBQVI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:08:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44384 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:08:57 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A9460293C50;
        Mon, 17 Feb 2020 21:08:55 +0000 (GMT)
Date:   Mon, 17 Feb 2020 22:08:52 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jernej.skrabec@siol.net, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org
Subject: Re: drm/bridge and lockup on boot
Message-ID: <20200217220852.55cbac43@collabora.com>
In-Reply-To: <20200217200942.GA2433@light.dominikbrodowski.net>
References: <20200217200942.GA2433@light.dominikbrodowski.net>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 21:09:42 +0100
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On my old Dell XPS 13 laptop with
> 
> 00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
> 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) (prog-if 00 [VGA controller])
> 
> booting 5.6-rc1 and -rc2 fails after the dmesg line
> 
> 	fb0: switching to inteldrmfb from simple
> 
> while the next lines should be something like (v5.5):
> 
> 	Console: switching to colour dummy device 80x25
> 	i915 0000:00:02.0: vgaarb: deactivate vga console
> 	[drm] ACPI BIOS requests an excessive sleep of 25000 ms, using 1500 ms instead
> 	[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> 	[drm] Driver supports precise vblank timestamp query.
> 	i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> 
> A git bisect lead to
> 
> 	commit b86d895524ab ("drm/bridge: Add an ->atomic_check() hook")

This commit has been reverted: you should ignore any failures between
b86d895524ab ("drm/bridge: Add an ->atomic_check() hook") and
099126352303 ("Revert "drm/bridge: Add a drm_bridge_state object").

> 
> as the first bad commit, as unlikely as that sounds. f7619a58ef92 is good,
> as is bf046007641a, and 3cacb2086e41 is definitely broken on my setup.
> Any ideas?
> 
> Oh, and this might be the same issue as reported here:
> 
> 	https://lore.kernel.org/lkml/99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs/
> 
> though I do not see such a warning, but nothing new once the line "fb0: switching
> to inteldrmfb from simple" is printed.
> 
> Thanks,
> 	Dominik

