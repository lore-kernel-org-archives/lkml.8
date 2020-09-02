Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE213C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB5C2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="icEHl0iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgIBQVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIBQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:21:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418AC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=g7CwtEKfB8taAJKHOl+B6Vy77KBez7Wj8qfNT2rp9Q8=; b=icEHl0iwQMQYNoukIz5Ou1aSLu
        cIXyBjtpqAND+i1q+6USzF61JoghiwGPI1sXjsx2XZgtc3DqBNrAgZqsWeDiVP4MqZq/tWvtvWkHA
        fRImhcbj1e8OJB5uT3Sb/jppb92jUTTRYmXoXgIY1f/UPMz8h7z/g6+lbUxYsiPc9e7YmjRkHpfK/
        6zpw2RSeST1hgiMoxYxS0GeuWcwGIpqdoguHgeAH23e+Ys8oMJ9/EqpzaX0Dw2Ytl9GYW8DZa9NKL
        eHuH7HEgil7yPzifbQ3D06FxGGVL8fSe1GVuFHcdJ2brhvdoTA3r1Rvu21A4S/h+alq1k2xgKfk5s
        EShTcTEg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDVVY-0006fb-ST; Wed, 02 Sep 2020 16:21:13 +0000
Subject: Re: [PATCH v2 2/2] staging: gdm724x: gdm_tty: replaced macro with a
 function
To:     Antoni Przybylik <antoni.przybylik@wp.pl>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200902161627.64686-1-antoni.przybylik@wp.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <14c3b5c1-a5d8-3843-6538-5f76c4b8d6df@infradead.org>
Date:   Wed, 2 Sep 2020 09:21:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902161627.64686-1-antoni.przybylik@wp.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 9:16 AM, Antoni Przybylik wrote:
> Changed return type to bool and removed inline specifier. Also added
>  static specifier.

why remove the inline specifier?
thanks.

> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 34a13d98c029..179fc9b9400b 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -34,7 +34,7 @@ static DEFINE_MUTEX(gdm_table_lock);
>  static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
>  static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
>  
> -inline int gdm_tty_ready(struct gdm *gdm)
> +static bool gdm_tty_ready(struct gdm *gdm)
>  {
>  	return (gdm && gdm->tty_dev && gdm->port.count);
>  }
> 


-- 
~Randy

