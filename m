Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64838C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3E20810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592336587;
	bh=4opddBx1OaE34iQ/v5+Xpl7I6itVGPI8xn9MndRWZ3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U3mYIFW9UsTNDrw45KmoV+LDF7V/zxwVoA+13lbnpTBucgxy32c/tJSGRmZdJQqG+
	 nWFHZPJlV2xKqs6S4nZFd7KxoTrHffI1ftT/l3myi5LcT3qPq7ldni+stjFEWMsIZq
	 BcLFAwJUmaQWVAn8yqyFbieMYEas8UV8AZbn4WQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgFPTnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgFPTnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:43:05 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB99C208C3;
        Tue, 16 Jun 2020 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592336585;
        bh=4opddBx1OaE34iQ/v5+Xpl7I6itVGPI8xn9MndRWZ3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zZn0AlQAZEerM5YU025XmSMmwOjA1q5/ZWfpj9XaIvSPU63Tq6hdqwVRc5CtXUVVR
         pMNXT4aMqpj2GSENieOni8xfcTAzWN28ku+hf2rz998z/l1Xi/mMCePv3Pbg8PWu+N
         reE5D3WTgC3m+Sd4QbvHA4fd31flQqI8pjt6gAhU=
Date:   Tue, 16 Jun 2020 12:43:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] powerpc/8xx: use pmd_off() to access a PMD entry in
 pte_update()
Message-Id: <20200616124304.bbe36933fcd48c5f467f4be9@linux-foundation.org>
In-Reply-To: <20200615092229.23142-1-rppt@kernel.org>
References: <20200615092229.23142-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 12:22:29 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The pte_update() implementation for PPC_8xx unfolds page table from the PGD
> level to access a PMD entry. Since 8xx has only 2-level page table this can
> be simplified with pmd_off() shortcut.
> 
> Replace explicit unfolding with pmd_off() and drop defines of pgd_index()
> and pgd_offset() that are no longer needed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> I think it's powerpc material, but I won't mind if Andrew picks it up :)

Via the powerpc tree would be better, please.
