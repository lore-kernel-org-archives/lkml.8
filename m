Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA1EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2873D207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHTU1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgHTU1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:27:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9BE207BB;
        Thu, 20 Aug 2020 20:27:40 +0000 (UTC)
Date:   Thu, 20 Aug 2020 16:27:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peiyong Lin <lpy@google.com>
Cc:     amit.kucheria@linaro.org, android-kernel@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paul.walmsley@sifive.com, pavel@ucw.cz,
        prahladk@google.com, rafael.j.wysocki@intel.com,
        ulf.hansson@linaro.org, yamada.masahiro@socionext.com,
        zzyiwei@android.com, sidaths@google.com
Subject: Re: [PATCH v3] Add power/gpu_frequency tracepoint.
Message-ID: <20200820162738.33053904@oasis.local.home>
In-Reply-To: <20200820194134.2176242-1-lpy@google.com>
References: <20200813175037.48a16064@oasis.local.home>
        <20200820194134.2176242-1-lpy@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 12:41:34 -0700
Peiyong Lin <lpy@google.com> wrote:

> Historically there is no common trace event for GPU frequency, in
> downstream Android each different hardware vendor implements their own
> way to expose GPU frequency, for example as a debugfs node.  This patch
> standardize it as a common trace event in upstream linux kernel to help
> the ecosystem have a common implementation across hardware vendors.
> Toolings in the Linux ecosystem will benefit from this especially in the
> downstream Android, where this information is critical to graphics
> developers.
> 
> Signed-off-by: Peiyong Lin <lpy@google.com>

Just from the tracing point of view (not from the content of the trace
point of view).

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
