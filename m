Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A093C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED87206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApTIxpeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGZNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 09:31:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20500 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbgGZNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 09:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595770260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/A2bM4QDQNoWhlsEvHOmFTbiGGj6Tky9OF/epfzxYU=;
        b=ApTIxpeoL+rkSUq8XIYADlXwt6r7hGpzoa03B7iPvD/5f1yqoPXwM7Ne0PKvESfqXtVfeR
        xBrn1r3yT4U9lchSc5kgwiDTKCOZLAIT839d3W6qHGXhroOv5OiKqfuzJe1Fbh1x7G9WlS
        kMgbqQtwwvSzIJfUG1oveDqh+W2fd/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-49rHXPKhNie0iPPxSI1LUg-1; Sun, 26 Jul 2020 09:30:54 -0400
X-MC-Unique: 49rHXPKhNie0iPPxSI1LUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A48F1902EA0;
        Sun, 26 Jul 2020 13:30:53 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E02C61001281;
        Sun, 26 Jul 2020 13:30:52 +0000 (UTC)
Date:   Sun, 26 Jul 2020 07:30:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Geoffrey McRae <geoff@hostfission.com>
Cc:     hdanton@sina.com, tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Poor windows VFIO performance, GPU stalls (bisected)
Message-ID: <20200726073052.284dadb2@x1.home>
In-Reply-To: <30452714b2935b530b9c2bbf2d20854a@hostfission.com>
References: <30452714b2935b530b9c2bbf2d20854a@hostfission.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 17:49:07 +1000
Geoffrey McRae <geoff@hostfission.com> wrote:

> Hi All,
> 
> The commit 22540ca3d00d2990a4148a13b92209c3dc5422db causes a Windows KVM 
> guest running under QEMU with a VFIO passthrough GPU to randomly stall 
> when using the GPU leading to the guest assuming that the driver has 
> hung. Reverting this commit resolves the problem.

Please double check this commit ID, I can't find it in mainline or
linux-next.  Thanks,

Alex
 
> The host system is configured with the following kernel arguments which 
> may be related:
>    isolcpus=0-5,24-29,6-11,30-35 rcu_nocbs=0-5,24-29,6-11,30-35
> 
> The system is an AMD Threadripper 2970WX on a Gigabyte x399 AORUS Gaming 
> 7 board.
> It has two GPUs each being passed through to two separate KVM guests, 
> one is an AMD Radeon 7 in a Linux guest, the other is a GeForce 1080Ti 
> in a Windows guest.
> The cores used for these two guests are isolated from the host for 
> performance reasons.
> 
> Any insight as to why this is occurring would be appreciated. If you 
> need any more information or would like to test patches please let me 
> know.
> 
> Kind Regards,
> Geoffrey McRae
> HostFission
> 
> https://hostfission.com
> 

