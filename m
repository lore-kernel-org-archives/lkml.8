Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9A20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585676480;
	bh=SNoQUVCjCkooeA8cu157MJg11jvVTYE1Wq5nD+SAOt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LE+oDxmVcY1Bb4jBIxSWOLaMnwIstlADUl8es861EIF6Dd6bfDNfcIS12JRqV/idZ
	 OPJrhtNF4Rx0D1l4r3Je+QVbwPXQsGwP1G39FlPoqmqRB4yknxUWI1CVtR25YWXpfX
	 rYhja9HDyOaRMwju16d35kAlXp/VZN//B26abXfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgCaRlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCaRlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:41:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C987820BED;
        Tue, 31 Mar 2020 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585676478;
        bh=SNoQUVCjCkooeA8cu157MJg11jvVTYE1Wq5nD+SAOt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0TzQFv49ZtbVWvHeK30LQ5TJJS1xON3Eh0FdMYTf784spIdbnyxArUevTGYwiRg7
         xDtnBb5qIzwDOhOzngke9jfyWVI8OAvh6FPLLCieOEgn/yjDEbw+v0rDptNNpvWjU4
         RZBYSJkOatgocnrYQMdivvqcQAdw8vl3CtQFuR4c=
Date:   Tue, 31 Mar 2020 19:41:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, festevam@gmail.com, grundler@chromium.org,
        hayeswang@realtek.com, johan.hedberg@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        marcel@holtmann.org, nishadkamdar@gmail.com, peter.chen@nxp.com,
        pmalani@chromium.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in skb_release_data (2)
Message-ID: <20200331174116.GA1844017@kroah.com>
References: <000000000000da6059059fcfdcf9@google.com>
 <0000000000005b022005a22a0050@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005b022005a22a0050@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:36:01AM -0700, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit d9958306d4be14f4c7466242b38ed3893a7b1386
> Author: Nishad Kamdar <nishadkamdar@gmail.com>
> Date:   Sun Mar 15 10:55:07 2020 +0000
> 
>     USB: chipidea: Use the correct style for SPDX License Identifier
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d4940be00000
> start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a66a7c2e996797bb4acb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c25a81e00000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: USB: chipidea: Use the correct style for SPDX License Identifier

I really doubt a comment change fixed a syzbot bug :)
