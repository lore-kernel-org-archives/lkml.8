Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3302C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29D20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pY6VX3wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCIJMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:12:13 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15467 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgCIJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:12:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200309091210epoutp037e49f37e503df89b38fa7f3e47f18b15~6l84iHKrA1914619146epoutp03G
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 09:12:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200309091210epoutp037e49f37e503df89b38fa7f3e47f18b15~6l84iHKrA1914619146epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583745130;
        bh=P0YfZTJ4g4GWBG6pWgAboI0yQMIZ92iH2iS2DfBPB+o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pY6VX3wcvZmfeD2RiReTufu27ZbmnC4zu1ml0JIxyiVph2bHRVS3P/QW10mWeFo5v
         UvJc7IqomcPkOcd4xcnLlT6vkyNadRnqMOqLeP6JFqfXwjugDUWgP6XkS/OC84PO/X
         xn0bHh51RYPllkUXBsxMcMtU+NMlanPPET04/UZ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200309091209epcas1p4351a2168c69093fb4cad127c73c16c6d~6l8337qZo2381623816epcas1p4r;
        Mon,  9 Mar 2020 09:12:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48bXY44SBbzMqYkW; Mon,  9 Mar
        2020 09:12:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.6B.52419.868066E5; Mon,  9 Mar 2020 18:12:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200309091208epcas1p30087f3874f2fe6f3399c026ec93d631b~6l82VBimF0790207902epcas1p3v;
        Mon,  9 Mar 2020 09:12:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200309091208epsmtrp12c8e7842ee905a2d471639d10018fa29~6l82UXtQb1057910579epsmtrp13;
        Mon,  9 Mar 2020 09:12:08 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-86-5e6608688939
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.38.06569.868066E5; Mon,  9 Mar 2020 18:12:08 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200309091207epsmtip2849fd3cbbd66901cd7d758caf02128dd~6l81tz7Ky1170111701epsmtip2f;
        Mon,  9 Mar 2020 09:12:07 +0000 (GMT)
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, walken@google.com,
        bp@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E660863.2090104@samsung.com>
Date:   Mon, 9 Mar 2020 18:12:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200308123616.GH31215@bombadil.infradead.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmrm4GR1qcwepNKhZz1q9hs5jYr2nR
        vXkmo8XlXXPYLO6t+c9q8W9SrcXvH3PYHNg9ds66y+6xYFOpx+YVWh6bPk1i9zgx4zeLx+bT
        1R6fN8kFsEfl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7Uy
        NDAwMgWqTMjJeHNtOVPBdfGKFd1T2BsYrwh1MXJySAiYSEyZ9Yixi5GLQ0hgB6NEb/MdFgjn
        E6PE+02bWSGcb4wSyzva2GBaFu3cBNWyl1Fi9aeP7BDOW0aJ1mPXWECqhAXsJI5NPQLUzsEh
        IqAh8WaLEUgNs8AsRol93YeYQWrYBLQl3i+YxApi8wpoSTxtW8MEYrMIqEis+jmJEcQWFYiQ
        2DH3IyNEjaDEyZlPwOZzCthInDixkR3EZhaQl2jeOpsZZIGEwH02iZsP5jFBnOoi8fNmEwuE
        LSzx6vgWdghbSuJlfxs7REMzo8TbmZsZIZwWRom7m3oZIaqMJXp7LjCDvMAsoCmxfpc+RFhR
        YufvuYwQm/kk3n3tAftSQoBXoqMNGqpqEi3PvrJC2DISf/89g7I9JHZsPsUGCa2bzBJPD79i
        msCoMAvJc7OQPDQLYfMCRuZVjGKpBcW56anFhgXGyJG8iRGcPrXMdzBuOOdziFGAg1GJh/eB
        fGqcEGtiWXFl7iFGCQ5mJRHeRq3kOCHelMTKqtSi/Pii0pzU4kOMpsDwnsgsJZqcD0zteSXx
        hqZGxsbGFiZm5mamxkrivA8jNeOEBNITS1KzU1MLUotg+pg4OKUaGGPvT59VG3VYzcVs07VN
        j552xBeHed2csPLltuoQWU691b/XTW9awerib3rm0GzX03It1X0/TvZ1PFPZ0rHG9kz2Qr7p
        C9R0/rl/brvJWXeh8bdhwArPVV/8p3U9CU6eFMmeqJz1XVkiNWBPTUXNraiNCy6wHy7WNLug
        f8WM9fPhoOeH5xX9n67EUpyRaKjFXFScCABGE4/WtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvG4GR1qcweyrbBZz1q9hs5jYr2nR
        vXkmo8XlXXPYLO6t+c9q8W9SrcXvH3PYHNg9ds66y+6xYFOpx+YVWh6bPk1i9zgx4zeLx+bT
        1R6fN8kFsEdx2aSk5mSWpRbp2yVwZby5tpyp4Lp4xYruKewNjFeEuhg5OSQETCQW7dzE2MXI
        xSEksJtR4uqJH2wQCRmJN+efsnQxcgDZwhKHDxeDhIUEXjNKzLjFAWILC9hJHJt6hBWkRERA
        Q+LNFiOIMTeZJWY1fWAHqWEWmMEocWShM4jNJqAt8X7BJFYQm1dAS+Jp2xomEJtFQEVi1c9J
        jCC2qECExOp115ghagQlTs58wgJicwrYSJw4sRFqprrEn3mXmCFseYnmrbOZJzAKzkLSMgtJ
        2SwkZQsYmVcxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHg5bWDsYTJ+IPMQpwMCrx
        8D6QT40TYk0sK67MPcQowcGsJMLbqJUcJ8SbklhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBA
        emJJanZqakFqEUyWiYNTqoHReMuCQyHH1DcVHkl9/39rs1aJ0JGEG7026iJpb/hkt854w+D0
        vj8r+77qrkaWd3vVL+7bpbbr4M8F2alHVOzkZz336Y9nY92kM1davspBzkjvx9YFCRWVoV4L
        eIRyvgeGbr591tpC+yl7VN6CmBkNvHOSXK+WHN2udIlxtexuhYQFRV/TX6krsRRnJBpqMRcV
        JwIAoCF464ICAAA=
X-CMS-MailID: 20200309091208epcas1p30087f3874f2fe6f3399c026ec93d631b
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
        <5E64C1D7.3000208@samsung.com>
        <20200308123616.GH31215@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 08일 21:36, Matthew Wilcox wrote:
> On Sun, Mar 08, 2020 at 06:58:47PM +0900, Jaewon Kim wrote:
>> On 2020년 03월 08일 10:58, Matthew Wilcox wrote:
>>> On Sat, Mar 07, 2020 at 03:47:44PM -0800, Andrew Morton wrote:
>>>> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>>>> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
>>>>> Virtual memory space shortage of a task on mmap is reported to userspace
>>>>> as -ENOMEM. It can be confused as physical memory shortage of overall
>>>>> system.
>>> But userspace can trigger this printk.  We don't usually allow printks
>>> under those circumstances, even ratelimited.
>> Hello thank you your comment.
>>
>> Yes, userspace can trigger printk, but this was useful for to know why
>> a userspace task was crashed. There seems to be still many userspace
>> applications which did not check error of mmap and access invalid address.
>>
>> Additionally in my AARCH64 Android environment, display driver tries to
>> get userspace address to map its display memory. The display driver
>> report -ENOMEM from vm_unmapped_area and but also from GPU related
>> address space.
>>
>> Please let me know your comment again if this debug is now allowed
>> in that userspace triggered perspective.
> The scenario that worries us is an attacker being able to fill the log
> files and so also fill (eg) the /var partition.  Once it's full, future
> kernel messages cannot be stored anywhere and so there will be no traces
> of their privilege escalation.
Although up to 10 times within 5 secs is not many, I think those log may remove
other important log in log buffer if it is the system which produces very few log.
In my Android phone device system, there seems to be much more kernel log though.
> Maybe a tracepoint would be a better idea?  Usually they are disabled,
> but they can be enabled by a sysadmin to gain insight into why an
> application is crashing.
In Android phone device system, we cannot get sysadmin permission if it is built
for end user. And it is not easy to reproduce this symptom because it is an user's app.

Anyway let me try pr_devel_ratelimited which is disabled by default. I hope this is
good enough. Additionally I moved the code from mm.h to mmap.c.

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2069,7 +2069,7 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
                addr = unmapped_area(info);
 
        if (IS_ERR_VALUE(addr)) {
-               pr_warn_ratelimited("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx mask:0x%lx offset:0x%lx\n",
+               pr_devel_ratelimited("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx mask:0x%lx offset:0x%lx\n",
                        __func__, addr, current->mm->total_vm, info->flags,
                        info->length, info->low_limit, info->high_limit,
                        info->align_mask, info->align_offset);
>
>

