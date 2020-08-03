Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A548C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0244420781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZHd/XLl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgHCLHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:07:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60820 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:07:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200803110721euoutp025f0aa30c58386d76a640d14ad795b1f7~nvWaMZp8a0765807658euoutp02B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:07:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200803110721euoutp025f0aa30c58386d76a640d14ad795b1f7~nvWaMZp8a0765807658euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596452841;
        bh=YuGdyCVaKEYE24EuD7N0wpnCbtpkm39w8lrqKYdD6iY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZHd/XLl5MGXDnhv3k6kfCOm0tRbeDiVyNjAaLBzCCKs6fVwUUU4AluExexMQVcwdS
         qxs1ydjWwd2nJQ6atEYGsfYBZdrTluGO+USa/xE8e+L33hjRaYWI3+724VL/k/LoRy
         W4UkP+OyynnZadbfk1Jks9I6uX0C7HcibnTXNWAo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200803110720eucas1p271ddc715648770630856e629d5bd8799~nvWZ2IkWc0126901269eucas1p2F;
        Mon,  3 Aug 2020 11:07:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.92.06318.8EFE72F5; Mon,  3
        Aug 2020 12:07:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200803110720eucas1p24d589fdd1ef2f7bc0e0629dd8cd6a7b6~nvWZdaKJ30535105351eucas1p24;
        Mon,  3 Aug 2020 11:07:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200803110720eusmtrp1d85e781ca1f455426951f388e375ef9f~nvWZcjdh20426104261eusmtrp1l;
        Mon,  3 Aug 2020 11:07:20 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-09-5f27efe8f4c3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.66.06314.8EFE72F5; Mon,  3
        Aug 2020 12:07:20 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200803110719eusmtip152dc41f6fc746fec13c3f3a0e45ef509~nvWY3hoZ11924719247eusmtip1q;
        Mon,  3 Aug 2020 11:07:19 +0000 (GMT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback
 buffer
To:     Greg KH <greg@kroah.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jirislaby@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Kyungtae Kim <kt0755@gmail.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Solar Designer <solar@openwall.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        xiao.zhang@windriver.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <86fc45ac-5bb1-50a2-5f4c-5c2da30f7c3b@samsung.com>
Date:   Mon, 3 Aug 2020 13:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200803094753.GC635660@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b27u1pXXmfig0nBCM2oVNaP2wdSFnH/hAsiKixbeZkrN21X
        V0Y/hKJ0MyutpkvLRJdKaPmxmq0Iy48hSl9TC0UTi5Km5izoa9W8k/x3nnPO857nwEsTcq80
        ktbqs3mDXp2hoIJJe+f3vrUfp2JS4xunFKzZ3InYP/bLBPv66xTF9lWWInayIor9Md1LsN1F
        01L2VVs5xXZ0mgjWZVGyY0UeGVtsqiHYlpl+CTvx20JtCeFqn5uk3I3Jo9yjb5Uk57AOy7iz
        zzxSrqm+gOI871Rcd+lPkhsxd0k47+chGff+1zDFeZuWc40trRIVsz94cxqfoTXyhrjEQ8Hp
        NwrKJFlnQ0+629pkeaiZMaEgGvB6GPA1SE0omJbjWgTDP8uROMwi+GR3BhQvglnHU9n8StFn
        CykKtxHUfrAHBg+CL88fk35XGE6GlvtDEj9eiqMgv9op85sI7CTh6oNvcwKFN8Ll8/X/Amma
        wYngG9vhp0m8Em6ZLkj9OBzvhZnRp3OYwaHgKhufez8Ix8PEmZI5TOAIeDt+UyLiFXCm9Trh
        zwJ8iwZbsY8Uz94OY+57SMRhMNHVEqgTBT0lhaS40IDgd/7HwPZ9BLdLfJTo2gRDfT8o/6UE
        joXGtjiR3go1T/oJPw04BAY9oeIRIVBstwRoBvLPyUV3NNy13aXmY02OOuISUlgXVLMuqGNd
        UMf6P7cSkfUogs8RdBpeUOr5E+sEtU7I0WvWHcnUNaF/X7HH1/X1AXr863A7wjRSLGHSvdGp
        cqnaKOTq2hHQhGIpk9Tbc1DOpKlzT/GGzFRDTgYvtKNlNKmIYJRVnw7IsUadzR/j+SzeMK9K
        6KDIPGQcSbpQcRBrD7vcSdIrL1ftvqfdqXA5BvqPO1Xuffrk5kdTvfGesUWLBU1IeJ1tmzt2
        V4pZvWpPdYrzT0Jobp7G/LDwi/zi5jdVy1M6XtCj52MGa20bCh0xqmuLyhff4XUdNmO0UlVS
        V+nNSjMm5k0eP2A5vXVN37Dz9YArYdSuIIV0dcJqwiCo/wJKL1MehgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4Xd0X79XjDZo/8Fh0dx9jtPi/bSKz
        xZWv79kszi2YwWjxbq6Mxa8PZ5ktTvR9YLW4vGsOm8XRY13MFienG1s86nvLbjGpaymzxZZP
        15gsXv2dzubA57HiQherx7x3WR57vy1g8dg56y67R8uRt6wem1Z1snm8fRjgcWLGbxaP+93H
        mTw+v7nD7vH0z102j8+b5DzWb9nKFMAbpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJcxr3MmU0GLYMXVXbvYGxg383YxcnJICJhI9L2ZztLFyMUh
        JLCUUeJe52nmLkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpS40DqVCSQhLOArsfj/DjYQWwSovmPJ
        HnaQImaBfSwSr1d2MUJ0HGKWaH/4GqyDTcBKYmL7KkaQDbwCdhL/HrmBhFkEVCQWdvWygtii
        AhESh3fMYgSxeQUEJU7OfMICYnMKGEi8ap4MZjMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvME
        RqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJTwLZjPzfvYLy0
        MfgQowAHoxIPb8ZntXgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BXpu
        IrOUaHI+MD3llcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg7A9Q
        s/L3fHivZ6rtk6m7+ZS43vKujFiZ63jW8MgKIwnJwtssB5o5GbqWsMb9vSzGe7il6ZDr5SPM
        nhUFu/cXmvIY/Enq/H5Z2urVv7sZaxa+U0448u7cdGvWCWz7PTiiktqnPZ9pwvr/ftOy/WzR
        s1zTVRYVfxe0rXLPf2wSzON179Prr70PlViKMxINtZiLihMB+KKm1xcDAAA=
X-CMS-MailID: 20200803110720eucas1p24d589fdd1ef2f7bc0e0629dd8cd6a7b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200803094820eucas1p1696af31a3c9a295b7c4a4f478a5bde8d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200803094820eucas1p1696af31a3c9a295b7c4a4f478a5bde8d
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
        <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
        <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
        <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
        <20200803081823.GD493272@kroah.com>
        <CAKMK7uEV+CV89-L1Y=dijOEy8DKE=juRfQDnNnbhbAJhFh1fYw@mail.gmail.com>
        <CGME20200803094820eucas1p1696af31a3c9a295b7c4a4f478a5bde8d@eucas1p1.samsung.com>
        <20200803094753.GC635660@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/20 11:47 AM, Greg KH wrote:
> On Mon, Aug 03, 2020 at 10:45:07AM +0200, Daniel Vetter wrote:
>> On Mon, Aug 3, 2020 at 10:26 AM Greg KH <greg@kroah.com> wrote:
>>>
>>> On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
>>>> Hi,
>>>>
>>>> On 31. 07. 20, 7:22, 张云海 wrote:
>>>>> Remove whitespace at EOL
>>>>
>>>> I am fine with the patch. However it should be sent properly (inline
>>>> mail, having a PATCH subject etc. -- see
>>>> Documentation/process/submitting-patches.rst). git send-email after git
>>>> format-patch handles most of it.
>>>>
>>>> There is also question who is willing to take it?
>>>>
>>>> Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
>>>> can sign off and resend the patch which was attached to the mail I am
>>>> replying to too, if need be.)
>>>
>>> I can take it, if Bart can't, just let me know.
>>
>> Yeah vt stuff and console drivers != fbcon go through Greg's tree past
>> few years ...
>>
>> Greg, should we maybe add a MAINTAINERS entry that matches on all
>> things console? With tty/vt you definitely have the other side of that
>> coin already :-)
> 
> Sure, that would be good as things do fall through the cracks at times.

Since taking over fbdev in 2017 I've tried to act as the last resort
Maintainer for console stuff (AFAIK there are no "lost" patches) but
it really deserves its own entry.

Also most console patches make it through you nowadays anyway:

$ git log --pretty=fuller --since=2017 drivers/video/console/|grep "Commit\:"|sort|uniq -cd
      2 Commit:     Arnd Bergmann <arnd@arndb.de>
     11 Commit:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
      2 Commit:     Daniel Vetter <daniel.vetter@ffwll.ch>
      3 Commit:     Dave Airlie <airlied@redhat.com>
     12 Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
      7 Commit:     Linus Torvalds <torvalds@linux-foundation.org>
      2 Commit:     Martin Schwidefsky <schwidefsky@de.ibm.com>

> If you write the patch, I'll merge it :)
ACK from me. :)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
