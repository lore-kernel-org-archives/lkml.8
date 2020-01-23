Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24020C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7922464
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579802143;
	bh=WQfF52ocBvdFZrGb8gqOqp46CCs46jtplHpqIo6xK7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZ+jzPehgdrNQ+a87XyUMqYl+XCXU5ExuYUNmYbZV4F6f1yw6ID1uupdlkKS1LQ/C
	 GTOLPwgj1lTOnb6e0iy8QxqYkDwF+uRg2EYEhjzFuzzvOoL+LjdX0zDXa9CIpi81z6
	 pUgckh4ThjtsgyWGgPMULm3AXdbhilMcovSyqEfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgAWRzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:55:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BB920718;
        Thu, 23 Jan 2020 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579802139;
        bh=WQfF52ocBvdFZrGb8gqOqp46CCs46jtplHpqIo6xK7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izD0sZ/0eWhZ0V86Gh+KU1CiIJHw7hDsdlomWl779Ou720ttBnLEIfT5g0nvJom66
         B9Uw8EsWfyHs3dXpaMxJL172BZLzQSBOnn57ynjeHg6bFSegWBk1hqDkDPRi4c4Yxu
         d0GtijL0/hb3/8OuG/Q5pagbdf+OJV6A6tahHfyI=
Date:   Thu, 23 Jan 2020 18:55:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200123175536.GA1796501@kroah.com>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <20200123155340.GD147870@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123155340.GD147870@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:53:40AM -0500, Theodore Y. Ts'o wrote:
> On Wed, Jan 22, 2020 at 08:31:18PM +0100, Greg Kroah-Hartman wrote:
> > With the realization that having debugfs enabled on "production" systems is
> > generally not a good idea, debugfs is being disabled from more and more
> > platforms over time.  However, the functionality of dynamic debugging still is
> > needed at times, and since it relies on debugfs for its user api, having
> > debugfs disabled also forces dynamic debug to be disabled.
> > 
> > To get around this, move the "control" file for dynamic_debug to procfs IFF
> > debugfs is disabled.  This lets people turn on debugging as needed at runtime
> > for individual driverfs and subsystems.
> 
> Instead of moving the control file IFF debugfs is enabled, what about
> always making it available in /proc, and marking the control file for
> dynamic_debug in debugfs as deprecated?  It would seem to me that this
> would cause less confusion in the future....

Why deprecate it?  It's fine where it is, and most developer's have
debugfs enabled so all is good.  I'd rather only use /proc as a
last-resort.

thanks,

greg k-h
