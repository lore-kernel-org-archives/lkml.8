Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A7CC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036E42073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixTRfI6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDWUtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:49:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgDWUte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587674973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpfM6TK/0jJscTZNrGZn3Mz2FJsfk4oVi2Msfy8udyc=;
        b=ixTRfI6ojKZrPGf/B7xqg/Llr765JsgnhHvBpA4fxIWOYUgCwS2IRmosVi3lBp8wPTrDy3
        CJQDsWPyoWkIm6pmFeUxJ4GW3ffJ3onJn2qYaUdChZdaJ4atXjdp/giVwAOWOjupGefAvA
        tOA1REGwk3dPxEwNKrCHB9kAf0BUA6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-IrxtYKNiPRitE6cYZagNhQ-1; Thu, 23 Apr 2020 16:49:31 -0400
X-MC-Unique: IrxtYKNiPRitE6cYZagNhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCC8D1054F8B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:49:30 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-119-233.rdu2.redhat.com [10.10.119.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF9A25D9CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:49:30 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id C88D012025C; Thu, 23 Apr 2020 16:49:29 -0400 (EDT)
Date:   Thu, 23 Apr 2020 16:49:29 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd4: stid display should preserve on-the-wire byte
 order
Message-ID: <20200423204929.GA11239@pick.fieldses.org>
References: <1587674073-9551-1-git-send-email-bfields@redhat.com>
 <1587674073-9551-2-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587674073-9551-2-git-send-email-bfields@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, one other thing I noticed, in the "states" file there's a
field like:

	superblock: "fd:10:114"

That's major:minor:inode number, which is the same thing /proc/locks
uses to identify files.  "superblock" makes sense for the "major:minor"
part, but the inode number is for the one file, not the superblock.  So
that probably should have been

	superblock: "fd:10:114", inode: 114

or something.  Oh well.  It's been that way in a few kernel versions now
so I guess it's not worth breaking backwards compatibility.

--b.

