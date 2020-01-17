Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18530C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4A20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAN247Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAQSLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:11:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728901AbgAQSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579284694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsgYM2TGG8lRq9niu1aCEnMk5zwASxNohdIB47d0fPM=;
        b=HAN247KhsXlAXS/uKkIwMhHto4+DzkLslP8y9QlSqDhQoYmxIkWouLHtonrf0AWsi6IqGF
        raiHOaVCO579vBG6NXEo5eVAlIcfBFcL8VR2GuGc9pth32W1yIMv2gpg3Rm1KQErX4joBR
        S+1vsg8PRTL3DohBYuempntnF3d0gh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-cuZZlEvPPxqHNMDkMEDNpQ-1; Fri, 17 Jan 2020 13:11:28 -0500
X-MC-Unique: cuZZlEvPPxqHNMDkMEDNpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAEBDDB20;
        Fri, 17 Jan 2020 18:11:25 +0000 (UTC)
Received: from treble (ovpn-123-54.rdu2.redhat.com [10.10.123.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED0E95D9CD;
        Fri, 17 Jan 2020 18:11:23 +0000 (UTC)
Date:   Fri, 17 Jan 2020 12:11:21 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mmotm 2019-12-10-19-14 uploaded (objtool: func() falls through)
Message-ID: <20200117181121.3h72dajey7oticbf@treble>
References: <20191211031432.iyKVQ6m9n%akpm@linux-foundation.org>
 <07777464-b9d8-ff1d-41d9-f62cc44f09f3@infradead.org>
 <20191212184859.zjj2ycfkvpcns5bk@treble>
 <042c6cd7-c983-03f1-6a79-5642549f57c4@infradead.org>
 <20191212205811.4vrrb4hou3tbiada@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212205811.4vrrb4hou3tbiada@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:58:11PM -0600, Josh Poimboeuf wrote:
> On Thu, Dec 12, 2019 at 12:21:17PM -0800, Randy Dunlap wrote:
> > On 12/12/19 10:48 AM, Josh Poimboeuf wrote:
> > > On Wed, Dec 11, 2019 at 08:31:08AM -0800, Randy Dunlap wrote:
> > >> On 12/10/19 7:14 PM, Andrew Morton wrote:
> > >>> The mm-of-the-moment snapshot 2019-12-10-19-14 has been uploaded to
> > >>>
> > >>>    http://www.ozlabs.org/~akpm/mmotm/
> > >>>
> > >>> mmotm-readme.txt says
> > >>>
> > >>> README for mm-of-the-moment:
> > >>>
> > >>> http://www.ozlabs.org/~akpm/mmotm/
> > >>>
> > >>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > >>> more than once a week.
> > >>>
> > >>> You will need quilt to apply these patches to the latest Linus release (5.x
> > >>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > >>> http://ozlabs.org/~akpm/mmotm/series
> > >>>
> > >>> The file broken-out.tar.gz contains two datestamp files: .DATE and
> > >>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > >>> followed by the base kernel version against which this patch series is to
> > >>> be applied.
> > >>
> > >> on x86_64:
> > >>
> > >> drivers/hwmon/f71882fg.o: warning: objtool: f71882fg_update_device() falls through to next function show_pwm_auto_point_temp_hyst()
> > >> drivers/ide/ide-probe.o: warning: objtool: hwif_register_devices() falls through to next function hwif_release_dev()
> > >> drivers/ide/ide-probe.o: warning: objtool: ide_host_remove() falls through to next function ide_disable_port()
> > > 
> > > Randy, can you share the .o files?
> > 
> > Sure. They are attached.
> 
> These look like compiler bugs to me... execution is falling off the edge
> of the functions for no apparent reason.  Could potentially be triggered
> by the '#define if' trace code.

Randy, do you happen to have a config which triggers the above bugs?  I
can reduce the test cases and open a GCC bug.

-- 
Josh

