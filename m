Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F37DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774A521841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEHPh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbgEHPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:37:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B1424953;
        Fri,  8 May 2020 15:37:08 +0000 (UTC)
Date:   Fri, 8 May 2020 11:37:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508113707.3af3fce7@gandalf.local.home>
In-Reply-To: <20200508021438.4373-1-mcgrof@kernel.org>
References: <20200508021438.4373-1-mcgrof@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 02:14:38 +0000
Luis Chamberlain <mcgrof@kernel.org> wrote:

> The new helper module_firmware_crashed() uses LOCKDEP_STILL_OK as
> this fact should in no way shape or form affect lockdep. This taint
> is device driver specific.

Looks fine to me.

-- Steve
