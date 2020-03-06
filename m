Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519F1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3039E2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCFQpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:45:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C451C2072A;
        Fri,  6 Mar 2020 16:45:35 +0000 (UTC)
Date:   Fri, 6 Mar 2020 11:45:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with
 -C option
Message-ID: <20200306114534.63319731@gandalf.local.home>
In-Reply-To: <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
References: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
        <158338818292.25448.7161196505598269976.stgit@devnote2>
        <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 08:52:40 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> CC +kbuild, -stable

Thank you, as these are kbuild specific changes and not bootconfig (as
building anything in tools doesn't work here with top level O= command).

Masami, any patches you send for this, they should go to the kbuild
maintainers.

-- Steve

