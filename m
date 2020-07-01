Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACC1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EF62070C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZm47KnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGAGHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgGAGHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:07:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35482C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:07:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i25so23806276iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LGHKE3CWYXOl1zyvc87Bj7eLB7pNJ5K3zyWHyC6VVBk=;
        b=iZm47KnBKr7LRhtHtKHwHWBeBdYuECPBnSAL8oOsRypDWUAeddoTfRhJFdYYrFimZ1
         te7CD+5EIWk6riRAIb7IDbOUnX+1nQa0rNKpJpoYfF1oh24GXShwll7JAkOMZe3UBMxQ
         fap656nLnkJ9we769La8zKnk5+wlCmjIjMIUXMdrd3BiEhr31YlSAlqfATh8s3EUA4f0
         qIHJbKV4LMgKgdMgDywY3X77cpKjFVfhONq0JZVXyeWhDurEuqZ1YmBNNIjQddiK8Dkf
         jKAY2MkRGxRV2itV4oV7welatfPyqpbe894/Wx3ovNfo6MXzSuZn3KN+A1YUxqvfs8XK
         V5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LGHKE3CWYXOl1zyvc87Bj7eLB7pNJ5K3zyWHyC6VVBk=;
        b=GrAnqggbWINCgsPWBxMdJvJ/n0jYgSY3AwVII2kFIa53VoQHAuGBBhAvf0h4BoN7oZ
         G63MJlBAkkXTZsYTCwFbeFl+c/CYi5xn4Vv2HsRMpH2cwPg4zu2ZbYJvR9Mgm77WBXP9
         MlSt8wADGX5gsAEs7QEjb9QJbpnsh42fia5AVXzNI4xuz5i97jodWCUKAYzDXvSFwYXQ
         PGmwYH8QFybP4UfoYUduPJUeh/RQ7ylnYrrHochWIa+uwcF0mxxcCAeIPX/uYOWwxLMt
         Svq8NWtZgoDdUJ5fA7Y01Q5GlfZ9tr2SVv5QPZOnZw8hCSerU+OPsvwhpxwr/+ojqmkq
         /O3g==
X-Gm-Message-State: AOAM530x3KcBwO5XUyan+EPMruaRxy2myZ8n937IPM2i0vQETKdk6eqD
        TyUbYVvxB/C7oksqYAw2dIG9LV3MeLs+d8jPbDI=
X-Google-Smtp-Source: ABdhPJwkNwFk2mv3KYJqzFGtvP5CqsE3Le8Yp5Jy4t+X4+Xw+vedK5D8tWtVnxFMIdXCabi9GMlcjIF8GNXexcsT5TI=
X-Received: by 2002:a05:6602:2f0a:: with SMTP id q10mr678848iow.134.1593583619432;
 Tue, 30 Jun 2020 23:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6awRF3J=sn-bZ1FO-JzuEAhcBvb66ev7=5BB2YracCgWg@mail.gmail.com>
In-Reply-To: <CAAvDm6awRF3J=sn-bZ1FO-JzuEAhcBvb66ev7=5BB2YracCgWg@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 30 Jun 2020 23:06:48 -0700
Message-ID: <CAM_iQpWcK1ou9st5QWvdQ7MNfdV09WqjfPB1ASwpoJaBKzJrjQ@mail.gmail.com>
Subject: Re: How do you investigate the cause of total hang? Is there some
 information that I should pay attention to in order to get some hint?
To:     =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <Kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:49 PM =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <sun=
shilong369@gmail.com> wrote:
>
> Hi, list
>
> My x86 machine(linux4.19) sometimes hangs, suddenly not responding in
> any way to the mouse or the keyboard.
>
> How can I investigate why it hung up? Is there extra information I can
> find for a clue? Is there anything less drastic than power-off to get
> some kind of action, if only some limited shell or just beeps,
> but might give a clue?
>

If the hang was a crash which you didn't get a chance to capture the
last kernel log, you can use kdump to collect them. The kernel log
tells what kind of crash it is, a NULL pointer deref, a kernel page fault
etc..

If the hang was a hard lockup, you have to turn on lockup detector
and also kdump to capture what the detector tells.

Thanks.
