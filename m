Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B618CC38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8316020782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587437945;
	bh=W3MzZqLv72l10lePV5P3s2AV3T4CM7dFmWlBV+gveZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wGmJfjlZr0+wefvt+tGYkyiumpF19U7b8ileh5Uy+sYkpxJqRqQXcW++x8XOD9xnh
	 ueLcPuWoZ3y5cFOe4QflOhuRIXRPvrojyRiL6GHCEuifioAMAw/9bfv5q5COhnTyQL
	 vK5+2kwmTzqp6QXw5zd9V/TRRtflrnhHU9wWKeUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUC7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgDUC7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:59:04 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3C320782;
        Tue, 21 Apr 2020 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587437944;
        bh=W3MzZqLv72l10lePV5P3s2AV3T4CM7dFmWlBV+gveZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E52zdUtcXbBhlSAwu0JC0W09eFVNtik1wixT7L0iRFiUrQxgyOnu69HNxCeFQK6Ig
         my+2RBnLM46sKg75wo+yultZE4u0I+yYDR65Dvv/IxvF+/ySrPkDL9dXQ5SoE2w7Nq
         fWgSnVOSXj2rtd9REBwnXrn0RVSqdHzhzXJTfdbc=
Date:   Mon, 20 Apr 2020 19:59:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     agordeev@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/mmap.c: do not allow mappings outside of allowed
 limits
Message-Id: <20200420195903.93455e087985b423f97bdfe3@linux-foundation.org>
In-Reply-To: <d6da1319114a331095052638f0ffa3ccb0be58f1.1584958099.git.agordeev@linux.ibm.com>
References: <cover.1584958099.git.agordeev@linux.ibm.com>
        <d6da1319114a331095052638f0ffa3ccb0be58f1.1584958099.git.agordeev@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020 14:29:29 +0100 agordeev@linux.ibm.com wrote:

> It is possible to request a fixed mapping address below
> mmap_min_addr and succeed. This update adds early checks
> of mmap_min_addr and mmap_end boundaries and fixes the
> above issue.

Does this solve any known problems?  If not, what is the motivation for
the change?

