Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CEA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593092171;
	bh=mtp7nug8DXnlg3klSnF/L9TcVC11/sBPd5QOTqGfuB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mPregogYm847lG7EFCsIQ1oIKsWEJ4k1K8dOV7UymkGVcK5DRREQ1TPc2eeP4v4uV
	 lJ9ixGzVput2pXfg7CgIRpFmgG5S38T3tf9iFCb9ZMtjaJzL1cohB2PurXD1+0pIZE
	 lbJpfoySTc2rX/wQOCPhLJbrllm5iXiJCh2K45ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405184AbgFYNgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404910AbgFYNgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:36:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF7720672;
        Thu, 25 Jun 2020 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593092168;
        bh=mtp7nug8DXnlg3klSnF/L9TcVC11/sBPd5QOTqGfuB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEcBD9CMFPVpvmqk5ePBRmi/v2EI0o5geZyyKhMEJey2WC6W6IARCSJ53mDT3LA5C
         v+ykaRF8klL9RAS1wPEqAoXCaV5kYZMyak7nG9hzQ3USCnPPe5Cj/c9NMOFdMXAWE0
         D3EOW5mgD77G3q/jn2HHvlgMXBlPFBxNuchSiD0M=
Date:   Thu, 25 Jun 2020 15:36:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brooke Basile <brookebasile@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, devel@driverdev.osuosl.org, trivial@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: Convert symbolic permission to octal
Message-ID: <20200625133604.GA3533051@kroah.com>
References: <20200625132513.10805-1-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625132513.10805-1-brookebasile@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 09:25:13AM -0400, Brooke Basile wrote:
> Fixing checkpatch WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> 
> Signed-off-by: Brooke Basile <brookebasile@gmail.com>
> ---
>  drivers/staging/gasket/gasket_sysfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
> index ab5aa351d555..eb0fd3b0490f 100644
> --- a/drivers/staging/gasket/gasket_sysfs.h
> +++ b/drivers/staging/gasket/gasket_sysfs.h
> @@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
>  
>  #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
>  	{                                                                      \
> -		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> +		.attr = __ATTR(_name, 0444, _show_function, NULL),	       \
>  		.data.attr_type = _attr_type                                   \
>  	}

Someone else sent this a few days before you did:
	 https://lore.kernel.org/r/20200622073612.12282-1-rodolfovillordo@gmail.com

sorry,

greg k-h
