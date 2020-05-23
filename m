Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D61C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD4D206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590213446;
	bh=B+hznuKDFx6T7Au3LCjr/F3IeAwacylewB3yHhTyAlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bjUI4MmxN1yyUGCn2epbLdUElqRuyrhLBt0a3343gO3yfZIBhJDFpgF7y8s+lloBa
	 dNKcrnPTrw5ikZHBPCdH8HWgZ2KZzEgZSt+TuyoMgw29hgl5ucYFuN93WjDiWuZJ/R
	 i8DXGhBXq0LijiwAsuiqXecwvXgpfL58p8jXxCYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbgEWF5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 01:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387446AbgEWF5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 01:57:25 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E816206DD;
        Sat, 23 May 2020 05:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590213445;
        bh=B+hznuKDFx6T7Au3LCjr/F3IeAwacylewB3yHhTyAlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2tEJyVD5zZXvGZgtxeg3dC43GmuSLWjqsmlOUJToGAk9oxwiZ+BqaR6qYoWtDiJt
         5d5Ec1/FUR50t1VWh8OuzZsFUOy3ifsxAe4I3gWGNnsZObupbAU/eOij/QDMeNvJ4/
         nlQecWDhKdbVgFooMHlt07X26kppUPN7lTL1rcfs=
Date:   Sat, 23 May 2020 07:57:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
Message-ID: <20200523075720.64e24d11@coco.lan>
In-Reply-To: <20200523021928.67126-1-skhan@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Em Fri, 22 May 2020 20:19:28 -0600
Shuah Khan <skhan@linuxfoundation.org> escreveu:

> get_maintainer.pl picks only the first email address found in the file.
> Reorder my email addresses so it finds my linuxfoundation.org email.

Next time someone would run the ordering script again, this patch
would need to be re-applied.

Instead, why don't you just use a single e-mail at the maintainer's
entry and place the other one at the .mailmap file?

> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc0749810b0..dbad8b18bfe6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4404,8 +4404,8 @@ F:	include/linux/cpuidle.h
>  
>  CPU POWER MONITORING SUBSYSTEM
>  M:	Thomas Renninger <trenn@suse.com>
> -M:	Shuah Khan <shuah@kernel.org>
>  M:	Shuah Khan <skhan@linuxfoundation.org>
> +M:	Shuah Khan <shuah@kernel.org>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	tools/power/cpupower/
> @@ -9238,8 +9238,8 @@ F:	include/uapi/linux/sunrpc/
>  F:	net/sunrpc/
>  
>  KERNEL SELFTEST FRAMEWORK
> -M:	Shuah Khan <shuah@kernel.org>
>  M:	Shuah Khan <skhan@linuxfoundation.org>
> +M:	Shuah Khan <shuah@kernel.org>
>  L:	linux-kselftest@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
> @@ -17484,8 +17484,8 @@ F:	drivers/usb/common/usb-otg-fsm.c
>  
>  USB OVER IP DRIVER
>  M:	Valentina Manea <valentina.manea.m@gmail.com>
> -M:	Shuah Khan <shuah@kernel.org>
>  M:	Shuah Khan <skhan@linuxfoundation.org>
> +M:	Shuah Khan <shuah@kernel.org>
>  L:	linux-usb@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/usb/usbip_protocol.rst



Thanks,
Mauro
