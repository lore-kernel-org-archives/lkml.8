Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CF6C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B796220848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581544730;
	bh=NIzr3bNWf1aMRrgZ8jkW+jI7fikdoe2GZiH8v1p3UTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K1eBjRb8WKS/rjv+1jlF5oSuOQtq93XpKyoIdIHkINGhF6ieqYU/gIx31aY8nWaIy
	 qOTiKAoI5GZsnynD7qPpzlaJTdlHY/74BG8kElnrQA0huVvSWstAhx2KAEg0LdktfX
	 SeZ8pzTt4S0zEPnFosFIIka0zhZGIoDyJelOPhvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgBLV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgBLV6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:58:49 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F102082F;
        Wed, 12 Feb 2020 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581544728;
        bh=NIzr3bNWf1aMRrgZ8jkW+jI7fikdoe2GZiH8v1p3UTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kExeR861AcmKi8/BScBgFovpGQ+GVNS6kuNsYmZMbM6pXa/JrG0W+SdhkVQc7mdxR
         K0TogNvzqBOIOQhAW+CK5FzYnux5bvhbZLlejU+g08/juxJg1VVoa0F2jY+4JgDqhe
         WUpQrQmhYpPqIVi/iMvKXv9T7LplaxE2dhUxlQ24=
Date:   Wed, 12 Feb 2020 13:58:47 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200212215847.GA2386833@kroah.com>
References: <20200123093628.GA18991@willie-the-truck>
 <20200123085015.GA436361@kroah.com>
 <CAGETcx86rQpS4qodSiv_v+E_8P3DUQDY9jiN_Yq07Jwh9tHQcQ@mail.gmail.com>
 <20200125101130.449a8e4d@lwn.net>
 <20200125014231.GI147870@mit.edu>
 <20200123155340.GD147870@mit.edu>
 <20200209110549.GA1621867@kroah.com>
 <20200210211142.GB1373304@kroah.com>
 <827b4265-918e-99a7-544a-668edad5b2b9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827b4265-918e-99a7-544a-668edad5b2b9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:15:50PM -0800, Randy Dunlap wrote:
> On 2/10/20 1:11 PM, Greg Kroah-Hartman wrote:
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> > index 252e5ef324e5..585451d12608 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
> >  				<debugfs>/dynamic_debug/control
> >    -bash: echo: write error: Invalid argument
> >  
> > +Note, for systems without 'debugfs' enabled, the control file can also
> 
> Hi Greg,
> If you make any more changes, please drop the word "also" here       ^^^^

I will delete it by hand when I apply the patch now, thanks!

greg k-h
