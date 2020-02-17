Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBAFC34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAA72064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgBQUJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:09:49 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:55664 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgBQUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:09:48 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 24C2C200B28;
        Mon, 17 Feb 2020 20:09:47 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 097BB2006A; Mon, 17 Feb 2020 21:09:43 +0100 (CET)
Date:   Mon, 17 Feb 2020 21:09:42 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     boris.brezillon@collabora.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jernej.skrabec@siol.net,
        jonas@kwiboo.se
Cc:     linux-kernel@vger.kernel.org
Subject: drm/bridge and lockup on boot
Message-ID: <20200217200942.GA2433@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my old Dell XPS 13 laptop with

00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) (prog-if 00 [VGA controller])

booting 5.6-rc1 and -rc2 fails after the dmesg line

	fb0: switching to inteldrmfb from simple

while the next lines should be something like (v5.5):

	Console: switching to colour dummy device 80x25
	i915 0000:00:02.0: vgaarb: deactivate vga console
	[drm] ACPI BIOS requests an excessive sleep of 25000 ms, using 1500 ms instead
	[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
	[drm] Driver supports precise vblank timestamp query.
	i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem

A git bisect lead to

	commit b86d895524ab ("drm/bridge: Add an ->atomic_check() hook")

as the first bad commit, as unlikely as that sounds. f7619a58ef92 is good,
as is bf046007641a, and 3cacb2086e41 is definitely broken on my setup.
Any ideas?

Oh, and this might be the same issue as reported here:

	https://lore.kernel.org/lkml/99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs/

though I do not see such a warning, but nothing new once the line "fb0: switching
to inteldrmfb from simple" is printed.

Thanks,
	Dominik
