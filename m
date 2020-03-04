Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0178922522
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgCDLAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:00:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48581 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbgCDLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:00:21 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 17beebadd5720644; Wed, 4 Mar 2020 12:00:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 22/30] ACPI: OSL: Add missing annotation for acpi_os_acquire_lock()
Date:   Wed, 04 Mar 2020 12:00:19 +0100
Message-ID: <6715482.taCdthcxpl@kreacher>
In-Reply-To: <20200223231711.157699-23-jbi.octave@gmail.com>
References: <20200223231711.157699-23-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 24, 2020 12:17:03 AM CET Jules Irenge wrote:
> Sparse reports a warning at acpi_os_acquire_lock()
> 
> warning: context imbalance in acpi_os_acquire_lock() - unexpected unlock
> 
> The root cause is the missing annotation at acpi_os_acquire_lock()
> Add the missing annotation __acquires(lockp)
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/acpi/osl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 41168c027a5a..7094abc5ffc6 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1598,6 +1598,7 @@ void acpi_os_delete_lock(acpi_spinlock handle)
>   */
>  
>  acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
> +	__acquires(lockp)
>  {
>  	acpi_cpu_flags flags;
>  	spin_lock_irqsave(lockp, flags);
> 

Merged with the [23/30] and applied with modified subject and changelog as
5.7 material.

Thanks!




