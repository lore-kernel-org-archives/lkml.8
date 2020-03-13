Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7E5206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bnrNgJt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMExY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:53:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54167 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCMExY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:53:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200313045321epoutp04839ce24a8f428bbeec6c431e940ad74f~7xADL7fbL2795427954epoutp04m
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 04:53:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200313045321epoutp04839ce24a8f428bbeec6c431e940ad74f~7xADL7fbL2795427954epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584075201;
        bh=cqo00DQ6dzZsgG1sP9EFcSbddYdSjLw4CFnOQx+hYzQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bnrNgJt3l4I1Gvn2ZoMz8ugOjXCRj45xOiaU6KfEvNAZ2kWSM0kIEOTPmX/8mrAaK
         t+MypqVGnDSPg+i5viw715ofOQHhjtXt0DrjHjU4tFIVqLWzdmkiUi4CLC9DkwozDr
         jep1quGgvRDV5fpOZ0/n1cvCIf1GXjX09b8KmWDE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200313045321epcas1p425bfa3ab6f8ed3f4289804b24675bfa1~7xAC3jzoN1682516825epcas1p4F;
        Fri, 13 Mar 2020 04:53:21 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48dtcc0hryzMqYkv; Fri, 13 Mar
        2020 04:53:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.E5.57028.0C11B6E5; Fri, 13 Mar 2020 13:53:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200313045319epcas1p19364cf341987d7ccdd717a8cddb6fbc6~7xABeVaEZ1176011760epcas1p1O;
        Fri, 13 Mar 2020 04:53:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200313045319epsmtrp28ddbab6925fcd94604313457e92da3d6~7xABdEgd41833018330epsmtrp2s;
        Fri, 13 Mar 2020 04:53:19 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-c7-5e6b11c002f7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.C9.04215.FB11B6E5; Fri, 13 Mar 2020 13:53:19 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200313045318epsmtip2429f72e6d68a3142936aa0b490a24589~7xAAQY9rd1325313253epsmtip2B;
        Fri, 13 Mar 2020 04:53:18 +0000 (GMT)
Subject: Re: [RFC PATCH 1/3] proc/meminfo: introduce extra meminfo
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E6B11BD.3070700@samsung.com>
Date:   Fri, 13 Mar 2020 13:53:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200311173550.GA2170@avx2>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmnu4Bwew4g+0PmC2mN3pZzFm/hs2i
        e/NMRouVe34wWVzeNYfN4t6a/6wWy76+Z7fY0DKL3eLRhElMFqfufmZ34PLYOesuu8emVZ1s
        Hps+TWL3uHNtD5vHiRm/WTze77vK5rHz02ZWj8+b5AI4onJsMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUGBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GQ0zlzDXHCQu2LOonvsDYx9nF2M
        nBwSAiYSN3fPYe1i5OIQEtjBKPHrzSNmkISQwCdGiVUTfCES3xgl/n6cwAjT8eTtLXaIxF5G
        ie5lU1ggnLeMEqu3L2EFqRIWcJLY++gbWIeIgKbEsbub2ECKmAUeMUpcaHrGDpJgE9CWeL9g
        ElgDr4CWxNQll8HiLAKqEmdnTWMCsUUFIiR2zP3ICFEjKHFy5hMWEJsTaOiS6Q/AbmUWkJdo
        3jqbGeK8/2wS347kQtguEjNm/2WCsIUlXh3fwg5hS0l8frcX7CAJgWZGibczNzNCOC2MEnc3
        9UI9aizR23MBaCoH0AZNifW79CHCihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImaRMuzr6wQ
        tozE33/PoGwPifY9KxkhofWEUeLq3m/sExgVZiH5bRaSf2YhbF7AyLyKUSy1oDg3PbXYsMAQ
        OY43MYKTrZbpDsYp53wOMQpwMCrx8BqIZcUJsSaWFVfmHmKU4GBWEuGNl0+PE+JNSaysSi3K
        jy8qzUktPsRoCgzuicxSosn5wEyQVxJvaGpkbGxsYWJmbmZqrCTOm/QJaI5AemJJanZqakFq
        EUwfEwenVANjjUjgzH9zmbfo6eQWxFxsfMA1wymJrfOeLH/JoxrDE/1+3zbPb7UQvbblm9Pi
        kifiUQE+cg+Y9IPe39hj/iOBZ/Js2YhjN1seqC5NY4qa9V+P7RL7BG3LT6kqOXWRj76fj6wq
        2FD+9aXun5bP3Z4CAk4PfZf8d7TXWfjs6d1twadDeW5bhc1TYinOSDTUYi4qTgQANP8JkcwD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXne/YHacwfEmDYvpjV4Wc9avYbPo
        3jyT0WLlnh9MFpd3zWGzuLfmP6vFsq/v2S02tMxit3g0YRKTxam7n9kduDx2zrrL7rFpVSeb
        x6ZPk9g97lzbw+ZxYsZvFo/3+66yeez8tJnV4/MmuQCOKC6blNSczLLUIn27BK6MxplrmAsO
        clfMWXSPvYGxj7OLkZNDQsBE4snbW+xdjFwcQgK7GSW2dS5gh0jISLw5/5Sli5EDyBaWOHy4
        GCQsJPCaUaLtRhyILSzgJLH30TdGEFtEQFPi2N1NbBBznjBKrGh8ATaUWeARo8SU6zOZQarY
        BLQl3i+YxApi8wpoSUxdchlsGYuAqsTZWdOYQGxRgQiJ1euuMUPUCEqcnPmEBcTmBNqwZPoD
        sDizgLrEn3mXoGx5ieats5knMArOQtIyC0nZLCRlCxiZVzFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBEeQltYOxhMn4g8xCnAwKvHwGohlxQmxJpYVV+YeYpTgYFYS4Y2XT48T4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwJh10KmmJNbz819x
        heovyfrNGc/tM5SjWuc+UfFS+la5NSRxlrycrNHlanWbLxxXTu2aPMt90eX03nniVw7eWOA+
        95T+qf3zm17Wqspr+0wwdH0SsNnji8gttVJl1qusBq1sC1cJz9syP2wCR0tDodnHt7lT3Qr7
        vzxf2jlhprKpftwJL2OzWUosxRmJhlrMRcWJAEt76YmcAgAA
X-CMS-MailID: 20200313045319epcas1p19364cf341987d7ccdd717a8cddb6fbc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <CGME20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf@epcas1p1.samsung.com>
        <20200311034441.23243-2-jaewon31.kim@samsung.com>
        <20200311173550.GA2170@avx2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 12일 02:35, Alexey Dobriyan wrote:
> On Wed, Mar 11, 2020 at 12:44:39PM +0900, Jaewon Kim wrote:
>> Provide APIs to drivers so that they can show its memory usage on
>> /proc/meminfo.
>>
>> int register_extra_meminfo(atomic_long_t *val, int shift,
>> 			   const char *name);
>> int unregister_extra_meminfo(atomic_long_t *val);
>> +			show_val_kb(m, memtemp->name_pad, nr_page);
> I have 3 issues.
>
> Can this be printed without "KB" piece and without useless whitespace,
> like /proc/vmstat does?
>
> I don't know how do you parse /proc/meminfo.
> Do you search for specific string or do you use some kind of map[k] = v
> interface?
If need, I can remove KB. but show_free_areas also seems to print KB for some stats.
And I intentionally added : and space to be same format like others in /proc/meminfo.
show_val_kb(m, "MemTotal:       ", i.totalram);
>
> 2) zsmalloc can create top-level symlink and resolve it to necessary value.
> It will be only 1 readlink(2) system call to fetch it.
Yes it could be done by userspace readlink systemcall. But I wanted to see
all huge memory stats on one node of /proc/meminfo.
>
> 3) android can do the same
>
> For simple values there is no need to register stuff and create
> mini subsystems.
>
> 	/proc/alexey
OK as Leon Romanovsky said, I may be able to move other node of /proc/meminfo_extra.
Please let me know if it still have a point to be reviewed.

Thank you
>
>

