Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF22DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802762063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="TU1GJV8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbgDMWcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:32:53 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:50328 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389641AbgDMWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:32:52 -0400
Date:   Mon, 13 Apr 2020 22:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1586817170;
        bh=seUGhoZepOTnyOHLE3h+4/e4jZLc55h9FX57lknv1A0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TU1GJV8XzK9LYQ8Pa65IahPFwirwI2nMYSb8vXtvgfkxI7nBzdDrRJdtCIkqn5q6w
         6EN8wDVhb1ApjR1INNEAinkN+gUgLfU5hI4rfdpkrOUSQ8TUUSiGtfKZfSfQkrxXCa
         rar5mDd027U13HpPbGUAU1GjONIxHZq8mdspJaEA=
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
Subject: Re: [PATCH 2/5] drm: Add "RGB quantization range" connector property
Message-ID: <k5qjrDz46MIiTOYsgNWoplNnN6Y2wuMP9iHqOw555BtThDyBETAFd7JNbVK3bi-FUsOu9Gzx9Ibj3p8iLpwc9yAPiOBl-t_5e9tw48e4dFw=@emersion.fr>
In-Reply-To: <20200413214024.46500-3-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-3-dev@pp3345.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you also add docs for this property in "DOC: standard connector
properties" in drm_connector.c?
