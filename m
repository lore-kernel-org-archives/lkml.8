Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5E20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596782855;
	bh=SqxXmUiK7bEJla9DM38sBEbKa6Nq9LJxsuptDBfN6kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQ+dL9eWc4hwfItNCAhvK587i5FHc72WXrZe6+4buPu6iN39QPtO9qUR0WQglaPi8
	 mGurOxmr/3RovuhNW2VCXIqsl/pC/RifmIipwkwydnVEjNmZBJ5abBuovHjaUy/7lI
	 V1vKS1fwQZfKe8Rkg0gptMA0scCfdmUoXsthU/pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHGGre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHGGre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:47:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002BE20866;
        Fri,  7 Aug 2020 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596782852;
        bh=SqxXmUiK7bEJla9DM38sBEbKa6Nq9LJxsuptDBfN6kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtjyCGcIEP9AXhfIM3EG4BPCtXhgO8DRQUKxnQDB9dOVTSYff71OVVO9yoqHpuJc7
         oznteTT5V+qeKzOd6GrgoxH9iaXxDzUl3zGm0bWeyZBs0Y0TBPleciknAqoYPjm+Hq
         gNFpNdoG03LTULJs9HowQlVUi2i0eQTMWzD9Mclo=
Date:   Fri, 7 Aug 2020 08:47:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        stable@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] module: Correctly truncate sysfs sections output
Message-ID: <20200807064729.GA981993@kroah.com>
References: <20200807063539.2620154-1-keescook@chromium.org>
 <20200807063539.2620154-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807063539.2620154-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:35:38PM -0700, Kees Cook wrote:
> The only-root-readable /sys/module/$module/sections/$section files
> did not truncate their output to the available buffer size. While most
> paths into the kernfs read handlers end up using PAGE_SIZE buffers,
> it's possible to get there through other paths (e.g. splice, sendfile).
> Actually limit the output to the "count" passed into the read function,
> and report it back correctly. *sigh*

Ugh, never thought about that...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
