Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40DEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33DC2467E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCCAU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:20:27 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56936 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:20:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6F0632A436;
        Mon,  2 Mar 2020 19:20:24 -0500 (EST)
Date:   Tue, 3 Mar 2020 11:20:22 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 31/42] docs: scsi: convert scsi_mid_low_api.txt to ReST
In-Reply-To: <881e7741dfed5d6f5f73e1dfc2826b200b8604aa.1583136624.git.mchehab+huawei@kernel.org>
Message-ID: <alpine.LNX.2.22.394.2003031104580.12@nippy.intranet>
References: <cover.1583136624.git.mchehab+huawei@kernel.org> <881e7741dfed5d6f5f73e1dfc2826b200b8604aa.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020, Mauro Carvalho Chehab wrote:

> +			slave_alloc()
> +			slave_configure()
> +			    |
> +			slave_alloc()   ***
> +			slave_destroy() ***
> +
> +
> +    *** For scsi devices that the mid level tries to scan but do not
> +	respond, a slave_alloc(), slave_destroy() pair is called.
>  
>  If the LLD wants to adjust the default queue settings, it can invoke
>  scsi_change_queue_depth() in its slave_configure() routine.
>  
> -*** For scsi devices that the mid level tries to scan but do not
> -    respond, a slave_alloc(), slave_destroy() pair is called.
> -

Elsewhere in this series you have replaced asterisks with footnotes, as in 
[#]. Was that overlooked here?

BTW, certain patches in this series produce warnings from 'git am', that 
is, 'space before tab in indent'. Most of that whitespace appears to be 
intentional (for table formatting) or is pre-existing, but some seems to 
have been accidentally added...

$ git diff @~42.. | grep $'^[+].*\x20\x09'

Also, some of the patches in this series, like this one, were not Cc'd to 
the linux-scsi mailing list.
