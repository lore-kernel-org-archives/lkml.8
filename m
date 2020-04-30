Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB36C83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543112082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD3DXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:23:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58797 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgD3DXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:23:39 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; 
   d="scan'208";a="90801342"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Apr 2020 11:23:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9166650A996E;
        Thu, 30 Apr 2020 11:23:34 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 30 Apr 2020 11:23:35 +0800
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Li Wang <liwang@redhat.com>
CC:     LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587552329-21738-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2ea_CtRyP9KtpJDjpEzobRyhrodiycDCAxhLbCjuOwhCQ@mail.gmail.com>
 <662aa817-04ff-e924-6880-7c23fa1cfe31@cn.fujitsu.com>
 <CAEemH2cF-kziNEHuN1GayTtzwdxFFzsu0wRGB85yJ=LaKS-XBw@mail.gmail.com>
 <3268f153-6730-708f-ed93-19ca4cf85fdd@cn.fujitsu.com>
 <CAEemH2ee7c55=EQb5qohpu40XMACSOCrSStwWt7u=_GyqjrxLw@mail.gmail.com>
 <CAHk-=wg7u4AjZQd49VjrZXikDMfK-HchOKHYqoUFwcXjsbJ3XQ@mail.gmail.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <36bd1e20-414b-ec24-f7e3-16ef7e2395d9@cn.fujitsu.com>
Date:   Thu, 30 Apr 2020 11:23:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg7u4AjZQd49VjrZXikDMfK-HchOKHYqoUFwcXjsbJ3XQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 9166650A996E.AB31D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus


> On Sun, Apr 26, 2020 at 4:59 AM Li Wang <liwang@redhat.com> wrote:
>>
>>  From kernel code seems you are right. The pipe indeed takes use of PAGE_SIZE(ppc64le: 64kB) to split the writes data in the packetized mode (marked by O_DIRECT). But in the manual page, O_DIRECT indicates us the PIPE_BUF is the correct atomic unit.
> 
> The manual is correct.
> 
> PIPE_BUF is the size we _guarantee_ can be used atomically.
> 
> The fact that in practice we do have bigger buffers on some platforms
> is an implementation detail.
> 
> Yes, that implementation detail can be visible, but basically any test
> code that tries to test for "what if we use a bigger bug that
> PIPE_BUF" is buggy. It's simply not guaranteed to work any more.
> 
> O_DIRECT is kind of immaterial, except it's just one of those things
> where the atomic size is slightly more visible. But basically,
> packetized pipes with bigger packets than PIPE_BUF is random behavior.
> It may work. It may not.
Thanks for your explanation. I am more curious about the user scene of 
this flag.

@Li, so how to design this test? In this test, we don't have complex 
scene to test this automic unit.

Best Regards
Yang Xu
> 
>                  Linus
> 
> 


