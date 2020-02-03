Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B24C3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0EC20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580723748;
	bh=0oz4rNG3jjtawfvHWTDokHCv83TnzaSNGD1zVS/V4dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wAJpzUs1Wv8VooOivhpK111vLkjAr16nIXj/or/n076sIRyjonnHltO08ea/RyTIz
	 tq4lRlJSRMy7CJ8TUgDMDMWjO6RldI//DJbEV+JJ0KE5ixPJRA3iatn0Z+++Rcl65D
	 IG46EgBNcISX2tuEqWCQSJYGuVWTrx9Va89eTR6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBCJzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgBCJzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:55:47 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4655B20661;
        Mon,  3 Feb 2020 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580723405;
        bh=0oz4rNG3jjtawfvHWTDokHCv83TnzaSNGD1zVS/V4dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcT4St4kKU2H7JjnBVMcqbcCg0FspLM1F1Nl+i7C8clTuKXUIZN8Wi/OPJJBR6p5L
         tmu5abEVTbBoSJg6u1D6Pk5xx8mSQf5NEFbQ+IiN5BtI08fhDC6QsOroWVym7hKBkR
         PsV/M6Po4uYND5Syb/1M/uy1NlmlVDr9+zZeom+M=
Date:   Mon, 3 Feb 2020 09:50:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
Message-ID: <20200203095000.GB1721@willie-the-truck>
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131124531.623136425@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 01:45:31PM +0100, Peter Zijlstra wrote:
> In order to faciliate Will's READ_ONCE() patches:
> 
>   https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> 
> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> are tested using ARAnyM/68040.
> 
> Michael tested the previous version on his Atari Falcon/68030.
> 
> Build tested for sun3/coldfire.
> 
> Please consider!

Apart from the two written by me:

Acked-by: Will Deacon <will@kernel.org>

Cheers,

Will
