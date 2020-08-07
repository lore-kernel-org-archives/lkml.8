Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B89C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EF5206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H3yQRv02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHGBU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:20:27 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:34436 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgHGBUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:20:23 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200807012020epoutp02d312e13f88b886116a76684db39a66af~o17Bue5GE2093320933epoutp02d
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 01:20:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200807012020epoutp02d312e13f88b886116a76684db39a66af~o17Bue5GE2093320933epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596763220;
        bh=0bzgxzv+xoy9CsixNrx4dnMN1shAY2rIUs1e6k9XoAM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H3yQRv020BnNKug2KpGwRKRyPA2vFKnDTIC3DuXAausTKf1Nxc02fvVRCA71UZMHj
         h3VRLzNWWnGdkQ1n88e8XY5L6v77mke/2g9d78KKse8gvSrg4yYjgdRK1cpH4zhuJ6
         bkmpVWaJ6NIHzWjie4rX/3nDj1IAReooJsfpCRUQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200807012020epcas1p4597259080aa38005572f96b9d09acdf1~o17BSZQ6h2682726827epcas1p4Z;
        Fri,  7 Aug 2020 01:20:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BN6wy14xpzMqYl1; Fri,  7 Aug
        2020 01:20:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.0B.18978.D4CAC2F5; Fri,  7 Aug 2020 10:20:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200807012012epcas1p3f110e9d8badc6c37a363de0b70b28e42~o1656fjZD1403314033epcas1p3i;
        Fri,  7 Aug 2020 01:20:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200807012012epsmtrp22c2ff9c9a9096f0dee757b8a8dcb2fce~o1655iZY71933719337epsmtrp2h;
        Fri,  7 Aug 2020 01:20:12 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-f0-5f2cac4da10b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.06.08382.C4CAC2F5; Fri,  7 Aug 2020 10:20:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200807012012epsmtip163812c47bd0156efdbd57d24c419a6fa~o165rCdPU1337713377epsmtip1U;
        Fri,  7 Aug 2020 01:20:12 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-clk@vger.kernel.org
Cc:     tomasz.figa@gmail.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <bb483f3c-7d83-4807-aff2-7969a43121aa@samsung.com>
Date:   Fri, 7 Aug 2020 10:32:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200806160646.1997-1-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmga7vGp14g1cHhC02zljPavGx5x6r
        xeVdc9gsZpzfx2Sx9shddouLp1wtDr9pZ7X4d20ji8WqXX8YHTg93t9oZffYOesuu8emVZ1s
        Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85
        P9fK0MDAyBSoMCE7Y/nlPvaCl2wVq1edZmtg3MXaxcjJISFgIrH++yvmLkYuDiGBHYwSixr/
        s0M4nxglNvcvYYJwvjFKfFq7gQ2mpf/gWnYQW0hgL6PEnpO8EEXvGSUun1nECJIQFoiWWHp3
        OtBcDg4RAS+JeQ26IDXMIPXtj/+BDWIT0JLY/+IGmM0voChx9cdjsF5eATuJn593soDYLAIq
        Eje2L2UGsUUFwiRObmuBqhGUODnzCVgNp4C1xKqdV8AOYhYQl7j1ZD4ThC0vsf3tHLDfJASW
        cki8P9AMdpCEgIvE6pVQ/wtLvDq+hR3ClpL4/G4v1JPVEitPHmGD6O1glNiy/wJUg7HE/qWT
        mUDmMAtoSqzfpQ8RVpTY+XsuI8RePol3X3tYIVbxSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFp
        FpJvZiH5YBaSD2YhLFvAyLKKUSy1oDg3PbXYsMAQObI3MYKTqpbpDsaJbz/oHWJk4mA8xCjB
        wawkwpv1QjteiDclsbIqtSg/vqg0J7X4EKMpMHwnMkuJJucD03peSbyhqZGxsbGFiaGZqaGh
        kjjvw1sK8UIC6YklqdmpqQWpRTB9TBycUg1M2gGKafUP1JS5nf/N5/62i82jyOmBTMApQcOJ
        +55uOvQkVGt5wZXsJUt7BD6Xayeu2Hn/J5O56Htx2TSNdbPafl3l/xLI9Thvf8XWyxvnX9u5
        nZ3hV/yRVW/mut6UePRMq9F/hjvHEo+WwxWeAolZkUqPNuhm29crdp/0mxvpUeX/gTllxec/
        x3or9c023p/hX1Hy6a7wr92H26b/OVa70ujVk1fflOX0ps1a8mx2a03lrr1V4jX+MVMPLlac
        oiy2Z/3ZRIsdD9XOvJvcteLomluzts/ftZWtu7BBy/tTfafBtfLO4oUTk30cplUEnTMvdkk4
        pjklNbNHseX6+Ull1c+mTpxocsQi+mpU0bv4LCWW4oxEQy3mouJEAJ4iVyozBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTtdnjU68wbeVnBYbZ6xntfjYc4/V
        4vKuOWwWM87vY7JYe+Quu8XFU64Wh9+0s1r8u7aRxWLVrj+MDpwe72+0snvsnHWX3WPTqk42
        j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MpYfrmPveAlW8XqVafZGhh3sXYxcnJICJhI9B9c
        y97FyMUhJLCbUaJpy2NGiISkxLSLR5m7GDmAbGGJw4eLIWreMkr8PPcGrEZYIFpi6d3pYDUi
        Al4S8xp0QcLMAnsZJf7/rISo72OUmDBxPxtIgk1AS2L/ixtgNr+AosTVHxC7eAXsJH5+3skC
        YrMIqEjc2L6UGcQWFQiT2LnkMRNEjaDEyZlPwGo4BawlVu28wg6xTF3iz7xLzBC2uMStJ/OZ
        IGx5ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
        P3cTIzi+tDR3MG5f9UHvECMTB+MhRgkOZiUR3qwX2vFCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eW8ULowTEkhPLEnNTk0tSC2CyTJxcEo1MBUKfeRa8mjLLZcEtecVOumB0uruAqGXrB7MUxLe
        y8LdVba1pbZcZh3/4ZK7Dpdf6yblsT7Krip6YvggJnT1HUuvxP0S75K9XXNDWwoYL6bHClju
        fHn86AGfe0vP1tdHvbK/KH485Vdy19fGsOZfhmYGEVVvmHfEy36NLv317try6lXhOrz5TrzL
        V82avlC9Z4Lntcqv9XU7++98nMJzV/fipAWrZh40Eng65WRM+q+DMy35zl5VToh88W3rvx+c
        53vs5j091Dlp5hZGSU/eRyZrX7iUXinSFv+fNnez/eTLMtdn++88fV3Hd4L9h1veuyPOszk8
        12i84D/Ba6lvwU1jPd/JZWr7ONgF5mguLlBiKc5INNRiLipOBADbBb+iHgMAAA==
X-CMS-MailID: 20200807012012epcas1p3f110e9d8badc6c37a363de0b70b28e42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
References: <CGME20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f@eucas1p2.samsung.com>
        <20200806160646.1997-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 8/7/20 1:06 AM, Sylwester Nawrocki wrote:
> In the .set_rate callback for some PLLs there is a loop polling state
> of the PLL lock bit and it may become an endless loop when something
> goes wrong with the PLL. For some PLLs there is already (duplicated)
> code for polling with a timeout. This patch refactors that code a bit
> and moves it to a common helper function which is then used
> in .set_rate callbacks for all the PLLs.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-pll.c | 94 +++++++++++++----------------------
>  1 file changed, 35 insertions(+), 59 deletions(-)
> 

(snip)

It fix the infinite loop and unify the duplicate code.
It looks good to me. Thanks.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
