Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78619C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:31:41 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD1620678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AyXFsaqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD1620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgDMEbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 00:31:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5757C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 21:31:37 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200413043134epoutp01cb1fe8ea0fa1d6810d10c359a14b00c7~FRs4eKpn-1716517165epoutp01R
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:31:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200413043134epoutp01cb1fe8ea0fa1d6810d10c359a14b00c7~FRs4eKpn-1716517165epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586752294;
        bh=mo+wGiE3q9exEReZ9I1l3u3kx0udyKEJ2Pg/f1ETpv8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AyXFsaqZ1QTtWNlSrupVpogJFkDCsXc+fuKmGfhwKo4/yAVsHCc+Y51Bt64uuz+gB
         nWb3nkoNpQApme2qkew5zkZw68G8/5KMu+7v2Pob7uq+5KcQTMJvZGVQHQdh6ZlUq1
         P8dCWaAQWtuYM5mFLtlo+Bp4UYD8Yl9HSdJqwujc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200413043133epcas1p30dab5615302e7d65d8358ae762cf56f0~FRs3tUAhI1933219332epcas1p3L;
        Mon, 13 Apr 2020 04:31:33 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 490wg86TzTzMqYmB; Mon, 13 Apr
        2020 04:31:32 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.2D.04402.42BE39E5; Mon, 13 Apr 2020 13:31:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200413043132epcas1p10720f5787ba23504a9574312aa9471d0~FRs2aXH3j1616416164epcas1p1Z;
        Mon, 13 Apr 2020 04:31:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200413043132epsmtrp249552862c07feb25dc9f27e8bf2b6836~FRs2ZgywF2658726587epsmtrp20;
        Mon, 13 Apr 2020 04:31:32 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-90-5e93eb24a715
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.4F.04024.42BE39E5; Mon, 13 Apr 2020 13:31:32 +0900 (KST)
Received: from [10.253.105.163] (unknown [10.253.105.163]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200413043132epsmtip13444828e122a536e370c847bd728c70f~FRs2N-sE_0702307023epsmtip1p;
        Mon, 13 Apr 2020 04:31:32 +0000 (GMT)
Subject: Re: [PATCH] dm verity fec: fix hash block number in
 verity_fec_decode
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        =?UTF-8?B?6rCV66y47LKg?= <mcneo.kang@samsung.com>,
        sunwook5492@gmail.com, LKML <linux-kernel@vger.kernel.org>
From:   Sunwook Eom <speed.eom@samsung.com>
Message-ID: <8a6d104e-4a2b-c393-567f-95bc06f6763a@samsung.com>
Date:   Mon, 13 Apr 2020 13:31:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CABCJKueSJ4sXHL5xnB5LQVW_6od2+_TEp0y_vv1gdi=yBB1Zfg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmrq7K68lxBgtumFisP3WM2WLvu9ms
        Fpd3zWGz6GqMt1i64i2rRdvGr4wW/fs3sDmwe+ycdZfdY8GmUo/3+66yefRtWcXo8XmTXABr
        VI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqE
        nIyT+ztZCiZyVczr3cXcwNjO0cXIySEhYCJx6c1m9i5GLg4hgR2MEk9ObmeGcD4xSrRM3M4G
        4XxjlJgzsY+li5EDrGX1Mh+I+F5GiRcHf0EVvWeUWNjUxQgyV1ggQKL5/xkmEFtEQFvi5tU+
        sLHMAm8ZJZZ/bmAGSbAJaEoc6jnGAmLzCthJfHk0iQ3EZhFQlbjc3gQWFxWIkLi39CAzRI2g
        xMmZT8Cu4BQIlLj2JQokzCwgL9G8dTYzhC0ucevJfCaQXRICj9kkVt5cxALxqIvE4k+zoWxh
        iVfHt7BD2FISn9/tZYOwqyWunLjIBGHXSPRev8UKYRtL9PZcYAbZywx08/pd+hBhRYmdv+cy
        Quzlk3j3tYcVEkC8Eh1tQhAlyhJvj5+H2iopcfrvVKiJHhJfFm5mn8CoOAvJY7OQfDMLyTez
        EBYvYGRZxSiWWlCcm55abFhgiBzZmxjBCVTLdAfjlHM+hxgFOBiVeHgTXCbHCbEmlhVX5h5i
        lOBgVhLhfVI+MU6INyWxsiq1KD++qDQntfgQoykw3CcyS4km5wOTe15JvKGpkbGxsYWJmbmZ
        qbGSOO/U6zlxQgLpiSWp2ampBalFMH1MHJxSDYwl545ECO9axd+o7O2zsORBgWDZNIuPLtuO
        SRmE7+mdd2Hf/jCeG7pn83L1eBo+bHnXZL1L3+n4s2AD09+HX9t9mFbP/Xd6QsrR2ruz7ips
        aX/iN6Vow6lHL47JOn4WCNx06oyZ7+u9QnsnfP7CI9j0etHH+pLQh/sVgv+n7JRTk2RNYtFe
        ce+VEktxRqKhFnNRcSIAJ9kWm7YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnK7K68lxBkceyVisP3WM2WLvu9ms
        Fpd3zWGz6GqMt1i64i2rRdvGr4wW/fs3sDmwe+ycdZfdY8GmUo/3+66yefRtWcXo8XmTXABr
        FJdNSmpOZllqkb5dAlfGyf2dLAUTuSrm9e5ibmBs5+hi5OCQEDCRWL3Mp4uRi0NIYDejxIHp
        W5m7GDmB4pISb5ouM0LUCEscPlwMUfOWUaLv4zz2LkZ2DmEBP4lP/iDVIgLaEjev9jGDlDCD
        lBx98ooZov4mo8SXTxuZQKrYBDQlDvUcYwGxeQXsJL48msQGYrMIqEpcbm8Ci4sKREi03r3F
        DFEjKHFy5hMWkBs4BQIlrn2JAgkzC5hJzNv8kBnClpdo3jobyhaXuPVkPtMERqFZSLpnIWmZ
        haRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNFS3MH4+Ul8YcYBTgY
        lXh4d7hNjhNiTSwrrsw9xCjBwawkwvukfGKcEG9KYmVValF+fFFpTmrxIUZpDhYlcd6necci
        hQTSE0tSs1NTC1KLYLJMHJxSDYzd4SvMXbrPyn5Tn55cumPhDfkJwgzTzxx5sul+2+pVIS92
        7S2Pi69ZxaYq9o5tgfW5zWs/bV3lXzHzsGfH5im9fJksAutubd83YebMiyfX3S3YJ6Ql/kz2
        c01C3aUeW8n2vVlLigo72i/Uqp+dtvF9a/XMoh8FCzUS9LhbTt7QmnGqbdq5v0r/lViKMxIN
        tZiLihMBOBGpm5ICAAA=
X-CMS-MailID: 20200413043132epcas1p10720f5787ba23504a9574312aa9471d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200410035424epcas1p2d47ca3a171af6a895af17d86e2838269
References: <CGME20200410035424epcas1p2d47ca3a171af6a895af17d86e2838269@epcas1p2.samsung.com>
        <b8de2c4b-d8cf-2bdb-f4cf-5b10faf48955@samsung.com>
        <CABCJKueSJ4sXHL5xnB5LQVW_6od2+_TEp0y_vv1gdi=yBB1Zfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20. 4. 11. 오전 12:41, Sami Tolvanen wrote:
> On Thu, Apr 9, 2020 at 8:54 PM Sunwook Eom <speed.eom@samsung.com> wrote:
>> The error correction data is computed as if data and hash blocks
>> were concatenated. But hash block number is start from v->hash_start.
>> So, we have to calculate hash block number based on that.
>>
>> Fixes: a739ff3f543af ("dm verity: add support for forward error correction")
>> Signed-off-by: Sunwook Eom <speed.eom@samsung.com>
>> ---
>>    drivers/md/dm-verity-fec.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
>> index 49147e634046..fb41b4f23c48 100644
>> --- a/drivers/md/dm-verity-fec.c
>> +++ b/drivers/md/dm-verity-fec.c
>> @@ -435,7 +435,7 @@ int verity_fec_decode(struct dm_verity *v, struct
>> dm_verity_io *io,
>>        fio->level++;
>>
>>        if (type == DM_VERITY_BLOCK_TYPE_METADATA)
>> -        block += v->data_blocks;
>> +        block = block - v->hash_start + v->data_blocks;
>>
>>        /*
>>         * For RS(M, N), the continuous FEC data is divided into blocks of N
> Thank you for the patch!
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>
> Sami
>
>
Add CC : LKML <linux-kernel@vger.kernel.org>

