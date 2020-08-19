Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0312C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88AF205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N89EMM+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgHSMEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:04:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26330 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728358AbgHSMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597838618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9+0bAxLuUQbDhStzV9Q7LQwgzKpdo+DUCTWFOEtQPc=;
        b=N89EMM+Df1NfsAsDtGUcT8iRMU8piiaEhhvDKpiicSe1fCElL8tu9sbyCq9l3ShYfBjSoh
        uqFMYi3sqFAN9vBKCYH77qd7TWrHx5EgAxAp6BCjlGm+GNkDzrhyWNdPZKm5NPPY7T7IP+
        0aFKlm/yKU1V8PamcAPzoDRdqxBMI2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-9z5gyIZuP6iSl37NVFxRVQ-1; Wed, 19 Aug 2020 08:03:16 -0400
X-MC-Unique: 9z5gyIZuP6iSl37NVFxRVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E754A801AE5;
        Wed, 19 Aug 2020 12:03:12 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5C947A421;
        Wed, 19 Aug 2020 12:03:04 +0000 (UTC)
Date:   Wed, 19 Aug 2020 20:03:01 +0800
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
Message-ID: <20200819120301.GA13727@dhcp-128-65.nay.redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
 <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
 <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/20 at 03:07pm, chenzhou wrote:
> 
> 
> On 2020/8/10 14:03, Dave Young wrote:
> > Hi,
> >
> >>> Previously I remember we talked about to use similar logic as X86, but I
> >>> remember you mentioned on some arm64 platform there could be no low
> >>> memory at all.  Is this not a problem now for the fallback?  Just be
> >>> curious, thanks for the update, for the common part looks good.
> >> Hi Dave,
> >>
> >> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
> > I meant about this reply instead :)
> > https://lkml.org/lkml/2020/1/16/616
> Hi Dave,
> 
> Sorry for not repley in time, I was on holiday last week.

Hi, no problem, thanks for following up.

> 
> The platform James mentioned may exist for which have no devices and need no low memory.
> For our arm64 server platform, there are some devices and need low memory.
> 
> I got it. For the platform with no low memory, reserving crashkernel will  always fail.
> How about like this:

I think the question should leave to Catalin or James, I have no
suggestion about this:)

> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8e34d97a894..4df18c7ea438 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -147,7 +147,7 @@ static void __init reserve_crashkernel(void)
>         }
>         memblock_reserve(crash_base, crash_size);
>  
> -       if (crash_base >= CRASH_ADDR_LOW_MAX) {
> +       if (memstart_addr < CRASH_ADDR_LOW_MAX && crash_base >= CRASH_ADDR_LOW_MAX) {
>                 const char *rename = "Crash kernel (low)";
>  
>                 if (reserve_crashkernel_low()) {
> 
> 
> Thanks,
> Chen Zhou
> 
> >
> > Thanks
> > Dave
> >
> >
> > .
> >
> 
> 

