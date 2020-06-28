Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8174EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 19:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C368206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 19:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgF1TH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 15:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgF1TH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 15:07:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669E0204EA;
        Sun, 28 Jun 2020 19:07:57 +0000 (UTC)
Date:   Sun, 28 Jun 2020 15:07:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kbuild: introduce ccflags-remove-y and asflags-remove-y
Message-ID: <20200628150755.523fbb2c@oasis.local.home>
In-Reply-To: <20200628015041.1000002-1-masahiroy@kernel.org>
References: <20200628015041.1000002-1-masahiroy@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 10:50:41 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> CFLAGS_REMOVE_<file>.o works per object, that is, there is no
> convenient way to filter out flags for every object in a directory.
> 
> Add ccflags-remove-y and asflags-remove-y to make it easily.
> 
> Use ccflags-remove-y to clean up some Makefiles.
> 
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Nice feature!

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
