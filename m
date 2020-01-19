Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A722C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE87246AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579395887;
	bh=UC0MjXqTZ9KKw7ixKrMeXOzVZ+e+F/FydRb0OQ8QP+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WA/hmIGCWJOj2R+nEMRp2JfE9c+H+gOk5d4OaWRmrGkk5FwJogRhFYp3sCt/Bcict
	 xecaU6Q8wAiE7XGtCDE9+n1lIpBIXskJ3MH3aPUNcNn2K9fNvP53qanFN+pV4/FtI3
	 PXj/8D4tnJXDUtG5tFZSMAEPlHkOm6lxehj5UjB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgASBEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgASBEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:04:46 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2FC2467C;
        Sun, 19 Jan 2020 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579395885;
        bh=UC0MjXqTZ9KKw7ixKrMeXOzVZ+e+F/FydRb0OQ8QP+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0C41Sgqmz28bOgjI6zFREqdPrxnbdmnXsjiXKjgOY4EOwLy+sAGGhFK+nheXzCOcK
         NfWt2L1hPIUYO2rEUJYVaL7vURlzvXAHqLNjix1AoWw+AdwlTNd+vxikG7MSE839Ia
         NL1FH+8f2Z7icJoxxWsEDLFMsIH1Njrifecy2OTk=
Date:   Sat, 18 Jan 2020 17:04:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, thp: fix defrag setting if newline is not used
Message-Id: <20200118170445.370d908ce29f42068390addb@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.2001171411020.56385@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com>
        <20200116191609.3972fd5301cf364a27381923@linux-foundation.org>
        <025511aa-4721-2edb-d658-78d6368a9101@suse.cz>
        <alpine.DEB.2.21.2001170136280.20618@chino.kir.corp.google.com>
        <a3c269a7-ff41-ee7c-9041-ee06e50c5a10@suse.cz>
        <alpine.DEB.2.21.2001171411020.56385@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 14:11:48 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> If thp defrag setting "defer" is used and a newline is *not* used when
> writing to the sysfs file, this is interpreted as the "defer+madvise"
> option.
> 
> This is because we do prefix matching and if five characters are written
> without a newline, the current code ends up comparing to the first five
> bytes of the "defer+madvise" option and using that instead.
> 
> Use the more appropriate sysfs_streq() that handles the trailing newline
> for us.  Since this doubles as a nice cleanup, do it in enabled_store()
> as well.

I can't really I really understand this prefix-matching thing that
we're taking away.  Documentation/admin-guide/mm/transhuge.rst doesn't
appear to mention it.  Could we please add a paragraph to the changelog
to spell all this out.  Bonus points for formally describing the
behaviour which we're removing!

Thanks.

