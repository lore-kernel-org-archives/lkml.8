Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F470C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA22B207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579602657;
	bh=m2TZeehd4HPkhbBqRD/zh5m873xVDQ+5aGttOrBjQ0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rmehgsqZNiggl7XUBkL58H0WPhO5ul0qHWJaQzm6QFsiDR6k2nURVJF3ym/vZU1HQ
	 W73T5hMXmOUTlITh857IjB8/6XWAhCiEb1YShTa4YEu/bBfZYwAaSo3Sp41h2yFMf0
	 bwAn9htxWzzi0/H+C8RX2LSNylCF4IeROEooIa94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAUKa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUKaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:30:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE2B620700;
        Tue, 21 Jan 2020 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579602655;
        bh=m2TZeehd4HPkhbBqRD/zh5m873xVDQ+5aGttOrBjQ0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2mzmvBEeEvcT2iFNTRAAwzrpYy2fdyk5chBvqELCWZS8je3dYlGeSAZ/OfSPK73AK
         vDq+zdLQnvz/YX2YLCc86dj69AtrApmhJ9U4O2DGmISlqGdQ1JnqXtNx3VP3Rg+Sq1
         igQoiuY9sF8TuGun7lIb5bLRlBpyuT5Ib6ux3YiQ=
Date:   Tue, 21 Jan 2020 10:30:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
Subject: Re: [RFC v5 56/57] arm64: entry: Avoid empty alternatives entries
Message-ID: <20200121103050.GD11154@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-57-jthierry@redhat.com>
 <20200109165145.GI3112@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109165145.GI3112@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:51:46PM +0000, Mark Rutland wrote:
> On Thu, Jan 09, 2020 at 04:02:59PM +0000, Julien Thierry wrote:
> > kernel_ventry will create alternative entries to potentially replace
> > 0 instructions with 0 instructions for EL1 vectors. While this does not
> > cause an issue, it pointlessly takes up some bytes in the alternatives
> > section.
> > 
> > Do not generate such entries.
> > 
> > Signed-off-by: Julien Thierry <jthierry@redhat.com>
> 
> This looks like a sensible cleanup on its own. FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

I'll pick this one up, thanks.

Will
