Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A99FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78FA20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598302770;
	bh=4+0iQbpq05lWO5uaP5s74XH/C6aQ3ITZkVphPS3p7ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OjAhVdI2JnsRCh6pCayD7vjArCgs+kVO/XxMUs8smYgPOCt7buH08GzUC64BishOd
	 Sb8ux7IA6bGAWs5BdYcJjK7vxC1CVWUlgdBaWRcwqWrFHABHGv5/OsnjOJdyNaW43Z
	 EUtKo46maeo3Fr6hlN9smobczReMDlqVSIg2Ac5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXU73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:59:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DFBD2067C;
        Mon, 24 Aug 2020 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598302765;
        bh=4+0iQbpq05lWO5uaP5s74XH/C6aQ3ITZkVphPS3p7ss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B25I8koMGssHnexX/OyD91/GVSd1cU2haDLC4bxbiNAuPpfnviIXV89tPBjDUF0u0
         J1UgRrf0rRVYYm2iY2kE+PyVwDdP2JOkrrIUdVOojBS1gisoZtt9euTQRoBqTHL94D
         ptOp5ZBbB76H7MP0Ly2k8zDi+WUQniIr5yge+few=
Date:   Mon, 24 Aug 2020 13:59:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, npiggin@suse.de, agl@us.ibm.com,
        ak@linux.intel.com, nacc@us.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Fix a race between hugetlb sysctl handlers
Message-Id: <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
In-Reply-To: <20200822095328.61306-1-songmuchun@bytedance.com>
References: <20200822095328.61306-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 17:53:28 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> There is a race between the assignment of `table->data` and write value
> to the pointer of `table->data` in the __do_proc_doulongvec_minmax().

Where does __do_proc_doulongvec_minmax() write to table->data?

I think you're saying that there is a race between the assignment of
ctl_table->table in hugetlb_sysctl_handler_common() and the assignment
of the same ctl_table->table in hugetlb_overcommit_handler()?

Or not, maybe I'm being thick.  Can you please describe the race more
carefully and completely?

> Fix this by duplicating the `table`, and only update the duplicate of
> it. And introduce a helper of proc_hugetlb_doulongvec_minmax() to
> simplify the code.
> 

