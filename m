Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F28C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE8E246A5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582845090;
	bh=NMVxdRyW7430xx8OHb0SuyAUzMc3aQvGxEHsdnsMvHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AVc+pWZS/sU3rvL1FBk1aTmkDPZBBH1yz7Ws1CDePR94uPMFvpTEEq8K9IyNK1iyZ
	 W156Q/iWalQmfI145Vx81+W/r/jezw3ijr0WUuvvr7++dN9aubr2E7UNzxUjQfY1Zk
	 CCgwUqf5h+I2H6LsLiL1ofNixUypDDosDWMTtYiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgB0XL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgB0XL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:11:29 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE93246A3;
        Thu, 27 Feb 2020 23:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582845089;
        bh=NMVxdRyW7430xx8OHb0SuyAUzMc3aQvGxEHsdnsMvHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Otg+LgVIC0ee/E0n2q2JTpD0TCn0ZBBbTB7xGNA5tn30fBbuub2gdCOGjY1tHxloJ
         hk8KIxX0cy76gnhh3Bg3gIUnWtks1dKRR0Nt5nqyYo/4lAu9qMudQloIrxDkQNt5RZ
         depdOCCEnLf6C5Z90wM9X7iAc8kM/zGQDdUJhuFc=
Date:   Fri, 28 Feb 2020 00:11:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200227231125.GE21795@lenoir>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.605144982@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225221305.605144982@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:08:05PM +0100, Thomas Gleixner wrote:
> Now that the C entry points are safe, move the irq flags tracing code into
> the entry helper.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
