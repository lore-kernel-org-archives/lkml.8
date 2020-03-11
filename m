Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE9C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF9021655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgCKL1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:27:04 -0400
Received: from foss.arm.com ([217.140.110.172]:48358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKL1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:27:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ABAB1FB;
        Wed, 11 Mar 2020 04:27:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09383F6CF;
        Wed, 11 Mar 2020 04:27:02 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:27:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hoan Tran <hoan@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@os.amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
Message-ID: <20200311112700.GD3216816@arrakis.emea.arm.com>
References: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200206102340.GA17074@willie-the-truck>
 <c85dbc06-a72b-9c98-fe41-b25069114b2f@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85dbc06-a72b-9c98-fe41-b25069114b2f@os.amperecomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:01:19PM -0800, Hoan Tran wrote:
> Hi Will,
> 
> On 2/6/20 2:23 AM, Will Deacon wrote:
> > On Mon, Feb 03, 2020 at 11:55:14AM -0800, Hoan Tran wrote:
> > > Some NUMA nodes have memory ranges that span other nodes.
> > > Even though a pfn is valid and between a node's start and end pfns,
> > > it may not reside on that node.
> > > 
> > > This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
> > > this type of NUMA layout.
> > > 
> > > Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
> > > ---
> > >   arch/arm64/Kconfig | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index e688dfa..939d28f 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> > >   config HOLES_IN_ZONE
> > >   	def_bool y
> > > +# Some NUMA nodes have memory ranges that span other nodes.
> > > +# Even though a pfn is valid and between a node's start and end pfns,
> > > +# it may not reside on that node.
> > > +config NODES_SPAN_OTHER_NODES
> > > +	def_bool y
> > > +	depends on ACPI_NUMA
> > > +
> > 
> > I thought we agreed to do this in the core code?
> > 
> > https://lore.kernel.org/lkml/1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com
> 
> Yes, but it looks like Thomas didn't agree to apply this patch into
> x86.
> 
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de/

Was it a clear statement that such change will not make it to x86 or a
request for improving the patch or the description? I'd suggest you
update the x86 patch comment to include the rationale as per your reply
to Thomas and post a new version of the generic series. If Thomas (or
the mm folk) reject it again, we'll revisit the arm64-specific thread.

-- 
Catalin
