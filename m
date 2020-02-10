Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C0CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3611E20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581352155;
	bh=+ORjYNrg863vE14AtfBIx2e4BnkkymL4mrKyg3T5GYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=becZWPKreMqElQPekAuYtJGqkSZfD5BE/jEbrVMwuCg+PARVlNhcWdQgdMlYZsukO
	 vQIxQS1jxjAVIfP+9QE/ep1TlfwM0ndbKMO4J1p7rw8VKWbI8Tkb+DX6sMqUAjA77y
	 lO1FnrcE/uP0RRTwAdlyXOy2KIPelpdabpVL3HGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBJQ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:29:14 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:49118 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:29:14 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 01AGT65V023180
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:29:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01AGT65V023180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581352146;
        bh=BL9YgVLBpBvpRqMhRZ7v5hCeFCnXrqtfAGM6uYBznPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ie4gKs1jQXCfQK+If5+kLytDvbWULflrJ3HKHYv9LayXyVgZz06g1V8a5Qnk/zoBt
         NRty9oPfMRVa4TVfdrVeUyjfqs9kuK70o+0l70+klLkI0mSZAXcucgF9H6NL/aJsqI
         1IKKcJ74KvA0bR31baJ/nevRVn9Bv86sJE4GoP3Y+ka+9f60A9y7MdXNCmk4OKoR2l
         nS9kfZ+z4qOh90CtWflzOC35d0Z3Bj0jEJwumn8qDccYXMFP6C3IGpuG7oP3UxTFh5
         JjijvNX88GYKkhtRu7kUsZk0qmU29mT0vOCtVuffrvO+SJz6qaM0JZa6kGeLy+VqhS
         FZIBIdS+u8XuA==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id b2so1386781vkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:29:06 -0800 (PST)
X-Gm-Message-State: APjAAAU2u1kXxODT5XfwDGWdRB5hvCSvhOR4b6zCmsdGrFsM4y6KXSWq
        MKRrapzwJfZTF0Yy/4fWHLj655A6Xgsn7YX21j8=
X-Google-Smtp-Source: APXvYqzWEWcyYAIwXwJbZkDpCsEKbZ0Sky5eLvgt4NUntZczPMXbAKAmahgwsLTn1IvPc4Gn1n5iQdxxO02Uw5e+o4M=
X-Received: by 2002:a1f:bfc2:: with SMTP id p185mr1181564vkf.73.1581352145397;
 Mon, 10 Feb 2020 08:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20200210134133.GA32563@amd>
In-Reply-To: <20200210134133.GA32563@amd>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Feb 2020 01:28:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCVL9DFUtWNbUUuXbh+M1NogNafQkPBErbe3e3XKzX4w@mail.gmail.com>
Message-ID: <CAK7LNASCVL9DFUtWNbUUuXbh+M1NogNafQkPBErbe3e3XKzX4w@mail.gmail.com>
Subject: Re: 5.6-rc1: regression -- assertion failure in kallsyms
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 10, 2020 at 10:41 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> I'm now getting this:
>
>   MODPOST vmlinux.o
>     MODINFO modules.builtin.modinfo
>       GEN     modules.builtin
>         LD      .tmp_vmlinux1
>           KSYM    .tmp_kallsyms1.o
>           kallsyms: malloc.c:2385: sysmalloc: Assertion `(old_top ==
>     initial_top (av) && old_size == 0) || ((unsigned long) (old_size)
>     >= MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end &
>     (pagesize - 1)) == 0)' failed.
>     Aborted (core dumped)
>     /data/fast/l/k/Makefile:1077: recipe for target 'vmlinux' failed
>     make[1]: *** [vmlinux] Error 134
>     make[1]: Leaving directory '/data/fast/l/k/o/900'
>     Makefile:179: recipe for target 'sub-make' failed
>     make: *** [sub-make] Error 2
>     make took 1 minutes 8 seconds
>     Command returned exit status 2
>     pavel@amd:/data/l/k$
>
> ..and am not able to cross-compile kernel for Nokia N900. Any ideas?


Sorry, this should fix the crash.

https://patchwork.kernel.org/patch/11373579/



>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



--
Best Regards
Masahiro Yamada
