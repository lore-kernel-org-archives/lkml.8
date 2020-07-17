Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AA02064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgGQTGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:06:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:36864 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgGQTGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:06:55 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E9992728;
        Fri, 17 Jul 2020 19:06:54 +0000 (UTC)
Date:   Fri, 17 Jul 2020 13:06:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] Documentation: amdgpu_device_suspend: Fix sphinx
 warning
Message-ID: <20200717130653.347d2f20@lwn.net>
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 15:56:00 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix this warning:
> 
> warning: Excess function parameter 'suspend' description in
> 'amdgpu_device_suspend'
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a027a8f7b2819..9e67abe8d0aad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3377,7 +3377,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   * amdgpu_device_suspend - initiate device suspend
>   *
>   * @dev: drm dev pointer
> - * @suspend: suspend state
>   * @fbcon : notify the fbdev of suspend

Thanks for working to improve the docs build!  I do have a couple of
requests, though:

 - Use get_maintainer.pl to create a proper list of recipients for your
   patches.  Neither Mauro nor I should be applying patches to the DRM
   subsystem.

 - Please work on your subject lines; "fix warning" is rarely useful.
   What you have done here is to correct a kerneldoc comment, so the
   subject line should say "remove excess parameter in kerneldoc comment"
   or some such.  Also look at commits in the DRM subsystem and try to
   follow their conventions in general.

Those comments apply in similar form to the rest of the patches as well.

Thanks,

jon
