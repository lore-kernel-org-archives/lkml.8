Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5214C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F1D20768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="LuiZA/a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgDGPgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:36:48 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com ([98.137.65.82]:43881
        "EHLO sonic313-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728917AbgDGPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1586273807; bh=DRcjw4RWlx/WffnvzoKrFTQcWvavqs2gXoWOXywXOCk=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=LuiZA/a8J4tRv8OVyXpyrJG3TSZ8cWvWlv0C8Hb7y2zk+OODgV2AEqCDG7eze/O7WeQ+PFtabVgv4k0/GjnJxWiEvPxQ9DwLmvlerAkqcBzQBU1u70H2oDTPovXKlqpU3lGGtlmRqOxurDoFu3pN95CSJpeodeHwHRy7bESmwphTdYTqvgfT+z2BLQPluu5lM4ML+3XBLr3O6U+TE2ibBz4/wbOO9OkMls+TohZU1H/rHEn85kLlX/Nt45+bttpCfWOuVLT0skXbPABJ3gaGmpgEJe78Czd3dJDuhGYIob05zGAR+ohb62P6S5scKbOYKyJbMQP2u8xvUU6gYjFYqA==
X-YMail-OSG: ZZge5_4VM1kR52e0GUo2fNzjRFaCBHWfxv3eFEqMjiW_9RaNaQc0GXkvJCJiqIE
 blLtaswVknj.HLQ0tq50cqppuya9hxO4FMYBbwvzGBP.G.1PPbNwr9QGozst0N7RxnXEQztLPS4U
 OZECCg.DlMptgSP8YIx5uHu9nxLOW2fGdvHSj8bVLOL7aeyYHkAlShHyGkLFrKf_rh1PhsjSPWeh
 Z9B01Xeh3TcsGQyGNw1Twjb8bVbjwJ7kwCfUm7Rk7LunS8r0stFudDfsKWj1epUigHejRKjnivrq
 iZErCkyY8ofZxWYSszvlmCdg40JharWeEPQe.LNAuLETD8JRdg2DRCbf125WKyQFGtqSN9oUwv9r
 dehtJYhYwg8PU1pV91yrfp8bQRPBgeIV6Plyrtj6IIYLox0EdKZlyG9e5EuVy5PLJRaWAZs0dbKB
 ENHl4qzBtTgpRuIAbBRtEHKb8MOWW58uKYJVp681a7UBW4zIdThVI8ZhzIc.MMLT2AC42HZaGRU1
 fCFgslw0pIF3ENIj2aUveZgqe_0hFT7EPyT2VSHbAc7NnaU8Lh7fHUV5ee6bUsMN06aIyoiEAWCS
 MUMD9UsHbd351IsRXRaXVzJOGvh9MsdaLtGgIQRxYYetjboypwjlG9CrqJzOncoLKrOVtFR_G70H
 3yhvEJ3OUGXkGeMek4LUUfoyK_.IC0vbBUe.bn_A2yGIx4lhX1fsUc87l_VOrAm0sU3WQpM1945Q
 CjmkIBFjePN2atP1kIvJYfdJEnR0EnkVtwNOLy88bz_bLM1vSG8MACf2gYwygY6aaA3wQm4reNGx
 K01we4heQm1bV1hj6WfOdhGjglVO0SDKc_hEn44tuQQ3ahSMx5km_iFfVt2zy4V5VC.itVHKvUuQ
 wYnlCGxj6BDNTbpOzarAkWhJhvN1zgeiWvKXmyAH42yQ6PcFjZZc6NcKtf7QiDRw8FNziHcPV343
 bmF.oZlF7zbDfEjicxH9BUHmJLoqFZ63G9q3bLk5Wn46t8wegXSMGlIDa.pXUe6DMsXb_oBOsGvW
 Gen_7eZ4vVRHgMgXzS02.VvbmROcQzVuXEp0Dh7igqbqvCWMXfm5MQq4X2D2anGxK9tpL_3LNBDQ
 UmlAIXTVRIMPX0VIIDW17OsaNxC4LIy2FQnpVpswgy8XThGlQgNvHpRfTIrN8spsim4LvK5enMN.
 4YfvUu1s6bsY18FYwTXkyckVX1kZ8Omar5erlWhLXn25WrNROGO7wbkIBUUu8aXeHv2eF2BuDrG8
 eDF.AppJEZsPCbWwrYRrznjUJK_O_RDbdPIB.8sqcFzstQhEpMWcFni4j.LY_O1YTlHvkWMBTLN6
 A.WCHw50Nhut4OOKQhIfNc1mR2TxklNTq4DO1TbKgu0qoDLYd_0kjMujgMEbbNSrvuaE9DWZd2.C
 lKXXUpniCGnMLktTt43mSyiRV4A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 7 Apr 2020 15:36:47 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8d3a3a4d22c2dc4e05ca5abcebba6325;
          Tue, 07 Apr 2020 15:36:42 +0000 (UTC)
Date:   Tue, 07 Apr 2020 11:36:39 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: Bad rss-counter state from drm/ttm, drm/vmwgfx: Support huge TTM
 pagefaults
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Thomas =?iso-8859-1?q?Hellstr=F6m?= "(VMware)" 
        <thomas_os@shipmail.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?b?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-graphics-maintainer@vmware.com,
        Michal Hocko <mhocko@suse.com>, pv-drivers@vmware.com,
        Ralph Campbell <rcampbell@nvidia.com>,
        Roland Scheidegger <sroland@vmware.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <1586138158.v5u7myprlp.none.ref@localhost>
        <1586138158.v5u7myprlp.none@localhost>
        <0b12b28c-5f42-b56b-ea79-6e3d1052b332@shipmail.org>
        <1586219716.1a3fyi6lh5.none@localhost>
        <37624a1f-8e6b-fe9c-8e0e-a9139e1bbe18@shipmail.org>
In-Reply-To: <37624a1f-8e6b-fe9c-8e0e-a9139e1bbe18@shipmail.org>
MIME-Version: 1.0
Message-Id: <1586273767.0q72rozj3x.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Thomas Hellstr=C3=B6m (VMware)'s message of April 7, 2020 7:2=
6 am:
> On 4/7/20 2:38 AM, Alex Xu (Hello71) wrote:
>> Excerpts from Thomas Hellstr=C3=B6m (VMware)'s message of April 6, 2020 =
5:04 pm:
>>> Hi,
>>>
>>> On 4/6/20 9:51 PM, Alex Xu (Hello71) wrote:
>>>> Using 314b658 with amdgpu, starting sway and firefox causes "BUG: Bad
>>>> rss-counter state" and "BUG: non-zero pgtables_bytes on freeing mm" to
>>>> start filling dmesg, and then closing programs causes more BUGs and
>>>> hangs, and then everything grinds to a halt (can't start more programs=
,
>>>> can't even reboot through systemd).
>>>>
>>>> Using master and reverting that branch up to that point fixes the
>>>> problem.
>>>>
>>>> I'm using a Ryzen 1600 and AMD Radeon RX 480 on an ASRock B450 Pro4
>>>> board with IOMMU enabled.
>>> If you could try the attached patch, that'd be great!
>>>
>>> Thanks,
>>>
>>> Thomas
>>>
>> Yeah, that works too. Kernel config sent off-list.
>>
>> Regards,
>> Alex.
>=20
> Thanks. Do you want me to add your
>=20
> Reported-by: and Tested-by: To this patch?
>=20
> /Thomas
>=20
>=20

Sure. Shouldn't we fix it properly though?
