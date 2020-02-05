Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7B2C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7001E20730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZFeVZv5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBEW6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:58:22 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:58378 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBEW6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:58:22 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 92A8D5C406B;
        Wed,  5 Feb 2020 23:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580943500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VcufrJgxcsnT3S/lhbayM64sOm4ET3fTVcPeVl2zZQ=;
        b=ZFeVZv5CBiTvPjv/SoNT0kqhSe8GHIQRwoODxqFs1CRGLHTi1oJPSx5IzsHc0HMAY3YuKg
        47L9FkQvz7oqUDbthAyrbKSI3/dYX2BKNGGeLPDZNhzqWSt8+lIZLZqkK95qmgooY8HaeR
        J0M99Jpg9b3v94QFpK0P4vJyCFZyZTc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 23:58:20 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Joe Perches <joe@perches.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel.vetter@ffwll.ch,
        airlied@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm: Add missing newline after comment
In-Reply-To: <5a14078affad5e26330627d91df394da990ba301.camel@perches.com>
References: <586aab08af596120f48858005bb6784c83035d59.1580941448.git.stefan@agner.ch>
 <5a14078affad5e26330627d91df394da990ba301.camel@perches.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <75de5f45061e2d13268479d43cb84625@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-05 23:50, Joe Perches wrote:
> On Wed, 2020-02-05 at 23:26 +0100, Stefan Agner wrote:
>> Clang prints a warning:
>> drivers/gpu/drm/drm_lock.c:363:6: warning: misleading indentation;
>> statement is not part of the previous 'if' [-Wmisleading-indentation]
>>          */     mutex_lock(&dev->struct_mutex);
>>                 ^
>> drivers/gpu/drm/drm_lock.c:357:2: note: previous statement is here
>>         if (!drm_core_check_feature(dev, DRIVER_LEGACY))
>>         ^
>>
>> Fix this by adding a newline after the multi-line comment.
> 
> Thanks, already in -next

Whoops, sorry for the duplication. Searched for "indentation" which did
not bring that one up.

--
Stefan

> 
> commit 5b99cad6966b92f757863ff9b6688051633fde9a
> Author: Dan Carpenter <dan.carpenter@oracle.com>
> Date:   Wed Jan 8 08:43:12 2020 +0300
> 
>     gpu/drm: clean up white space in drm_legacy_lock_master_cleanup()
>     
>     We moved this code to a different file and accidentally deleted a
>     newline.
>     
>     Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>     Link:
> https://patchwork.freedesktop.org/patch/msgid/20200108054312.yzlj5wmbdktejgob@kili.mountain
