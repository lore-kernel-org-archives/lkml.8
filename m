Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95719C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB320737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDIq1pgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGCEuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:50:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27976 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725764AbgGCEun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593751843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91u9x3PurKyYQuo/GKg5Q8kQqmkXpBjemFQPdQHOu3c=;
        b=GDIq1pgOp7Dl7qszXaE/SXVlApNLGgzFnOqwlYRQOkAktmYhHtZNkrRlb5v3VyXTghxb96
        VpbTjkqjES96URvoKxTyOa9dx4iQVXLFjo6nwLf+wm1cokyKuS44dTnnGFkKZLkhGecqad
        VBMhI0cqRV+st0A++x7Tf2e55JUYA1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-uZl0zMuhPiGGlHVu-yBVZg-1; Fri, 03 Jul 2020 00:50:39 -0400
X-MC-Unique: uZl0zMuhPiGGlHVu-yBVZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81215800C60;
        Fri,  3 Jul 2020 04:50:36 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-10.pek2.redhat.com [10.72.13.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7E4F5BAD5;
        Fri,  3 Jul 2020 04:50:26 +0000 (UTC)
Date:   Fri, 3 Jul 2020 12:50:23 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, arnd@arndb.de, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de, corbet@lwn.net,
        bhsharma@redhat.com, horms@verge.net.au, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 5/5] kdump: update Documentation about crashkernel on
 arm64
Message-ID: <20200703045023.GB28640@dhcp-128-65.nay.redhat.com>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-6-chenzhou10@huawei.com>
 <20200703044635.GA28640@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703044635.GA28640@dhcp-128-65.nay.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/20 at 12:46pm, Dave Young wrote:
> Hi,
> 
> Thanks for the update, but still some nitpicks :(
> 
> I'm sorry I did not catch them previously,  but maybe it is not worth to
> repost the whole series if no other changes needed.

Feel free to add my acks for the common kdump part:

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

