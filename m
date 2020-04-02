Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D94206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NncElT+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgDBBpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:45:16 -0400
Received: from ozlabs.org ([203.11.71.1]:45835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDBBpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:45:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48t5VK3Grmz9sQt;
        Thu,  2 Apr 2020 12:45:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585791913;
        bh=rQ+kEm5U3RQEncvzPQQVCOjsrblPRADn17cBcKTb5o8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NncElT+PLctiF6Wh0QKfVYEoPAo8BmveXDGYB73FNT6yCG9p6pgsxbR5WWNHSfE4I
         usZgf9bWdLaf/XD2H3oA8TzGxQSghfb7bbPaWgD6lcNgpj8zzPz1zVIeE4WNAzY32E
         5tmxDBaRqMkAJwxIUvywudE+3P1oGMg7l+QOt19OM6nZGw2daueAxHZf039YIBrGRM
         kzoVe/xul3uxQ2LBWSrPQStPqcWr9Md91WAlW2r+QDZsaV1q2pabIc7Y4XUi4GlLjD
         JQV0ZPa/chHsZlgMBla8jctcOMnDoTRrxRGdXhS/RxNLlH+equgfkS/u/OWikFL0Nb
         r/tqKBys7YQ3A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty/sysrq: Export sysrq_mask()
In-Reply-To: <20200401151222.GA2508664@kroah.com>
References: <20200401143904.423450-1-dima@arista.com> <20200401144610.GA2433317@kroah.com> <b0099c8c-5bab-960a-8d0d-4691e11a462f@arista.com> <20200401151222.GA2508664@kroah.com>
Date:   Thu, 02 Apr 2020 12:45:20 +1100
Message-ID: <87pncqu0cv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Wed, Apr 01, 2020 at 03:49:56PM +0100, Dmitry Safonov wrote:
>> On 4/1/20 3:46 PM, Greg Kroah-Hartman wrote:
>> > On Wed, Apr 01, 2020 at 03:39:04PM +0100, Dmitry Safonov wrote:
>> >> Build fix for serial_core being module:
>> >>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
>> >>
>> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> Cc: Jiri Slaby <jslaby@suse.com>
>> >> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> >> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> >> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> >> ---
>> >>  drivers/tty/sysrq.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> > 
>> > Is this a new problem?  What commit does this fix?
>> 
>> Right, sorry I've managed to forget adding the tag:
>> 
>> Fixes: eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")
>> 
>> Maybe also:
>> 
>> Link:
>> https://lore.kernel.org/linux-fsdevel/87tv23tmy1.fsf@mpe.ellerman.id.au/
>
> Thanks, that works.  WIll queue this up after -rc1 is out.

Why wait until after rc1?

It's a build break for a bunch of folks and the fix is obviously correct
(famous last words).

cheers
