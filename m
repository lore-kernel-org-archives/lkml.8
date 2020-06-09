Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD19C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05E9207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgFIF3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:29:19 -0400
Received: from ozlabs.org ([203.11.71.1]:38845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgFIF3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:29:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzFF26KKz9sTl; Tue,  9 Jun 2020 15:29:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Bharata B Rao <bharata@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200402195156.626430-1-leonardo@linux.ibm.com>
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after reboot on pseries guests
Message-Id: <159168034470.1381411.12073746896730178123.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:29:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 16:51:57 -0300, Leonardo Bras wrote:
> While providing guests, it's desirable to resize it's memory on demand.
> 
> By now, it's possible to do so by creating a guest with a small base
> memory, hot-plugging all the rest, and using 'movable_node' kernel
> command-line parameter, which puts all hot-plugged memory in
> ZONE_MOVABLE, allowing it to be removed whenever needed.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kernel: Enables memory hot-remove after reboot on pseries guests
      https://git.kernel.org/powerpc/c/b6eca183e23e7a6625a0d2cdb806b7cd1abcd2d2

cheers
