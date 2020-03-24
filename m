Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8DCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FC62076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068175;
	bh=F5trW5ADWsv/2B2og+hJh/rRyTBedzD44xQ2ildnw6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SORlc+fnbpQjl3e3r6rR0VLyqNjVWZ/CXd3+ZSDNysc+319OJGOTtI32tHWP1EdKy
	 ga8WHeDMRgQnkqWQtVfSm7M6MyzHkIuANnzi+vCgi3n+05irmNXwomgQ0KaevLlqlR
	 AsCQPqvQYTiuuwDE1zY4ypoQtGWaWB8aPwennzOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCXQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgCXQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:42:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFA32076E;
        Tue, 24 Mar 2020 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585068174;
        bh=F5trW5ADWsv/2B2og+hJh/rRyTBedzD44xQ2ildnw6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvPkMF4EW43aTAYf7ebcRR12fM2r0IdNbhbwRi+5xTqVEr2O88zXQXwi4mMPZBA6M
         3sShx80ruCzBZnbrk9+AEFyBrMPeIS/qqytmK7su8MBAlHMz0SncJDlCDO6k4I3mq4
         74PWoLwRq6eF8NBzPO1QAyV6VgLeoyehNKz66MBg=
Date:   Tue, 24 Mar 2020 17:42:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 14/21] plist: Use CHECK_DATA_CORRUPTION instead of
 explicit {BUG,WARN}_ON()
Message-ID: <20200324164252.GD2518746@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-15-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-15-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:36PM +0000, Will Deacon wrote:
> CHECK_DATA_CORRUPTION() allows detected data corruption to result
> consistently in either a BUG() or a WARN() depending on
> CONFIG_BUG_ON_DATA_CORRUPTION.
> 
> Use CHECK_DATA_CORRUPTION() to report plist integrity checking failures,
> rather than explicit use of BUG_ON() and WARN_ON().
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
