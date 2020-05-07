Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB7C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D721473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588891531;
	bh=m6BQnVKIlUtyrdBpZe1PlvAZv15nUYwubFnQjyNpYOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yRFpFi6aDIcsrbV0ek1hKz3bSFyeC4SLgT7t3Zi9B6YWDKLrW2swtA1eDei1+0Xje
	 RTjxSylehC7Ma0JB/QE1vBDFZ+z9Bw0TsdpmMRt7BdEDq/iVZiuEEe26/T14wEXtt6
	 18wOS9Jfe4/Z4319AxXJHpW6nGtSnsnYqIXgiKUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEGWpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgEGWp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:45:29 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C274220725;
        Thu,  7 May 2020 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588891529;
        bh=m6BQnVKIlUtyrdBpZe1PlvAZv15nUYwubFnQjyNpYOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqhYuwHu/gCZASVTcH8p9XI9PqStc01J6jRoOc4dpLZaEtCorgMNAlMkLyF+Z+5A/
         toHFjg8LJxX05TsbJCUGlv3mrAJlsS9BLDA/RBSk+FAIWB8FMzYV7uaNiLDgT0W6vQ
         geB1GancB2T8LkkZlAiiipAVdzAsTXo+MQWruYR0=
Date:   Thu, 7 May 2020 17:49:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: Replace zero-length array with flexible-array
Message-ID: <20200507224955.GA22343@embeddedor>
References: <20200507185041.GA13930@embeddedor>
 <20200507215812.ksvwcykfged7ye2a@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507215812.ksvwcykfged7ye2a@madcap2.tricolour.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:58:13PM -0400, Richard Guy Briggs wrote:
> On 2020-05-07 13:50, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> > 
> > This issue was found with the help of Coccinelle.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Sounds reasonable to me.  There's another in include/uapi/linux/audit.h

Hi,

I wouldn't advise to make any of these conversions in include/uapi/
[1][2].

> in struct audit_rule_data buf[0].  This alert also helped me fix another
> one in a patchset I'm about to post (and will probably cause a merge
> conflict but we can figure that out).

Awesome. :)

> 
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
>

Thanks
--
Gustavo

[1] https://lore.kernel.org/lkml/20200424121553.GE26002@ziepe.ca/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e6e9d0f4859ec698d55381ea26f4136eff3afe1

> > ---
> >  include/linux/audit.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index f9ceae57ca8d..2b63aee6e9fa 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -19,7 +19,7 @@
> >  struct audit_sig_info {
> >  	uid_t		uid;
> >  	pid_t		pid;
> > -	char		ctx[0];
> > +	char		ctx[];
> >  };
> >  
> >  struct audit_buffer;
> > 
> > 
> > --
> > Linux-audit mailing list
> > Linux-audit@redhat.com
> > https://www.redhat.com/mailman/listinfo/linux-audit
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
> 
