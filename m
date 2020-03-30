Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12728C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D107920748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYVfcmTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgC3BDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:03:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36856 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727815AbgC3BDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585530195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUugoluBnwyJRYALZAP5gLOlTOYfV1KHNo4jHyfrVrU=;
        b=QYVfcmTpTyqlI6/n4EpmU6sdGg1yElmszpwjnvQA4U1vuuAn9GqMXLHpi2PJ625zJRVyQb
        kkP53PJ73X8fwPcVsq/AR/DRFBLdu8JuNB/x7gFDfWBqQEwq6Fd4pGM9CN6WzxoEeYGU1d
        LRutuUjdVOid+3Hja8pSjTil7xSCXS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-b83Lbdv_Pw6HknSb_AfGbQ-1; Sun, 29 Mar 2020 21:03:12 -0400
X-MC-Unique: b83Lbdv_Pw6HknSb_AfGbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC1F5189DF74;
        Mon, 30 Mar 2020 01:03:10 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B388E60C63;
        Mon, 30 Mar 2020 01:03:08 +0000 (UTC)
Date:   Mon, 30 Mar 2020 03:03:03 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Simran Singhal <singhalsimran0@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove
 unnecessary braces for single statements
Message-ID: <20200330030303.024899f7@elisabeth>
In-Reply-To: <20200325140245.GA11949@simran-Inspiron-5558>
References: <20200325140245.GA11949@simran-Inspiron-5558>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 19:32:45 +0530
Simran Singhal <singhalsimran0@gmail.com> wrote:

> Clean up unnecessary braces around single statement blocks.
> Issues reported by checkpatch.pl as:
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_efuse.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> index bdb6ff8aab7d..de7d15fdc936 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -43,9 +43,8 @@ Efuse_Read1ByteFromFakeContent(
>  	u16 	Offset,
>  	u8 *Value)
>  {
> -	if (Offset >= EFUSE_MAX_HW_SIZE) {
> +	if (Offset >= EFUSE_MAX_HW_SIZE)
>  		return false;
> -	}
>  	/* DbgPrint("Read fake content, offset = %d\n", Offset); */

I find the resulting version a bit confusing:

	if (Offset >= EFUSE_MAX_HW_SIZE)
		return false;
	/* DbgPrint("Read fake content, offset = %d\n", Offset); */
	if (fakeEfuseBank == 0)
		*Value = fakeEfuseContent[Offset];

The check on "Offset" isn't separated in any way by the following
logic. I would suggest that you replace the closing brace by a newline,
also for the other cases you're fixing up here:

	if (Offset >= EFUSE_MAX_HW_SIZE)
		return false;

	/* DbgPrint("Read fake content, offset = %d\n", Offset); */
	...

-- 
Stefano

