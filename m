Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E357C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AC020706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUsKZlYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgFWRFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbgFWRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:05:24 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E99C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:05:23 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a21so19437791oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3QxZJJ54EMs7Y3ADWg95hGHdd6XLGjVw3dK8YQ4OXI=;
        b=tUsKZlYmd3XNn3OLNu01j27/WM0HW7XuO/4jPJSDQ/7puCkimoBTxKmGenl44KWXX8
         o7g+HHRYORIZkR5UEn1vl/XIDQ7Y6HF4HhmFd19Z0HO0Soy1jn9AIMU+XZNMQVpLSlxt
         mM8VLAhnv+W8PLE8v0F/VeM8nP4qZ2yVTBapXnLK82X2E9wLuLGtn/IMcZV/UEhQ5GWO
         P1+eP1vYzZpPM+PDS3qs4e3J83E4IOUYDYzVBjgkd4kmc5EiRibFOgq8ruY74FtEMyoB
         PIGKNIK8PyX61zhPYRcKmW4w/pRAWmRJNdPtpF6vL0n/YhKeyee4bAsCw9J/ihRheS56
         jnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3QxZJJ54EMs7Y3ADWg95hGHdd6XLGjVw3dK8YQ4OXI=;
        b=Qig5aQZrT5j/01hwNZdcAFeL6o2MgR+1dNx0HiP+UNUwClnMuxk388RDnhNXyhA3gm
         EznflJ752VxborzEFEHbSrWlNENMRpxIBBMrwwDGtSitmCnlGmZo+/banYE8I0OplBzC
         YL3h6fiTx6vpVVdKcsjAa+obitYhebykJIapuVx0RwhFKxeGqRo/si53rfxDB4gV0Nx6
         2FCBj/sm6LCKVP05KnQqC7BBJuRxd50pak2F14LwNtFlTSplmonl9N03Vu8yQVeIHyWq
         QAfR+9OcGXmVfraQzdSAbRg75oRfZfOi+5PriBUSXzFBkZ1NIxYqvpBVvYLke+5s4L9S
         PVLg==
X-Gm-Message-State: AOAM5325j0fLSUBPdpSrKEiIyyBx4ZvPUurexOz9pPAkBPuqA49Te3JE
        3E7hEaC4BsCdqSIlHFC4qW9fGCkbUqJ94NFMx/E3Ag==
X-Google-Smtp-Source: ABdhPJxaDdFK/N9khT/R8tRAcoksYGBiMIqSY896QErio7QGoraF477ADs5IcBCmI8/tdJDj860fWW4a6WVqEip87hY=
X-Received: by 2002:aca:b205:: with SMTP id b5mr15288523oif.103.1592931922959;
 Tue, 23 Jun 2020 10:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200623004520.26520-3-TheSven73@gmail.com> <202006240015.pGzlVrrz%lkp@intel.com>
In-Reply-To: <202006240015.pGzlVrrz%lkp@intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 23 Jun 2020 13:05:11 -0400
Message-ID: <CAGngYiUQ_ytR83xRHFBkCOPTuSXvtav8sQrAdg4iC3Up+ncijA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] romfs: address performance regression since v3.10
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Janos Farkas <chexum+dev@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:17 PM kernel test robot <lkp@intel.com> wrote:
>
>    ld: fs/romfs/super.o: in function `romfs_largest_blocksize':
> >> fs/romfs/super.c:505: undefined reference to `__moddi3'
>
>  > 505                  if ((device_sz % blksz) == 0)

I can change this to device_sz & (blksz-1) if this patch gets
positive feedback.
