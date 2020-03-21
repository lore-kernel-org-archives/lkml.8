Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8572FC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 07:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D76A20739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 07:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="ay1CXFxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgCUHCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:02:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33022 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgCUHCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 03:02:12 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so8661587iof.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXnfnJdxwyP4iXFKwBQ2Uuna7kuUgG8tOJJOGAbD0FA=;
        b=ay1CXFxFI2kqh1GC/SM7jIVOfPTUieW0GKf6rU36wlUW9H+EFkPbv4WFL6rXrnC6+m
         pxAGtKx/myQRAMfSfo8qH1L72jii+b4kDuYiEsnlIbT0ymKDTP+gPYxFY769W8HgOXWD
         +3YYcVOkYwlaPjrEZxo6h7yjLoq5o2jnK4uEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXnfnJdxwyP4iXFKwBQ2Uuna7kuUgG8tOJJOGAbD0FA=;
        b=ZJg7bMJcFrrWIdfWCA8CId+rnJJvcpmB4xqj7lxn27IA/hnci8w4lso/wbO/Ctn3cm
         +QfVHQMDGN/PVEkDVi7tFvpKhm7f+4Q/l/xYTA89zfHFM4ZGHJLRmFb1/qiHV5R8/wSm
         HfstaX5Awjv26epY2CmZMi/1pDxCWICTKcG+SJvrYfo114kWqTaN7Z6EwOWWb+w3orvl
         oTQ09jpPZGRGnmggKudLuYE8cd/Zmi/h1+/Qfz0djbHDpdNmPQXyr5xmhmF9+X2wQovA
         QAsotfjOAviJw/45FZKOuC+1cj/r1o7COBLKvzFDanVwGkj0qUvkx+zq/UcQRlVs4DxP
         z7gg==
X-Gm-Message-State: ANhLgQ3y03KQDbUtmVpYZyzj67j15vkSimFlklqhLyLNvnSd0V5CSqQC
        l6N1/6KimFYFxVIQF5Qhh1qpPs4jCXle3gzQCuxQTA==
X-Google-Smtp-Source: ADFU+vs+FKm069H/iVNq87gZm09sSiRcson512o9Fb2ivFkX/UaD9JOQI0sPTk8hsofSeCEP18qA6mjwclmsC/f6KY0=
X-Received: by 2002:a05:6638:319:: with SMTP id w25mr660446jap.26.1584774131021;
 Sat, 21 Mar 2020 00:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200320201539.3a3a8640@canb.auug.org.au> <ada1cf22-b135-d84c-b75b-62ff2b4f1945@infradead.org>
In-Reply-To: <ada1cf22-b135-d84c-b75b-62ff2b4f1945@infradead.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 21 Mar 2020 00:02:00 -0700
Message-ID: <CAJCx=gkbP9=G_kvO954=psTwfqCG8ws0DT47mKJ0D0VfPR832w@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 20 (drivers/media/i2c/video-i2c.o)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 9:11 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/20/20 2:15 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200319:
> >
>
> on i386 or x86_64:
>
> ld: drivers/media/i2c/video-i2c.o: in function `amg88xx_hwmon_init':
> video-i2c.c:(.text+0x2e1): undefined reference to `devm_hwmon_device_register_with_info'
>
>
> Full randconfig file is attached.

Odd since there is a "imply HWMON" for the driver.

- Matt

>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
