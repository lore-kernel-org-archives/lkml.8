Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268C32088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593693963;
	bh=xg4z6gzs49EQwSpfMOpSHLIfIchzaIF1cN5rruUIces=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ivJXqTnJAcuxYEVXuwrArtZjUA179j9mfsddFz/SQe8RMRV0xkkCtTIxnWXgvPhAy
	 0OGGBWq+rnFX1NmzJWOjbX9YXBtCn9hgZndaP4SW2LIhWDRo07IIIC+gA6NMrgMMqL
	 luJzDiiHA6ab82f1e0FJM5agpndvqcvj9yxa7KWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGBMqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:46:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A860A20885;
        Thu,  2 Jul 2020 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593693960;
        bh=xg4z6gzs49EQwSpfMOpSHLIfIchzaIF1cN5rruUIces=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PE8mQ9M2LtUB3RDl1/9TBroLoEMaqczDoQXKhNu+neXjCXUPjc6QELa5xqL5FRrIw
         TQreaWj5nA8GqptMCgjrR10sCgjNgZmf0E8E1ZYcZhqsVJ9KOVoXHSujn9VB4KdgW5
         YHSAtdJtn7yvWlI0/zWAZ7LjdUH67JRq5J/mthvs=
Date:   Thu, 2 Jul 2020 14:46:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware: improve description of firmware_request_nowarn
Message-ID: <20200702124603.GA1883510@kroah.com>
References: <20200625200221.18219-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625200221.18219-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:02:21PM +0200, Wolfram Sang wrote:
> The doubled 'however' is confusing. Simplify the comment a little and
> reformat the paragraph.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_loader/main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index ca871b13524e..8c7d9b432cb1 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -838,13 +838,14 @@ EXPORT_SYMBOL(request_firmware);
>   * @name: name of firmware file
>   * @device: device for which firmware is being loaded
>   *
> - * This function is similar in behaviour to request_firmware(), except
> - * it doesn't produce warning messages when the file is not found.
> - * The sysfs fallback mechanism is enabled if direct filesystem lookup fails,
> - * however, however failures to find the firmware file with it are still
> - * suppressed. It is therefore up to the driver to check for the return value
> - * of this call and to decide when to inform the users of errors.
> + * This function is similar in behaviour to request_firmware(), except it
> + * doesn't produce warning messages when the file is not found. The sysfs
> + * fallback mechanism is enabled if direct filesystem lookup fails. However,
> + * failures to find the firmware file with it are still suppressed. It is
> + * therefore up to the driver to check for the return value of this call and to
> + * decide when to inform the users of errors.
>   **/
> +

Why the extra blank line, doesn't that break kerneldoc handling?

Can you drop that and resend with Luis's ack?

thanks,

greg k-h
