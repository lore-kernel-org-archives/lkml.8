Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F99C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B13217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391190AbgFSQP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:15:28 -0400
Received: from foss.arm.com ([217.140.110.172]:37096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391026AbgFSPDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:03:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11762B;
        Fri, 19 Jun 2020 08:03:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6E93F71F;
        Fri, 19 Jun 2020 08:03:33 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:03:31 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: qrtr: Migrate nameservice to kernel from
 userspace
Message-ID: <20200619150331.kk2gocn2jifwgxif@e107158-lin.cambridge.arm.com>
References: <20200213091427.13435-1-manivannan.sadhasivam@linaro.org>
 <20200213091427.13435-2-manivannan.sadhasivam@linaro.org>
 <20200616184805.k7eowfhdevasqite@e107158-lin.cambridge.arm.com>
 <9184F012-1FDC-4F6B-8B3E-5D2B87F5DACA@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9184F012-1FDC-4F6B-8B3E-5D2B87F5DACA@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 20:16, Manivannan Sadhasivam wrote:
> Hi, 
> 
> On 17 June 2020 12:18:06 AM IST, Qais Yousef <qais.yousef@arm.com> wrote:
> >Hi Manivannan, David
> >
> >On 02/13/20 14:44, Manivannan Sadhasivam wrote:
> >
> >[...]
> >
> >> +	trace_printk("advertising new server [%d:%x]@[%d:%d]\n",
> >> +		     srv->service, srv->instance, srv->node, srv->port);
> >
> >I can't tell exactly from the discussion whether this is the version
> >that got
> >merged into 5.7 or not, but it does match the commit message.
> >
> 
> This got merged and there was a follow up patch to replace trace_printk() with tracepoints got merged as well. 

Cool. Thanks!

--
Qais Yousef
