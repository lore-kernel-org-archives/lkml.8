Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB267C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C652E2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TKAgM0jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGQTgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:36:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2DC0619D2;
        Fri, 17 Jul 2020 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=vdwZIeP/5ERRdxhT4tm912eFf6IQw0zOb9u5nhr4xh0=; b=TKAgM0jjr8L9FnRPKbO1PwvU5/
        NIuP4LJmBDIyyEaIbyOoDkyk7Ac5vSzAylv1ekF71YUs5ukbuGCrS4mZo4I6VrxNaTk4HQhfZgWd7
        WSqKDkYC2DR5+vAKEMKeedGW8gduex2Mq0gtRU87cDuo09E7SrXYFQrmKSLbZQ+wuwPiRXFtJgGR4
        TmqXqMWawaTbI4lrqSNF0Qxd2pQRk/Etn2z9q3HBs+zDrnuvrfNt3W6mFOBAqOKVy7aH7x16Q6G7h
        91re09MaX/L4n/am+fRvFeWj1vL5KIP3rIYYD21uh5n6RGIkAYve4xLPWDOBApa4NifD6sg3G+sH4
        qzy5R/Jw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwW9x-0002Lm-Bh; Fri, 17 Jul 2020 19:36:41 +0000
Subject: Re: [PATCH 06/25] Documentation: usbstring: usb_validate_langid: Fix
 sphinx warnings
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-6-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7c4a651b-06ca-d8fd-dbcf-546250316f16@infradead.org>
Date:   Fri, 17 Jul 2020 12:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-6-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following warnings:
> 
> warning: Function parameter or member 'langid' not described in
> 'usb_validate_langid'
> 
> warning: Excess function parameter 'lang' description in
> 'usb_validate_langid'
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Hi Daniel,

This is already fixed in Greg's tree.

thanks.

> ---
>  drivers/usb/gadget/usbstring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
> index 58a4d33250902..2e9735abfeb95 100644
> --- a/drivers/usb/gadget/usbstring.c
> +++ b/drivers/usb/gadget/usbstring.c
> @@ -16,7 +16,7 @@
>  
>  
>  /**
> - * usb_gadget_get_string - fill out a string descriptor 
> + * usb_gadget_get_string - fill out a string descriptor
>   * @table: of c strings encoded using UTF-8
>   * @id: string id, from low byte of wValue in get string descriptor
>   * @buf: at least 256 bytes, must be 16-bit aligned
> @@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_get_string);
>  
>  /**
>   * usb_validate_langid - validate usb language identifiers
> - * @lang: usb language identifier
> + * @langid: usb language identifier
>   *
>   * Returns true for valid language identifier, otherwise false.
>   */
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
