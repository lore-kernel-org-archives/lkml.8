Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459AFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4E42073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbgFXHXb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:23:31 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33368 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389661AbgFXHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:23:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03BAC6089348;
        Wed, 24 Jun 2020 09:23:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kIp0YWd4f9Wp; Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 987DE6246915;
        Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id guvA4nah7l7J; Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6A8CC6089348;
        Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
Date:   Wed, 24 Jun 2020 09:23:25 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard.weinberger@gmail.com>
Message-ID: <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
In-Reply-To: <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
References: <20200529200347.2464284-1-keescook@chromium.org> <202006231610.4993DC5@keescook> <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: lkdtm: Various clean ups
Thread-Index: AQwsBIGnKjKHDWJPXuIGObKRE4SqJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
> 
>> True that, we can rip the file.
> 
> Has anyone fixed the uml build errors?

I didn't realize that this is a super urgent issue. ;-)

Kees, if you want you can carry a patch in your series, I'll ack it.
Otherwise I can also do a patch and bring it via the uml tree upstream
as soon more fixes queued up.

Thanks,
//richard
