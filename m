Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5570C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84F9246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582843960;
	bh=FZz4dZKRW22gd+R5IdLVCLPgZQsd/7VJDFmarAZHaVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hPDszsW4ncKeguIk043+6oX9vDP7eU/fkUO9IAyd8JmH1DbP69LdrADLOLv0YHbCU
	 bzy1BVVtQZ3BX00wV7k6wVQKV/AXV3f2oR0FL99RbFZUIWyP4CZ6SJmxtXbk2V6Kgv
	 VL2DkFNALhEghk61aCK0xwCwADs6cMhq/wrrB6DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgB0Wwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbgB0Wwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:52:39 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4051C2469F;
        Thu, 27 Feb 2020 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582843958;
        bh=FZz4dZKRW22gd+R5IdLVCLPgZQsd/7VJDFmarAZHaVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epu6IjIl5CxdlkGUd0JKIJZHlDdSIJkxI+0KgbjsBEmAfCL7aeaz/eeAc0hbV8OFl
         0JxMmqBzQKV0lTulnZx3wiVQeN2pQejMFxTJgXKkJT5tMPrsz3eVV8pKXnm2Ue+7nf
         2yWTNrQM4cb5ljT5GYnRghM8Ka2qHa9TupS6mprY=
Date:   Thu, 27 Feb 2020 23:52:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 2/8] x86/entry/common: Consolidate syscall entry code
Message-ID: <20200227225235.GD21795@lenoir>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.390667997@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225221305.390667997@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:08:03PM +0100, Thomas Gleixner wrote:
> All syscall entry points call enter_from_user_mode() and
> local_irq_enable(). Move that into an inline helper so the interrupt
> tracing can be moved into that helper later instead of sprinkling
> it all over the place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
