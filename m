Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE1FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D092A20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHXND1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:03:27 -0400
Received: from foss.arm.com ([217.140.110.172]:33588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgHXND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:03:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C5921FB;
        Mon, 24 Aug 2020 06:03:20 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E98B3F66B;
        Mon, 24 Aug 2020 06:03:19 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS, edac: Calxeda Highbank, handover maintenance
 to Andre Przywara
To:     Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200824124931.2933-1-rric@kernel.org>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <06bfa7db-5810-a184-a26c-add3fff9badf@arm.com>
Date:   Mon, 24 Aug 2020 14:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824124931.2933-1-rric@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2020 13:49, Robert Richter wrote:
> I do not have hardware anymore, nor there is ongoing development. So
> handover maintenance to Andre who already maintains the last
> remainings of Calxeda.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robert Richter <rric@kernel.org>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b7b0c1a24c8..6ed56e1a7d28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6148,7 +6148,7 @@ S:	Supported
>  F:	drivers/edac/bluefield_edac.c
>  
>  EDAC-CALXEDA
> -M:	Robert Richter <rric@kernel.org>
> +M:	Andre Przywara <andre.przywara@arm.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/highbank*
> 

