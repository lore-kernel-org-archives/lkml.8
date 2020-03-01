Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC92C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E7D214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCAPQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:16:56 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59390 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:16:55 -0500
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
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F04B2200B2E;
        Sun,  1 Mar 2020 15:16:51 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id CF43520DA9; Sun,  1 Mar 2020 16:15:55 +0100 (CET)
Date:   Sun, 1 Mar 2020 16:15:55 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Souza, Jose" <jose.souza@intel.com>, airlied@redhat.com
Cc:     "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "s.zharkoff@gmail.com" <s.zharkoff@gmail.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>
Subject: 5.5.6-rc1+: lockup on boot -- drm/i915/display: Force the state
 compute phase once to enable PSR
Message-ID: <20200301151555.GA127893@light.dominikbrodowski.net>
References: <20200217200942.GA2433@light.dominikbrodowski.net>
 <20200217220852.55cbac43@collabora.com>
 <20200218114821.GA2240@light.dominikbrodowski.net>
 <eb191e966bb4065239d413fd904684de24d37789.camel@intel.com>
 <20200218185847.GA15931@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218185847.GA15931@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:58:47PM +0100, Dominik Brodowski wrote:
> On Tue, Feb 18, 2020 at 06:01:37PM +0000, Souza, Jose wrote:
> > Hi
> > 
> > Yes this patch has a issue and we have a fix, I'm trying to find
> > someone to review it, more information: 
> > https://gitlab.freedesktop.org/drm/intel/issues/1151
> 
> Alas, that patch does not apply cleanly to -master.

Any update on this patch? It doesn't seem to have landed in -master yet,
though it solves a clear regression and without such a patch, my laptops
refuse to boot. So it'd be much appreciated if that patch (or a variant
thereof) is pushed upstream rather sooner than later.

Thanks,
	Dominik
