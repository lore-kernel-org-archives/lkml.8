Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32057C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE3F20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyoXPdye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHNFvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:51:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21580 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgHNFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597384291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4eFb0x1bgAtaNVjZyGJiTbqbSK0ZBQoYWyMZYDO0tk=;
        b=IyoXPdyehLiEwESUAgbN1zqQOsgL+9sSPXkYctcjLSf0HMVqsS/QQVEgauW/iyecnzJhhl
        GqPDF12rCdU/ckt0ykwZPavDpvki9JCreB5aGuJQq+mAkdyKiZajlAtsCdWfAiH1XPDjXR
        M1g9q22xeBG0DVQO+RgAcHCXkocK/bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543--ZbG-KaWOlmN6ar__nZYRg-1; Fri, 14 Aug 2020 01:51:29 -0400
X-MC-Unique: -ZbG-KaWOlmN6ar__nZYRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC7E802B45;
        Fri, 14 Aug 2020 05:51:27 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9243F5D9D2;
        Fri, 14 Aug 2020 05:51:23 +0000 (UTC)
Date:   Fri, 14 Aug 2020 13:51:19 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] kexec: Delete an unnecessary comparison
Message-ID: <20200814055119.GA17263@dhcp-128-65.nay.redhat.com>
References: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/20 at 08:45pm, Youling Tang wrote:
> Regardless of whether the ret value is zero or non-zero, the trajectory
> of the program execution is the same, so there is no need to compare.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 78c0837..3ad0ae2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
>  						     digest, SHA256_DIGEST_SIZE, 0);
> -		if (ret)
> -			goto out_free_digest;
>  	}
>  
>  out_free_digest:
> -- 
> 2.1.0
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

