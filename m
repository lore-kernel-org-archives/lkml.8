Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A841C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CEE24676
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBLThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLThx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:37:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE251206D7;
        Wed, 12 Feb 2020 19:37:52 +0000 (UTC)
Date:   Wed, 12 Feb 2020 14:37:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
Message-ID: <20200212143751.0114fe78@gandalf.local.home>
In-Reply-To: <CAKT=dDk+CiMQ_-f6Daa_ea2FOW=De6PKmcyiGrm4KEkVbH2fDQ@mail.gmail.com>
References: <20200211011631.7619-1-zzyiwei@google.com>
        <20200210211951.1633c7d0@rorschach.local.home>
        <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com>
        <20200210221521.59928416@rorschach.local.home>
        <CAKT=dDk+CiMQ_-f6Daa_ea2FOW=De6PKmcyiGrm4KEkVbH2fDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 11:26:08 -0800
Yiwei Zhang <zzyiwei@google.com> wrote:

> Hi Steven,
> 
> I can move the stuff out from the kernel/trace. Then can we still
> leave include/trace/events/gpu_mem.h where it is right now? Or do we
> have to move that out as well? Because we would need a non-drm common
> header place for the tracepoint so that downstream drivers can find
> the tracepoint definition.
> 

You can leave the header there. The include/trace/events/ is the place
to put trace event headers for common code.

It just did not belong in kernel/trace/

Thanks!

-- Steve
