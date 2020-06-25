Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D029AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A96206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404742AbgFYMsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:48:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46500 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404125AbgFYMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:48:51 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1joRJ9-0001G3-Pm; Thu, 25 Jun 2020 12:48:48 +0000
Date:   Thu, 25 Jun 2020 14:48:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 3/3] nsproxy: support CLONE_NEWTIME with setns()
Message-ID: <20200625124846.xhwhzh5q4mqnra44@wittgenstein>
References: <20200619153559.724863-1-christian.brauner@ubuntu.com>
 <20200619153559.724863-4-christian.brauner@ubuntu.com>
 <20200625090618.GC151695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625090618.GC151695@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 02:06:18AM -0700, Andrei Vagin wrote:
> On Fri, Jun 19, 2020 at 05:35:59PM +0200, Christian Brauner wrote:
> > So far setns() was missing time namespace support. This was partially due
> > to it simply not being implemented but also because vdso_join_timens()
> > could still fail which made switching to multiple namespaces atomically
> > problematic. This is now fixed so support CLONE_NEWTIME with setns()
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Dmitry Safonov <dima@arista.com>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hi Christian,
> 
> I have reviewed this series and it looks good to me.
> 
> We decided to not change the return type of vdso_join_timens to avoid
> conflicts with the arm64 timens patchset. With this change, you can add
> my Reviewed-by to all patched in this series.
> 
> Reviewed-by: Andrei Vagin <avagin@gmail.com>

Thanks! As discussed in the thread for th arm changes. We'll defer the
return type changes!

Christian
