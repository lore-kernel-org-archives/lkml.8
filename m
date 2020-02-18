Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C231C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580C0207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRLsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:48:38 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53698 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgBRLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:48:37 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 41890200ADE;
        Tue, 18 Feb 2020 11:48:36 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 5120920A8D; Tue, 18 Feb 2020 12:48:21 +0100 (CET)
Date:   Tue, 18 Feb 2020 12:48:21 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        jose.souza@intel.com, s.zharkoff@gmail.com,
        gwan-gyeong.mun@intel.com, jani.nikula@intel.com
Cc:     narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jernej.skrabec@siol.net, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, airlied@redhat.com
Subject: lockup on boot -- drm/i915/display: Force the state compute phase
 once to enable PSR
Message-ID: <20200218114821.GA2240@light.dominikbrodowski.net>
References: <20200217200942.GA2433@light.dominikbrodowski.net>
 <20200217220852.55cbac43@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217220852.55cbac43@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:08:52PM +0100, Boris Brezillon wrote:
> On Mon, 17 Feb 2020 21:09:42 +0100
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > On my old Dell XPS 13 laptop with
> > 
> > 00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (rev 09)
> > 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) (prog-if 00 [VGA controller])
> > 
> > booting 5.6-rc1 and -rc2 fails after the dmesg line
> > 
> > 	fb0: switching to inteldrmfb from simple
> > 
> > while the next lines should be something like (v5.5):
> > 
> > 	Console: switching to colour dummy device 80x25
> > 	i915 0000:00:02.0: vgaarb: deactivate vga console
> > 	[drm] ACPI BIOS requests an excessive sleep of 25000 ms, using 1500 ms instead
> > 	[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> > 	[drm] Driver supports precise vblank timestamp query.
> > 	i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> > 
> > A git bisect lead to
> > 
> > 	commit b86d895524ab ("drm/bridge: Add an ->atomic_check() hook")
> 
> This commit has been reverted: you should ignore any failures between
> b86d895524ab ("drm/bridge: Add an ->atomic_check() hook") and
> 099126352303 ("Revert "drm/bridge: Add a drm_bridge_state object").

A new bisect now points to

	60c6a14b489b ("drm/i915/display: Force the state compute phase
	once to enable PSR").

Please note that bisecting this is quite a hassle, in particular due to
various reverts in between and back-merges (such as ec027b33c8bb, which has
two parents in "bad" state). As 60c6a14b489b does not revert cleanly, I
can't test a revert on top of 5.6-rc2.

Thanks,
	Dominik
