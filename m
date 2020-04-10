Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593B8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D83920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586532267;
	bh=YAh7F8xqHYA/YYq63Fw4pG/inlVkd2YY4Y0mqVN0Y9w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=GFXnMybkVBnrGvQKTl9RT+l4nrnNqDgNLSmCjdzAMcCS73UgGQaGoi3aIAQacaMKU
	 k6HjHnEFCtHVoTGGfyStwNi/qddjQr3DAuvBirCFVLXWsbpFh5I1Nqmjqi+uJz7vBA
	 IBAJC6NKDTgQJoN2fVpgR1AS3cZdw1YT83KtO+9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDJPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:24:25 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4565C206F7;
        Fri, 10 Apr 2020 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586532265;
        bh=YAh7F8xqHYA/YYq63Fw4pG/inlVkd2YY4Y0mqVN0Y9w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=k70eLZfHUtQ2Pbb5jyVkNmqTFx2MpQUakHbDZZpZWO2N4NBDibqs0LkdKrIzhFHZ3
         Rf30ZtpeU9sXmnwd+wMYlsXOscYDGX4MEWNvnTLSChicge4pmgTiZ6Bm1dGPca4P/s
         iMni8Bwaz8wnaZa4Gw4hCgjc0MW876J1QILgRfBw=
Date:   Fri, 10 Apr 2020 08:24:18 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     YueHaibing <yuehaibing@huawei.com>
cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] xen/pvcalls: Make pvcalls_back_global static
In-Reply-To: <20200410115620.33024-1-yuehaibing@huawei.com>
Message-ID: <alpine.DEB.2.21.2004100824020.19608@sstabellini-ThinkPad-T480s>
References: <20200410115620.33024-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/xen/pvcalls-back.c:30:3: warning:
>  symbol 'pvcalls_back_global' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/pvcalls-back.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
> index cf4ce3e9358d..4807704f8d69 100644
> --- a/drivers/xen/pvcalls-back.c
> +++ b/drivers/xen/pvcalls-back.c
> @@ -24,7 +24,7 @@
>  #define PVCALLS_VERSIONS "1"
>  #define MAX_RING_ORDER XENBUS_MAX_RING_GRANT_ORDER
>  
> -struct pvcalls_back_global {
> +static struct pvcalls_back_global {
>  	struct list_head frontends;
>  	struct semaphore frontends_lock;
>  } pvcalls_back_global;
> -- 
> 2.17.1
> 
> 
