Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD5C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C37220888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="NB+kAbK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgGWIwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGWIv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:51:59 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jul 2020 01:51:59 PDT
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE7C0619DC;
        Thu, 23 Jul 2020 01:51:59 -0700 (PDT)
Received: from mxback19g.mail.yandex.net (mxback19g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:319])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 4A68D94066C;
        Thu, 23 Jul 2020 11:50:54 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback19g.mail.yandex.net (mxback/Yandex) with ESMTP id IXTuY98NkU-orkGSgG9;
        Thu, 23 Jul 2020 11:50:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1595494253;
        bh=A7Ht5k3cZ3wxccJoqj/PU6v+iHZnZU4ly3x7oHqkv+M=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=NB+kAbK8jL51yG7iUfuCj2Km7Zr9+LcusXRNK1dx6omRfimbwO8NdQl1IptD3dwCC
         HiUOnyZVRpobUx/AtjcxiI86QvD276nv8UCtjC4xgy99lLvrNjdG0f6ZUqwZippBOZ
         3z/91RLD368Aw6Quastv1Wdkwy++U7jLCSe+sSLI=
Authentication-Results: mxback19g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-7b46a58f2373.qloud-c.yandex.net with HTTP;
        Thu, 23 Jul 2020 11:50:52 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
In-Reply-To: <20200723010055.GA1333715@rowland.harvard.edu>
References: <20200721201558.20069-1-novikov@ispras.ru>
         <20200722141741.GA1310843@rowland.harvard.edu>
         <2097231595446720@mail.yandex.ru> <20200723010055.GA1333715@rowland.harvard.edu>
Subject: Re: [PATCH] usb: gadget: net2280: fix memory leak on probe error handling paths
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 23 Jul 2020 11:50:52 +0300
Message-Id: <1903061595494082@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.07.2020, 04:00, "Alan Stern" <stern@rowland.harvard.edu>:
> On Wed, Jul 22, 2020 at 10:56:09PM +0300, Evgeny Novikov wrote:
>>  Hi Alan,
>>
>>  I have neither an appropriate hardware nor an experience to deal with
>>  issues that you mentioned. Our framework does not allow to detect them
>>  as well at the moment. At last, it seems that rather many drivers can
>>  suffer from these issues. So, it would be much better if somebody else
>>  will suggest necessary fixes and test them carefully.
>
> Heh... Working from home, I no longer have access to the appropriate
> hardware either. But at least I do have the necessary experience. :-)
>
>>  BTW, you have already discussed the race within net2280_remove() with
>>  my colleague about 3 years ago. But you did not achieve a consensus at
>>  that time and no fixes were made after all.
>
> I don't recall that. Do you have a pointer to the email thread in the
> archives?
https://lkml.org/lkml/2017/8/16/345 - this is the top message of that thread.

Evgeny
>>  Anyway, one can consider both issues independently on the one fixed by
>>  the patch.
>
> Yes. I'll write and submit a series of patches.
>
> Alan Stern
