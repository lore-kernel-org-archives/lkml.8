Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869ABC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D21F20730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBEWwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:52:14 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:52144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727722AbgBEWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:52:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C02BD3AB6;
        Wed,  5 Feb 2020 22:52:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: order36_1316b577d5b11
X-Filterd-Recvd-Size: 2066
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 22:52:11 +0000 (UTC)
Message-ID: <5a14078affad5e26330627d91df394da990ba301.camel@perches.com>
Subject: Re: [PATCH] drm: Add missing newline after comment
From:   Joe Perches <joe@perches.com>
To:     Stefan Agner <stefan@agner.ch>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel.vetter@ffwll.ch
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Wed, 05 Feb 2020 14:50:59 -0800
In-Reply-To: <586aab08af596120f48858005bb6784c83035d59.1580941448.git.stefan@agner.ch>
References: <586aab08af596120f48858005bb6784c83035d59.1580941448.git.stefan@agner.ch>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 23:26 +0100, Stefan Agner wrote:
> Clang prints a warning:
> drivers/gpu/drm/drm_lock.c:363:6: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>          */     mutex_lock(&dev->struct_mutex);
>                 ^
> drivers/gpu/drm/drm_lock.c:357:2: note: previous statement is here
>         if (!drm_core_check_feature(dev, DRIVER_LEGACY))
>         ^
> 
> Fix this by adding a newline after the multi-line comment.

Thanks, already in -next

commit 5b99cad6966b92f757863ff9b6688051633fde9a
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed Jan 8 08:43:12 2020 +0300

    gpu/drm: clean up white space in drm_legacy_lock_master_cleanup()
    
    We moved this code to a different file and accidentally deleted a
    newline.
    
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Link: https://patchwork.freedesktop.org/patch/msgid/20200108054312.yzlj5wmbdktejgob@kili.mountain


