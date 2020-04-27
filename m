Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04489C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C895E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Iv7lN4SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD0SDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgD0SDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:03:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97BFC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:03:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so641200wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8kkiQoZyL52bM98uS+NVNJ+KUSycw9kMBRFEFYEjPyo=;
        b=Iv7lN4SYgCC8OCj34c9Lww3ZLGvoQTjyKptBU5gHoNiBmYcM6Rn7qkDZO4H9ehwNRI
         SxI0MVDhCwo1G4h7Upp9rJgTrU8tsu6w2MjiZAaxNZQl2up9C6rIig0GGKUFmyHFZEG5
         5qelknXeJyP5KKvQjk0ughV21vg44zk+NAgpD1JxF8NnQ5S7cXSjJnO/Tw49f0YQ6DVK
         sFgEZ1jf7yvJVI5yAqeqR0ncOP3jHQ1u3ia/jgiEJlG/R9LYLot9BYzo9V7ByfXdruaX
         0h1fFb0VdmK+EirNJQMvCOG2+3+Ll5qd7aHBHslD8CYAMKvLnOUBBUNwr7HnTaBe3Zyu
         PhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8kkiQoZyL52bM98uS+NVNJ+KUSycw9kMBRFEFYEjPyo=;
        b=pa/DnNsxkfYE/B1XWv4lCXTPI29byOArNgIXsYBmYv8uwVx81P2zDjwEEu4410jfP2
         yBaQR9PebIEtoUfe3zN1u+Csb/80Kq6L8mDlGMIGXIhiHFFlFvHU9F3JywoIp1TbymsE
         KATJScXEt3qE4A2XandtHVR08Go3Qy3QZ7PsMIs9lZCcLYN3ZkENnEZ1Qb/DRKPydeOo
         +lppX7O1MY5jQnYcnlOU+jRgchnF/VbyPzXr0FtEhGh2tMcW2Frd160jx1/Nr6VPDbfJ
         eT8two9LdszLpPlzgez+xmN7CbFUkpipirOQ89NQ8r+ERirT2jvuFK6oZKUwpJXUnMxh
         jjRA==
X-Gm-Message-State: AGi0PuYellEB4w6ufUDN0JlstBSkgJVuPxp056KKsVw+sDJHkzFpITaI
        wCHmfn9d/oELGlAXHSTOAy0/Aw==
X-Google-Smtp-Source: APiQypIBvmmtnAK8BhRP5kW/qy9KU+eOczQrDkh0Mx/nX8nsKauWKImyvvS3MLQzevLvhmx1gpPDGQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr663782wmk.97.1588010593436;
        Mon, 27 Apr 2020 11:03:13 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
        by smtp.gmail.com with ESMTPSA id n25sm11445511wmk.9.2020.04.27.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 11:03:12 -0700 (PDT)
Date:   Mon, 27 Apr 2020 20:03:11 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200427123443.520469-1-niklas.cassel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2020 14:34, Niklas Cassel wrote:
>When jumping to the out_put_disk label, we will call put_disk(), which will
>trigger a call to disk_release(), which calls blk_put_queue().
>
>Later in the cleanup code, we do blk_cleanup_queue(), which will also call
>blk_put_queue().
>
>Putting the queue twice is incorrect, and will generate a KASAN splat.
>
>Set the disk->queue pointer to NULL, before calling put_disk(), so that the
>first call to blk_put_queue() will not free the queue.
>
>The second call to blk_put_queue() uses another pointer to the same queue,
>so this call will still free the queue.
>
>Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>---
> drivers/nvme/host/core.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 91c1bd659947..f2adea96b04c 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>
> 	return;
>  out_put_disk:
>+	/* prevent double queue cleanup */
>+	ns->disk->queue = NULL;
> 	put_disk(ns->disk);
>  out_unlink_ns:
> 	mutex_lock(&ctrl->subsys->lock);
>-- 
>2.25.3
>
What about delaying the assignment of ns->disk?

diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
index a4d8c90ee7cc..6da4a9ced945 100644
--- i/drivers/nvme/host/core.c
+++ w/drivers/nvme/host/core.c
@@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
         disk->queue = ns->queue;
         disk->flags = flags;
         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
-       ns->disk = disk;

         __nvme_revalidate_disk(disk, id);

@@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
                 }
         }

+       ns->disk = disk;
+
         down_write(&ctrl->namespaces_rwsem);
         list_add_tail(&ns->list, &ctrl->namespaces);
         up_write(&ctrl->namespaces_rwsem);


Javier
