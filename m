Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B3C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D3F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581590142;
	bh=NIljgsYqVdaDxPgwZoKkDL5vFfJ8VuJH1KorovtlNRc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ylXbAZRy/rWkmK1ufuxjEEM/fCt6UXKbadGcPWuTy7dOPH7npKpBCiBckFn10XNfC
	 Up3jRB8CX1c6KTaaEum39fbM0HbyoVGpvkQ72AhHJFa3XCcWyyrJTcTKZEMUwNwBJv
	 62L/2vv71AIh1zIpZ127bgFSL9h6txXxHql9I6YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgBMKfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:35:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:35:41 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787CD218AC;
        Thu, 13 Feb 2020 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581590140;
        bh=NIljgsYqVdaDxPgwZoKkDL5vFfJ8VuJH1KorovtlNRc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j1BhQ6p7gagtWdPoZEcA0Z8+IXZ87QOy5pb01g6eyi0IHP9kkYk1U+tAr81Lqj7Qb
         Us0fzY8wysZZSVMchl7y6hCjAB2jx/2XNTVVsTDZKShDSYWhwxWcFXL8zlSXOpaNGW
         MVA12yUKZofn52wZUDlWDICtg0IcVv2RSjsXvJZ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0608535226E8; Thu, 13 Feb 2020 02:35:38 -0800 (PST)
Date:   Thu, 13 Feb 2020 02:35:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20200213103537.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200213092613.1b66d1f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213092613.1b66d1f5@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:26:13AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   71901ffaf70d ("locktorture: Print ratio of acquisitions, not failures")
> 
> Fixes tag
> 
>   Fixes: 0af3fe1e ("locktorture: Add a lock-torture kernel module")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Good catch, will fix, thank you!

							Thanx, Paul
