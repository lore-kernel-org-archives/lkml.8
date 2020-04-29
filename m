Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C1C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F086520731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588132444;
	bh=De6PzrfxSghoqsQ3yniIp4J9/bydVMy1hGfoZX7LRyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hOq1L96R9aJ0UJpoXh0G6iSUqt8cXeOfQlM7Ytq7DBQcYMWJCbo81DNXfjufWoEQC
	 6XChIchY2jc8zBuS5BqVp+n/GnKYPC1kdLCHNiBgrd4rSCLkaZeqAzDG44BJbdwvsK
	 CI3StqyuPOZrzudU+hTuM9yx+UvfeuRGX6I3M8E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2DyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:54:03 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42256 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgD2DyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:54:02 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03T3rjqE031628
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:53:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03T3rjqE031628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588132425;
        bh=Mz2apSt2RX+xw6S7HBmiwyUlKgj81QfS69CFaJ49lRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2QWMxumD9V6BMmQfEWnqzc9iQ1/01wrbpO17g1KbcazDqJv4YtKBk3lrpcFT4BmH4
         UduCK29ChKOZuPgqlUytkcS8Wxvr0UFOekvybm78vliobeO5tqU4YVsLbVLfMCeXao
         Hsutl+89lTG3jgWBOwVUSevDPaITBiVFoGKm/Z8sWGca7YUrso1RAA5H108ZLghqHT
         061h/LZ5dpt/5pAb1rnAOZIpykT2/z4miToWGqrtqHdVJ5XuU0bKCnlVirciD+NU7t
         SNAOQkXz2ygW9WCOhIhXw+CsXSq6x/zjgQ/RlCyEyE1qj+/SNwgWzZsOcS4zwrpCS9
         rdS4C/7GhTgIw==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id t8so432047uap.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:53:45 -0700 (PDT)
X-Gm-Message-State: AGi0PubTge1skEyiYIwnkrgAA6fGBGH+nTda+CGGzGDYsYqOFll/v6fv
        s62flHw3odsqaxiXa5GMVK9MqVUZqfm7Pd9mwhg=
X-Google-Smtp-Source: APiQypLVOKMBwctHfkarhyPWDYMPmkP4fYxrx3pmM1MLASVEbEjoBJkP+qKSSzELeGHE9CM2a1+QyMAIHAyghPgt/gU=
X-Received: by 2002:ab0:2e84:: with SMTP id f4mr24010753uaa.121.1588132424239;
 Tue, 28 Apr 2020 20:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200428212555.2806258-1-arnd@arndb.de>
In-Reply-To: <20200428212555.2806258-1-arnd@arndb.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 29 Apr 2020 12:53:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARF-hqpcwVX7LvyZeWX5dJnnBBW=k2EBHSWM9cQCLW9Sw@mail.gmail.com>
Message-ID: <CAK7LNARF-hqpcwVX7LvyZeWX5dJnnBBW=k2EBHSWM9cQCLW9Sw@mail.gmail.com>
Subject: Re: [PATCH] samples: fix binderfs sample
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Brauner <christian@brauner.io>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,


On Wed, Apr 29, 2020 at 6:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A routine check for misspelled Kconfig symbols showed on instance
> from last year, the correct symbol name is CONFIG_ANDROID_BINDERFS,
> not CONFIG_CONFIG_ANDROID_BINDERFS, so the extra prefix must
> be removed in the Kconfig file to allow enabling the sample.
>
> As the actual sample fails to build as a kernel module, change the
> Makefile enough to get to build as a hostprog instead.
>
> Fixes: 9762dc1432e1 ("samples: add binderfs sample program")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Nice catch!


I am working on a new syntax 'userprogs'.

This builds programs for the target architecture
instead of the host.

Once, my series lands,
you can use 'userprogs', like this:
https://patchwork.kernel.org/patch/11515977/

Then 'ifndef CROSS_COMPILE' will go away.




-- 
Best Regards
Masahiro Yamada
