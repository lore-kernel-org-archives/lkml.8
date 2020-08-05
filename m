Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9293921D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6wGUUGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHETsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgHEQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:59:10 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 09:59:10 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z3so27760446ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iY/ubMmbOSOA8vM2Ed9hyP7ugEKG4FguBxj1BcTv4M=;
        b=h6wGUUGcP75XA3LUEzYumdnVapc3qvV4UdgfvimPqvzccdQVOToiVkOD2SCzhcXKmf
         yIWsGk3a2DnN301kQaz84du1eqLCiPxGyvYag41d8ICac7CBAdh2ZcoD/yN5rC7UydHy
         FFJoHcL3brk1PRJFxENYKmQqn0sNE4IsuCrr52Ys5/muTA2A5LZ3RMupCxdVmPooRVcS
         6mwUxSwk8VGQYVixrXLkMpVkbG13MPKnEwXTh2MNL8AMRF+bDhzoziRusSmmw4UtcYeZ
         cBDxgzWt8M39rLO2Fgb0v4Sxw4hh+j5xBfBqnk4SiqRrobA4tvtSp2OesiWDYYiIszb3
         u6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iY/ubMmbOSOA8vM2Ed9hyP7ugEKG4FguBxj1BcTv4M=;
        b=o6AOTp5TBNdLY5qziOPYYs7y6AOnk4OZAn1uusHndTMom8DwMl9Egl2/ZhSk9mlq9e
         20QRxZAQWvAn3OoMakkj3r5HNpWY4uhQPQTm4khs5TrabEqusw/ltasb1i5B+Pyf5fea
         ulRmVnLrRyb19pnSVlk9f7RT6Udrhs9FrP7OFeDi7vwEz0cQIsymVol6iVeuTGFTi4pe
         h3bc/JrvwqwUkUTPB9H4T54v0LBsWPXQk3ouCWUS7K/87AfuMsIZ/wc4UZERgB9o4Qbw
         sUyb7rRy8d0GeBS2zVR6OvtZVuNAwbnLrZhzDIeGU6hCeR+P7JBPL2gwetbQLhhC6vi3
         icDw==
X-Gm-Message-State: AOAM532RiLKBJ9BKFB8yNv7Nma7R5ws/Md7F0QhWw6D+AwfeZX7SO4wj
        e21AcDHfBvYBe/ep7FN+DhW1+ZVVXFnDJQRYZLl91Q==
X-Google-Smtp-Source: ABdhPJypYAKgX0g9f2ZUaKnwT2czaqscnJNCCLD3hST31y/Ci03lV+urmS6O+HiFATowBbfuaEHvgtP8cK1MMqA4igQ=
X-Received: by 2002:a92:da0a:: with SMTP id z10mr2863722ilm.275.1596646748668;
 Wed, 05 Aug 2020 09:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <202008051540.zMO6UY7G%lkp@intel.com>
In-Reply-To: <202008051540.zMO6UY7G%lkp@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 Aug 2020 19:58:57 +0300
Message-ID: <CAOQ4uxh9s8ukzyUvADZzF-kyTGXgZxdei9LyfzEDHJ_h+wKRFg@mail.gmail.com>
Subject: Re: fs/notify/fanotify/fanotify_user.c:370:3: warning: Assignment of
 function parameter has no effect outside the function. Did you forget dereferencing
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:40 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4da9f3302615f4191814f826054846bf843e24fa
> commit: 44d705b0370b1d581f46ff23e5d33e8b5ff8ec58 fanotify: report name info for FAN_DIR_MODIFY event
> date:   4 months ago

Gee that's an old patch...

> compiler: nds32le-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> cppcheck warnings: (new ones prefixed by >>)
>
> >> fs/notify/fanotify/fanotify_user.c:370:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
>      buf += ret;
>      ^
> >> fs/notify/fanotify/fanotify_user.c:371:3: warning: Assignment of function parameter has no effect outside the function. [uselessAssignmentArg]
>      count -= ret;
>      ^
...

>    348          /* Event info records order is: dir fid + name, child fid */
>    349          if (fanotify_event_name_len(event)) {
>    350                  struct fanotify_name_event *fne = FANOTIFY_NE(event);
>    351
>    352                  ret = copy_info_to_user(fanotify_event_fsid(event),
>    353                                          fanotify_event_dir_fh(event),
>    354                                          fne->name, fne->name_len,
>    355                                          buf, count);
>    356                  if (ret < 0)
>    357                          return ret;
>    358
>    359                  buf += ret;
>    360                  count -= ret;
>    361          }
>    362
>    363          if (fanotify_event_object_fh_len(event)) {
>    364                  ret = copy_info_to_user(fanotify_event_fsid(event),
>    365                                          fanotify_event_object_fh(event),
>    366                                          NULL, 0, buf, count);
>    367                  if (ret < 0)
>    368                          return ret;
>    369
>  > 370                  buf += ret;
>  > 371                  count -= ret;
>    372          }

This is intentional.
The code is more readable and robust this way even though these
assignments have no effect in current code.

Thanks,
Amir.
