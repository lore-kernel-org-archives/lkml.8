Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8406C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 05:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B434B207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 05:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590472691;
	bh=qhr+W4r+DK58Si3GSGhxHhAM2vWivWSuFtrDJmUxCeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YPtQur/Bz+X+jd6l7tgaPNa4u7fVwb4InHcuaU+r5YCQ9krqfz4jrHQcW+T3kD4nq
	 3njCB5YvIpphZQi3qI/XTOpIwQAerVrxUd5Mn0iC8beV2pZOUOv4Nl4CbI/JJFnSUH
	 yNHeecV5ee2MJDfP+jQV0ueOZN3qlROjFAGPTYZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEZF6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 01:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgEZF6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 01:58:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721482071A;
        Tue, 26 May 2020 05:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590472689;
        bh=qhr+W4r+DK58Si3GSGhxHhAM2vWivWSuFtrDJmUxCeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbEwpKSVrvVgJ/yTO3ymhzxH9T6rVrn0KGo61uyTGEl8POokUahrRss4d6QXcOmrq
         rty3G7UxdQ2DBXYmAhL8VDdNevdoImBDU6xZ+yULeOqFtG15GvD1sLSj5orJq89GGl
         vXa2LCMJKmRxBLBJMBUQiTVxfv2FtB9+y7lv55ec=
Date:   Tue, 26 May 2020 07:58:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
Message-ID: <20200526055806.GA2576013@kroah.com>
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200524153041.2361-2-gregkh@linuxfoundation.org>
 <CAKdAkRShA2sAMH12H_zpCm=9XJn_yEcnAaaZhLgvhaUMxC-EMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRShA2sAMH12H_zpCm=9XJn_yEcnAaaZhLgvhaUMxC-EMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 03:49:01PM -0700, Dmitry Torokhov wrote:
> On Sun, May 24, 2020 at 8:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> > after the files are actually gone from sysfs, due to how reference
> > counting for kobjects work.  This should not be a problem, but it would
> > be good to properly send the information when things are going away, not
> > at some later point in time in the future.
> >
> > Before this move, if a kobject's parent was torn down before the child,
> 
> ^^^^ And this is the root of the problem and what has to be fixed.

I fixed that in patch one of this series.  Turns out the user of the
kobject was not even expecting that to happen.

> > when the call to kobject_uevent() happened, the parent walk to try to
> > reconstruct the full path of the kobject could be a total mess and cause
> > crashes.  It's not good to try to tear down a kobject tree from top
> > down, but let's at least try to not to crash if a user does so.
> 
> One can try, but if we keep proper reference counting then kobject
> core should take care of actually releasing objects in the right
> order. I do not think you should keep this patch, and instead see if
> we can push call to kobject_put(kobj->parent) into kobject_cleanup().

I tried that, but there was a _lot_ of underflow errors reported, so
there's something else happening.  Or my attempt was incorrect :)

thanks,

greg k-h
