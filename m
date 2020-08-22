Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3104EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2C420738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598113842;
	bh=T6qxWCdnx7yQWW539dupam4L5Gst5+melCCWJ5BWJIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d1Zhr6WKnJ++75+5vvaIsSna2aYTJ1CEGfkt6bJ9XGDSlFpmvPCfwEbyzwslTEH0Q
	 a8rVyQI9nuj1PTn0E1C8nFRJhEvGhfs/jKcqG4p65/lIm3y1aJQ29z+AxMFI9tFrjm
	 NF/wXmoMvtL1R9YB5i66ZkNDGULEaVUrEwvgWBAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgHVQak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgHVQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:30:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C34C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:30:37 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f75so3617568ilh.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJj5TK3G7MVm+VYBo5lqKGxPSR8A7s2q6tf5foLdof4=;
        b=S75MaG1vCkClffX2X3FaZOKUXo+pwYdtuLZc6ncCVkuF7BdPWJ13mqOgHl3iDTyGt1
         ULyvbN3EPIMD26sIkvGpT8s0smqQ/4ky4VwJSoaH6CJcbOaDUgu2OfdWm1M77634TEeu
         mtteCanJgrirygtSakPKLI0b7KFcBW3CF8Ew0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJj5TK3G7MVm+VYBo5lqKGxPSR8A7s2q6tf5foLdof4=;
        b=WDhiL2hyElq/9HyBhvIcJQ0IHiqn/Wz0dyBeg05cuhpyynOzzIaSkCvZetSCsfsZGD
         gkRNYvN8Ut2rhoVgYPs+B7TiUzxiQ0Qjz9idZqWYN7htG2WRD+gjZBT/sF9hREMmcGdH
         8Vv2JvfdX6bHyd2H2tmjI6DrpMlL2t20HzW+7aQltPgkDeskhCcQs1vA38y0glsA07QH
         /H8xG1jLqPeNZoGQpwQe68ev+msE9bx6rh/eY5164uMkOEEHDdm9UOiDAtLQWQ8Qh2j0
         k4s7wvwYzNPY90sDbcanE4uwoyu7hKxMr19qAQ5dUbbQxMYHLh8zbPx23Lwkz+0ZDPQf
         sytg==
X-Gm-Message-State: AOAM530LHaVFIb3kn2Abkyjk68Pwgy4I5cfUfN9quwxFAAl9TWmp2/4/
        Ycm+LkrG308NYgfhdQdotAsT+kKWKG6YmD+cYND4nw==
X-Google-Smtp-Source: ABdhPJzQYZ/z0hpLgPOSs8sPRZM4W0ZXC5611Jmeb9rkOBbf1q+BiabPCpGfL1YZ9sPLlsdfHTEd3UhZNYkdnb/4Hqg=
X-Received: by 2002:a92:da49:: with SMTP id p9mr7196041ilq.233.1598113835616;
 Sat, 22 Aug 2020 09:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000045b3fe05abcced2f@google.com> <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
 <20200807053148.GA10409@redhat.com> <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
 <20200810192941.GA16925@redhat.com> <d1e83b55-eb09-45e0-95f1-ece41251b036@i-love.sakura.ne.jp>
 <dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp> <7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp>
In-Reply-To: <7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Aug 2020 09:30:25 -0700
Message-ID: <CAADWXX-wpVR5Y1Z=BH5QnMjbsGbkQT__r4D2zCFFVycMDELxOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] pipe: make pipe_release() deferrable.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 9:35 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Therefore, this patch tries to convert __pipe_lock() in pipe_release() to
> killable, by deferring to a workqueue context when __pipe_lock_killable()
> failed.

I don't think this is an improvement.

If somebody can delay the pipe unlock arbitrarily, you've now turned a
user-visible blocking operation into blocking a workqueue instead. So
it's still there, and now it possibly is much worse and blocks
system_wq instead.

                Linus
