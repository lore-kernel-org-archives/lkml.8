Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FB2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D89206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sCPp7Jiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFARmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:42:38 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6621 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFARmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:42:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed53db70000>; Mon, 01 Jun 2020 10:41:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Jun 2020 10:42:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 01 Jun 2020 10:42:37 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jun
 2020 17:42:26 +0000
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to
 pin_user_pages*()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Paul Mundt" <lethal@linux-sh.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
 <20200531205819.GC138722@ravnborg.org>
 <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com>
 <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
 <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com>
 <CAHp75VcaXTM86K9vzyxTQJP_oNnzJ8mMHzgm7ybEioVhG6DHDQ@mail.gmail.com>
 <8fa07f59-6d77-f76b-7539-c88bf85c5036@nvidia.com>
 <CAHp75VfHnLz56jyR5PNgpxWGtO_u0bss45+iHhQ03c_4L3jH5g@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2f832d22-179e-b228-0864-f55dde765b48@nvidia.com>
Date:   Mon, 1 Jun 2020 10:42:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfHnLz56jyR5PNgpxWGtO_u0bss45+iHhQ03c_4L3jH5g@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591033271; bh=ChY8kQ3GISu3XKtIp7DQSWGeUWq2DqG74+qg5oD8kN8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sCPp7JivTlZhcs+40THY6PI0JWnW2mcA0A2601nDZ8DnPr9GsqZOl/aJ0iq1cefjI
         hfItZabxvz1KtzwrdLtiByIm4aJ1UOsVrt3Jx7UA0ZHsUCzCpEluXZ9lDEERWj6iJ5
         7Crih9Xi3hxUnPY1RxtA3EwDCZZgvilOGjy5zpmAT9sW01BOv0BpWnESgQF/ZrIWPv
         WFA4i7MjiPK6Pgn4jubGCI0rAt80dfO3JAzUw5Q/zgUE4LQN/szeJtJKMCLA13ifls
         +vvjTizNjYNDUs5fDsQypUkq1vdGDhe/mb6Pv6MMZVfNMlt2UoHvh/H8Pr4xAzQTPZ
         /j6nA5Szu0kRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 10:25, Andy Shevchenko wrote:
> On Mon, Jun 1, 2020 at 8:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 2020-06-01 03:35, Andy Shevchenko wrote:
>>> On Mon, Jun 1, 2020 at 1:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>>> On 2020-05-31 14:11, Andy Shevchenko wrote:
>>>>>       ...
>>>>> JFYI, we have history.git starting from v0.01.
>>>>>
>>>> OK, thanks for that note. According to that history.git [1],
>>>> then: drivers/video/pvr2fb.c had get_user_pages_fast() support added to
>>>> pvr2fb_write() back in 2004, but only for CONFIG_SH_DMA, as part of
>>>>
>>>>        commit 434502754f2 ("[PATCH] SH Merge")
>>>>
>>>> ...and that commit created the minor bug that patch 0001 here
>>>> addresses. (+Cc Paul just for the sake of completeness.)
>>>>
>>>>
>>>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>>>
>>> I mentioned this one, but I guess content should be the same.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
>>>
>>
>> Actually, that history.git *starts* at Linux 2.6.12-rc2,
> 
> It's not true.

OK I see, neither a straight "git log" nor git branches will suffice, you
have to use tags in order to get to the older versions.

> 
>> while
>> tglx/history.git *ends* at Linux 2.6.12-rc2 (which is in April, 2005).
>> And the commit I was looking for is in 2004. So that's why I needed a
>> different stretch of history.
> 
> Actually history/history.git contains all of them starting from v0.01.
> But it ends, indeed, on 2.6.33.
> 

thanks,
-- 
John Hubbard
NVIDIA
