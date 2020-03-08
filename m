Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C3C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801AB20828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZNXQsR2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCHJ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:59:13 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42520 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCHJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:59:13 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200308095909epoutp022daf5f1555b5d8eee51e31185d509625~6S8n-DVe_0851508515epoutp02O
        for <linux-kernel@vger.kernel.org>; Sun,  8 Mar 2020 09:59:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200308095909epoutp022daf5f1555b5d8eee51e31185d509625~6S8n-DVe_0851508515epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583661549;
        bh=qLRo2OIuTu7VzkzRvJ32S21C1Ybw2I2BN7KLwFt05yg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZNXQsR2RwKgFp+rNwTOAMyiGXbNa7PU0JOjaE81oFIgDiTfazkiONd17SGT6LuJXf
         VdfB492POtQ/NB+03z5zI1seYOdZ5C6Oy7byT5mwVQiSAiXBMWfhag1YK0h529/Jaz
         vOzOilTe15FF5YbIGrEfnFugurX4ZFkSJK0kpQB4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200308095908epcas1p469b73abb1cd5fb116ff36056957a1fa1~6S8mq4WzM0391003910epcas1p4y;
        Sun,  8 Mar 2020 09:59:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48Zxdl3YbJzMqYkV; Sun,  8 Mar
        2020 09:59:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.1A.48019.BE1C46E5; Sun,  8 Mar 2020 18:59:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200308095906epcas1p150fec0fb5b86907b09be9104f7171f12~6S8kcjt5J3121531215epcas1p1M;
        Sun,  8 Mar 2020 09:59:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200308095906epsmtrp17576b5d0c64d67a1742f3367a0421292~6S8kZMGTz0575105751epsmtrp11;
        Sun,  8 Mar 2020 09:59:06 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-5e-5e64c1eb218e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.41.06569.9E1C46E5; Sun,  8 Mar 2020 18:59:05 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200308095905epsmtip287890fa2d68a6c446c3c287450d41a1a~6S8jxvm520104101041epsmtip2S;
        Sun,  8 Mar 2020 09:59:05 +0000 (GMT)
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     walken@google.com, bp@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E64C1D7.3000208@samsung.com>
Date:   Sun, 8 Mar 2020 18:58:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200308015802.GD31215@bombadil.infradead.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTu193uruHiOs0OFrluD9psteucXsVZUMQgIaEH6R/abbtt2l7t
        bpZGZCnaQ7OkIF+0ip74gK3HNCOzsEywIEKK7EUEJVaahWVq2+4k//vOd76P853z+xGY7Bwe
        R+TbXJzTxloofI7o1gOFSjV435irbmmLZRpam3DmVLWCOe6rRczz9gacedM0JWYmaw4w42MN
        +FqJvq1uQKL3eN1631Wl3jtSI9E/Pjsu0vt69+t/eBdlSXIs6WaONXJOOWcz2I35NpOO2rg5
        b12eNllNq+hUJoWS21grp6PWZ2apNuRbAlkoeSFrcQeoLJbnqdUZ6U6728XJzXbepaM4h9Hi
        oNWOVTxr5d020yqD3ZpGq9WJ2oByh8U80F0rcjyJ2NfdHFWCBiTHUAQBZBL0TlycfQzNIWSk
        H4F30C8WihEEFR/vh4tfCM4+rRZPW4bHOnChcRfB25ZKPNiQkUMIpry7gjiazIDuMw9Dhhhy
        K/j7mgMagsBIK1R0W4M0TibAN09NSCIllXD+4QlREIvIpdBbdTwUbx65HfyNw0jQREFP7ceQ
        JoJMh3cfXobGYmQ8lN6sx4J5gOzH4fW70+Hd1kN9fWcYR8OXRzfCOA4+V5dLBEMpgqFaHxKK
        MgQD3iokqDRQVfkME1IroLV9tUAvhrbxRiRMngtff1aKgxIgpXCkXCZIlkPZp5/hYy2EiclP
        YawHv+9J+HDlGJSWT2AnkbxuxnJ1Mxaq+z/Zg7DrKJZz8FYTx9OOpJkv7EWhz6lk/KijL7ML
        kQSiIqU7+gy5MjFbyBdZuxAQGBUjPaQMUFIjW1TMOe15TreF47uQNnDvU1jcPIM98NVtrjxa
        m6jRaJik5JRkrYaaL32frciVkSbWxe3mOAfnnPbNJiLiStCygysUTfLYS9lRc2P2eEqTc1S3
        70S+PHrl/ciCTj6z+GKkaXgiLSfh3vcfhdcK1s3am/p5y5IC8/V+itkpGsWe0Wm3ZI/XpLVL
        cxN6qs589e3ZtFU3TsevTLQb3hb4dZe3XRjtXzP0m/c89RtftFanjvREv7p2clQ1WHy40jv5
        N/sPJeLNLK3EnDz7D5wYmhuyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO7LgylxBpfbbSzmrF/DZjGxX9Oi
        e/NMRovLu+awWdxb85/V4t+kWovfP+awObB77Jx1l91jwaZSj80rtDw2fZrE7nFixm8Wj82n
        qz0+b5ILYI/isklJzcksSy3St0vgyrh7bCZLwSnOimNrBRsY77J3MXJySAiYSHz8sYeti5GL
        Q0hgN6PEo+9v2SASMhJvzj9l6WLkALKFJQ4fLoaoec0oMXXGJGaQGmEBO4ljU4+wgtgiAqES
        V988YYEoamOWeHD5LFiCWSBX4t2zaWBD2QS0Jd4vmAQW5xXQklh4pI8FxGYRUJE43dsNdpGo
        QITE6nXXmCFqBCVOznwCVsMpYCPx4NFNNpCDmAXUJdbPE4IYLy/RvHU28wRGwVlIOmYhVM1C
        UrWAkXkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwLGhp7WA8cSL+EKMAB6MSD++O
        C8lxQqyJZcWVuYcYJTiYlUR4G7WAQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5ak
        ZqemFqQWwWSZODilGhg9pzh267I6rH83XfNU2iq5tOkOutoNLZ5Vs9SEdeRWVcxnyapiehJ/
        tsOgM2KqeVjD4jz+2ZOnbDc1kd3/t+G9grx9Meu2Z0mq3g6VpoG2TXOK0ueJ7fm048ydk/Pe
        1ypPPPLixJLzVXqXL+3r1gioYcxxTIhdcSBJulf8pMbR8vS8Wd1275RYijMSDbWYi4oTAfk2
        bKaBAgAA
X-CMS-MailID: 20200308095906epcas1p150fec0fb5b86907b09be9104f7171f12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
        <20200304030206.1706-1-jaewon31.kim@samsung.com>
        <5E605749.9050509@samsung.com>
        <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
        <5E61EAB6.5080609@samsung.com>
        <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
        <20200308015802.GD31215@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 08일 10:58, Matthew Wilcox wrote:
> On Sat, Mar 07, 2020 at 03:47:44PM -0800, Andrew Morton wrote:
>> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
>>> Virtual memory space shortage of a task on mmap is reported to userspace
>>> as -ENOMEM. It can be confused as physical memory shortage of overall
>>> system.
> But userspace can trigger this printk.  We don't usually allow printks
> under those circumstances, even ratelimited.
Hello thank you your comment.

Yes, userspace can trigger printk, but this was useful for to know why
a userspace task was crashed. There seems to be still many userspace
applications which did not check error of mmap and access invalid address.

Additionally in my AARCH64 Android environment, display driver tries to
get userspace address to map its display memory. The display driver
report -ENOMEM from vm_unmapped_area and but also from GPU related
address space.

Please let me know your comment again if this debug is now allowed
in that userspace triggered perspective.

I may change to pr_debug or drop this change.

Thank you
>
>

