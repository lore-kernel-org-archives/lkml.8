Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF60C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A198421BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894888AbgDPNKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894835AbgDPNJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:09:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86024214AF;
        Thu, 16 Apr 2020 13:09:53 +0000 (UTC)
Date:   Thu, 16 Apr 2020 09:09:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <ellerman@au1.ibm.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC] seq_buf: Export symbols to external modules
Message-ID: <20200416090951.6f74b0c8@gandalf.local.home>
In-Reply-To: <20200416035124.549067-1-vaibhav@linux.ibm.com>
References: <20200416035124.549067-1-vaibhav@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 09:21:24 +0530
Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> 'seq_buf' provides a very useful abstraction for writing to a string
> buffer without needing to worry about it over-flowing. However even
> though the API has been stable for couple of years now its stills not
> exported to external modules limiting its usage.
> 
> Hence this patch proposes update to 'seq_buf.c' to mark all functions
> seq_buf_X() which are part of the seq_seq API to be exported to
> external GPL modules.
> 
> Earlier work:
> There was an earlier proposal by Borislav Petkov <bp@alien8.de> to
> export seq_buf_printf() to modules at [1], as part of his EDAC
> patch-set "EDAC, mce_amd: Add a tracepoint for the decoded
> error". However the proposed patch was never merged and its fate is
> unknown as I couldn't locate any subsequent discussion as to why patch
> in [1] was dropped.
> 
> References:
> [1]: https://lore.kernel.org/lkml/20170825102411.8682-5-bp@alien8.de/
> [2]: https://lore.kernel.org/lkml/20170825092757.434f1eda@gandalf.local.home/
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  lib/seq_buf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
>

I'm perfectly fine with this change, but recently there's been a lot of
discussion about doing something like this for out-of-tree modules. Is
there going to be a use case for in tree modules for this? It will make the
case much easier to get this accepted.

-- Steve
