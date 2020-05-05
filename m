Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CDBC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B2120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ouq0b8PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgEEOTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729830AbgEEOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:19:16 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3FC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R8fDfWX4P2yPJD6o/XlgPtCXLkbf9HDss4RsKImeIag=; b=Ouq0b8POa+V6ud1wBnYKlX0dS
        wYGr2eLWM5FQKt3psQSL1XN9/B3gzkSH5YDPNfPwBKnwZ2FOOLq6Cq2vL/KNmE24rOcLmlMlgFxw+
        xj9PY7GJ1O9xEw295rSgrAf2h7jjhS1WlJGfuc0qb20+sEK8Euwi5kTUYvBhq98iLqC6kd9adobbS
        Z1cb9vXBAodizzUU5JMA1atSzxb6O5u0Pw6G1LaqcmPabwTstOXOoJbSQswsZiYfV5CDEJG6NLZfw
        GG3fTFhwGb2jFQOCuIDQRAKPFZNm64jN3O3uAUOdMudEvjkRc0bH+5AN5yPS/LqaU1Uf3uyuSQosm
        +feM8msHg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:54052)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jVyPd-0002rZ-5d; Tue, 05 May 2020 15:19:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jVyPc-0007DZ-9d; Tue, 05 May 2020 15:19:08 +0100
Date:   Tue, 5 May 2020 15:19:08 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: use ARM unwinder for gcov
Message-ID: <20200505141908.GH1551@shell.armlinux.org.uk>
References: <20200505141218.684079-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505141218.684079-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:11:56PM +0200, Arnd Bergmann wrote:
> Using gcov on ARM fails when the frame pointer unwinder is used:
> 
> arm-linux-gnueabi-ld: kernel/softirq.o:(.ARM.exidx+0x120): undefined reference to `__aeabi_unwind_cpp_pr0'
> arm-linux-gnueabi-ld: init/main.o:(.ARM.exidx+0x98): undefined reference to `__aeabi_unwind_cpp_pr0'
> arm-linux-gnueabi-ld: init/version.o:(.ARM.exidx+0x0): undefined reference to `__aeabi_unwind_cpp_pr0'
> arm-linux-gnueabi-ld: init/do_mounts.o:(.ARM.exidx+0x28): undefined reference to `__aeabi_unwind_cpp_pr0'
> arm-linux-gnueabi-ld: init/do_mounts_initrd.o:(.ARM.exidx+0x0): undefined reference to `__aeabi_unwind_cpp_pr0'
> arm-linux-gnueabi-ld: init/initramfs.o:(.ARM.exidx+0x8): more undefined references to `__aeabi_unwind_cpp_pr0' follow
> 
> This is likely a bug in clang that should be fixed in the compiler.
> Forcing the use of the ARM unwinder in this configuration however
> works around the problem.

Or should the stub functions in arch/arm/kernel/unwind.c be moved out?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
