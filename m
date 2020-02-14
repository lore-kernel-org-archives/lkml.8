Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB40C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD820873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WakEy6F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBNAQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:16:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36820 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBNAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:16:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so7502074otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rG1vX77YtWxx+qL8zmiC+QnNHHiP3NTzOqE4AoDqMAw=;
        b=WakEy6F3ApIgrFEWOBecDIpNAJVCgyi10fdF/akTwcUGBT/IeipHX+cR+pausx7Txa
         7UpvycLmRq/nijUulx4THHko9/h9P66nE9yegW2DJCw2lEvpbFoDPpSvlzVjjiK591cd
         Rr8x4FzuhApsMQUcyzM7pwdPWH/+KQEHO4p6WX9coLltDx4n8+EjOgxAzocqEWD9Df9/
         rPtRsNJJzJI1Py506R6OpDFKhaBhiR5AjgFkWd2SJsdLuIPHg1eM0z3wbdPTifRofxTb
         2VGRsxRz3JGMjoX7iNlz5pPilqd3IezNtke3awlEFoLYQ2S5V+EoX29v6ejvmx44X62I
         Wc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rG1vX77YtWxx+qL8zmiC+QnNHHiP3NTzOqE4AoDqMAw=;
        b=YzzhKfYDNdOZsf7VKHPj0Ngs0x50lDBNqwJebKDzQkHFYZXpdmnYFR5t9DBZT7azL+
         n7eNiWNDb+2M+dL6C+O2dPCkxrwk3dbRWa2I2U/ZtQzLyzS++iV30J4f7DV+DKdUB2i3
         HmgVUeK0pMKT7cBH6rXbUaXy+rHvgmI0/Oxi0HhghWULjWp43TTUtYyanzAMeEQZqXD1
         11yyqynQvl/1pJjjGe/NR+ANzMkRNF6UxiSDXnSNCYomOpOpjWtG6J2UCA35mUGVFENO
         /+SatJjTlH8EdKRxhFyLCbTlw7vJgO7p+Ixy5g/+DO09hB4iE1CkY7OdouQLuHv3UbCu
         OYtw==
X-Gm-Message-State: APjAAAW/1LN8XAWwOUgIj+ukHGG7+k84fPPiCtLdh1tcNgTka8n6Ee6u
        lcJgmjgqnmMl1kuT2/mgJOY1ri/FLVb8Fimtgi/ECA==
X-Google-Smtp-Source: APXvYqyUhkfNbR0RFLXIH6LAygeGDOeEqqLcdiUcZRMmfqVyLefKN3yOki9UTAHgFJxWwXRQBZtdbLe4rMpJWfAsWb0=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr89938otm.247.1581639389017;
 Thu, 13 Feb 2020 16:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20200208193445.27421-1-ira.weiny@intel.com> <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com> <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
 <20200213190156.GA22854@iweiny-DESK2.sc.intel.com> <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
 <20200213195839.GG6870@magnolia> <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Feb 2020 16:16:17 -0800
Message-ID: <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 3:29 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, Feb 13, 2020 at 11:58:39AM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2020 at 11:05:13AM -0800, Ira Weiny wrote:
> > > On Thu, Feb 13, 2020 at 11:01:57AM -0800, 'Ira Weiny' wrote:
> > > > On Wed, Feb 12, 2020 at 02:49:48PM -0500, Jeff Moyer wrote:
> > > > > Ira Weiny <ira.weiny@intel.com> writes:
> > > > >
> > >
> > > [snip]
> > >
> > > > > Given that we document the dax mount
> > > > > option as "the way to get dax," it may be a good idea to allow for a
> > > > > user to selectively disable dax, even when -o dax is specified.  Is that
> > > > > possible?
> > > >
> > > > Not with this patch set.  And I'm not sure how that would work.  The idea was
> > > > that -o dax was simply an override for users who were used to having their
> > > > entire FS be dax.  We wanted to depreciate the use of "-o dax" in general.  The
> > > > individual settings are saved so I don't think it makes sense to ignore the -o
> > > > dax in favor of those settings.  Basically that would IMO make the -o dax
> > > > useless.
> > >
> > > Oh and I forgot to mention that setting 'dax' on the root of the FS basically
> > > provides '-o dax' functionality by default with the ability to "turn it off"
> > > for files.
> >
> > Please don't further confuse FS_XFLAG_DAX and S_DAX.
>
> Yes...  the above text is wrong WRT statx.  But setting the physical
> XFS_DIFLAG2_DAX flag on the root directory will by default cause all files and
> directories created there to be XFS_DIFLAG2_DAX and so forth on down the tree
> unless explicitly changed.  This will be the same as mounting with '-o dax' but
> with the ability to turn off dax for individual files.  Which I think is the
> functionality Jeff is wanting.

To be clear you mean turn off XFS_DIFLAG2_DAX, not mask S_DAX when you
say "turn off dax", right?

The mount option simply forces "S_DAX" on all regular files as long as
the underlying device (or soon to be superblock for virtiofs) supports
it. There is no method to mask S_DAX when the filesystem was mounted
with -o dax. Otherwise we would seem to need yet another physical flag
to "always disable" dax.
