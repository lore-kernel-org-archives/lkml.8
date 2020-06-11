Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C0A2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFott7HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFKQv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:51:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgFKQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591894287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VyiOMCknkLLdkkng3brgL4BkJyIYCIkonWDKyJSqKTI=;
        b=JFott7HScsMEQlbieLjLX8YacLqB8xQ9XTxmRsERaF4UVbS2hgZZxwkUcspsqi1lZER/4i
        rPJOfKKiTZeKjkyPAcceMCsAqFh2dVztqT7yYd9DVbmHahG+Rnqy9l/Nh37HrStVQoKhWI
        80FzBezvVBMPorGWVtYSS/U7grsTW8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-s3RYe3d_NMOnloE6AlIXkg-1; Thu, 11 Jun 2020 12:51:23 -0400
X-MC-Unique: s3RYe3d_NMOnloE6AlIXkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27891800D41;
        Thu, 11 Jun 2020 16:51:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6A1375D9E5;
        Thu, 11 Jun 2020 16:51:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Jun 2020 18:51:20 +0200 (CEST)
Date:   Thu, 11 Jun 2020 18:51:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH 4.19 24/25] uprobes: ensure that uprobe->offset and
 ->ref_ctr_offset are properly aligned
Message-ID: <20200611165116.GE12500@redhat.com>
References: <20200609174048.576094775@linuxfoundation.org>
 <20200609174051.488794266@linuxfoundation.org>
 <CA+G9fYukN5V1z3g6Qwe9K5xnnXEuFafWdqGfDA1Wj2iVstoxfw@mail.gmail.com>
 <20200609190321.GA1046130@kroah.com>
 <20200610145305.GA3254@redhat.com>
 <20200610145855.GA2102398@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610145855.GA2102398@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10, Greg Kroah-Hartman wrote:
>
> > Greg, please let me know if you want me to send the patches for 4.9/4.14/4.19.
>
> Please do.  I tried to backport it to those trees, and it seems to
> build/boot/run, but I would like verification I didn't mess anything up
> :)
>
> Your 4.4 version below matched my version, so I think I'm ok...

Greg, I was going to send the patches, but after I've cloned
git/stable/linux-stable-rc.git I see that you have already updated these

	origin/queue/4.14
	origin/queue/4.19
	origin/queue/4.4
	origin/queue/4.9

branches, and the new patches look good to me.

So I think I can relax? ;)

Thanks!

Oleg.

