Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776BA207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590242661;
	bh=3GrDS2+LfV+5Q1mKglHDFkYxRwI4AAtXMEEXKunzq3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MkOH+RU4GTQCAbFgfmcKPF5a/BDQgiX3GPx3opBFu/uAXh1Llv6hVlAqvagBlZFfm
	 Yj369gWPtBmrtuN/LmICocH4jbu4F0MHvD6I3gKb2xbFdaMgI41rVqj0G2rYn65nbT
	 /i+Uu2sUgFqSesp3IeHSWV3DvXiTHdP9QRmjho1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgEWOEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 10:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbgEWOEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 10:04:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BB62072C;
        Sat, 23 May 2020 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590242653;
        bh=3GrDS2+LfV+5Q1mKglHDFkYxRwI4AAtXMEEXKunzq3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVZj5q+FKln2NEIeK0OZ41mzcqT7ILj9jfKpLGM4QNnhZoYBpGvPFOkPtDHvIMfGQ
         Jxv1rT7u92dlCkjmMv86YzODMCHGzSWqCPTV3Wc8x+ffZCX15ylxAINbASOUIPAhFA
         cpW/4oHZO4BEgq0cwgIOYKO5g9fRI6IH4NJKep9M=
Date:   Sat, 23 May 2020 16:04:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200523140411.GA114366@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523132101.GA76443@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523132101.GA76443@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 06:21:01AM -0700, Guenter Roeck wrote:
> On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> > In the function kobject_cleanup(), kobject_del(kobj) is
> > called before the kobj->release(). That makes it possible to
> > release the parent of the kobject before the kobject itself.
> > 
> > To fix that, adding function __kboject_del() that does
> 
> s/kboject/kobject/
> 
> > everything that kobject_del() does except release the parent
> > reference. kobject_cleanup() then calls __kobject_del()
> > instead of kobject_del(), and separately decrements the
> > reference count of the parent kobject after kobj->release()
> > has been called.
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> All my arm64be (arm64 big endian) boot tests crash with this patch
> applied. Reverting it fixes the problem. Crash log and bisect results
> (from pending-fixes branch) below.

Ugh, ok, just when I send Linus a pull request.  Let me go fix that...

greg k-h
