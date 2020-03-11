Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F85C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC33E206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="C9ioYl0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgCKRHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:07:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34453 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbgCKRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:07:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id g6so2627863oiy.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2lvDdSLPhmcM0nXdmXNuB/sfxCFsfZa1DAwoATiN2U=;
        b=C9ioYl0fzU/vmkecoyhX5BivhKG5b1jtS5V7vkjWOi0PiELjheJ1R7QdbXo9TuQysN
         1IY2fq/TBnNmInGLeEDCh9Qg2FQPnwr45qh6swtd5Q15fbPVwPnXkCsXB+xAGAvG4adz
         4pNukYlTfGqeQfrlNRzbfK46LmVnw+4AdBzAKJ4KQ+UvRNhB5A0lbDMBYMN58JDrQch+
         oX7mhxiYWNyX5vHzUU02K0pFLjUB+uLzDkt4Ih+CrGHBmXGEGor3jeQlS9bS4aed6zJR
         BNVlWCs49Q2ZXXJf0Kl9+b5Oc1HBCpMZOUmjYXZdiHusPlLa5qph+Sy0JONGt0kTD9Q4
         qxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2lvDdSLPhmcM0nXdmXNuB/sfxCFsfZa1DAwoATiN2U=;
        b=sLeSGEj7dn95aO9rBiPeI91TjjUdtfBX5e55cshkO2BJG+2Tkebp+kQZfQb8MZN8hT
         2xJYi2RU/h7weKk0cMs+7LhwZP12nKLOEf8Oaay9kGdC9GNY+3FntpRI6MRQwperl4hU
         8Go5ZwEeuVgqSEQL0cZziBfeqnXgeAyJ/qbrrwZLfAcJ0Vo2gSQl6QOnQB1MMFweu7uR
         RaFZ5WcAUoq3oAT1D2dSGXjGeSr+6hM5hVyjVPWTGUUpdpnl/VtpLQCs0lSc72g4tekL
         rITIqid4RsW90CAyxSAP25R1QMsw2xJ3y8ca21SDUBEe2Fi0dN30F+qsNQrm5xcRr7PD
         BvSQ==
X-Gm-Message-State: ANhLgQ0t0fv+doiJyJwQWTBjTS3wTpUveGZyns3TetFt4L7+Feq7Ef/H
        MKo5c/26TRAlg2Bbj94ofWTeJNmAZbZCmA7cp5GxrQ==
X-Google-Smtp-Source: ADFU+vtHWaxjCHodf/i8X2TsY67+jZq3h7w3Q9evQy7tS+y4d+px/3vFxbGvBUdESzEm1GeGh5OUonvksn5m8/27xO4=
X-Received: by 2002:a54:4585:: with SMTP id z5mr2651107oib.149.1583946470021;
 Wed, 11 Mar 2020 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia>
 <20200311063942.GE10776@dread.disaster.area> <20200311064412.GA11819@lst.de>
In-Reply-To: <20200311064412.GA11819@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Mar 2020 10:07:38 -0700
Message-ID: <CAPcyv4jk5i0hPpqbZNPhUH8wKPS66pd48xNoPnQpy6vt72+i=w@mail.gmail.com>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 11, 2020 at 05:39:42PM +1100, Dave Chinner wrote:
> > IOWs, the dax_associate_page() related functionality probably needs
> > to be a filesystem callout - part of the aops vector, I think, so
> > that device dax can still use it. That way XFS can go it's own way,
> > while ext4 and device dax can continue to use the existing mechanism
> > mechanisn that is currently implemented....
>
> s/XFS/XFS with rmap/, as most XFS file systems currently don't have
> that enabled we'll also need to keep the legacy path around.

Agree, it needs to be an opt-in capability as ext4 and xfs w/o rmap
will stay on the legacy path for the foreseeable future.
