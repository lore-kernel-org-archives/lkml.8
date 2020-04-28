Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F9C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E20206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgD1OML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:12:11 -0400
Received: from foss.arm.com ([217.140.110.172]:52556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgD1OMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:12:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BA131B;
        Tue, 28 Apr 2020 07:12:10 -0700 (PDT)
Received: from bogus (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 667233F68F;
        Tue, 28 Apr 2020 07:12:09 -0700 (PDT)
Date:   Tue, 28 Apr 2020 15:11:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for
 and populating /firmware/ node
Message-ID: <20200428141148.GA11737@bogus>
References: <20200421173256.34897-1-sudeep.holla@arm.com>
 <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
 <20200423081149.GB18538@bogus>
 <2b2e29ec-ebbf-3ee6-acc9-3722a2fabbfb@linux.intel.com>
 <20200428083238.GA21288@bogus>
 <a583b842-585d-888e-49e5-32a16dfab8a6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a583b842-585d-888e-49e5-32a16dfab8a6@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:14:25AM -0500, Richard Gong wrote:
> Hi,
> 
> On 4/28/20 3:32 AM, Sudeep Holla wrote:
> > On Mon, Apr 27, 2020 at 02:12:56PM -0500, Richard Gong wrote:
> > > Hi Sudeep,
> > > 
> > > In our dts, firmware is not under root node. You can refer to
> > > arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi for details.
> > > 
> > > This is why we need check and populate firmware node.
> > > 
> > 
> > Ah that's bad. One of very few DTS I see firmware node not in the
> > root.
>
> Per the Devicetree Specification, there is no need to define firmware
> under the root node. Some examples are fsl-ls1012a.dtsi and
> hi6220-hikey.dts.
>

Yes I checked that before I replied, otherwise I would have asked to change
😉 

> > But this driver is the only one duplicating the code
> then Commit 3aa0582fdb82 should be extended to handle firmware which is
> not defined under the root node. I am not sure if it is doable.

I agree, I need to take a look at it again.

-- 
Regards,
Sudeep
