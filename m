Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE5DC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9836D2078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGGze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:55:34 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:36912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGGze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:55:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 643B412F5C;
        Thu,  7 May 2020 06:55:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mass87_4d4fdba8e3930
X-Filterd-Recvd-Size: 2187
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 06:55:31 +0000 (UTC)
Message-ID: <777550697e44478c46768db5265dcdda094932f4.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
From:   Joe Perches <joe@perches.com>
To:     christian.koenig@amd.com, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>
Cc:     Guchun Chen <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Dennis Li <Dennis.Li@amd.com>
Date:   Wed, 06 May 2020 23:55:30 -0700
In-Reply-To: <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
References: <20200505140208.284473-1-arnd@arndb.de>
         <006e29037a9314fb286a5d6d84905bce99cef6c7.camel@perches.com>
         <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 08:42 +0200, Christian König wrote:
> Am 06.05.20 um 21:01 schrieb Joe Perches:
[]
> > And trivia:
> > 
> > The !! uses with bool seem unnecessary and it's probably better
> > to make amdgpu_ras_is_feature_enabled to return bool.
[]
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
[]
> > @@ -560,7 +560,7 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
> >   	 */
> >   	if (!amdgpu_ras_is_feature_allowed(adev, head))
> >   		return 0;
> > -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> > +	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))
> 
> And while we are at improving coding style I think that writing this as 
> "if (enabled == amdgpu_ras_is_feature_enabled(adev, head))" would be 
> much more readable.

<blink, chuckle> that's decidedly true...


