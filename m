Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA21322CAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n33x5l1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgHFSiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHFSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:45 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD59C0617A4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:35:25 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so28692509edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuh5L///1+6tqkx4SRS1RotcWxk6pfAkKpYSeAk+r38=;
        b=n33x5l1lnQt4xhfltS+h6aHkFiEpQKoEeN3DjgJEnrmZOtzrI8h41Nsk6jHcBU7xik
         J/NVfpDtxYJSCVapvIg1v6tK1NEXOH+a51WJKHAy8hfOlwgMz4ietam7OwxMFYQ978n3
         +aOqhedYCnqrvHP4VHBfvtc2capnSIqaxd7gHLYLG0YE7QRFUV8P57kFaElHWxIO1T7z
         VIGC97g36bf9X35DK4mJeUK4eMk00yfJCj6CVZKCg61RTbXdQ+R8g/PitHxcRqU+HgeN
         9o5DEbIlLZyNXCgXdhDMVarwDmOpGFHw4Uil9rnYH5I6lDX5xTZwrrjRDyzEd0cfJFfV
         gsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuh5L///1+6tqkx4SRS1RotcWxk6pfAkKpYSeAk+r38=;
        b=irliqBxdwWJmH3Tw9B/s2b4k4DmFkX50uYUstSWZnLTZhQU/g7yZmA14WZdSh7Pcl9
         /k4K9Qp4Ir57cqGXHUELYOnWDUOxep4HFa7Pme0gPVxd0y9yjG18vhreb3i2pS5nZrS3
         1mGlQsjtB+D7Yg3jQwhPDvajffc3o1to5HlOZoOYrbGENxwYCY4w/NwhNsIMhwPQiwK0
         e2MVMxFD8ph46cSr3OsmS+SeSw8B6YunEodR0qRmtj5VyhdzlnrEnZJPAaDCMMwQAQ0G
         5VBPspKWH57+gRKcIg2jAXs6ZUKCRiiXeVU9iW0ian0THoK+M3Womjt7VHTNUL0iiIjD
         c+RQ==
X-Gm-Message-State: AOAM533TONQb1Om5VoyquTeajsHBsaMythRmnzcTUY7lfK9kkHODwG+s
        34wn2mmPTJFetgKQAyzwV/wX6ApZNTVMakOv7C5x
X-Google-Smtp-Source: ABdhPJzobp3XHFhPQHypcdgsf1CVg1Hjp7fpOVXPXt5WPfkFAmsIZUO5MG4ZWuct7JxXuKpRwr1fkzSlTGifEgIyyd8=
X-Received: by 2002:a50:93c5:: with SMTP id o63mr5213126eda.31.1596738924215;
 Thu, 06 Aug 2020 11:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200803123439.83400-1-jbi.octave@gmail.com> <20200803123439.83400-3-jbi.octave@gmail.com>
In-Reply-To: <20200803123439.83400-3-jbi.octave@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 14:35:13 -0400
Message-ID: <CAHC9VhQA0JZNLZbfUUecrTbMvnD3S7sRMOAoW5eeeK-jpZeEWw@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] audit: uninitialize variable audit_sig_sid
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 8:35 AM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Checkpatch tool reports
>
> "ERROR: do not initialise globals/statics to 0"
>
> To fix this, audit_sig_sid is uninitialized
> As this is stored in the .bss section,
> the compiler can initialize the variable automatically.
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Similar to patch 1/2, this will need to wait until after the merge
window closes.

-- 
paul moore
www.paul-moore.com
