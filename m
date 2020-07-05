Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2421BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C6E20760
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593967989;
	bh=nWJlHYWJYdErN+E4XpreVxwS1TLKqSJEkIkde3kJS4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pmt9DXUWrS49zJk/xKfDhTtj/bdTnqM3z1J893wj8BFN9rWu2XQ11ij8ptpuPW9SW
	 rPqtAYfiCRqPpCnR/Cb6XqW1Lfu37ncAnpbbvwtYlfCj8zZNz1OI7Rh7p5aA3kHf48
	 KmgXQ7Zfn3xFekmZBMhvW74TyVknF0bA4x+R+Yic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGEQxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 12:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgGEQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 12:53:06 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C2F20739;
        Sun,  5 Jul 2020 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593967986;
        bh=nWJlHYWJYdErN+E4XpreVxwS1TLKqSJEkIkde3kJS4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgyxGT3EdrQCzZIZ0Fd1QksBst4bzwgUP3xSoFJ+PUvevQ3g6WCzLey8sICL8kwEy
         E49yUVjM+LXyGGVGW9YlYqaLTB8+F6Kps2f37b/YFLFv5t8P/PcBidCCRGEb7OxdyM
         zqVmQObXxmYS1imEMjrpaluS2gQp0hLpBKPiM7T0=
Date:   Sun, 5 Jul 2020 09:53:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/harness: Clean up kern-doc for fixtures
Message-ID: <20200705095304.16bf0655@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200705061232.4151319-2-keescook@chromium.org>
References: <20200705061232.4151319-1-keescook@chromium.org>
        <20200705061232.4151319-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jul 2020 23:12:30 -0700 Kees Cook wrote:
> The FIXTURE*() macro kern-doc examples had the wrong names for the C code
> examples associated with them. Fix those and clarify that FIXTURE_DATA()
> usage should be avoided.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Fixes: 74bc7c97fa88 ("kselftest: add fixture variants")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
