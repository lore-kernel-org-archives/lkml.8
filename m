Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D05C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C9620714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS2OSk6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBLJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:15:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59446 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728150AbgBLJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581498909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emUnSXuU1gnGL6zBKl9lbYM4Of017ZRheWAF5EOYEWY=;
        b=FS2OSk6upgltjg2vreNmq/dtvHghwkQpduwJpo96eJvK2ynAHPVGFc7zZU+1KtOfe6kVES
        VAmx6vAiF1ikVGd6izueqm2VgNjcUbkjGNUJv9iAhF5PA1RZ9gdt7iMWqXiYQ8lO541rij
        xdAib4Ygl3S+ZddLHgK8agxWnsxnfmk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-zb57WKeHOcC6QVaQVaWzPw-1; Wed, 12 Feb 2020 04:15:06 -0500
X-MC-Unique: zb57WKeHOcC6QVaQVaWzPw-1
Received: by mail-qt1-f197.google.com with SMTP id g26so836720qts.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=emUnSXuU1gnGL6zBKl9lbYM4Of017ZRheWAF5EOYEWY=;
        b=fedk4vPtppi8js+h59MBO4c8Wy5XiQxFFHfujXCA2WgeS+bY2PL08+kUVlr5YJi5Cl
         veJLhfRmaGqFKFkdGaYcnYS/pq7dkWILdtycye0QGljEPqz6OkSmRspkHKZg8xukxfEb
         W1wp5Sq/4Zn+biQ+FMpnGpOjM4WlusxsYEqOAj2j5vADqk/TFFDuOkZI+bhR0+XTU0iy
         VNF21DfYlmV09rMMnBlZIy/aQvkPKXu08MLy1DCTpn5BXH9LQ7EoRcgd5LGYv6W9dArd
         io3hdPRVv3vcbcqmYUNy9JF1OOfMSLIdyNmOxXQtP9qMumgmHo61hnf5VxRnqFoESRv1
         U5gw==
X-Gm-Message-State: APjAAAX5y3txcLBFgQU4++1Cyjp1SQkzAWVZQRb59OzgO4L6DKJ69aWH
        K8rivFhs37OQ8VTsAPuyLnXS79qTB7EC+4RzICzHxCdEonKwlyLywGP18cmWP77G545UP3XFkU8
        lQ826dSkK1t5uJ1cxXmAQlZqc
X-Received: by 2002:a37:9d44:: with SMTP id g65mr9308941qke.15.1581498906464;
        Wed, 12 Feb 2020 01:15:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlftBNRnpiBz+KvKNJz2frshDsvKQ2+OJG52e1nrZBO4xynJpwxurqShPM5E74UZozY6B2ag==
X-Received: by 2002:a37:9d44:: with SMTP id g65mr9308935qke.15.1581498906290;
        Wed, 12 Feb 2020 01:15:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id h14sm84919qke.99.2020.02.12.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 01:15:05 -0800 (PST)
Date:   Wed, 12 Feb 2020 04:15:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Zha Bin <zhabin@linux.alibaba.com>, slp@redhat.com,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200212041317-mutt-send-email-mst@kernel.org>
References: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
 <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
 <20200211090003-mutt-send-email-mst@kernel.org>
 <4557a5e8-74eb-f238-1579-b7b558cb2969@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4557a5e8-74eb-f238-1579-b7b558cb2969@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:03:00PM +0800, Jason Wang wrote:
> 
> On 2020/2/11 下午10:00, Michael S. Tsirkin wrote:
> > > Yes, it can work but it may bring extra effort when you want to mask a
> > > vector which is was shared by a lot of queues.
> > > 
> > > Thanks
> > > 
> > masking should be per vq too.
> > 
> > -- 
> 
> 
> Yes, but if the vector is shard by e.g 16 queues, then all those virtqueues
> needs to be masked which is expensive.
> 
> Thanks

I think that's ok - masking is rare. in fact if vectors can be
changed atomically I'm no longer sure they are needed,
maybe a destructive "disable" which can lose interrupts
is enough.

-- 
MST

