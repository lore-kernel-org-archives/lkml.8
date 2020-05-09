Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A5EC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF22217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgEIJfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:35:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45888 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEIJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:35:25 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 50d46019d67d5f50; Sat, 9 May 2020 11:35:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ACPI: debug: Make two functions static
Date:   Sat, 09 May 2020 11:35:22 +0200
Message-ID: <11439051.xyQN3uvUWn@kreacher>
In-Reply-To: <20200507070736.25418-1-zhengzengkai@huawei.com>
References: <20200507070736.25418-1-zhengzengkai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 7, 2020 9:07:36 AM CEST Zheng Zengkai wrote:
> Fix sparse warnings:
> 
> drivers/acpi/acpi_dbg.c:748:12: warning:
>  symbol 'acpi_aml_init' was not declared. Should it be static?
> drivers/acpi/acpi_dbg.c:774:13: warning:
>  symbol 'acpi_aml_exit' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
>  drivers/acpi/acpi_dbg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index 7a265c2171c0..6041974c7627 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -745,7 +745,7 @@ static const struct acpi_debugger_ops acpi_aml_debugger = {
>  	.notify_command_complete = acpi_aml_notify_command_complete,
>  };
>  
> -int __init acpi_aml_init(void)
> +static int __init acpi_aml_init(void)
>  {
>  	int ret;
>  
> @@ -771,7 +771,7 @@ int __init acpi_aml_init(void)
>  	return 0;
>  }
>  
> -void __exit acpi_aml_exit(void)
> +static void __exit acpi_aml_exit(void)
>  {
>  	if (acpi_aml_initialized) {
>  		acpi_unregister_debugger(&acpi_aml_debugger);
> 

Applied as 5.8 material, thanks!




