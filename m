Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEB3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F53214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZd/LM+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAORAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:00:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbgAORAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579107608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBQnQpVm4eKdteh8IhTOrm9qQNdOr/TSGOdEhhv2XDw=;
        b=WZd/LM+VhyfI69Xb8chtjnTkq6RCuqJVSEkVO6HoyvGqJ3ODl1na73n7mtKgu4BaNRIUKq
        5JOxKcR4qqqSHXOigZ40YNYLznZDHP0M6RgXIHE8DEUr81uRbBTp6eNuJ/wHDC8A2dqW7q
        /aWE+8V3utRbH6m+V2mwUTbMLem02Nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-xcn94VcLNdidfkTKf6Vnqg-1; Wed, 15 Jan 2020 12:00:04 -0500
X-MC-Unique: xcn94VcLNdidfkTKf6Vnqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B90F800D4C;
        Wed, 15 Jan 2020 17:00:02 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-36.ams2.redhat.com [10.36.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C89460BE0;
        Wed, 15 Jan 2020 17:00:00 +0000 (UTC)
Date:   Wed, 15 Jan 2020 17:59:57 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] io_uring: fix compat for IORING_REGISTER_FILES_UPDATE
Message-ID: <20200115165957.GJ1333@asgard.redhat.com>
References: <20200115163538.GA13732@asgard.redhat.com>
 <cce5ac48-641d-3051-d22c-dab7aaa5704c@kernel.dk>
 <20200115165017.GI1333@asgard.redhat.com>
 <a039f869-6377-b8b0-e170-0b5c17ebd4da@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a039f869-6377-b8b0-e170-0b5c17ebd4da@kernel.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:53:27AM -0700, Jens Axboe wrote:
> We'd need it in a union for this to work.

Note that union usage may be a bit problematic, as it may lead to difference
in behaviour (and possible subtle bugs, as a result) between native 32-bit
kernel and 64-bit one in compat mode due to the fact that u64_to_user_ptr
doesn't check higher 32 bits on 32 bit kernels; it is mostly ignored
in the case of plain __u64 usage, as it is less likely to pass garbage
in the higher 32 bits in that case, but the issue, nevertheless, stands,
so I'd propose to check these bits in case the union approach
is implemented.

