Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F74C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D619206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQYKkvR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgG3J6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgG3J6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:58:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D843C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3r0Hn9iO5Act6f5eDm4E4OUK9iFb6mqTx6+phUYPKkk=; b=tQYKkvR6ZwUL3Xuxsj5Kds/awW
        D3bUco/lkYC7+zRTdvP07C4IFJx6uTDS8+7g3n/3XCrleViG/ZmNh3Vr0bztdYNvrZVvr2HwQC1DC
        hkjezQTrfSXQyJDElw+rRnoKft0ySGnZTNhbLOAosmuZDMinnRIiNTocEGBKCrgarGo9+xuqOcVmQ
        orVTXcARAA+/lsyNPLSzMikwu8c0CHRUECUIia5tHEy+VZcwNExe+QflEp6JWc/iZNSf85YpuRQ4z
        wWhHhEKMD4spNuwFf606mXkX5D9TtPDGV4H8tcfRmbm465BNuTsRWVrnam9YD4Nvu7wlgcEouICwU
        qgDsYA9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k15K7-00024j-9B; Thu, 30 Jul 2020 09:58:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B58A330066E;
        Thu, 30 Jul 2020 11:57:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A140E210ECD11; Thu, 30 Jul 2020 11:57:59 +0200 (CEST)
Date:   Thu, 30 Jul 2020 11:57:59 +0200
From:   peterz@infradead.org
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 2/4] objtool: Move orc outside of check
Message-ID: <20200730095759.GH2655@hirez.programming.kicks-ass.net>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-3-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730094143.27494-3-jthierry@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:41:41AM +0100, Julien Thierry wrote:
> +		if (file->elf->changed)
> +			return elf_write(file->elf);
> +		else
> +			return 0;
>  	}

I think we can do without that else :-)
