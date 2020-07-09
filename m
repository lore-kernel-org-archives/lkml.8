Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974A62077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tkD7TSIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGIP4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgGIP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:56:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75BC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:56:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so2810008ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JorGRdPG9nGU83ESkYVYwju05GIEW9WB/KRf7m4udMA=;
        b=tkD7TSIv0Qv76lmvGZveqdO6YmW35iYrAzCeyQzb5iBAsnHgAzri43addS1orW4idl
         QbS/KsmQPr/vc1RCpVUbbDZFh4r+J/NF7uas79qYzsw4Ua4x1iv9m4lrC7DpfkS/SEvL
         gNVHHOMUnWM/1Wmy0EeVRoxZDdLHp9kE65nH7QGqsy+rGWs3lGvPnHTI5nNObFSPeb3R
         t94yt/59SXH9U9DJqCnYS+KlUy4SdNis9MsYMqoFERVjISL9VhcgZkfYfNmOJeHdE59a
         N1QVSAJIGNVirmL/qzGddIvbDelTvI0qbJymL347A1Ys7yHDOMCP84nCu322VI9n1ZQH
         8qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JorGRdPG9nGU83ESkYVYwju05GIEW9WB/KRf7m4udMA=;
        b=bqccnMK28i61cqi4VLECogVIK6k5EQP9HXBQKUnwYlOJYY+rlUX3lIZQapzMa3EHi7
         FZbnEl4ZinH/d+36ceEkRsHGPbF2BaGVTVnDG4TD+z8/m0z/k4hAb3iu+Bu870kRxNrZ
         ROQCMsI/mBY+ol5DhzZ90buPMWgEyvB6fXrqHJTvExlq1rmaxQ1VqJiFPt+iUoZ9VJWO
         s4RhO11BxU1qaip1AMIKpzt8pqIl0OiPvoPxYwtV3HXkSN1Vbw9pF3556P4M66IGTYUp
         Y5RnQbIsL/pEZO3yrdK3A+P4jldYcEINFJMG9v7ymPr5/uyjg3CSu6/sJZHLMj69V6jw
         2I6g==
X-Gm-Message-State: AOAM533YWaZy/E7N7ut7knexT+k7QuVIVx2AyUHnvTbitzyiXFnTVwUh
        mltNIMCBOXu7LvQUu9QZWuXGX5lf2zDjQF9EaWRlwQ==
X-Google-Smtp-Source: ABdhPJy9XlrguBIfBmUlV+QHkb1Tei6o3eM0eVlANMzS10C6igRbST6YWQ2dCOBPLw8ouVOoj0vUiDs0UBtRseGhwpM=
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr56751640ejb.174.1594310173763;
 Thu, 09 Jul 2020 08:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org>
In-Reply-To: <20200709150051.GA17342@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jul 2020 08:56:02 -0700
Message-ID: <CAPcyv4hafWDVfRCpX0JztXZANShx12o3=p3Y_GUrVK79JTQJbA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:01 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > The runtime firmware activation capability of Intel NVDIMM devices
> > requires memory transactions to be disabled for 100s of microseconds.
> > This timeout is large enough to cause in-flight DMA to fail and other
> > application detectable timeouts. Arrange for firmware activation to be
> > executed while the system is "quiesced", all processes and device-DMA
> > frozen.
> >
> > It is already required that invoking device ->freeze() callbacks is
> > sufficient to cease DMA. A device that continues memory writes outside
> > of user-direction violates expectations of the PM core to be to
> > establish a coherent hibernation image.
> >
> > That said, RDMA devices are an example of a device that access memory
> > outside of user process direction. RDMA drivers also typically assume
> > the system they are operating in will never be hibernated. A solution
> > for RDMA collisions with firmware activation is outside the scope of
> > this change and may need to rely on being able to survive the platform
> > imposed memory controller quiesce period.
>
> Yikes.  I don't think we should support such a broken runtime firmware
> activation.

Yikes indeed, that matches my initial reaction.

So I can say that the platform folks recognize that this situation is
untenable and you can see in the interface that it is built to support
future platforms that can activate without a memory quiesce period.
The question is what to do in the meantime. It turns out that despite
my initial skeptical reaction a significant number of users are
willing to manage this quiesce (or even race this quiesce!) to avoid a
server reboot which is basically guaranteed to knock a "9" off of a "5
nines" uptime system. My minimum requirement for supporting this in
Linux was to at least have a safe way to mitigate the risks of a race
and that's what led me to the hibernate path.
