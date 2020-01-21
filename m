Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2200C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5E2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqwMFQ7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAUIW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:22:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgAUIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579594948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+IXOERPobSolwbB9kBamtcVjIIwqZJdbh46pfHcqy8=;
        b=KqwMFQ7KQXa9ENwMb4yuD9jvRqXNjEm2aFXLSc1e/7wT9i06Q3pub6fkPP2IItHz+sZ1qf
        /+o3BzK96IGDNb/BwwBw4Yge/Udc6naIl1QbsgQKqb7M4cgYH6mVFXwqFBaHSXPzfSho+v
        AFPDmvUqm+N8oeiOzGcsQyiiz/xjJtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-BA4uRMB3OyePd8PxTjtYMA-1; Tue, 21 Jan 2020 03:22:27 -0500
X-MC-Unique: BA4uRMB3OyePd8PxTjtYMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 167FC184AD2A;
        Tue, 21 Jan 2020 08:22:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com [10.36.116.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB1F8BE23;
        Tue, 21 Jan 2020 08:22:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id CD4741138600; Tue, 21 Jan 2020 09:22:20 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     pbonzini@redhat.com, yelu@bytedance.com, libvir-list@redhat.com,
        gregkh@linuxfoundation.org, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, mprivozn@redhat.com
Subject: Re: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
        <20200110100634.491936-2-pizhenwei@bytedance.com>
Date:   Tue, 21 Jan 2020 09:22:20 +0100
In-Reply-To: <20200110100634.491936-2-pizhenwei@bytedance.com> (zhenwei pi's
        message of "Fri, 10 Jan 2020 18:06:33 +0800")
Message-ID: <87h80pi5hf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhenwei pi <pizhenwei@bytedance.com> writes:

> Add bit 1 for pvpanic. This bit means that guest hits a panic, but
> guest wants to handle error by itself. Typical case: Linux guest runs
> kdump in panic. It will help us to separate the abnormal reboot from
> normal operation.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  docs/specs/pvpanic.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
> index c7bbacc778..bdea68a430 100644
> --- a/docs/specs/pvpanic.txt
> +++ b/docs/specs/pvpanic.txt
> @@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
>  recognized by the device are set. Software should ignore bits it doesn't
>  recognize. On write, the bits not recognized by the device are ignored.
>  Software should set only bits both itself and the device recognize.

Guest software, I presume.

> -Currently, only bit 0 is recognized, setting it indicates a guest panic
> -has happened.
> +
> +Bit Definition
> +--------------
> +bit 0: setting it indicates a guest panic has happened.
> +bit 1: named crashloaded. setting it indicates a guest panic and run
> +       kexec to handle error by guest itself.

Suggest to scratch "named crashloaded."

The whole file is rather terse.  I figure that's okay as along as
there's just "guest panicked", because "kernel panic" is obvious enough.
The addition of "panicked, handling with kexec" makes it less obvious.
The commit message provides a bit more guidance.  Could that be worked
into this file?

>  
>  ACPI Interface
>  --------------

