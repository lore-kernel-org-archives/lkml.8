Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F83C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AB72074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gIOp9sZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFBL1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:27:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49686 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFBL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:27:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200602112711euoutp01f75a15ce2b493978a137d0e8e1c21bb7~UtoBqWoeq1161011610euoutp01R
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200602112711euoutp01f75a15ce2b493978a137d0e8e1c21bb7~UtoBqWoeq1161011610euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591097231;
        bh=lws8h8ngyIRcVucQE/5GbxxYe7NmIBaTOcKoGnIjGUU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gIOp9sZEIvVU+qQ/0HYsoSbU0k5jFjzdLg6QcA1ilAViPyGj+67CR/bt7CpWfqJag
         gN7s7SmuxjzM6vj3KQWJNoi2ViqvokxPPR4sNMwNzZJ47tC0zql3StJvk1ykZ2PzbE
         Iuf3k3P5C+ZryKlvxOOz+H9h1CPfsB1+KmZCnVCk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200602112710eucas1p167a6dd9ed602c468aeebd7123b2b51b4~UtoBXYYgd0788807888eucas1p1E;
        Tue,  2 Jun 2020 11:27:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.25.60679.E8736DE5; Tue,  2
        Jun 2020 12:27:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200602112710eucas1p116324667c77bec7a64faea095172e137~UtoBAkZfi1190611906eucas1p1h;
        Tue,  2 Jun 2020 11:27:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602112710eusmtrp14ec2c8ebe5efdc2dcf98ee565202c7c2~UtoA-_2ZY0880308803eusmtrp1D;
        Tue,  2 Jun 2020 11:27:10 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-97-5ed6378e49d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.76.08375.E8736DE5; Tue,  2
        Jun 2020 12:27:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200602112709eusmtip154bc48d3d3b960aba90ffc6a50bf8e66~UtoApDL-Q1526715267eusmtip1i;
        Tue,  2 Jun 2020 11:27:09 +0000 (GMT)
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5cb15e20-e2e1-f79d-72af-74cc09debc19@samsung.com>
Date:   Tue, 2 Jun 2020 13:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6d17452e-29ee-76dd-759c-b39d87bb82b8@physik.fu-berlin.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87p95tfiDP5N0rS48vU9m8WzW3uZ
        LGa/V7Y40feB1eLyrjlsFsufrGW2OP/3OKsDu8ehwx2MHve7jzN5nGz9xuJx8Nw5Ro/Pm+Q8
        Nj15yxTAFsVlk5Kak1mWWqRvl8CVsfbBDOaCW3wVvRMXMTUw3uTuYuTkkBAwkVh2biZzFyMX
        h5DACkaJS79uM0I4Xxglmk8cYIJwPjNKtM1azgjTMuPmYRaIxHJGiQfPH0C1vGWUuHduMQtI
        lbCAm8Svnf/BbBGBTIn25slgRcwCTUwSa7dsZAZJsAlYSUxsXwU2llfATmLLhA1gDSwCKhJ/
        328BqxEViJD49OAwK0SNoMTJmU/AajgF3CVubJ8N1sssIC5x68l8JghbXmL72znMEKfuYpeY
        cT+1i5EDyHaRmHeWAyIsLPHq+BZ2CFtG4vTkHrBvJATWMUr87XjBDOFsZ5RYPvkfG0SVtcSd
        c7/YQAYxC2hKrN+lDxF2lDhz4SUTxHw+iRtvBSFO4JOYtG06M0SYV6KjTQiiWk1iw7INbDBr
        u3auZJ7AqDQLyWOzkDwzC8kzsxD2LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY
        jE7/O/5lB+OuP0mHGAU4GJV4eA0Mr8UJsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76o
        NCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGKZOcGzn/3lPU3cJhuVS1LJVH
        WnETl21ddGdIjMfBfaG1yrqv+6eEvnxsXPBl7dm0w4bnwq9PuMWzI37/uZQ7/4TXXuThdrge
        kcF/7FXlgu3ndmYf17FkL1qvXK/1pXLm8QqvWz6rXlfmejt8aXbmvfVFYboX68lLL2aIr9id
        vqlf6dK6kvk/lViKMxINtZiLihMBrlXGoEIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7p95tfiDBbOFLK48vU9m8WzW3uZ
        LGa/V7Y40feB1eLyrjlsFsufrGW2OP/3OKsDu8ehwx2MHve7jzN5nGz9xuJx8Nw5Ro/Pm+Q8
        Nj15yxTAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CXsfbBDOaCW3wVvRMXMTUw3uTuYuTkkBAwkZhx8zBLFyMXh5DAUkaJv1vnMncxcgAlZCSO
        ry+DqBGW+HOtiw2i5jWjxIFFV5lBEsICbhK/dv5nAbFFBDIlTp39wQ5iMwu0MEks/qID0TCJ
        WeLUlvuMIAk2ASuJie2rwGxeATuJLRM2gDWzCKhI/H2/BWyoqECExOEds6BqBCVOznwCVsMp
        4C5xY/tsRogF6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwi
        qaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRt+3Yz807GC9tDD7EKMDBqMTDa2B4LU6INbGsuDL3
        EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTAx5JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYK7j1ZStmtVk+Z1nUFfS5Z4Ox/LyTlocX
        9Fd6263o/SiVn16kfXjD29z6orqViRrmHalfj8W63rfKX3Ul4dAq92kOde8WcM7LfLdaamX1
        4QoNf3n3N7ntk33KuuwOTTnAcDF7RpHnxRznv+slZoYxNLau8j/Vpn5vWe22+ytqyjxsNpcb
        vZRWYinOSDTUYi4qTgQARfAr6dQCAAA=
X-CMS-MailID: 20200602112710eucas1p116324667c77bec7a64faea095172e137
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504232908eucas1p296927bc7c736ad924cefaea9a546459d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504232908eucas1p296927bc7c736ad924cefaea9a546459d
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
        <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
        <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
        <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
        <CAMuHMdXUD4PNndjtxz84pYMdXaM68g7vWiRd+Gf18a35T-oA=Q@mail.gmail.com>
        <6d17452e-29ee-76dd-759c-b39d87bb82b8@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/20 1:07 PM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 6/2/20 1:04 PM, Geert Uytterhoeven wrote:
>>> What do you mean with the sentence "when arch/ppc/ was still king"?
>>
>> Ah, Bartl copied that from my email ;-)
>>
>> There used to be APUS support under arch/ppc/.
>> Later, 32-bit arch/ppc/ and 64-bit arch/ppc64/ were merged in a new\
>> architecture port under arch/powerpc/, and the old ones were dropped.
>> APUS was never converted, and thus dropped.
> 
> Ah, yes. Similar to the merge with x86.
> 
>>> Does that mean - in the case we would re-add APUS support in the future, that
>>> these particular changes would not be necessary?
>>
>> They would still be necessary, as PowerPC doesn't grok m68k instructions.
>> Alternatively, we could just drop the m68k inline asm, and retain the C
>> version instead?  I have no idea how big of a difference that would make
>> on m68k, using a more modern compiler than when the code was written
>> originally.
> 
> Hmm, no idea. I would keep the assembly for the time being. This was just
> a question out of curiosity. We could still consider such a change if
> someone should consider working on APUS support again.
> 
>> Note that all of this is used only for cursor handling, which I doubt is
>> actually used by any user space application. The only exception is the
>> DIVUL() macro, which is used once during initialization, thus also not
>> performance critical.
> I see, thanks.

Since the code in question is not performance critical it indeed seems to
be good idea to use C version. However it still would need be tested on
the hardware (or emulator at least) so for the time being I think that we
should just add another FIXME comment instead of doing real code changes..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
