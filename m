Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE6C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B13208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuRKAySC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDGDoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:44:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgDGDoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586231048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zZ0JGcJ7gllvczOenUswCIodif7F/kuIKIyA7jrbYg=;
        b=MuRKAySCbOywQneejllL+j3NXMiaFNZCyT07monzG2eMlQ00SLxcik/QlqA22uxqCLg8BP
        R3dpvodlpVr1iDpKuQTkw8TOhLFA24rGxI7nDfvUzyvC5hAEtZskgK9mmPx17vG/jNM1aY
        9k+nIFfNtW9BZdNeAdZfxev56TvAVoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-PNLJCvtANM2QVyyF4HjwKA-1; Mon, 06 Apr 2020 23:44:06 -0400
X-MC-Unique: PNLJCvtANM2QVyyF4HjwKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2CE31005513
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 03:44:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABA5DD766D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 03:44:05 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9F86318095FF;
        Tue,  7 Apr 2020 03:44:05 +0000 (UTC)
Date:   Mon, 6 Apr 2020 23:44:05 -0400 (EDT)
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <2049984978.20929266.1586231045581.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
Subject: Re: [PATCH v8 00/19] virtio: alignment issues
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.20, 10.4.195.30]
Thread-Topic: virtio: alignment issues
Thread-Index: KMkGKTubGwiP4mmEdkmEQxPtOtoC4g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> 
> 
> This is an alternative to
> 	vhost: force spec specified alignment on types
> which is a bit safer as it does not change UAPI.
> I still think it's best to change the UAPI header as well,
> we can do that as a follow-up cleanup.
> 
> changes from v7:
> 	typo fix
> changes from v6:
> 	add missing header includes all over the place
> changes from v5:
> 	ack for mellanox patch
> 	fixup to remoteproc
> changes from v4:
> 	fixup to issues reported by kbuild
> changes from v3:
> 	tools/virtio fixes
> 	a bunch more cleanups that now become possible
> 
> Changes from v2:
> 	don't change struct name, instead add ifndef
> 	so kernel does not see the legacy UAPI version.
> 
> Jason, can you pls ack one of the approaches?

Btw, this sereis includes the bathing optimization which I think
should be done in another one.

Thanks

