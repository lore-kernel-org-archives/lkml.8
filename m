Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB2C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3520737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kiv1J97Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgCKUpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:45:46 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59510 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCKUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lWqnS0cz202pymudp+fi5S2BVavTcKkGDJBwh6JxRl4=; b=Kiv1J97Q8JPE8ZCa5dB851mFp
        W4a0looOhxyYJXowNd7RWtL2s5gl1JqNnoQpNvCjfnx3oMdzxjDkwALD0SK3hJMDW9r+E5netNRw2
        gTa6OnqbDYIr3mEoYzRUvgGElWRkLcCaqPqiInqHIk8QujnuQo+raQFv7Ltv+4td/t4Lk27id2OpA
        Ik1RbOzbuLpGG1Pcs/cOXF4/nX0Pfc+QXXQdwAmI7s0Jn92cKyosaw2vEwSHMfcQbJU/maS0+GPOw
        mA62cq5sKkvh3YDW3uKLukGmsWpKjwuufduP7KtP1o/E4TL0TQbGJsM8lsDNbDAXdsH/8B9TZjnw+
        OTd58mRnA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:51728)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jC8ET-0005Qw-MZ; Wed, 11 Mar 2020 20:45:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jC8EN-0005di-5m; Wed, 11 Mar 2020 20:45:31 +0000
Date:   Wed, 11 Mar 2020 20:45:31 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
Message-ID: <20200311204531.GU25745@shell.armlinux.org.uk>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <20200309164931.GA23889@roeck-us.net>
 <202003111020.D543B4332@keescook>
 <04a8c31a-3c43-3dcf-c9fd-82ba225a19f6@roeck-us.net>
 <202003111146.E3FC1924@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003111146.E3FC1924@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:47:20AM -0700, Kees Cook wrote:
> On Wed, Mar 11, 2020 at 11:31:13AM -0700, Guenter Roeck wrote:
> > On 3/11/20 10:21 AM, Kees Cook wrote:
> > > On Mon, Mar 09, 2020 at 09:49:31AM -0700, Guenter Roeck wrote:
> > >> On Thu, Dec 06, 2018 at 09:32:57AM +0100, Ard Biesheuvel wrote:
> > >>> On ARM, we currently only change the value of the stack canary when
> > >>> switching tasks if the kernel was built for UP. On SMP kernels, this
> > >>> is impossible since the stack canary value is obtained via a global
> > >>> symbol reference, which means
> > >>> a) all running tasks on all CPUs must use the same value
> > >>> b) we can only modify the value when no kernel stack frames are live
> > >>>    on any CPU, which is effectively never.
> > >>>
> > >>> So instead, use a GCC plugin to add a RTL pass that replaces each
> > >>> reference to the address of the __stack_chk_guard symbol with an
> > >>> expression that produces the address of the 'stack_canary' field
> > >>> that is added to struct thread_info. This way, each task will use
> > >>> its own randomized value.
> > >>>
> > >>> Cc: Russell King <linux@armlinux.org.uk>
> > >>> Cc: Kees Cook <keescook@chromium.org>
> > >>> Cc: Emese Revfy <re.emese@gmail.com>
> > >>> Cc: Arnd Bergmann <arnd@arndb.de>
> > >>> Cc: Laura Abbott <labbott@redhat.com>
> > >>> Cc: kernel-hardening@lists.openwall.com
> > >>> Acked-by: Nicolas Pitre <nico@linaro.org>
> > >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >>
> > >> Since this patch is in the tree, cc-option no longer works on
> > >> the arm architecture if CONFIG_STACKPROTECTOR_PER_TASK is enabled.
> > >>
> > >> Any idea how to fix that ? 
> > > 
> > > I thought Arnd sent a patch to fix it and it got picked up?
> > > 
> > 
> > Yes, but the fix is not upstream (it is only in -next), and I missed it.
> 
> Ah, yes, I found it again now too; it went through rmk's tree.
> 
> For thread posterity:
> 
> ARM: 8961/2: Fix Kbuild issue caused by per-task stack protector GCC plugin
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8961/2

It's in my fixes branch, waiting for me to do my (now usual) push
of fixes to Linus.

I'm not sure whether the above discussion is suggesting that there's
a problem with this patch, or whether it's trying to encourage me
to send it up to Linus.  I _think_ there's the suggestion that it
causes a regression, hmm?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
