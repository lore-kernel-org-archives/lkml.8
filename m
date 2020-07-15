Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51852C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E14206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594796928;
	bh=cd7EBK6ejhx0Q0/uzC7b76QRiDZdxfcuOiocUXAovWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lOIyb/FbE7LRiTG1uBVk4uDk6Wdm2GJIWV2ewAwsEIBforR6bsKW5bUXpT3shjT/4
	 0IB7yICbb/8uhBl908sjhHd05e/npSPhQjscJSnH4zR8fDGkhCFvyA4+eFnl5BUO30
	 L+WsbkSp5l9GlG9tiqhSuBDZglS5Qw8XooK9G3R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgGOHIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgGOHIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F1B2065E;
        Wed, 15 Jul 2020 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594796926;
        bh=cd7EBK6ejhx0Q0/uzC7b76QRiDZdxfcuOiocUXAovWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wR17Hza5UBzs+eLV5QKBnPYd6OqgPBHHqOn8+UqnmwCRHq/Cg7a7sjTC6CWtdmW/9
         y2ZD1tOxOTAIK0XQlBWAdtDDyBqyR1ETDZ3uXH2SgJA41vJ2wo+Ym6kXWqIVUxqUfN
         ZCsnqaKrr+LlyfhO/lLSIc8CzhtsHCBBzA392A3s=
Date:   Wed, 15 Jul 2020 09:08:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: comedi_fops.c: changed type in
 assignment to unsigned int *
Message-ID: <20200715070842.GA2303720@kroah.com>
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> fixed a sparse warning by changing the type in
> assignment from void [noderef] __user * to unsigned int *
> (different address space)
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/comedi/comedi_fops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 3f70e5dfac39..4cc012e231b7 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
>  	cmd->scan_end_arg = v32.scan_end_arg;
>  	cmd->stop_src = v32.stop_src;
>  	cmd->stop_arg = v32.stop_arg;
> -	cmd->chanlist = compat_ptr(v32.chanlist);
> +	cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
>  	cmd->chanlist_len = v32.chanlist_len;
>  	cmd->data = compat_ptr(v32.data);
>  	cmd->data_len = v32.data_len;

Always run your patches through checkpatch before sending them, so you
do not have a grumpy maintainer telling you that you have to run
checkpatch on your patch before sending them.

thanks,

greg k-h
