Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDF0C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D59C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpMXv6ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXBX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:23:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727151AbgBXBX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582507437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8JUnLh89M4fi7B5JYgxQ+iHa3guaoKzTWzA8Cq+bHk=;
        b=BpMXv6lncsLevzzZtr8f+Qg80oUgEaHbZHDIVi27zNDPslpb7QS7hh0leUVsOHYtK6UNqe
        4yFQvUxX/2S32dkFS6ECSJS4eNr49Gw8s0jMKqSWbqngVp4O2IedmhN4VD+XV3iDp9ZBG0
        7ivruuFf23OZ1LL/LMBMIaVnURIXJXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-4E8PyZmEOp2GT8nmNgn5gw-1; Sun, 23 Feb 2020 20:23:54 -0500
X-MC-Unique: 4E8PyZmEOp2GT8nmNgn5gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9F828017CC;
        Mon, 24 Feb 2020 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 222898B755;
        Mon, 24 Feb 2020 01:23:50 +0000 (UTC)
Subject: Re: [PATCH 02/30] dax: Add missing annotations ofr dax_read_lock()
 and dax_read_unlock()
To:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "open list:DEVICE DIRECT ACCESS DAX" <linux-nvdimm@lists.01.org>
References: <0/30> <20200223231711.157699-1-jbi.octave@gmail.com>
 <20200223231711.157699-3-jbi.octave@gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <dddff25c-9716-74f4-7fdb-c6b8f849e8f4@redhat.com>
Date:   Mon, 24 Feb 2020 09:23:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200223231711.157699-3-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/20 7:16 AM, Jules Irenge wrote:
> Sparse reports warning at dax_read_lock() and at dax_read_unlock()
>
> warning: context imbalance in dax_read_lock() - wrong count at exit
>   warning: context imbalance in dax_read_unlock() - unexpected unlock
>
> The root cause is the mnissing annotations at dax_read_lock()
> 	and dax_read_unlock()
s/mnissing/missing
> Add the missing __acquires(&dax_srcu) notations to dax_read_lock()
> Add the missing __releases(&dax_srcu) annotation to dax_read_unlock()
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>   drivers/dax/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 26a654dbc69a..f872a2fb98d4 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -28,13 +28,13 @@ static struct super_block *dax_superblock __read_mostly;
>   static struct hlist_head dax_host_list[DAX_HASH_SIZE];
>   static DEFINE_SPINLOCK(dax_host_lock);
>   
> -int dax_read_lock(void)
> +int dax_read_lock(void) __acquires(&dax_srcu)
>   {
>   	return srcu_read_lock(&dax_srcu);
>   }
>   EXPORT_SYMBOL_GPL(dax_read_lock);
>   
> -void dax_read_unlock(int id)
> +void dax_read_unlock(int id) __releases(&dax_srcu)
>   {
>   	srcu_read_unlock(&dax_srcu, id);
>   }

