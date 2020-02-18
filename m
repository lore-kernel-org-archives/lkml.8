Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B07C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E69021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="zBT7ls+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgBRI1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:27:22 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:51570 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgBRI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:21 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 03:27:20 EST
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 6F98040434;
        Tue, 18 Feb 2020 09:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1582013845; x=1583828246; bh=ZCUmRkTZBCscrc2Oka2I0C9qAlUD6xdUbb8
        k/+y23eA=; b=zBT7ls+sKA7y8wjvjDIgdOBSl5T+/EIXyh11yYUkB79p/AzsevI
        l/1AsxWVTmsHOg9ZwehcEk4OTojIUo/uwqqL17q+bKlv4aE17R3ve/Tt9U8sElYH
        6ksIiwCl3tL8qLwVLCHMIj0CR/IA0f8ncwDKWhNPrmOYSlP1+TFN9pfOy2b1ffHU
        585fWv8Hv1J/bNCXYU+T5eZTbMgl7YWX5GpQdliZF4K7U2ntnOP3ujSuqwrwNlZK
        GJHkqLvwWLatclXvJGHj67k+L642EshEhSuBcuNFAcLE1VUIMiGrSWdCcuAmMs1B
        mugZGVKPwDN1Ks8nfb99e3ERi6BYynWvUcXTgI6jzfqKFSvi09C6ys/3Otss8lHZ
        GgmrQ9uHLdnl2rgxo3H+rQdgWkaulhmfqqbiNMUYy8v/FjBEVDUIYZzHKouLqW9H
        qZlUBzm9LnUiKFlKr7UcbbMwkpVyHoo/N2KwdZayxWruA7LJ5gArWJMfchO4Ydgg
        KGcbD76djb2J4/3ymQ5AfoRkW+giQnEZHUdYVOm1uJxhgr9frr3TszcuNERzqGEa
        galNq38nbnNHBLi1Mdmcm9WA9/DuMHI3V63dm0LKB7szMURpLUU0h6bGcfqS1GYf
        eUcIbKGKovS7J2fSWZ5zJstcSijrNxmR0p9SElygnvjtIbqR08fAGnkc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CYhEPNypRUrb; Tue, 18 Feb 2020 09:17:25 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id B8454403C2;
        Tue, 18 Feb 2020 09:17:25 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 57BDDAB7;
        Tue, 18 Feb 2020 09:17:25 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace stale url with active one for Mutt
Date:   Tue, 18 Feb 2020 09:17:23 +0100
Message-ID: <26370462.jMSB3ls19i@pcbe13614>
In-Reply-To: <20200218065854.13152-1-unixbhaskar@gmail.com>
References: <20200218065854.13152-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 18, 2020 7:58:54 AM CET Bhaskar Chowdhury wrote:
> This patch will replace  dead/stale url with the active urls.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/process/email-clients.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/email-clients.rst
> b/Documentation/process/email-clients.rst index 5273d06c8ff6..bf8b4c9a4efe
> 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
> @@ -237,9 +237,9 @@ using Mutt to send patches through Gmail::
> 
>  The Mutt docs have lots more information:
> 
> -    http://dev.mutt.org/trac/wiki/UseCases/Gmail
> +    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail
> 
> -    http://dev.mutt.org/doc/manual.html
> +    http://www.mutt.org/#doc

http://www.mutt.org/doc/manual/

I think this link is better

> 
>  Pine (TUI)
>  **********
> --
> 2.24.1


-- 
Federico Vaga
http://www.federicovaga.it/


