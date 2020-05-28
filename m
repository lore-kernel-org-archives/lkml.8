Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2239C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C1A2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590674652;
	bh=9xwH3ve1krCLi8y1IXws3TlA6kQno3U7f/kCcQRsHcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2MGkrS1td5zotCSTMbfKrBUvX/PVyLTDXEtuBcoc6PLFJZK4SVKKQ932huuh035Wk
	 YK8JTybnA76QBHcK9HrPjOkU3zDJ+Bl50Nbk1q2vP06QPaBL/SeBXDYjCu8LZelnbp
	 W8qS+Up/DWA2CC+1FnBcZobBpkBeBPD7JzvS30WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgE1OEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:04:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34192 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgE1OEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:04:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id w4so124718oia.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xwH3ve1krCLi8y1IXws3TlA6kQno3U7f/kCcQRsHcE=;
        b=aype7HTAS44qDgFVgc0a0M4sGlj6y11BCLtVKFyNzofyMkce1Uzqqx3Dh4L5AJKKWu
         i0DK0jY2r4XUaVNhixjs0WhebjwZH5+4ezkJxuIyNjbZALYSX8P2cQZcO5vsbioGe0BE
         82cxb4DJ2B5XBBkLdipp6U7vZNtLuA/lcwUX+hQVH7909sL18ZFdZsoSHSp4pHrr0Ymq
         8Wx7ljSKtDGo3Yh6oAXppSmJaKFve/DWerU71bOc+hvNVOxoINezAzKxHlq6h0trvwYq
         rA1Ch/2qmRWJJ4k6KndIIDnm4K/S5rzyg5vzbq4E97pBQ4/GONuApxevdYcVEnE+noRu
         aJfQ==
X-Gm-Message-State: AOAM531qRyinuBlCan3OQKqJN0sMnUDjBuDG8BR6OJxmIAkB3s3ESuDT
        ykkr0xLCW6HupMKrTh+yg+hnvdF41E3EmMo9tcQ=
X-Google-Smtp-Source: ABdhPJxZGEdE0NTXrH7/roYIA4lfVOkHJIsKosvzgDBT5Xesc6EAkiDq23rUgiBC7IkB8ReEAYBXrjVNj79tIxddfaI=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr2379166oih.110.1590674641617;
 Thu, 28 May 2020 07:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200527075048.GD3284396@kuha.fi.intel.com> <CAJZ5v0h0Xjovm-eVyiOG+j7kNEPxB=PZF4rLVEgwUW+H+61DFg@mail.gmail.com>
 <2407984.idRd5kzSG0@kreacher> <20200527222515.GA89212@roeck-us.net>
 <CAJZ5v0jPoi+5d+jv0iAuKkObSr=EDxmMhNqMTvLQNUEc_i9zcg@mail.gmail.com> <64eb962a-eaef-9747-9408-eb9061cb42f6@roeck-us.net>
In-Reply-To: <64eb962a-eaef-9747-9408-eb9061cb42f6@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 May 2020 16:03:49 +0200
Message-ID: <CAJZ5v0i+Kz9U7EHx-KMiqpKnzdbNc-u0gMZ7v0=fGDcqKa28vQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 3:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/28/20 3:57 AM, Rafael J. Wysocki wrote:
> > On Thu, May 28, 2020 at 12:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Wed, May 27, 2020 at 11:01:16AM +0200, Rafael J. Wysocki wrote:
> >>>
> >>> So Guenter, can you please test the patch below to see if it still introduces
> >>> the problems seen by you on ARM?
> >>>
> >>
> >> arm64 and arm64be boot tests pass with the patch below.
> >
> > Great, thanks!
> >
> >> Some arm boot tests fail, but I think that is due to some other problem with -next.
> >> Hard to say for sure at this point because -next is pretty badly broken
> >> overall. I'll need to run some bisects to see what is going on.
> >
> > I see.
> >
>
> The failing arm boot tests are due to various dts changes (commit "arm64:
> dts: vexpress: Move fixed devices out of bus node" and associated),
> unrelated to this patch.

Thanks for the confirmation!
