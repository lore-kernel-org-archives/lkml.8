Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6B8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0DD207EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599127943;
	bh=2F8Sftn0TzNaRjueUQEfuF/9mW8ur/5mCYKJYptfj+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d77HDL8Lf7Z0/6n7liTSE4m1fdtP+PstDqtC5xp2uIci7633pOxPeZcvy9BoeddKB
	 s0StTIZ6kyalF5VRn1A9ZwmKPaDete/wga6p7e7R2Rc/I4veKWVCcdL95xiAeGrqYw
	 Zu/8xnF9jhnYsoaJSgEjoAy5PASc3Ny0Rr5OelZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgICKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICKMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:12:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B5F20767;
        Thu,  3 Sep 2020 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599127936;
        bh=2F8Sftn0TzNaRjueUQEfuF/9mW8ur/5mCYKJYptfj+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zWPwcuSwHqTM741dmhtXPm6Fk9sZgDiLLVtQgGjxAPWAfenaMD8jwEd5pzMqv0W0a
         wUaY76eeG4NWRdhWYBn1R2i7rGINVA6O9PzF1coba7hHEXc8hwkjRMbJs6furkST0U
         aS6iNbP9PGqr/yL1tCBL7D55MhUTyc7DaVrPji/k=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDmE2-008rL1-U8; Thu, 03 Sep 2020 11:12:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 03 Sep 2020 11:12:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     zc <zoucao@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [PATCH] irqchip/gic-v3: change gic_data into gic_v3_data
In-Reply-To: <69118106-e6d8-71dc-7004-80fd96b32e54@linux.alibaba.com>
References: <1599124088-80231-1-git-send-email-zoucao@linux.alibaba.com>
 <c6eacce9e0990239ee12bfc5826fe2c6@kernel.org>
 <69118106-e6d8-71dc-7004-80fd96b32e54@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <b286343d4a17afea491c195920ca0c5d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zoucao@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 11:05, zc wrote:
>   thank for you reply.
> 
> 
>    of course it won't,   i just think it is better to splite the
> global data between irq-gic and irq-gic-v3.
> 
> I wrote some hook module for gic,  kallsyms_lookup_name can't support
> for mutlipte symbol,
> 
> i need to call kallsyms scan to get the addr.

Why would you need to hook into the GIC data?

>   If you think it isn't necessary, well for me.

I don't think it is necessary for mainline to work correctly,
and I don't understand what you are trying to achieve with this
"hook module".

If you could explain what you are trying to do and why you are
doing it, maybe we can come up with something. But I don't
think blindly repainting symbol names is a sensible course of
action.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
