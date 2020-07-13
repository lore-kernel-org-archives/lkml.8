Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E244C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1C7206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgGMR1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:27:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:36076 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMR1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:27:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A96F160C;
        Mon, 13 Jul 2020 17:27:19 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:27:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: USB HID/HIDBP
 DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
Message-ID: <20200713112718.6e404a1b@lwn.net>
In-Reply-To: <20200708123613.14368-1-grandmaster@al2klimov.de>
References: <20200708123613.14368-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jul 2020 14:36:13 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/hid/hiddev.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hid/hiddev.rst b/Documentation/hid/hiddev.rst
> index 209e6ba4e019..9b28a97c03e6 100644
> --- a/Documentation/hid/hiddev.rst
> +++ b/Documentation/hid/hiddev.rst
> @@ -65,7 +65,7 @@ The HIDDEV API
>  ==============
>  
>  This description should be read in conjunction with the HID
> -specification, freely available from http://www.usb.org, and
> +specification, freely available from https://www.usb.org, and
>  conveniently linked of http://www.linux-usb.org.

Applied (with a LESS SCREAMING SUBJECT LINE), thanks.

jon
