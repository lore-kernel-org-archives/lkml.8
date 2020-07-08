Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6829E206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ly3d/RI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgGHQgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgGHQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:36:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08BC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:36:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so32482573edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZO4r5tL7PznMab4hhlB/8rSsiS7Y5eVcUIiZqMDLjok=;
        b=ly3d/RI0Lg1QgPQrIVexS8DV63FICSkgPE4DIKAZV4Ef9kV6E+DkyMyUNqRr85PvwM
         ZbTIpm6b24FIK45fseZZ+aS5UP7kzSMAGGCHyLqyoFX9Dfmoym0VXMi730Jz0XH3ja6n
         3IqyUWdN9nG7ZUtjeeCvv8hzfvxV8IjAYnjB6ibXycnpgfmvStbaOrNwQhbmiO6W58eL
         /jhBPxUjqGzxh98kWL1ibJ0V071dCdiXjfbrnxnPJDYEmnrQV3Av/VvBz8v4lCO8/SmD
         M/4N/IViEqPwiEsbJokzkFM8f/Y12My5niP227eHXgAm+rxOeU4Wot/8cIajJ1Y6ogsw
         LQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZO4r5tL7PznMab4hhlB/8rSsiS7Y5eVcUIiZqMDLjok=;
        b=cHDvlkPHBG6PXKFYO3RJgK2PJs2/arQHdJ6dTmLtTOE4eptsQMMcwpEPb5rtPc6q04
         kVzgPpLsJC05yDsP3EVzxcZB/HnjX82rmdyBNhlsSXIBaoD5tCHSPAwib1Uq5h08Swe7
         PbrzfzyIrMRtQKFTW2YwtjnyMG7hEJzH1hbkqfxSX7zEVG9Z+QVebYXNFDlANJ9E7Szy
         Brq9lgZCcqc+r6ypXMyRlrJUE84r5BugH3rJbpgrBmVJEomFqshvCB1as1Rkjz08Npjy
         7dzmb7Whw0iviTt9MqQHemnSu3ljmgU9os2HQPSB9EQLa4d9Y5mcpVXf2bBydOEpHhyz
         0kpg==
X-Gm-Message-State: AOAM532UgcLEpQnT3CxtqAxByhwpkelJOTM2L7ltesXTKg9RQU9LRZoL
        W03j1sJhGSZzenn5ObbaAARPddqo+utGa2nWl/h6
X-Google-Smtp-Source: ABdhPJy8mhxWuifbJNYOySCkAc748MpDt07opbSutwbagEBkOcAMiQTjLNeFuzJ1S5wIEwRp5s3TgRSLxUc0c/Yz9ZM=
X-Received: by 2002:a50:a881:: with SMTP id k1mr66043994edc.12.1594226159823;
 Wed, 08 Jul 2020 09:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <1594094404-69691-1-git-send-email-fly.lihao@huawei.com>
In-Reply-To: <1594094404-69691-1-git-send-email-fly.lihao@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jul 2020 12:35:49 -0400
Message-ID: <CAHC9VhSCWfKkugHdSNc=Bmhf_MLP22PKsb7tmHuPKwRUH-G-aQ@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: Fix spelling mistakes in the comments
To:     lihao <fly.lihao@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, young.liuyang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 12:00 AM lihao <fly.lihao@huawei.com> wrote:
>
> Fix spelling mistakes in the comments
>     quering==>querying
>
> Signed-off-by: lihao <fly.lihao@huawei.com>
> ---
>  security/selinux/netif.c   | 2 +-
>  security/selinux/netnode.c | 2 +-
>  security/selinux/netport.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next, thank you.

-- 
paul moore
www.paul-moore.com
