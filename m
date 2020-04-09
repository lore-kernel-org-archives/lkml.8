Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80274C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366082072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqxHoMXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDIGVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:21:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgDIGVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586413275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mB7SP/Y8MXrZQ6SPWB8nv21X1ADlrVhI+qwnI43BNs=;
        b=KqxHoMXilldwjw/IdXZBQ+ZtHZk/FWbVsJa6TMPudOT4R3CXRlZMVf3SozDQQhNDM59HLN
        qlsmZOgYI3q6TR8Lxznf6Gm5xwON56azVV5YB6IjMiKNP4ZKCL4Tr1/Wxw+6/4A+PCdo9H
        pOkPKSq2qJIkdKPo1ihBm3XL/CKZOa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-4PB6D7EUPkmm0VMYoI55sA-1; Thu, 09 Apr 2020 02:21:10 -0400
X-MC-Unique: 4PB6D7EUPkmm0VMYoI55sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BA3A107B7D4;
        Thu,  9 Apr 2020 06:21:08 +0000 (UTC)
Received: from [10.72.13.188] (ovpn-13-188.pek2.redhat.com [10.72.13.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B42960C18;
        Thu,  9 Apr 2020 06:20:39 +0000 (UTC)
Subject: Re: virtio-mmio: Delete an error message in vm_find_vqs()
To:     Markus Elfring <Markus.Elfring@web.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Boyd <swboyd@chromium.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
 <03b19e72-0021-dc6b-77c4-ed3c4e13d526@redhat.com>
 <96031fc7-dced-95bd-fc57-a5fe890638f4@web.de>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6c94db13-ae46-cf8e-f3c4-6f270112ad87@redhat.com>
Date:   Thu, 9 Apr 2020 14:20:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <96031fc7-dced-95bd-fc57-a5fe890638f4@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/9 =E4=B8=8B=E5=8D=882:02, Markus Elfring wrote:
>>> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error alre=
ady.
>>> Thus omit a redundant message for the exception handling in the
>>> calling function.
>> It looks to me that not all error path of platform_get_irq() were logg=
d.
> How do you think about to clarify the handling of the error code =E2=80=
=9C-EPROBE_DEFER=E2=80=9D any more?
> https://elixir.bootlin.com/linux/v5.6.3/source/drivers/base/platform.c#=
L202


Aha, it looks to me that I'm on the wrong branch. Sorry.


>
>
>> And git grep told me there're other users of platform_get_irq() that c=
heck and log by themselves.
> Source code analysis can point further update candidates out, can't it?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/base/platform.c?id=3D7723f4c5ecdb8d832f049f8483beb0d1081cedf6


Yes, it can.


>
> Would you like to achieve collateral evolution?


Yes and it's probably be better to put all the fixes in one series.

For this patch.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> Regards,
> Markus
>

