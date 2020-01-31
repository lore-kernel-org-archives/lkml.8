Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B137C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE12082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgAaCiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgAaCiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:38:02 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0E02082E;
        Fri, 31 Jan 2020 02:38:00 +0000 (UTC)
Date:   Thu, 30 Jan 2020 21:37:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [GIT PULL] kconfig: localmodconfig: Minor clean ups to
 streamline_config.pl
Message-ID: <20200130213759.27aeeab9@rorschach.local.home>
In-Reply-To: <CAK7LNATryPUSTm8wPTFHO=E5f=sVPM4T0UxT=BF2qeyVehsH6Q@mail.gmail.com>
References: <20200130122221.30029e32@gandalf.local.home>
        <CAK7LNAR1AJFDahD6cB_MryBd-79N_T5O9WV3CMEA+HOCDXZEig@mail.gmail.com>
        <20200130143941.23a0e217@gandalf.local.home>
        <CAK7LNATryPUSTm8wPTFHO=E5f=sVPM4T0UxT=BF2qeyVehsH6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 11:08:59 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> Linus,
> 
> If you have not pulled this one yet,
> could you ignore it?

Ack, please ignore this pull request, Thanks!

-- Steve

> 
> 
> I will soon send pull requests for Kbuild + Kconfig,
> which includes the same patches.

