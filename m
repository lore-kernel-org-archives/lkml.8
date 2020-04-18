Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F129DC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3624221E9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ckrDAOTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDRRpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDRRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:45:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9783C061A0C;
        Sat, 18 Apr 2020 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=/WGvo5iks9DIfRMKjAtzrKN0Z+SLdeuJEBbkOe+BsQY=; b=ckrDAOTDxGJO6NaGkuEB4xSlsd
        NjJqTf7U0F6TFijNWdSlSEvoHC4e73LADZaHbTB5xx+WYjhAqJAQJ7jUdBznGFcMiaoNh8rEZi/v9
        q+7Rn1wNpDalFdODFDfI947zJJGUPxM9vcw/bPJjvc7RGdZmYLytCZL8qaTATLNasSKmxYLXA+rSr
        etXgNb6fXjESYhDhU0xtwYQwbQMb0e6uEdTeyQaY4MBaWc45HJJqOIRY21Wykp9qRpci6ze1PAvxT
        S21+I1Db7tYcod9DUc70x4ymbB6Ed9gYreyCoAlvVW2NwXqn2wkJUiy6vU7lPAVBADSv8NOMNuAbZ
        QK8Xs0cQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPrWg-0006Zx-Jl; Sat, 18 Apr 2020 17:45:10 +0000
Subject: Re: [PATCH] docs: ioctl-number.rst: add habanalabs driver IOCTL
To:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20200418174132.10597-1-oded.gabbay@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3ba8ac2-660f-a388-4f8d-0157607448a0@infradead.org>
Date:   Sat, 18 Apr 2020 10:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418174132.10597-1-oded.gabbay@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/20 10:41 AM, Oded Gabbay wrote:
> Habanalabs driver in misc exposes several IOCTLs to userspace. Document the
> letter and IOCTLs number range in ioctl-number.rst.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index f759edafd938..52bf58417653 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -146,6 +146,7 @@ Code  Seq#    Include File                                           Comments
>  'H'   40-4F  sound/hdspm.h                                           conflict!
>  'H'   40-4F  sound/hdsp.h                                            conflict!
>  'H'   90     sound/usb/usx2y/usb_stream.h
> +'H'   00-0F  uapi/misc/habanalabs.h                                  conflict!
>  'H'   A0     uapi/linux/usb/cdc-wdm.h
>  'H'   C0-F0  net/bluetooth/hci.h                                     conflict!
>  'H'   C0-DF  net/bluetooth/hidp/hidp.h                               conflict!
> 

thanks.
-- 
~Randy
