Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C4C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C4F2469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582809820;
	bh=3cMYy6F6o5W/jFM82opdF4vFXKTauV9YW5T6fsi3jz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LGqSHSM6zg9X7a7rc+3EbDrGcl63qr8Yb/w7q5UqDZ7lfVoGJkKAfskTe+CIPgoZ6
	 L5iUE54J76Wbf/6FBP2PRsUNlNv5FgUImiUkx2qzf8WLAUXWfYVrwylz/8xaOOYuQF
	 K4u+I3LPi0fJxdbmQ49S+QGrru0/U17scYuIw61A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgB0NXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgB0NXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:23:39 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7119921556;
        Thu, 27 Feb 2020 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582809818;
        bh=3cMYy6F6o5W/jFM82opdF4vFXKTauV9YW5T6fsi3jz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlsfxCYKxeYDFKohHbTPN3Bo4SDIivIsuayjpfewlHr6bsflQ/VOQtt81Wl3LSymH
         Lp6rD+4plmUhf3OazhngL1ftFRUyAuUpccYJfCOCAFPrdiY1xsbTiqUEeQe1qQm3pr
         4EfP2R4pwB8OvduC1EI693BpdXtw6C596n0olMO0=
Date:   Thu, 27 Feb 2020 14:23:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [GIT PULL] context_tracking: Remove TIF_NOHZ from 3 archs
Message-ID: <20200227132335.GE6075@lenoir>
References: <20200214152615.25447-1-frederic@kernel.org>
 <20200220151356.17637-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220151356.17637-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:13:56PM +0100, Frederic Weisbecker wrote:
> Ingo, Thomas,
> 
> Please pull the arch/nohz branch that can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	arch/nohz
> 

Ping?
