Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C470C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6677C207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mP8NX0pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgE0KeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:34:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgE0KeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ZMb7ayskfYmUMDD9vA/QW3XXA6gbYOmgUP9dQQUd5U=; b=mP8NX0puwAj0/ZU6+jWX/0WQ3e
        8ygp9uA3lrNb4s3vGm00FjArWHocZnsNIRCZ4XB4DwqarHYo/Cs2MWU6GDuB3mmwmYzD43iHHL9cA
        x2SB+T0aw3iNHL5ZflXtVA7xWGHZi+yFYohUH89W51GojX3uyfRT8AJHdCKkFDxiNrSZXiXLGfOEf
        GKZ2Lc+1zS6NBRgmh8XsYqT3QlJVdX17eBX9UAepbGAV06PgsW87eHEZvnKH3q91j2Zp3Vsz1XxeH
        arsw0vw7sEkXS+RVmXZo8KiZz08FACCrhtvcF+F4JlIuvhx3vSWPMEUgT7Ji2XXWvWRYWzrLd3HmG
        AgV/5NfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdtLh-000180-96; Wed, 27 May 2020 10:31:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88892300478;
        Wed, 27 May 2020 12:31:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 689CB2BD9C2B9; Wed, 27 May 2020 12:31:47 +0200 (CEST)
Date:   Wed, 27 May 2020 12:31:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        Andi Kleen <ak@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] x86: Pin cr4 FSGSBASE
Message-ID: <20200527103147.GI325280@hirez.programming.kicks-ass.net>
References: <20200526052848.605423-1-andi@firstfloor.org>
 <202005260935.EB11D3EB7@keescook>
 <20200526231423.qcsolcpll534sgro@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526231423.qcsolcpll534sgro@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:14:25PM -0700, Andi Kleen wrote:
> > And if this is going to be more permanent, we can separate the mask
> > (untested):
> 
> The FSGSBASE one should not be permanent, it will be replaced
> with the full FSGSBASE patches that set that bit correctly.

Well, even with full FSGSBASE patches on, that CR4 bit should never get
changed after boot.
