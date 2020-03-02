Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987FFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837C24699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dMnWkR7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBIiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:38:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12998 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:38:07 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2020 03:38:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583138286;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dyg4AOlIJyThsXs5J5Vubyx8MvOEPr/tJdn+Z7Tzl30=;
        b=dMnWkR7W9G9pQOsssqo1hdl0VcUddhnY2J0bEerrmUgpcMi3gl+reWuiLUmvKJLMbu
        GAZJw4YGzRx0aR3NPLHxbdbHJ7UN38B9Nz6rqhaRf/jXobPIEVh3Z4r/JXFnfLUVgpsp
        gXWiofM6pdO5arkJbUOjb5+83TDB/gJjgrHzcKqCRwHP553dsc0rn5UrbdCXCz57MXXC
        wX6e3g/bOOv3pvnMKMGwxSNp/484VYy+QAnVdHGmfI2Ll67UeRaBSi3g+avK0WcOivaU
        lYldXlqfm7KSY2kjZToh+pBHWXk43xABEa5TZU+BDaHQK10RJ1fiL5Aqm6MAyx511G1i
        lt7Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh6kEtw"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id e0a4ffw228W255z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 2 Mar 2020 09:32:02 +0100 (CET)
Subject: Re: KASAN: use-after-free Read in slcan_open
To:     syzbot <syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com>,
        davem@davemloft.net, dvyukov@google.com, jouni.hogander@unikie.com,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wg@grandegger.com
References: <00000000000099fb63059fd95165@google.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2f8c5b49-ae02-e269-97cf-b4a979f950ac@hartkopp.net>
Date:   Mon, 2 Mar 2020 09:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <00000000000099fb63059fd95165@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#sys fix: can: slcan: Fix use-after-free Read in slcan_open

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/slcan.c?id=9ebd796e24008f33f06ebea5a5e6aceb68b51794

Thanks,
Oliver

On 02/03/2020 07.30, syzbot wrote:
> This bug is marked as fixed by commit:
> slcan: Fix use-after-free Read in slcan_open
> But I can't find it in any tested tree for more than 90 days.
> Is it a correct commit? Please update it by replying:
> #syz fix: exact-commit-title
> Until then the bug is still considered open and
> new crashes with the same signature are ignored.
> 
