Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C62C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5772073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+6b6EUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392605AbgAPSjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:39:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387612AbgAPSjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579199952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9QaZpo4ehb9dzb9uGDth8ZZA66JROBihleoP8BqvZ0=;
        b=L+6b6EUp9Qect+NKD8MzEN0wtBLlXtZQNASb230tRgJSHBQiJlRfUyrk0Y5fdwf7mmVo49
        F6tbXnErPsNi0lylFXIvC+3wj0Sq8Tcw0eABgqkncFAlEO4gJ5UTt0zXMZoRWfZpScRKU5
        FOhhyBous4a8inQMh7PIeeanOU9Ds04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-1KLdtB6dNpy1BWHwcYn6Kw-1; Thu, 16 Jan 2020 13:39:08 -0500
X-MC-Unique: 1KLdtB6dNpy1BWHwcYn6Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422A7800D4C;
        Thu, 16 Jan 2020 18:39:06 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE9480617;
        Thu, 16 Jan 2020 18:39:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D15EA220A24; Thu, 16 Jan 2020 13:39:00 -0500 (EST)
Date:   Thu, 16 Jan 2020 13:39:00 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200116183900.GC25291@redhat.com>
References: <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
 <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:09:46AM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Hi, Dan,
> >
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> > > I'm going to take a look at how hard it would be to develop a kpartx
> > > fallback in udev. If that can live across the driver transition then
> > > maybe this can be a non-event for end users that already have that
> > > udev update deployed.
> >
> > I just wanted to remind you that label-less dimms still exist, and are
> > still being shipped.  For those devices, the only way to subdivide the
> > storage is via partitioning.
> 
> True, but if kpartx + udev can make this transparent then I don't
> think users lose any functionality. They just gain a device-mapper
> dependency.

So udev rules will trigger when a /dev/pmemX device shows up and run
kpartx which in turn will create dm-linear devices and device nodes
will show up in /dev/mapper/pmemXpY.

IOW, /dev/pmemXpY device nodes will be gone. So if any of the scripts or
systemd unit files are depenent on /dev/pmemXpY, these will still be
broken out of the box and will have to be modified to use device nodes
in /dev/mapper/ directory instead. Do I understand it right, Or I missed
the idea completely.

Vivek

