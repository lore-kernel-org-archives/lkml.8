Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D60BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B38207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPQbM/zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgATLcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726752AbgATLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579519954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9SYcfz1oePHF0++rlV1xUZ6OF7Ac6ASAIkjSA5Z3T4=;
        b=KPQbM/zbpH6pFuDRiTLV0X/G/TJJ6DiTClEMqb4f4TC0gERBJoAVvDd5H+97s1wJ3wdaQR
        eCn41PTo3POoM7Mu/Ei5U8Qi0OI/WomEZuE/xBMl4SlCVrCq6HWdA6H9L3p+0QZ42YiWyY
        e7DOBnGzeekTCpepTp8c+ihHd9IKB0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-pJN7XweONy2WmwNrjbK5cw-1; Mon, 20 Jan 2020 06:32:31 -0500
X-MC-Unique: pJN7XweONy2WmwNrjbK5cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72C34107ACC4;
        Mon, 20 Jan 2020 11:32:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AADFA8BE0D;
        Mon, 20 Jan 2020 11:32:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200120085411.116252-1-weiyongjun1@huawei.com>
References: <20200120085411.116252-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] watch_queue: Fix error return code in watch_queue_set_size()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <771478.1579519948.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Jan 2020 11:32:28 +0000
Message-ID: <771479.1579519948@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

>  	pages =3D kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
> -	if (!pages)
> +	if (!pages) {
> +		ret =3D -ENOMEM;

I think the preferred method would be to set ret before calling kcalloc as=
 the
attached.

David
---

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 8c625cf451e6..a11724d66834 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -249,6 +249,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe=
, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 =

+	ret =3D -ENOMEM;
 	pages =3D kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
 	if (!pages)
 		goto error;

