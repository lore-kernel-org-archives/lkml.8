Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EE5221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bgSPmGpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgHFSew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgHFSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:34:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA116C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:34:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so36598241ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Lwo0h1UUt/TkFfE8EDJeJnCBcomQmQ6I+GLf07iiXg=;
        b=bgSPmGpCYS5e5FW3E8UqQvh0DrBkVffrlqEPzxjQ13CfvimfhTStK2fLoQVOYd9W2w
         1f6gndjCwBqLRVnufF94mWiG+N80jMFrUzBIoHEFmw/O5M1BxMiSmJU+FsIMbeM1ZZ8m
         B1DOF1T+PwYCGXan6+xPmqtgc3jSc4lGG9rjT1dMfhKIMkixlBv3AJWf+Kd4+fU0DRj4
         mhZxQKFBp7vrNdEkcGJxFELeOpKh7KjxGwP6RgEP7Rzkxxp7enGlVMq/pZSwDTiofbVL
         o4Gn3Sn9KJpfg8ZpNjspxEkq6zTvwgSbaYyp1KpP8KbMF5n4z1blX7BVt4aylgklE54o
         mn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Lwo0h1UUt/TkFfE8EDJeJnCBcomQmQ6I+GLf07iiXg=;
        b=V2cKehBEZkTJx+dlJ/PMWy7cckMS/gddzVlIcU+Uq5b8qOdQZWt84auoMVYZV3L6pJ
         ppisdnkH5TkRteLJ4KLFJpS4Q5Y5i9T7V02resul1U7xZ/cCJsjg97JcupfPWmYSV/uF
         S8+jTCqPfde+NjzJ/7NVZocX12wFoapbgr8p8HE2w/LokzDWosreKvRCQPidV1lyEswA
         /buo0Sf3n3PCBIJnG1jjYngXAMj3L+qKIx0+gbgLDZK4YIbyvm7OZuVxOAKNkynTDGYU
         SrSl6ERhsCg9fvfmxrmi+9NrUl7diuCackLQr8v3KGgA2mi6JUhYKeJUZgS/OB9ePRuQ
         lglQ==
X-Gm-Message-State: AOAM533jF2KAWyOzswvHAPLKZILfp5yXHn/gSRcqzM0pxA7qAABVkscr
        /yNIUhquOBXwhBrZjA/l/TgTKPlCOI8Vxwcz2PNHduCquA==
X-Google-Smtp-Source: ABdhPJxMQZuQY3avDUyZx56UT2rDq0X/QFpraARHLo6LAMfX3Rh5oyf19noACgmf5bDruxn2zfaSliNFW2ds+o0adCE=
X-Received: by 2002:a17:906:1403:: with SMTP id p3mr5592371ejc.106.1596738839416;
 Thu, 06 Aug 2020 11:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200803123439.83400-1-jbi.octave@gmail.com> <20200803123439.83400-2-jbi.octave@gmail.com>
In-Reply-To: <20200803123439.83400-2-jbi.octave@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 14:33:48 -0400
Message-ID: <CAHC9VhR1-=veLYGeRiF9MAi3QxrGy_z-q+B1DD9t-foPPRJmbA@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] audit: change unnecessary globals into statics
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
> Variables sig_pid, audit_sig_uid and audit_sig_sid
> are only used in the audit.c file across the kernel
> Hence it appears no reason for declaring them as globals
> This patch removes their global declarations from the .h file
> and change them into static in the .c file.
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/audit.c | 6 +++---
>  kernel/audit.h | 4 ----
>  2 files changed, 3 insertions(+), 7 deletions(-)

Thanks Jules, this looks reasonable although I'm not going to merge
them into audit/next until after the merge window closes.  I'll send
another reply once this has been merged.

-- 
paul moore
www.paul-moore.com
