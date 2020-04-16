Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A17C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75429221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjmCqUQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgDPV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:58:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgDPV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587074328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6rrlZafhN6r+ubaAk51QbjlJxlyC5zfccAUUw8zuIQ=;
        b=EjmCqUQUNepT3q3TW1CAHlKf2tMfLu4nMJKIy1zPpfGVeqUj+ElCpAo4zLQPZhwCXpBVu1
        9Rp/DQbzQCdVt2o0QbZ/Q6GOS5dmqCyND45j3kuW1wwS50PuIchk4gxnv3LdCjT2AMUQei
        22JbU079yHy5dxanIpDwXN6/Z7bLTWE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Rl-7r6BlOtebRzhYtGRGLA-1; Thu, 16 Apr 2020 17:58:47 -0400
X-MC-Unique: Rl-7r6BlOtebRzhYtGRGLA-1
Received: by mail-wr1-f71.google.com with SMTP id f15so2466323wrj.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6rrlZafhN6r+ubaAk51QbjlJxlyC5zfccAUUw8zuIQ=;
        b=WZ2jfEypBzxQJy09EY+UP2umBm+PGW6pJoujMTuNQfItJo1kaXx3GqUgMP/K0AZIf+
         CEDWOLvHcRdAHdcCGT4LrYV8r371vDNDOuPGxslLjy0A6ODf/sjhF8q9OfLh039OVDZy
         UfE7uBnQAjdahvPYl8g8QfRa4DDtx5fNC3IqtMp4/tloQ487Y/sWDFzVQVjTUBuhZ8Aw
         X+/YAbDIkU7ybgkqdVYuJ5Lj8Okc5wV3UQbIgOLq2Dv9IJRQe9TzHk30yFmS9a6mtrRY
         zlZk//a/FgzbTh32WkMGtTSLJQUmVBeMkBktajAgBTnarjZWF9hUcfcPDw8dy4gUEW9f
         95eg==
X-Gm-Message-State: AGi0PuZnfoqaLPYOwEi9GEbEVhER08LwqjLgBWHUmOM6qBUR9aYCJqfO
        0ewMSZIz+KDmGq5ekDU2lauVaK+iyjrJ81Nt7IRvw5mdTHyNtX2AS14lSnrEvPQdf5WQL85ePOT
        DATleZqDOFCTKWOomgNt3Fkb3
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr6583328wmn.81.1587074325890;
        Thu, 16 Apr 2020 14:58:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypJuACRXU/ZXNyriL39YVRQFFxgHb4YC1TCpFzp0oXAv3mKwmNTGsmU40akcPlLbxfOx28D8Wg==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr6583297wmn.81.1587074325695;
        Thu, 16 Apr 2020 14:58:45 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id f79sm5629022wme.32.2020.04.16.14.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:58:45 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:58:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, ashutosh.dixit@intel.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        eli@mellanox.com, eperezma@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, hulkci@huawei.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>,
        matej.genci@nutanix.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        yanaijie@huawei.com, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20200416175644-mutt-send-email-mst@kernel.org>
References: <20200414123606-mutt-send-email-mst@kernel.org>
 <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
 <20200416081330-mutt-send-email-mst@kernel.org>
 <CAHk-=wjduPCAE-sr_XLUdExupiL0bOU5GBfpMd32cqMC-VVxeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjduPCAE-sr_XLUdExupiL0bOU5GBfpMd32cqMC-VVxeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 10:01:51AM -0700, Linus Torvalds wrote:
> On Thu, Apr 16, 2020 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > Well it's all just fallout from
> 
> What? No. Half of it seems to be the moving of "struct vring" around
> to other headers and stuff.
> 
> And then that is done very confusingly too, using two different
> structures both called "struct vring".
> 
> No way can I pull that kind of craziness as a "fix".
> 
>                 Linus

OK, I'll just disable vhost on that config for now - it was
suggested previously. Thanks for the comment and sorry about geeting it
wrong!


-- 
MST

