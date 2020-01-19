Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3DBC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3393A246B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579392430;
	bh=R4Rj5xaCoD2cEU5RSlC8uqyGpOVoasee2i1njuPxRzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WGkiWPso//RnUbhrATYbL5PNn7bt0SVTwgxLP3ZGEQZTwxJWlZGlg31bcGUpS7SeL
	 r3dNhRql5C4VgZJKT4Z0lwxSPaSQR9oAW2SKiOISt+syicUo5R5Qk+gR9YSfG2jVT8
	 dbIV5iOCcGcHIHOvi+tFIWG1cI9BaC3PaY+SffJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgASAHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgASAHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 19:07:05 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19248246A0;
        Sun, 19 Jan 2020 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579392424;
        bh=R4Rj5xaCoD2cEU5RSlC8uqyGpOVoasee2i1njuPxRzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=USnbHbj2WKtlIKa3Q8m5QRuMgWm/DDI3Mgbe8AdM/BBF8SOpvuA3WaNVkSXu2+lv7
         A6SNy2Eu6pUu5ATmAEQHCuthhYOf3QVldTIe2hjJfLrDCGKeaPptsOVoYrlYfgq9bv
         f/Gd5ggeVnhBoxQ73NqYfDqqCBm4UaGjWtLfrj6Y=
Date:   Sat, 18 Jan 2020 16:07:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        kirill@shutemov.name, yang.shi@linux.alibaba.com,
        thellstrom@vmware.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/5] mm/mremap.c: cleanup move_page_tables() a little
Message-Id: <20200118160702.9e5cc9f44ef855c070036331@linux-foundation.org>
In-Reply-To: <20200117232254.2792-1-richardw.yang@linux.intel.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020 07:22:49 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:

> move_page_tables() tries to move page table by PMD or PTE.
> 
> The root reason is if it tries to move PMD, both old and new range should
> be PMD aligned. But current code calculate old range and new range
> separately.  This leads to some redundant check and calculation.
> 
> This cleanup tries to consolidate the range check in one place to reduce
> some extra range handling.

Thanks, I grabbed these, aimed at 5.7-rc1.
