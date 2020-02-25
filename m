Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF83C35E08
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF77A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgBYPEm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:04:42 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:60151 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729870AbgBYPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:04:42 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20346492-1500050 
        for multiple; Tue, 25 Feb 2020 15:04:28 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sean Paul <sean@poorly.run>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200225140347.GA22864@embeddedor>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org
References: <20200225140347.GA22864@embeddedor>
Message-ID: <158264306645.3062.14566490586309398145@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm: Replace zero-length array with flexible-array member
Date:   Tue, 25 Feb 2020 15:04:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2020-02-25 14:03:47)
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:

I remember when gcc didn't support []. For the record, it appears
support for flexible arrays landed in gcc-3.0. So passes the minimum
compiler spec. That would be useful to mention for old farts with
forgetful memories.
-Chris
