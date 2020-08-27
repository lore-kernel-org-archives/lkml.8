Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E538C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B90E22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="an/fHdEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgH0HRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0HRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:17:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NzD+ydxkPqiBTHP1y2Jm5Uv3WxjO9rjvYkW8EsnnfDg=; b=an/fHdEgKJDXYXK/p/2RZrIXOv
        aRIAX7CN3W0Pp9Yctm/Zh+YuCR0LKfOIqoMQYuMOpDWuTz1uWr5VPwn+oGoxOcqq+tYeEWiBGa4SL
        f0O1rN7bQE5kngr4IShoqKFnulLa+SyK5NiLSgoH5INRigKlQcPFSH6DKfPv53HOxckViozOYxnqd
        geVTTLDzLuBpt5dzzkBxUbhQamiLMWzxHHmgxYdFhMOemrHEvkP7Idkb9mPi+B+TU4BIxaIvu9/Fc
        aFtfK8PDSXyqtHBwDb73NroWCm/9d5IVv8wTOL0Dbv1f4010YULifRJABXVKDo1owCgPIHp7/Wm/Q
        Xq2Yo+Eg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBC9W-0006nM-NV; Thu, 27 Aug 2020 07:16:54 +0000
Date:   Thu, 27 Aug 2020 08:16:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Tomer Samara <tomersamara98@gmail.com>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Arve Hj?nnev?g <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v4 0/2] staging: android: Remove BUG/BUG_ON from ion
Message-ID: <20200827071654.GB25305@infradead.org>
References: <cover.1598023523.git.tomersamara98@gmail.com>
 <20200825064729.GA30014@infradead.org>
 <20200825065229.GA1319770@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825065229.GA1319770@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:52:29AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 25, 2020 at 07:47:29AM +0100, Christoph Hellwig wrote:
> > On Fri, Aug 21, 2020 at 06:27:04PM +0300, Tomer Samara wrote:
> > > Remove BUG/BUG_ON from androind/ion
> > 
> > Please just remove ion.  It has been rejected and we have developed
> > proper kernel subsystens to replace it.  Don't waste your time on it.
> 
> It is going to be removed at the end of this year.  Why we keep it
> around until then, I really don't know, but John and Laura have this as
> the plan.

It keeps getting in the way of various projects and has no path
going upstream properly.  Seems weird to keep this dead and not all
that great code around.
