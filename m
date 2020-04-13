Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2313FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10D82072A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="DLGTLJlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgDMWrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:47:52 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:41008 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgDMWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:42:59 -0400
Date:   Mon, 13 Apr 2020 22:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1586817330;
        bh=jl/uF/D1PYwXMaOqDJFEWYGC7NJfXJLhzLgI8MtWbvw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DLGTLJlDtp72qIxjJIcyWYZi04gJ8hiXW7N14NeSglVLHZmfXyH1F59RPbbU1vVO9
         IqtLf5AzSsJ/8rvh3QYEb20XgGZBMhQcOf/9KhfhymnOu7KNHXeftPdXopouqzN91O
         bQZEe2JuSnGJRjZnvu9mf5KtfXLai+ShnEtSLccM=
To:     Yussuf Khalil <dev@pp3345.net>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB quantization range" property
Message-ID: <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
In-Reply-To: <20200413214024.46500-6-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-6-dev@pp3345.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <dev@pp3345.net> wrote:

> DRM now has a globally available "RGB quantization range" connector
> property. i915's "Broadcast RGB" that fulfils the same purpose is now
> considered deprecated, so drop it in favor of the DRM property.

For a UAPI point-of-view, I'm not sure this is fine. Some user-space
might depend on this property, dropping it would break such user-space.

Can we make this property deprecated but still keep it for backwards
compatibility?
