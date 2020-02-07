Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD0C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0120726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581067289;
	bh=rxfE3CGS2tLN84Rkks86mGZCRveVi6w9/Uzgu4ZbZPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AG9KT/C3yn3p/W0feew0DRCDFAdYq8XPzbt9d+XXITLtiML8MBPITcsVQs7PlYh8G
	 u6Ekr6ca3CQm0wxtPxCrVwmjZnn27BCAWsfsIRh7KDmgMv5H+j1QPzBmnm+xpOG4ik
	 3SBGzeeiqU6cy+/i+Se05/OhEzmSBX90Zp5jU2Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgBGJV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgBGJV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:21:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2323A20726;
        Fri,  7 Feb 2020 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581067287;
        bh=rxfE3CGS2tLN84Rkks86mGZCRveVi6w9/Uzgu4ZbZPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8+eoBko0GW6q3Z58Tr1NRIPXmJSSL3wx2ox9nW0P0FJsQhbTxGOKsiGKtiuw0B25
         ENhCpv1dScCdkL9PBI4cCq1/59wbdT44324XXyrecWBSVXSoSj3HOZICA1Ki9XDD0d
         mQSnr/cQQsoNCFDJz8wyVr7bbbxvMlSiFcOz0hqg=
Date:   Fri, 7 Feb 2020 10:21:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: hal: fix condition with no effect
Message-ID: <20200207092125.GA520856@kroah.com>
References: <20200125134604.GA4247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125134604.GA4247@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 07:16:04PM +0530, Saurav Girepunje wrote:
> fix warning reorted by coccicheck
> WARNING: possible condition with no effect (if == else)
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 8 --------
>  1 file changed, 8 deletions(-)

Patch does not apply to Linus's latest tree :(
