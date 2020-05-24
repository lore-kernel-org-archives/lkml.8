Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21DB20823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590320548;
	bh=Hsa4osmGTB+icwS6CCShOt0I44y6x7wldglePjcjJcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9YLAPLt5B7FKaXlEz/rkHexBglCqeU0W2DP9pF6KqpkDzSdNDJWpvycpvz6MOGr+
	 EL7X8dEDpFce85bTfZhLxkH/4rW+1HMbkTGsS+kiOtvYzuGfupA+5rMJcpPpsDZ0on
	 A3X5mmbSu6AwJoyZ2Ci1FUX7rKQsKZG4FRJisuX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgEXLm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 07:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgEXLm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:42:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77EC42075F;
        Sun, 24 May 2020 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590320546;
        bh=Hsa4osmGTB+icwS6CCShOt0I44y6x7wldglePjcjJcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6CotyABalJCSDuHY3tmlvjSdcdWp6zEG42vxCz6vzLMaQvVCPPkP07oo1RMKcnT7
         W+/p0GUomGACS7aFMGo2SWuZLy1yJfScXh1uaRDL3HWDqB0whvkBiNcNVKE4mK2aVj
         rLTkcwH06eeRmHlwkqhCufFoYPgiYMII/KRPA8ME=
Date:   Sun, 24 May 2020 13:42:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200524114223.GA1942568@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523153643.GA226270@kroah.com>
 <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
 <CAKdAkRQvQkC8aHUjOPdUrJTSQ8z3jK90RJ85VyTQaOfnfmj9Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRQvQkC8aHUjOPdUrJTSQ8z3jK90RJ85VyTQaOfnfmj9Cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 12:04:30PM -0700, Dmitry Torokhov wrote:
> On Sat, May 23, 2020 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 5/23/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> > >> In the function kobject_cleanup(), kobject_del(kobj) is
> > >> called before the kobj->release(). That makes it possible to
> > >> release the parent of the kobject before the kobject itself.
> > >>
> > >> To fix that, adding function __kboject_del() that does
> > >> everything that kobject_del() does except release the parent
> > >> reference. kobject_cleanup() then calls __kobject_del()
> > >> instead of kobject_del(), and separately decrements the
> > >> reference count of the parent kobject after kobj->release()
> > >> has been called.
> > >>
> > >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> > >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > >> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > >> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > >> ---
> > >>  lib/kobject.c | 30 ++++++++++++++++++++----------
> > >>  1 file changed, 20 insertions(+), 10 deletions(-)
> > >
> > > Stepping back, now that it turns out this patch causes more problems
> > > than it fixes, how is everyone reproducing the original crash here?
> >
> > Just load lib/test_printf.ko and boom!
> >
> >
> > > Is it just the KUNIT_DRIVER_PE_TEST that is causing the issue?
> > >
> > > In looking at 7589238a8cf3 ("Revert "software node: Simplify
> > > software_node_release() function""), the log messages there look
> > > correct.  sysfs can't create a duplicate file, and so when your test is
> > > written to try to create software nodes, you always have to check the
> > > return value.  If you run the test in parallel, or before another test
> > > has had a chance to clean up, the function will fail, correctly.
> > >
> > > So what real-world thing is this test "failure" trying to show?
> 
> Well, not sure about the test, but speaking more generally, should not
> we postpone releasing parent's reference until we are in
> kobj->release() handler? I.e. after all child state is cleared, and
> all memory is freed, _then_ we unpin the parent?

That's what the patch was trying to do in a way.  But I think you are
right, we should _only_ be doing it at that point in time, and no other,
which the patch was not doing.

Let me go try that and see what happens...

thanks,

greg k-h
