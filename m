Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B855C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC5220757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hjnCnTVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIGkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:40:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53076 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgDIGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:40:18 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200409064017epoutp039f376113a66a6b0e1296789b0360abf8~EE4HeMrpk0923709237epoutp03U
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 06:40:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200409064017epoutp039f376113a66a6b0e1296789b0360abf8~EE4HeMrpk0923709237epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586414417;
        bh=f5+1LXv2hzm9xQgGaKBt4kmJuet/OawIw/50bcl0rVg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hjnCnTVt4kUrKS/1BWC8KV+dDsrIXtl1JytiLPkfcyaPYJauUAqGzk3liDq+cdaxB
         XojVVGbrJR8mWpAC/ehD0ReCQo+pmbLCk5JGPIvVAZT7O4h0fXzpkKJhVpr8v6fAmn
         3hgFciDIbl6bN0hD4KnsRLWwaujVa/5WEbnfs0AU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200409064015epcas1p284d8a7e7300f7d8c4564c57d0fa7a3e8~EE4F_QXd_0424204242epcas1p2N;
        Thu,  9 Apr 2020 06:40:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48yWjV2JzyzMqYkn; Thu,  9 Apr
        2020 06:40:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.BD.04658.E43CE8E5; Thu,  9 Apr 2020 15:40:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200409064012epcas1p11be838e56ea23ea52019e03fabf5442f~EE4DSZJKS0214302143epcas1p1H;
        Thu,  9 Apr 2020 06:40:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200409064012epsmtrp238a5cdbcd8706e56b8daf1bd26b08643~EE4DRt1h50769107691epsmtrp2I;
        Thu,  9 Apr 2020 06:40:12 +0000 (GMT)
X-AuditID: b6c32a39-a81ff70000001232-7d-5e8ec34e02dd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.6D.04158.C43CE8E5; Thu,  9 Apr 2020 15:40:12 +0900 (KST)
Received: from [10.253.105.163] (unknown [10.253.105.163]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200409064012epsmtip2886c641577e888295928c8a664185f97~EE4DLu-i70744707447epsmtip2h;
        Thu,  9 Apr 2020 06:40:12 +0000 (GMT)
Subject: Re: [PATCH] dm verity fec: Don't add data_blocks to block
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sunwook5492@gmail.com
From:   Sunwook Eom <speed.eom@samsung.com>
Message-ID: <4a4a914c-c020-4b45-7cba-5aed816f0545@samsung.com>
Date:   Thu, 9 Apr 2020 15:40:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CABCJKudWRmdyJAxjnTs+NiRJVnhDUQfzGO3sVKZNJoQ5Qi-aew@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmga7f4b44g6UNAhbrTx1jttj7bjar
        xeVdc9gslq54y2rRtvEro0X//g1sDmweO2fdZfdYsKnU4/2+q2wenzfJBbBE5dhkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZCxYPIGxoJ2j
        YtKfeSwNjJPYuhg5OSQETCSO7nnF2MXIxSEksINRouXUbiYI5xOjxNwLJ6Gcb4wSq+afY4dp
        6Z93gxkisZdR4kTnUqiq94wSL3atBqsSFnCSePCrFWyJiIC2xM2rfWAdzCBL/jxexQqSYBPQ
        lDjUc4wFxOYVsJPYs66HGcRmEVCRuHDlI1izqECExL2lB5khagQlTs58AlbPKRAosXP7I7A4
        s4C8RPPW2VC2uMStJ/PBLpIQOMMmceLfYaBlHECOi8TUUxkQLwhLvDq+BeodKYnP7/ZCQ6Na
        4sqJi0wQdo1E7/VbrBC2sURvzwVmkDHMQDev36UPEVaU2Pl7LiPEWj6Jd197oDbxSnS0CUGU
        KEu8PX6eBcKWlDj9dyrURA+JU0/us09gVJyF5LFZSJ6ZheSZWQiLFzCyrGIUSy0ozk1PLTYs
        MEWO7U2M4ISpZbmD8dg5n0OMAhyMSjy8Evt744RYE8uKK3MPMUpwMCuJ8Ho3AYV4UxIrq1KL
        8uOLSnNSiw8xmgLDfSKzlGhyPjCZ55XEG5oaGRsbW5iYmZuZGiuJ8069nhMnJJCeWJKanZpa
        kFoE08fEwSnVwFixcW5GJ1ul8fVPxRfct9hNYbr2b5lIYevadTPf1tpNXMvQr6PcdkaZhePr
        J0VxbdnjMR7M8zKC9xpdXCTcnRDo9uZzxTlOtwT+hC8JtrLe2xcfXzh7k1pBY7OzyWmLcyIH
        MgX2cQUXv6njmvpF6M6KF6cE7sRenD5DKtnzvfctJ7OZSaumfVNiKc5INNRiLipOBABdHL/U
        rgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvK7P4b44gxvHtS3WnzrGbLH33WxW
        i8u75rBZLF3xltWibeNXRov+/RvYHNg8ds66y+6xYFOpx/t9V9k8Pm+SC2CJ4rJJSc3JLEst
        0rdL4MpYsHgCY0E7R8WkP/NYGhgnsXUxcnJICJhI9M+7wdzFyMUhJLCbUWLfri+sEAlJiTdN
        lxm7GDmAbGGJw4eLIWreMkrcOH+aEaRGWMBJ4sGvVrBBIgLaEjev9oENYhbYwShx5N1CJoiO
        m4wSbzs/glWxCWhKHOo5xgJi8wrYSexZ18MMYrMIqEhcuAJRIyoQIdF69xYzRI2gxMmZT8Dq
        OQUCJXZufwQWZxYwk5i3+SGULS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjFK
        phYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBMeIltYOxhMn4g8xCnAwKvHwSuzvjRNiTSwr
        rsw9xCjBwawkwuvdBBTiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgm
        y8TBKdXAuGrjU12x/W5fatzd2G2+ROnoRF9d8nO1lt3/bXyvKud89f10MeGEk8bGy3d2yQfP
        Vixet+lba8ssEz+Rjyr+X1fYMZ3OOPG5vWbPXobSbSG2Fktzv3JHsm6z8spdclFpQ6NbvOOT
        QpOyxo22Kj+vsB85slhY+sem6MSYTI11ve0Nz//VzEmXUGIpzkg01GIuKk4EAAVcjQ+NAgAA
X-CMS-MailID: 20200409064012epcas1p11be838e56ea23ea52019e03fabf5442f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82
References: <CGME20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82@epcas1p1.samsung.com>
        <317e0073-a6f7-4232-3b95-a4bc3ddbcdec@samsung.com>
        <CABCJKudWRmdyJAxjnTs+NiRJVnhDUQfzGO3sVKZNJoQ5Qi-aew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20. 4. 8. 오전 12:55, Sami Tolvanen wrote:
> On Mon, Apr 6, 2020 at 11:54 PM Sunwook Eom <speed.eom@samsung.com> wrote:
>> Even if block type is metadata,
>> block in verity_fec_decode() has already the right block number.
>> So there is no need to add data_blocks to block.
> Is this also true if the hashes are on a separate block device?
>
> The idea here is that the error correction data was computed over both
> data and hash blocks, as if they were concatenated, and we want to
> calculate the logical block number based on that. I agree that the
> code doesn't look quite right though. Should we use something like
> this instead?
>
>      if (type == DM_VERITY_BLOCK_TYPE_METADATA)
>              block = block - v->hash_start + v->data_blocks;
>
> Sami
>
>
You're right. I missed the case that hashes are on a separate block device.

And, the code you wrote seems to be correct.

If you don't mind, I'll send a new version of this patch.

Thank you for the review.


Sunwook






