Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE62C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C956B2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3xCc2pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgHJGEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:04:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgHJGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597039457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/g6ocOTxpoqmnPi0HORaNoUPZsIO5+a1HDXeru2CPY=;
        b=S3xCc2pTOnhkz4TOfvS4ujS6d1duDPuoNqp78UWrbkHu+DLJnUVtXwhzeR1l4gYv+7oMYS
        ZigwtWxHM85IvcZ1Pkr4PN58gPQdD1ouHTzOUqbmJxWcQq7OfDVsEvBtfX548ZaGTqNglQ
        oT1vqBML3ym4JtFn/zQtDFpxwgJPbR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-DPkl7louOe-6NWjDofFxMg-1; Mon, 10 Aug 2020 02:04:13 -0400
X-MC-Unique: DPkl7louOe-6NWjDofFxMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1007579EC1;
        Mon, 10 Aug 2020 06:04:11 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-38.pek2.redhat.com [10.72.13.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4045C22A;
        Mon, 10 Aug 2020 06:03:59 +0000 (UTC)
Date:   Mon, 10 Aug 2020 14:03:55 +0800
From:   Dave Young <dyoung@redhat.com>
To:     chenzhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Previously I remember we talked about to use similar logic as X86, but I
> > remember you mentioned on some arm64 platform there could be no low
> > memory at all.  Is this not a problem now for the fallback?  Just be
> > curious, thanks for the update, for the common part looks good.
> Hi Dave,
> 
> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?

I meant about this reply instead :)
https://lkml.org/lkml/2020/1/16/616

Thanks
Dave

