Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECD4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E120767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UjOsw/EY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGIQKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgGIQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:10:19 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E0C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 09:10:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id by13so2255601edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXGyI1jQM4MyDlznYgbObqnrQ6fGYg1DRfNByglLv1o=;
        b=UjOsw/EYQjZBeUPhxTDnLwz5hcjG7XJKZAgCs2jnN8hFjADCB++r0ATOAqmENgW/VP
         hikL0VJL7vWu6z3P4UkTBqdu2KGKyfsHsPW/Bi3c+q1lNKQwFaQ3jtXQyW/uMEGDpkA/
         TqqxyTc44LHLjuIv9MUJBAD9nKjyvaMtoS5ILB0gpHpaESvb3166bLYfXcKF04TJDOs0
         pa1AMO6kHH27YF7o2AKynrWSx+i1ba/Z1ZCBZyA3sL/VFV7J9RZ/YtnFWWUqfQN8T7G1
         xdoFwAAA2eCajSA9FJRXSZ84ILtv1QbBjC3Pfdo/yF5RcJ+LZqB+kCzPE+zAD4yYJPWE
         AlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXGyI1jQM4MyDlznYgbObqnrQ6fGYg1DRfNByglLv1o=;
        b=lgCrFxckwKHnx2Yp1IMXYzRVQCPr5xggZbCilcs3BKUcWik4TNvenCI4RHs6qI1oHB
         j6CsyHHeQcF1XNskg/CS+wErIQhq52uBsvmvdL6R9Q85WRmQ9OYlDwYn6OmtPkq13VZG
         VgFxiLbM+ND/HVZffbYad8i9VJ6d8rVQYeGwMpUiVQN0yRSi/sb4GsefKxWnuweSJOnD
         rkX84Ljheg9qYwa4ql34XwOcN9B/+gM6sYbSHaGoYcowIEmFJPin85CCxsHaBkBeP7lu
         kHmpLqR8+9sXaNezlvkTYf6aw0/BhHzDR5cdsSarl2qfUmdhQjzCHw5Yok9/prl3qSRP
         Gpxw==
X-Gm-Message-State: AOAM532VaYe/iHrvr5rr+RVN7k2Vz5O75gULY6Ta9lFHG1AJYy5UBW9g
        s9744nJeympy8YJTAlt1vYSqTVmDIu4Qfe0g2IY+Uw==
X-Google-Smtp-Source: ABdhPJys2PRuEgVWwVNfqL6iwk8phAva/9+kvQrbBEC8AGznqa+13FP1lQM5gT85aLrNX8emw/o4sdAG8MvO8CX0Aoc=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr75626053edo.102.1594311017269;
 Thu, 09 Jul 2020 09:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org> <20200709153854.GY23821@mellanox.com>
In-Reply-To: <20200709153854.GY23821@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jul 2020 09:10:06 -0700
Message-ID: <CAPcyv4hSPWEUih=we5QM_rdk7fLemi8phyk8_0tOd8ieL_=vPg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 09, 2020 at 04:00:51PM +0100, Christoph Hellwig wrote:
> > On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > > The runtime firmware activation capability of Intel NVDIMM devices
> > > requires memory transactions to be disabled for 100s of microseconds.
> > > This timeout is large enough to cause in-flight DMA to fail and other
> > > application detectable timeouts. Arrange for firmware activation to be
> > > executed while the system is "quiesced", all processes and device-DMA
> > > frozen.
> > >
> > > It is already required that invoking device ->freeze() callbacks is
> > > sufficient to cease DMA. A device that continues memory writes outside
> > > of user-direction violates expectations of the PM core to be to
> > > establish a coherent hibernation image.
> > >
> > > That said, RDMA devices are an example of a device that access memory
> > > outside of user process direction.
>
> Are you saying freeze doesn't work for some RDMA drivers? That would
> be a driver bug, I think.

Right, it's more my hunch than a known bug at this point, but in my
experience with testing server class hardware when I've reported a
power management bugs I've sometimes got the incredulous response "who
suspends / hibernates servers!?". I can drop that comment.

Are there protocol timeouts that might need to be adjusted for a 100s
of microseconds blip in memory controller response?

> The consequences of doing freeze are pretty serious, but it should
> still stop DMA.

Ok, and there is still the option to race the quiesce if the effects
of the freeze are worse than a potential timeout from the quiesce.
