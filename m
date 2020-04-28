Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79311C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53020206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxnlsRN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD1I4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:56:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgD1I4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588064173;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ag/nIHIIOCwHrm+u9Ds/YPYwbuQscrF+6RvhQwuBjfs=;
        b=fxnlsRN94AEclEo+lRvogVLqd8NRHlh4yZmEDj8/qp/qp1+22N+mW9zLnjpnUVRPnS25N8
        3kPBiWlgXv8bexSqQ4zaHgjNxM797XOGUrmBZPoD9b8U+E75EpSyh6D2LuKeuXw3uTVoVV
        NwsHxdx+KWZzk/LK7L8UgjWLd5yDs4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-7X7UlH-EPGaiqqYM_zNc1g-1; Tue, 28 Apr 2020 04:56:09 -0400
X-MC-Unique: 7X7UlH-EPGaiqqYM_zNc1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46BA6100CC8E;
        Tue, 28 Apr 2020 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D90275D9E2;
        Tue, 28 Apr 2020 08:56:05 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Reject invalid NUMA option
To:     Will Deacon <will@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20200424045314.16017-1-gshan@redhat.com>
 <20200424101132.GC1167@C02TD0UTHF1T.local>
 <f83c0ce1-b1b2-31f4-60c8-15567b87a8ff@redhat.com>
 <20200427225406.7cacc796@gandalf.local.home>
 <20200427225944.185d4431@gandalf.local.home>
 <20200427230920.3d606a2e@gandalf.local.home>
 <7e85ea83-de5f-c789-2e3c-e468a50ed4bd@redhat.com>
 <20200428072509.GA4049@willie-the-truck>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <858cb997-d187-e605-446e-24ac4169b147@redhat.com>
Date:   Tue, 28 Apr 2020 18:56:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200428072509.GA4049@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 4/28/20 5:25 PM, Will Deacon wrote:
> On Tue, Apr 28, 2020 at 02:35:20PM +1000, Gavin Shan wrote:
>> On 4/28/20 1:09 PM, Steven Rostedt wrote:
>>
>> [...]
>>
>>>
>>> Could this be a bug in the implementation of strncmp() in
>>> arch/arm64/lib/strncmp.S. As I don't know arm64 assembly, I have no i=
dea
>>> what it is trying to do.
>>>
>>> But strncmp("o","off",3) returning zero *is* a bug.
>>>
>>
>> I think it's false alarm. The patch has been in my local repo for a wh=
ile.
>> I checked out 5.7.rc3 and tried passing "numa=3Do" to the kernel, @num=
a_off
>> is unchanged and its value is false. I also check the return value fro=
m
>> strncmp() as below, it's correct. Nothing is broken. I should have ret=
ested
>> before posting it. Sorry for the noise. Please ignore the crap patch :=
)
>=20
> Hmm, it's still worrying that you had that patch kicking around though,=
 as
> it sounds like it /used/ to be broken. Would you be able to test the LT=
S
> kernels (5.4, 4.19, 4.14, 4.9, 4.4) to check that we're not missing a
> backport, please? Sorry to be a pain, but I'd like to get to the bottom=
 of
> this!
>=20

Sure, There are nothing to worry. I tried the following branches of the s=
table
tree. They all looks good in this regard.

    linux-5.6.y
    linux-5.5.y
    linux-5.4.y
    linux-5.3.y
    linux-4.19.y
    linux-4.9.y

linux-4.4.y isn't tried because the corresponding parameter starts to exi=
st
from linux-4.7.y: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 =
platforms.")

    # git tag --contains 1a2db300348b | sort -V | head -n 3
    v4.7
    v4.7-rc1
    v4.7-rc2

In the experiment, the following pr_info() is added and I got same output
from above branches:

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index b1e42bad69ac..1e0e3491de54 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -44,6 +44,8 @@ static __init int numa_parse_early_param(char *opt)
         if (!strncmp(opt, "off", 3))
                 numa_off =3D true;
 =20
+       pr_info("=3D=3D=3D> numa_off=3D%s\n", numa_off ? "true" : "false"=
);
+


[    0.000000] NUMA: =3D=3D=3D> numa_off=3Dfalse



There is unrelated compiling warnings in linux-5.3.y:

drivers/pinctrl/pinctrl-rockchip.c: In function =91rockchip_gpio_set_conf=
ig=92:
drivers/pinctrl/pinctrl-rockchip.c:2783:3: warning: this statement may fa=
ll through [-Wimplicit-fallthrough=3D]
    rockchip_gpio_set_debounce(gc, offset, true);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-rockchip.c:2795:2: note: here
   default:
   ^~~~~~~


> Thanks,
>=20
> Will
>=20

Thanks,
Gavin

