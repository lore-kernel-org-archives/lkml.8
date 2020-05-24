Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B75020823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590320799;
	bh=t6FPAdbmqROUcprpTUToZ+d/YaWfRUyQrPNoUSm1fAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OwnrDxQFyO2XEC2EgvW85ADsAjsm+sLPyRabVV6adxxVW2kMDl34T30Tv7E6ZJuNt
	 vxkYvBYf2fTWLqWNMbAmn9KOJxNI/ysbwXUEVCt3wn3OymLdMRbdJi9skv4S4EgblE
	 0B/0l456d+wa2T+PCi6WFrKpsbV+aE/+yBCyr79c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgEXLqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 07:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgEXLqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:46:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B5B2075F;
        Sun, 24 May 2020 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590320797;
        bh=t6FPAdbmqROUcprpTUToZ+d/YaWfRUyQrPNoUSm1fAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cqN2XUbILAoV9pd917Y0YLJE2EmAh1kSZaKzNlmUo2iDeQEhrEZh5RrBbzcZ79TOp
         6VkATfU0PrHNKD2uf/XSWvnFhWpWpNI1qyOabp3zd1F7bziXsZK5Ojb85tFeb6CiL+
         p9RJ69/W0dJKyj2scd7LS2AO2NSS0VVdguLH3lf4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jcp5P-00Ewm3-R2; Sun, 24 May 2020 12:46:36 +0100
Date:   Sun, 24 May 2020 12:46:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/irqchip: Remove function callback casts
Message-ID: <20200524124634.113203f6@why>
In-Reply-To: <20200524080910.13087-1-oscar.carter@gmx.com>
References: <20200524080910.13087-1-oscar.carter@gmx.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: oscar.carter@gmx.com, keescook@chromium.org, tglx@linutronix.de, jason@lakedaemon.net, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020 10:09:10 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

Hi Oscar,

Thanks for this. Comments below.

> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, remove all the function callback
> casts.
> 
> To do this, modify the IRQCHIP_ACPI_DECLARE macro initializing the
> acpi_probe_entry struct directly instead of use the existent macro
> ACPI_DECLARE_PROBE_ENTRY.
> 
> In this new initialization use the probe_subtbl field instead of the
> probe_table field use in the ACPI_DECLARE_PROBE_ENTRY macro.

Please add *why* this is a valid transformation (probe_table and
probe_subtbl are part of a union).

> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  include/linux/irqchip.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> index 950e4b2458f0..1f464fd10df0 100644
> --- a/include/linux/irqchip.h
> +++ b/include/linux/irqchip.h
> @@ -39,8 +39,14 @@
>   * @fn: initialization function
>   */
>  #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
> -	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
> -				 subtable, validate, data, fn)
> +	static const struct acpi_probe_entry __acpi_probe_##name	\
> +		__used __section(__irqchip_acpi_probe_table) = {	\
> +			.id = ACPI_SIG_MADT,				\
> +			.type = subtable,				\
> +			.subtable_valid = validate,			\
> +			.probe_subtbl = (acpi_tbl_entry_handler)fn,	\
> +			.driver_data = data,				\
> +		}
> 

I'd rather you add an ACPI_DECLARE_SUBTABLE_PROBE_ENTRY to acpi.h, and
use that here so that we can keep the ACPI gunk in a single place.

>  #ifdef CONFIG_IRQCHIP
>  void irqchip_init(void);
> --
> 2.20.1
> 
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
