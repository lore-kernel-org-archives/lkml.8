Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E60C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgIJVgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:36:46 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:44278 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727997AbgIJVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:36:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 06D4E100E7B42;
        Thu, 10 Sep 2020 21:36:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chain07_230dacc270e9
X-Filterd-Recvd-Size: 2027
Received: from XPS-9350 (unknown [172.58.19.160])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Sep 2020 21:36:02 +0000 (UTC)
Message-ID: <617a44ab25f4ac346f1dbb4174d5fb4f358a8610.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn on self-assignments
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>, julia.lawall@inria.fr
Date:   Thu, 10 Sep 2020 14:35:59 -0700
In-Reply-To: <202009101250.FBB416D@keescook>
References: <20200811210127.11889-1-efremov@linux.com>
         <20200901094812.428896-1-efremov@linux.com>
         <afc2cffdd315d3e4394af149278df9e8af7f49f4.camel@perches.com>
         <202009101250.FBB416D@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-10 at 12:51 -0700, Kees Cook wrote:
> On Sat, Sep 05, 2020 at 10:58:29AM -0700, Joe Perches wrote:
> > The uninitialized_var() macro was removed recently via
> > commit 63a0895d960a ("compiler: Remove uninitialized_var() macro")
> > as it's not a particularly useful warning and its use can
> > "paper over real bugs".
> > 
> > Add a checkpatch test to warn on self-assignments as a means
> > to avoid compiler warnings and as a back-door mechanism to
> > reproduce the old uninitialized_var macro behavior.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> I like it! :)
> 
> Can you add a section to code style and include a link in the checkpatch
> warning to it? (Feel free to just reuse the text removed from
> deprecated.rst)

Hi Kees.

I believe coding style is already a bit bloated
and more rules and content really won't add much
for new developers.

You're welcome to try to add whatever you want
to it though.

cheers, Joe

