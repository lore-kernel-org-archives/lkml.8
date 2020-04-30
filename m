Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ABFC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BB220757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a6xd7hgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD3Lt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:49:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52313 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3Lt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:49:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200430114954euoutp028e55f6d362e7b279f648b81d812e8a30~Klpc8yow11769717697euoutp02t;
        Thu, 30 Apr 2020 11:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200430114954euoutp028e55f6d362e7b279f648b81d812e8a30~Klpc8yow11769717697euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588247394;
        bh=FgAZPBlreq72LKpIUsT6wipUhPu/8+hOE2yX72Yote4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6xd7hgp/m/RlHBHpN09ByyUWvwZ6mi3l/z34cLSxkfKhOLg7craBNP9VQqs5hH3Z
         /bp91JJzlxAzFMIa/FJF1Wbt4QL2t1cZK0cY8mn5TlbFqbj3xrPjtv/Zx37sIsWEzr
         8WZlurwZk6heqzIuSXaeAmN8OKIyiJWk/AkdfWiw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200430114954eucas1p10a4da7a8e091fe3ff0a803e8e5a27176~KlpcxIdSB2618726187eucas1p1u;
        Thu, 30 Apr 2020 11:49:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.03.60698.26BBAAE5; Thu, 30
        Apr 2020 12:49:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200430114954eucas1p22f46edec60e20dd45f7d9797ca8373d3~KlpcdG6xL1889018890eucas1p2K;
        Thu, 30 Apr 2020 11:49:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200430114954eusmtrp1abbd6269b27f76fa1261b7aa725f10e0~KlpcchOHe3186331863eusmtrp1P;
        Thu, 30 Apr 2020 11:49:54 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-35-5eaabb62528c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.06.07950.26BBAAE5; Thu, 30
        Apr 2020 12:49:54 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200430114954eusmtip22822e07fa1b9f179915b30973b6a8fea~KlpcPGRYX3163631636eusmtip2P;
        Thu, 30 Apr 2020 11:49:54 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64: kexec_file: print appropriate variable
Date:   Thu, 30 Apr 2020 13:49:40 +0200
In-Reply-To: <20200430111923.GB40114@C02TD0UTHF1T.local> (Mark Rutland's
        message of "Thu, 30 Apr 2020 12:19:39 +0100")
Message-ID: <dleftjwo5xfb1n.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SayxbYRjH8/ac0x7NylEWT5BlGjK7uCzEKrbZTLZ+8EF82TJxKU7UpiUt
        hm3hw1ILZSsT0ZhdGNIpVpdYXdcYNjLbZNhiYy7ZMGvmNhZhrUPi2+95/s/l/7x5SYzfQTiS
        CbIUWi4TJwrYXLyld2PII6ZNG+m9sOYuNFWpkHCis5ol1E+PEMJhQxlb+Gz0A0u42bWBC+f+
        9OPnOKLa8lokGh9pZ4saK7NEy/pDofhV7uk4OjEhjZZ7nY3mSqZqH6LkEYf09Vk1kY227XKR
        FQmUL+QPKvFcxCX5VA2C5hwlhwlWEKgqtxATLCPY6P/C3mtpvfORzQjVCLLXhgkm+IGgsqnN
        3EKSbMoTdLorlgZ76gioDCs7OzDKhMBQ8Ru3CHZUEPT0KVkWxik3mGns2WErKh2KNJ93mEed
        gq/DWsLCByl/aPo5wWHytvCmdGZnDkZJoXToF2LcdXKgaNqZ4WBQd08SDNvBfF8Th2FnGChS
        4RafQGVBUaGfxRtQKgQtZes4UxMA4+/+7V58Hiof5RFMvTWMLdoya62hsKUEY9I8uKvkM9Wu
        UHevfXeKI+TP1+w6E0Hr0uLuU+cheL1UwbqPDmv2XaPZd43GPBajjkK9wYtJH4eqJwsYw2eg
        rs6EP0aEFjnQqQppPK3wkdE3PBViqSJVFu8ZmyTVI/NHGtjqW21FnZsxRkSRSHCAR+q1kXxC
        nKbIkBqRq3nSVMPz98gRlyXJaIE973uEWebFiTMyaXlSlDw1kVYYkROJCxx4Pk/nIvhUvDiF
        vk7TybR8T2WRVo7Z6JL/xotElUnnFpxywSYkjP7L43cX2w5exotpo8dFlxP1Xps5ylnJ9mSX
        ZkmSGVWuflBRmoTdfDX2TScJH1ZFrjWL9R0vnbTeahd3rCRmtCLWt6FmdfBtgTGeLA206Q/6
        FGoKC7ld5hrIvabJx3mq8Gj1YHLBrd5Qv7GAGA++AFdIxCePYXKF+D8LBuP/UAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7pJu1fFGax8zW/xflkPo8X9fcuZ
        LDY9vsZqcXnXHDaLpdcvMln82f+TxeLlxxMsDuwea+atYfS4c20Pm8fmJfUenzfJBbBE6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU8WjOXseCa
        eMWPpxNZGxj/C3cxcnJICJhI7Gi5xNbFyMUhJLCUUeLNiZ/MXYwcQAkpiZVz0yFqhCX+XOuC
        qnnKKLHt5WV2kBo2AT2JtWsjQGpEBNQlenZ9YQGxmQVeAdV8KgGxhQWcJI4cb2MCKRcSMJd4
        dEIDJMwioCrxZPMRJhCbU6BCYvKsm2A2L1DJ3curWEFsUQFLiS0v7rNDxAUlTs58AjU+W+Lr
        6ufMExgFZiFJzUKSmgW0jVlAU2L9Ln2IsLbEsoWvmSFsW4l1696zLGBkXcUoklpanJueW2yk
        V5yYW1yal66XnJ+7iREYSduO/dyyg7HrXfAhRgEORiUeXo5Nq+KEWBPLiitzDzGqAI15tGH1
        BUYplrz8vFQlEd6HsUBp3pTEyqrUovz4otKc1OJDjKZAf05klhJNzgdGf15JvKGpobmFpaG5
        sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsbMux++FPntarx54MWCotltG7IWb67Z
        ueOWuf289d+qy/Yf6GaxXjk/2WunQ/f5Qz3PJk6YEHUwm33i+sZjR+/3Wy497BaasOjjjuS/
        jEuY7p3sWv2ih/vZhS85Pw1Ez7Hlvb58N/RwZNejJ5GHOTfof6/ykPjSH2T7bdkBk29by3h2
        xV7Pnz79ohJLcUaioRZzUXEiAEZEKHzGAgAA
X-CMS-MailID: 20200430114954eucas1p22f46edec60e20dd45f7d9797ca8373d3
X-Msg-Generator: CA
X-RootMTR: 20200430114954eucas1p22f46edec60e20dd45f7d9797ca8373d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430114954eucas1p22f46edec60e20dd45f7d9797ca8373d3
References: <20200430111923.GB40114@C02TD0UTHF1T.local>
        <CGME20200430114954eucas1p22f46edec60e20dd45f7d9797ca8373d3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-04-30 czw 12:19>, when Mark Rutland wrote:
> On Thu, Apr 30, 2020 at 12:50:34PM +0200, =C5=81ukasz Stelmach wrote:
>> Fixes: 4312057681929 ("arm64: kexec_file: load initrd and device-tree")
>
> This commit ID is bogus (doesn't exist in mainline or the arm64 tree).
>
> The upstream commit ID seems to be: 52b2a8af7436044cfcb27e4b0f72c2ce1f389=
0da

Fixing.

> As will said, this needs a commit message. Please explain what you think
> is wrong here.

Fixing.

> Also, when sending a fix, *please* Cc the author of the original patch.
>
> I've added parties relevant to the original patch (Takahiro and James).

Thank you.

>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/=
machine_kexec_file.c
>> index b40c3b0def92..2776bdaa83a5 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -332,7 +332,7 @@ int load_other_segments(struct kimage *image,
>>  	image->arch.dtb_mem =3D kbuf.mem;
>>=20=20
>>  	pr_debug("Loaded dtb at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
>> -			kbuf.mem, dtb_len, dtb_len);
>> +			kbuf.mem, dtb_len, kbuf.memsz);
>
> It's worth noting that we follow the same pattern repeatedly in this
> file, so if you think this instance is wrong you should consider whether
> the others are correct.
>
> Earlier in this file we have:
>
> |	pr_debug("Loaded elf core header at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n=
",
> |		 image->arch.elf_headers_mem, headers_sz, headers_sz)
>
> |	pr_debug("Loaded initrd at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> |		 initrd_load_addr, initrd_len, initrd_len);

Fixing.

> ... and it looks like x86 does similar in kexec-bzimage64.c, for some
> sort of consistency with the old kexec logging.

When I fix it for x86, should I combine changes in one patch or prepare
two separate patches?

> If <foo>_len and kbuf.memsz can differ, we should log that in all cases.
> If not, we should remove the redundant logging.

Yes, memsz is page-aligned in kexec_add_buffer();

Kind regards,
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl6qu1UACgkQsK4enJil
gBCN+Af+OKcovFV8R0frOmKpOoA8SH64oXvYRY/UAzggb8dpqSuQb0sYVEgNygvh
zJEYpXzf/iR1eCqcrE7YLbFVue3KllwML6sOkEsv0QEYEHbLJ6OZDu2VDdxt8y26
DMfoMeum7BC+HaNtdYxhsTcrqLFtf6E36HxwrGoMGyept/ZiRZdxdfJjjY+mDub5
9TQyiVDSbU0Aa6zP7QzqVmocZH8rMyb3JCMElq4fUbsSe1VIVIIMwbslNv3dVpsS
qe2BYlbFHlPc/vVoxmxN41zX3/pwZAIIkEJVNvV7EdSoUAHRYy2n59wg7qBKJ+VJ
TlJXuQZ7xVQLGN59N4InNQOKDQENvg==
=9fnd
-----END PGP SIGNATURE-----
--=-=-=--
