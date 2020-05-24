Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311A5207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590337005;
	bh=5rzhJWqGS7NxsVv+AenK5F0yLsoR3FozPAo0q/n1BlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ByGe/uraIsjIcMggGLJQLdjIRgH8jgvsgIylRM5S8UCyGuqyF+kL9qVglt5Y9yrAJ
	 CuKAu4XYBOf5z4jCvwFz5Prkg09boZihZjbcgSKuxcRj/z5cAs7OOo76xaGEmRW06D
	 0fBLg/6T1AyrADrIX9vM82xVfuqL+9FK4GQaZ8H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgEXQQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 12:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgEXQQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:16:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4CF20776;
        Sun, 24 May 2020 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590337003;
        bh=5rzhJWqGS7NxsVv+AenK5F0yLsoR3FozPAo0q/n1BlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zxw/yjuEnd1TJ34Mmso2+2K+95mZ9xIe13l8Vu7CAlN609PuYXCMGSEG21mTX/Lo1
         BYVNx00q+409RPowbZmgVVHUJTDFF2KWvSJkuOuEoP/2RXZfoCDs5W7iY0TD6/LOPp
         o6T2sYn5scy0oil03GuFNkGqL9dhVxd3eTkSDNl4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jctIn-00Eya2-Hv; Sun, 24 May 2020 17:16:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 24 May 2020 17:16:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/irqchip: Remove function callback casts
In-Reply-To: <20200524160626.GA30346@ubuntu>
References: <20200524080910.13087-1-oscar.carter@gmx.com>
 <20200524124634.113203f6@why> <20200524160626.GA30346@ubuntu>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b0bd9442c1ba63c38d25ade479885cbd@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: oscar.carter@gmx.com, keescook@chromium.org, tglx@linutronix.de, jason@lakedaemon.net, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24 17:06, Oscar Carter wrote:
> Hi Marc,
> 
> On Sun, May 24, 2020 at 12:46:34PM +0100, Marc Zyngier wrote:
>> On Sun, 24 May 2020 10:09:10 +0200
>> Oscar Carter <oscar.carter@gmx.com> wrote:
>> 
>> Hi Oscar,
>> 
>> Thanks for this. Comments below.
>> 
>> > In an effort to enable -Wcast-function-type in the top-level Makefile to
>> > support Control Flow Integrity builds, remove all the function callback
>> > casts.
>> >
>> > To do this, modify the IRQCHIP_ACPI_DECLARE macro initializing the
>> > acpi_probe_entry struct directly instead of use the existent macro
>> > ACPI_DECLARE_PROBE_ENTRY.
>> >
>> > In this new initialization use the probe_subtbl field instead of the
>> > probe_table field use in the ACPI_DECLARE_PROBE_ENTRY macro.
>> 
>> Please add *why* this is a valid transformation (probe_table and
>> probe_subtbl are part of a union).
> 
> Ok, I will add a more detailed explanation.
> 
>> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
>> > ---
>> >  include/linux/irqchip.h | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
>> > index 950e4b2458f0..1f464fd10df0 100644
>> > --- a/include/linux/irqchip.h
>> > +++ b/include/linux/irqchip.h
>> > @@ -39,8 +39,14 @@
>> >   * @fn: initialization function
>> >   */
>> >  #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
>> > -	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
>> > -				 subtable, validate, data, fn)
>> > +	static const struct acpi_probe_entry __acpi_probe_##name	\
>> > +		__used __section(__irqchip_acpi_probe_table) = {	\
>> > +			.id = ACPI_SIG_MADT,				\
>> > +			.type = subtable,				\
>> > +			.subtable_valid = validate,			\
>> > +			.probe_subtbl = (acpi_tbl_entry_handler)fn,	\
>> > +			.driver_data = data,				\
>> > +		}
>> >
>> 
>> I'd rather you add an ACPI_DECLARE_SUBTABLE_PROBE_ENTRY to acpi.h, and
>> use that here so that we can keep the ACPI gunk in a single place.
> 
> Ok, I will do the changes you suggested and I will resend a new 
> version.
> Later, I will also send a series to clean up the checkpatch warnings 
> and
> errors for the acpi.h header.

Not necessarily a good idea. Churn for the sake of keeping checkpatch
at bay is pretty pointless. Do fix bugs if you spot any, but please
exercise judgement.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
