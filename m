Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EA9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADD020787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589805242;
	bh=HaY3ABwfaRO6UoNgRn0bHMV0yl53SNp5iJWDXXT9BPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AhAdB0fhI7yoB5YifclgaGdSRP+77bT4SxqDkh/YNBZepDavjdUBKtBURfJubz+OS
	 hwMuhmasWg/b1F+LFILVKe47SDL+dPVCdPbiQIxKDfbkOSWecVU2+ZmiyCVAHeOJBJ
	 M/OqOorPF/p3APoOyEToujVVpmYvCtmjShJG6q6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERMeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgERMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:34:01 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB34120657;
        Mon, 18 May 2020 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589805241;
        bh=HaY3ABwfaRO6UoNgRn0bHMV0yl53SNp5iJWDXXT9BPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTIot6i8i/rMUu0LpUwSA3/CrD7rN47ZuKU6rxdlLVSiHIcM4AwgItpxYOm5FRAdE
         UvUVqk/hAy+Bs68TL8l4zuCqxQ+T14akon6FrWCNabDo+pcMTKl4FknUqHoyiaMlw6
         bQaPVtCUPUJwMwSjsWTui942qqdacj4+qW1OzIfk=
Date:   Mon, 18 May 2020 08:33:59 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200518123359.GB33628@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org>
 <20200518061836.GA15641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200518061836.GA15641@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 11:18:36PM -0700, Christoph Hellwig wrote:
>On Mon, May 11, 2020 at 12:52:53AM -0400, Sasha Levin wrote:
>> Benefits:
>> Currently a user process that wishes to read or write the FS/GS base must
>> make a system call. But recent X86 processors have added new instructions
>> for use in 64-bit mode that allow direct access to the FS and GS segment
>> base addresses.  The operating system controls whether applications can
>> use these instructions with a %cr4 control bit.
>>
>> In addition to benefits to applications, performance improvements to the
>> OS context switch code are possible by making use of these instructions. A
>> third party reported out promising performance numbers out of their
>> initial benchmarking of the previous version of this patch series [9].
>
>The [9] reference can't be resolved anywhere in this mail.

Sorry, I'll fix it up. The reference was supposed to be pointing to:

	https://www.phoronix.com/scan.php?page=article&item=linux-wip-fsgsbase&num=1

-- 
Thanks,
Sasha
