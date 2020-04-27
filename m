Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B4C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A854206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgD0PCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:02:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39054 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgD0PCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:02:05 -0400
Received: by mail-il1-f198.google.com with SMTP id c11so11529332ilr.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TfUPXfE+cTIMWHEFg4Dl9b/oLW/Udq/MPl9VKXgMmok=;
        b=orx3swKb+YGnHB8IAbwLB31KAHQlB8IKJttP7dsXoqbK3Ibn5GOjcqZabyQe6ejd1m
         oZebrHk/fBSLaohbeop0RZ85ypaZpQU7oCb8DCGb0TsLm67Qsc4AQSBPzDRQ/vt93kMz
         Z8YwguCwlIr+5+02naNJYgyNyV7a2BFTxai/6t/y4k+5G9pY5CZ+hIN5SSJ7yQjTW1Fw
         pC5p/l95tzRscGXNKtdZ99+r2aciPEJGqbBlS0GY6MOeYxe76m3IpfO8LjuaaMW4/y1Q
         HCqGbSw0jVIL/Hyevj8gi2NtwHbLR7d9221Sl+LR3X9wk6H6zRZ5ys6kQqGT+ANLHkrt
         Dylw==
X-Gm-Message-State: AGi0PubmjnKMusxTlxZH5rkOCSKn1Z04YjbbNmAtFFj2og4XnQLrKnCY
        licQxszDmeku55fBjQk8sRoWbbkjJ7wiPGCm1Y4PPKMxXY6E
X-Google-Smtp-Source: APiQypL38u/Fn/pFodfcLRM1XK4BHxaVuMTFystRgZIhu07N9kJA6Yq8V9okZv7VSqr1LnfCu93YVrBkOZXUvBvnmUfJyxrixMPE
MIME-Version: 1.0
X-Received: by 2002:a5d:85d7:: with SMTP id e23mr21430309ios.174.1587999723210;
 Mon, 27 Apr 2020 08:02:03 -0700 (PDT)
Date:   Mon, 27 Apr 2020 08:02:03 -0700
In-Reply-To: <CAAEAJfAnMeZw3H3PJccpJTEME877i3=21CehykkSgnSnCZbOVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067d2de05a446ffb5@google.com>
Subject: Re: KASAN: use-after-free Read in vkms_dumb_create
From:   syzbot <syzbot+e3372a2afe1e7ef04bc7@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        ezequiel@vanguardiasur.com.ar, hamohammed.sa@gmail.com,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to apply patch:
checking file drivers/gpu/drm/vkms/vkms_gem.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c578ddb3 Merge tag 'linux-kselftest-5.7-rc3' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=e3372a2afe1e7ef04bc7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165806efe00000

