Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B08C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366C62084E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltnrjz77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgBCKfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:35:25 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35701 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgBCKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:35:25 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so6223456pjc.0;
        Mon, 03 Feb 2020 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lia+nCVPidpTdOXM9PCOjvOmj8H2mFaldrs7XGRJlZM=;
        b=Ltnrjz77GclMDf82N7PF9E4bIG28r30mif81mtf+3FynVJl/LdMnoEarJjrxihL3GV
         uk9LRxP3xIl9Lrnj37QJYxfRa/CEyEvJdtOGBzw3eDgENcXQ74ydKgRoSICheYcBZq4+
         o7ju57Saof9c07gkewzGE9XZsnmdGXq0vgsuVA3VRGLpxnc6YaeQ1T2W+qkLwot9d13C
         E2Dz6Pxjio7MGAkvD/zPRgbvIxAHmAbqdY8hjGrweMqyytfMxEGH/seLRoiW9KjsoS5W
         GbZC0aw6muYrq2RlArCfpE5lSvNGbY680tcBqWKWCHwFI8Mr24N+pWLXoZ8isEdMBNzj
         7pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lia+nCVPidpTdOXM9PCOjvOmj8H2mFaldrs7XGRJlZM=;
        b=APzJpZzl7xeTBHFFP1s4Bw/4IVDVhRuVBcQpjW8R2FOVvspiGStkSmP5i3Zxy4p7gp
         WAnlXcKULPLCvZMwA7BvHz4/kZHv+Dz49vrnx36PDBKy8Zgd+6QhoKSQlixjy3mDFg2i
         KBGdbf9SSL/PkT3sP7VmUfyEaMbmZRqeUaiQ8sH1HkFZ7xYISdYKwPbMFiefAc6O+ULi
         0FWX511JA+1oSVw7ugAymF326zloMoLRiFhNWKKVqeePsTxFqpPy2ygFnE6dN133s+oQ
         /dhm5t94jqlCJQdsZ4iAPC+vvLMAWXJpFnb4kHhSOWaC/kfXPvulIEZjGliK31koCxG6
         vM8g==
X-Gm-Message-State: APjAAAXHCWmTQq7MYlWXgC528ZmK5ByQWp9hy4Tq7kjaRE2sOLD9Ln14
        fvz+xW6R7LNAGBDLDkJilmd4qwv6OxBtYc7rxusW0poDXoA=
X-Google-Smtp-Source: APXvYqymAyffMgx0RQpZjaQQ96FpAo65pgZ1eldw3u7YisZDQSYu6+UGb0nEoO5KZOueAEU7SIi4tuzTF81/vZSlsaw=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr698048plf.255.1580726124840;
 Mon, 03 Feb 2020 02:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <20200203101806.2441-4-peter.ujfalusi@ti.com>
In-Reply-To: <20200203101806.2441-4-peter.ujfalusi@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 12:35:16 +0200
Message-ID: <CAHp75Vd-yjWV=m1TaWnqq-aTa-OGcGeUysiuJ6eDE+PezmY7gQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: Encourage dma_request_slave_channel_compat()
 users to migrate
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:


> +       dev_info(dev, "Please add dma_slave_map entry for %s:%s and migrate to"
> +                " dma_request_chan()", dev_name(dev), name);

Please, don't split string literals.

-- 
With Best Regards,
Andy Shevchenko
