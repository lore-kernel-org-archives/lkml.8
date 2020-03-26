Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE234C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762342074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585242899;
	bh=tj6UWC2N1eMarlE9vLXgoNsjZ5q7v0w71QGd2wxbPsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zVB5/Wrxywp/cdYkout6Cyt8gTgQcBGstZsHgovRsCxbfwqd0lcEiKlwDoZ+0FEhm
	 6pa+VuXjx0w4WfZ6I27bpc98+asYBgj6DSQ7WsWdC/gLtHFZqMmhnA8XG4Yj74BuDs
	 p+NYHtgI4qHkLF60KixsS+gNRmk2A0HFj9dOPHMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgCZRO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgCZRO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:14:58 -0400
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E0720737;
        Thu, 26 Mar 2020 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585242897;
        bh=tj6UWC2N1eMarlE9vLXgoNsjZ5q7v0w71QGd2wxbPsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eT4CkxqbfxQVQKBDcv4qJBOnzAuvFiILeUaX1T33w6EuwkKTTBHNk8TfZHngsppx+
         zTjzubbxMW87eoeymyv7rOU+a24GO1emVrKPKXF5nbw3AAlk5YLdj3Xxx+721BKj2i
         w/1uAx89k27kwYFgJMpNqj/xGUmeSMP0SM6WKG2U=
Date:   Thu, 26 Mar 2020 18:14:53 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: Re: modpost Module.symver handling is broken in 5.6.0-rc7
Message-ID: <20200326171453.GA21406@linux-8ccs>
References: <931818529b1d4d13a08d30ddace22733@AcuMS.aculab.com>
 <20200326165036.GA22172@linux-8ccs>
 <90b763cc306140499fddf8e3185e26f5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90b763cc306140499fddf8e3185e26f5@AcuMS.aculab.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ David Laight [26/03/20 17:06 +0000]:
>From: Jessica Yu
>> Sent: 26 March 2020 16:51
>> +++ David Laight [26/03/20 16:25 +0000]:
>> >Something is currently broken in modpost.
>> >I'm guessing it is down to the recent patch that moved the
>> >namespace back to the end of the line.
>> >
>> >I'm building 2 'out of tree' modules that have a symbol dependency.
>> >When I build the 2nd module I get ERROR "symbol" undefined message.
>> >
>> >If I flip the order of the fields in Module.symver to the older order
>> >and link with modpost from 5.4.0-rc7 (which I happen to have lurking)
>> >it all works fine.
>> >
>> >Note that I'm using a named namespace, not the default one
>> >that is the full path of the module.
>> >
>> >I'll dig in a little further.
>>
>> [ Adding more people to CC ]
>>
>> Hi David,
>>
>> Could you provide some more details about how I can reproduce the
>> issue? As I understand it, you have two out-of-tree modules, and one
>> has a symbol dependency on the second? Pasting the modpost error
>> messages helps too.
>
>Ok, I've found out what broke it.
>Was actually the removal of the code that parsed Module.symvers
>from the current directory (which happened for 5.5.0-rc0).
>
>Took some digging and printfs in modpost to find what wasn't happening.
>
>	David

Hi David,

I'm a bit confused - just to confirm, is there a legitimate bug
upstream or was it just a hiccup related to your setup?

Thanks!

Jessica
