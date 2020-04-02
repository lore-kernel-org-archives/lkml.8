Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ECC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9C2074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiAzN/Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbgDBR6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:58:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388641AbgDBR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585850319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NEefEuPt19eXKr0aYLp6K0QHZOSz7uK3FpT9vTXrck=;
        b=PiAzN/VkA94+sFyn0xYbGejTMyAHjoa56RItAk3BvRW2fC0oexTMXdjGvjVakILXVnCSIu
        /OA965D0ML0ONbsG6o9qFsl1iC/MKXTP0JmditXVvp6+VhZbeahEE92GBneEnj4H05LrUV
        Tc2WcPh1uld+kw6sFQIybqRD/Me9w+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-AQsWQSAEM465z1UW1i8YhA-1; Thu, 02 Apr 2020 13:58:34 -0400
X-MC-Unique: AQsWQSAEM465z1UW1i8YhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF8480268F;
        Thu,  2 Apr 2020 17:58:31 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82D8D60BF4;
        Thu,  2 Apr 2020 17:58:30 +0000 (UTC)
Date:   Thu, 2 Apr 2020 12:58:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 00/10] Objtool updates for easier portability
Message-ID: <20200402175827.kk7su6mo42aa6bh5@treble>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:28:37PM +0000, Julien Thierry wrote:
> Hi,
> 
> This patchset includes some of the least controversial changes that
> were needed as part of the arm64 port [1].
> 
> I'm resending these rebase on top of linux-tip/core/objtool, following
> the addition of Peter's patches [2]
> 
> It consist mostly of small fixes or lifting some limitations to make it
> easier to support a new architecture in objtool. Of course, these will
> not be the only required changes, but these are the ones I hope make
> enough sense to be merged separately from the rest of arm64 port series.
> 
> Changes since v1[3]:
> - Really just rebased things
> 
> [1] https://lkml.org/lkml/2020/1/9/643
> [2] https://lkml.org/lkml/2020/3/25/807
> [3] https://www.spinics.net/lists/kernel/msg3453718.html
> 
> Thanks,
> 
> Julien

I'm taking everything except 5, 7, and 10.  I'll run them through
testing and then send them along to the tip maintainers.  Thanks!

-- 
Josh

