Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAED7206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588070530;
	bh=CvEzbuCfH4+7PgmhF93OcCUlpgwCqTZYnfybiXHV8/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kzp6EXkvAx6puPdvKmSlitq1RWbYwl2vCd/7T8TqmG92g1MSVN8PVPlUvqCVxwrzz
	 HCSTN1ynxidqE05iNiENtHpyPdzvPcSSIk8wrl0gM2JI49L666fqrLlZ9qwBQu/Wsl
	 P5dIhwhfI8ZJ38jkbX/KYc+tDJj0woRMeFXGT+7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD1KmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgD1KmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:42:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D36206D9;
        Tue, 28 Apr 2020 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588070529;
        bh=CvEzbuCfH4+7PgmhF93OcCUlpgwCqTZYnfybiXHV8/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8saSke60GAMFfflqYFA1fvYiKEOXGCYpCXzaZ88cMJDx2OMK6q2ZgUl0aCzEbRQ1
         jrkgdfDk7TiAkNgrBjRO1Yxki5drTIwAQQOkOlF7iiCwEpWgttzO9NUvzU+m0DYyW9
         CoPKdTLtFrM+EXN6YP6eYb/XyjyVltLcmp4Dwr9g=
Date:   Tue, 28 Apr 2020 12:42:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-3] staging: rts5208: rtsx: Use balanced braces for
 if/else if blocks
Message-ID: <20200428104206.GA1131692@kroah.com>
References: <20200428102804.28795-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428102804.28795-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:28:04AM +0100, John Oldman wrote:
> Coding style issues


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
