Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B54C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6B32074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRigTL2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFLO27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:28:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B85C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:28:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c35so6578292edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7VXV5WQNHN1mQmIJTfQ/JXY1z4j66dpspOrWipDAibA=;
        b=KRigTL2Plp/Srv11vk7lzbWGOA97w13+GYhokFhtivV5NrXW5l/dC95O2+zODstwse
         qPv8IydI7l3/lBQE8HWOANhRrfdNa5P/gzXstxfvRY7foFS1ICfEx2KAUD5aAs2z8h2f
         jQwcaneg/ywxCLy/tgjQIbuI65Fj47OhtkWntrs60vgulb2kBujM6/FUVk+az11YXV1f
         w0XkwsQmejU5hKZu6Fk9ImZDceJ7ibF2IY5L6ok9anYwcKBb6UUfvIegQdeqErCWtK/Z
         pn7PJShpS7HJb9J8oNjw33fwqQ+OI8e4+x8FvIwGrx1FPGULdh1ETLFABT0WBLg4PoNE
         0rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VXV5WQNHN1mQmIJTfQ/JXY1z4j66dpspOrWipDAibA=;
        b=oBSEIBT20bEcBP34ZqM4QyhOG6e6HPdZZ4pKZHlZfSoFeoPVtlfgBU4LUpdTl8qtJl
         8Cc2p6udDuzgUh/nbxRCqkLsgym+KwaGg6W+E2DP9C3WgoT8tpDPL9jwGTUvY11PuAvh
         DDLW8aE3OG5vDtWAB35YCsQHqB1eOr+4KJvtOZCSXq/6Wl8yZFqmSm6tv2JTuUB6XX/x
         4Uba6ZQZ6ZRtr/ZH+rsbJyst2qOY3ib2bO9Wf5dkt09FLNMVF6WndVu5WurraSQBWs44
         ryH0QTT+8V5ANg7hC1E5mm13vgS1BMYoEasqXW748tncElLcbJ6oaG77R4CPyOkASUp1
         jAIw==
X-Gm-Message-State: AOAM533R+ogm1P3nExLAQT+xlY/rUE9DNn9jPYjbUCRxmLiMlazPEd7W
        HyccAjn8qas0Tir5/gh0xI6QH84w
X-Google-Smtp-Source: ABdhPJzlILERYb7dNe+MQ27SwiC9/hp9eApeKd9lx7aPOrEFErhZgBw4nzu9i3VmfHEOG+xeNABj6g==
X-Received: by 2002:a05:6402:1750:: with SMTP id v16mr12333329edx.137.1591972136759;
        Fri, 12 Jun 2020 07:28:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t5sm3244701eds.81.2020.06.12.07.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 07:28:55 -0700 (PDT)
Date:   Fri, 12 Jun 2020 14:28:55 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200612142855.l22qslnmx4upddhl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200604122805.d2ndjmkmti6wl3nz@master>
 <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master>
 <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
 <20200608223112.ftncszh7hfnmqj3m@master>
 <20200609091649.GX2428291@smile.fi.intel.com>
 <20200609230241.gdqebrspmucnru5k@master>
 <CAHp75VdVUNqUsfr19jKHjba8CPTQhbSK+WfTKwZFtCfK0JtRCw@mail.gmail.com>
 <20200610220613.ets3envsukjstvlu@master>
 <CAHp75VcaDX8exWvTimzjwyLKjcKtaZyxugzWmnNMErvTZHDLQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcaDX8exWvTimzjwyLKjcKtaZyxugzWmnNMErvTZHDLQQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:25:07AM +0300, Andy Shevchenko wrote:
>On Thu, Jun 11, 2020 at 1:06 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>> On Wed, Jun 10, 2020 at 01:17:28PM +0300, Andy Shevchenko wrote:
>> >On Wed, Jun 10, 2020 at 2:06 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>> >> On Tue, Jun 09, 2020 at 12:16:49PM +0300, Andy Shevchenko wrote:
>> >> >On Mon, Jun 08, 2020 at 10:31:12PM +0000, Wei Yang wrote:
>> >> >> On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:
>> >> >
>> >> >...
>> >> >
>> >> >> The test on 64bit machine pass. Since I don't have a 32bit machine by hand,
>> >> >
>> >> >Out of curiosity what that machine is?
>> >> >
>> >>
>> >> It is a Intel Xeon Gold CPU.
>> >
>> >I suppose it's x86 (and not ia64).
>> >In this case you can always build an i386 configuration and test on a
>> >32-bit "machine".
>> >
>>
>> Yes, you are right. While last time I tried to run a 32bit guest, it took me a
>> lot of time to setup. If my understanding is correct, to run on a 32bit
>> machine, we not only need the kernel but a whole 32bit system. This means I
>> need to re-install a 32bit system. And I found many distro doesn't support
>> 32bit system any more.
>>
>> Do you have a better way to setup the environment?
>
>Yes, BuildRoot is your friend. I have a branch [1] to make it suitable
>to create bootable images for x86 machines. There is a quick
>instructions what it does provide.
>
>[1]: https://github.com/andy-shev/buildroot/tree/intel/board/intel/common
>

Many thanks for your instruction. I will take a look into this.

>-- 
>With Best Regards,
>Andy Shevchenko

-- 
Wei Yang
Help you, Help me
