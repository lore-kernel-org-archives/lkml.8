Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D6C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664102073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Godxthak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgC1Qbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:31:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46706 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC1Qbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:31:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so13218945oth.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tepq1jSwDCN89tryT39lGx5t8RvfKo7KJYe9WreZN8E=;
        b=Godxthakoj8WDjgl/1xUDzE5sUEkmS4LTviBbCzV6Ma0iDh5GdRhECpcZTGY2Edk7W
         +klahkVThDTocA6UalroXBd3d/s1yNbA1MoKTHR6rFBKeI3CDoSMNENbizT8hyxv+Zk7
         JFJYO5cqHODkH5KbjguHKYz6RZCBCYW+cVUwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tepq1jSwDCN89tryT39lGx5t8RvfKo7KJYe9WreZN8E=;
        b=tVgW3Pj9ECGYAIaNj2+Tk/JsiWDilnfcJrXYtsFvTPpB/dV1WqPtMmcjy1wzwn0h9I
         xyVvRhZOw5vNg+EnekINpXhKQQCMdD01mJloVnUBiMVG+ZegriKbIYl00mvtDu1Bgg66
         Is+SC2PF4fcC7KO2gQb0j1Yp6MyJhW6L/ZX2NXWDGcidK8yLPRq0862oCrkYz1rYMY6I
         x6Ivc5pq56XFeXylV2TPrgsHYYPczK6buqRHBcyTvfSO45l6I7//HTaeTRQ0d7dF/kU8
         IBHh9k6RQI3xYCBCsROr6+72BDQzHE+EC73oCZ7ozdrf5N9u1IiZ18h1AgCciEwnzyhZ
         jzWQ==
X-Gm-Message-State: ANhLgQ0JMoOsmjA81rfqVsHXuFuBmLbXXqu2/zjNIwDzxSexw0zgLRwj
        gHrVh2C0IsGB3U1qO+Ubjns4jYmlnNDoUMCOTcXzkmuh
X-Google-Smtp-Source: ADFU+vv7GkRqQqz0012YOeCZDSoBlbR6P9EsoxOSUlc+Q4oxoxo4uNEE60PtSV0CuFZ8fdglQmV2e/lzTkJgpD6++Zg=
X-Received: by 2002:a9d:7696:: with SMTP id j22mr3344521otl.188.1585413105299;
 Sat, 28 Mar 2020 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200328151511.22932-1-hqjagain@gmail.com>
In-Reply-To: <20200328151511.22932-1-hqjagain@gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat, 28 Mar 2020 17:31:34 +0100
Message-ID: <CAKMK7uF2mipUSr-XRESrRJ8JdOZCekNTCVsDPW5hNp-mWwPj6Q@mail.gmail.com>
Subject: Re: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        ghalat@redhat.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 4:15 PM Qiujun Huang <hqjagain@gmail.com> wrote:
> Add check for vc_cons[logo_shown].d, as it can be released by
> vt_ioctl(VT_DISALLOCATE).

Can you pls link to the syzbot report and distill the essence of the
crash/issue here in the commit message? As-is a bit unclear what's
going on. Patch itself looks correct.

Thanks, Daniel

> Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index bb6ae995c2e5..7ee0f7b55829 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
>                 fbcon_update_softback(vc);
>         }
>
> -       if (logo_shown >= 0) {
> +       if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
>                 struct vc_data *conp2 = vc_cons[logo_shown].d;
>
>                 if (conp2->vc_top == logo_lines
> @@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
>                         return;
>                 if (vc->vc_mode != KD_TEXT || !lines)
>                         return;
> -               if (logo_shown >= 0) {
> +               if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
>                         struct vc_data *conp2 = vc_cons[logo_shown].d;
>
>                         if (conp2->vc_top == logo_lines
> --
> 2.17.1
>


--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
