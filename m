Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00C4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4672070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2gEmLzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGFOXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:23:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729140AbgGFOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594045390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMkDLlaHyxEo26VU8+NVZNSorJ/w0+rb3X6GaNbyCaU=;
        b=Z2gEmLzriPV0YcLemRCcDO8Ly1ApJ2oF3VvOFqXeKjFp4RfnyDewxayhhXs/wbmktheizw
        ReJoC5RC7ofTBw+1sLhc95jXQa72BNgg+a3OfLaHlj2NISaZY5GYZDGdaC++riULyrQqUa
        zYPn2LDm1hofqCWNqQIGxuKAPFYyt/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-JMrnx_lOOmi8XrKMucsVnA-1; Mon, 06 Jul 2020 10:23:08 -0400
X-MC-Unique: JMrnx_lOOmi8XrKMucsVnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB92118FE863;
        Mon,  6 Jul 2020 14:23:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 592D060C84;
        Mon,  6 Jul 2020 14:23:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200705224324.16090-1-Jason@zx2c4.com>
References: <20200705224324.16090-1-Jason@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: replace open-coded pr_warn_once() with actual call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2918158.1594045383.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 06 Jul 2020 15:23:03 +0100
Message-ID: <2918159.1594045383@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> There's no reason to open code this here, so instead replace it with
> pr_warn_once, which amounts to exactly the same thing.

Note that this file is set to be entirely deleted here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

David

