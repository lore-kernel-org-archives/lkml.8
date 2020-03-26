Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFBC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E888F20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="JMnlHokU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCZV6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:58:52 -0400
Received: from ozlabs.org ([203.11.71.1]:52927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCZV6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:58:52 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 48pJls712Wz9sRR; Fri, 27 Mar 2020 08:58:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1585259929; bh=Sf69iWUNrMQgDwyFTyrEPmKhiAksHzMcJ+e9NXva9XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMnlHokUFLvdNAUyd3LZd3Bu/BGitZr+URsSji24FWeLJKpN20AGvD98ZM/pZh2wn
         pM23ZJ+sEfSZwPjY1jGmYzm/KRK+Ejotg3ffuSZlU1XICemP4Mb5DjWePlirfNXZkj
         SUcrwRH5JsENXTwMmZ+CDyLdRwUufCNMjIwkpxdbKzhnva9bSS4TtC4y4NTIvpaD1n
         z2+Zzp7g2WQk5Zxxpj9Mq2NCGM7e6ExKfZimRvVOnQ/1L1OsALeqfbNrh7r+KYdyMI
         yIZjZila19w9omhqFebV2SFHjF+LiLMHNWj6fA/7y8t5T4yGWIE6qhjw+9ZN/Ji5cG
         HMteGzZrU/vjQ==
Date:   Fri, 27 Mar 2020 08:40:05 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] ppc/smp: Replace unnecessary 'while' by 'if'
Message-ID: <20200326214005.GB9894@blackberry>
References: <20200326203752.497029-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326203752.497029-1-leonardo@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:37:52PM -0300, Leonardo Bras wrote:
> spin_until_cond() will wait until nmi_ipi_busy == false, and
> nmi_ipi_lock_start() does not seem to change nmi_ipi_busy, so there is
> no way this while will ever repeat.
> 
> Replace this 'while' by an 'if', so it does not look like it can repeat.

Nack, it can repeat.  The scenario is that cpu A is in this code,
inside spin_until_cond(); cpu B has previously set nmi_ipi_busy, and
cpu C is also waiting for nmi_ipi_busy to be cleared, like cpu A.
When cpu B clears nmi_ipi_busy, both cpu A and cpu C will see that and
will race inside nmi_ipi_lock_start().  One of them, say cpu C, will
take the lock and proceed to set nmi_ipi_busy and then call
nmi_ipi_unlock().  Then the other cpu (cpu A) will then take the lock
and return from nmi_ipi_lock_start() and find nmi_ipi_busy == true.
At that point it needs to go through the while loop body once more.

Paul.
