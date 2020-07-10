Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63803C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34906207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTvIS/3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGJN1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:27:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbgGJN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594387632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8A/1vpEmoSOyHkkH6nhIq0DHvbGeWI2fZCwGb0gKD0U=;
        b=ZTvIS/3VgfJzVLdZ1stwoHBYKFNEg5QV99BbNE1BSIougrfBUdecwRkF56iqjdNVtwObVI
        +rlBsqpjHeCrA40FCxLACT/dmZBWEMD7T7NqCUreOl16K2eZ7PjKU9HrW4F5Wl5W3bHjSS
        b2kCnU8gO2MYr5qOqBNiZYfejnP/sY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-iB5ik_0TPn-3lfedhmvmhg-1; Fri, 10 Jul 2020 09:27:10 -0400
X-MC-Unique: iB5ik_0TPn-3lfedhmvmhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447AB1092;
        Fri, 10 Jul 2020 13:27:08 +0000 (UTC)
Received: from carbon (unknown [10.40.208.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACAD478A4B;
        Fri, 10 Jul 2020 13:27:00 +0000 (UTC)
Date:   Fri, 10 Jul 2020 15:26:58 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: generic DMA bypass flag v4
Message-ID: <20200710152658.31a9391a@carbon>
In-Reply-To: <20200708152449.316476-1-hch@lst.de>
References: <20200708152449.316476-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jul 2020 17:24:44 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Note that as-is this breaks the XSK buffer pool, which unfortunately
> poked directly into DMA internals.  A fix for that is already queued
> up in the netdev tree.
>=20
> Jesper and XDP gang: this should not regress any performance as
> the dma-direct calls are now inlined into the out of line DMA mapping
> calls.  But if you can verify the performance numbers that would be
> greatly appreciated.

=46rom a superficial review of the patches, they look okay to me. I don't
have time to run a performance benchmark (before I go on vacation).

I hoped Bj=C3=B6rn could test/benchmark this(?), given (as mentioned) this
also affect XSK / AF_XDP performance.

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

