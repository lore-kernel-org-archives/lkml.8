Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF7C33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2042084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 22:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/BDkbWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgALWt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 17:49:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgALWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 17:49:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so6791618wrh.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 14:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MzoQ2jg4oFupXMXlxp1CLkIfp3lD+zbiYm54IT89hQE=;
        b=n/BDkbWvwPexU6KNI3DcndbVPFfvq6msl56o2Vs8WDpxxUWVLXJSM542ofKL3ni5V0
         FZTyvLjw4btxAQtK5JSTRiTzoggcyD+S3Uua993GbnNpPvlXru6WNyyC6dk6oDkKX2oK
         67kH4gkLR72NOORdAE6vNxPqyOci0T6zpGu+sGyW2ykzIV422CoZcDQdQn5ah+1xssYO
         vxSHrp011TrKmNpOBwS9cVcL+inamf0M65LqC9GEN/u/BdZp/0CBG841i6FzJUjdEiPA
         bTDPRVN9FO/irN5OQOhA42CSvSfVBAcrpE3jIhujT1DVFoC10NgB2TC6UcQCr9NIy99p
         rOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MzoQ2jg4oFupXMXlxp1CLkIfp3lD+zbiYm54IT89hQE=;
        b=O1iE+6D6hx61c8bOlBN1wG2IR4jsQE/pfxk+Tc3e1Cdkx6xuKPujPtb6E7NiP7IOt2
         oBRzr+D+4Wx2D2kefEayo2+j9HNun134FmDIRSQsDBLcLGf5/ZXGlaU7dCU9S5mZAZRk
         1fevhfUvtWtvc7SgPyxvhvu1m07l/0gi0i+EkGnx7x79tv3M/gD/8I9EPaz67Q04BXhY
         gWZV5DO31Hnr5flhwRHSnK5Znyhlu7lHik0ROyTomJI0PwJNS3gy+HDIPwcZH8FrRUNj
         M0Ina6aFi+OKt+jQ6AwWWRfPUW+m+gGbWXqYaEXuy7mX4hbcQq9ubN83mn+T4QxzyvQN
         6m8g==
X-Gm-Message-State: APjAAAU29M12BqU98ItEBq9YIkULtv9ae9ByPtth87UjBHNSlnRO9MfW
        p4a2fvtLEHuIgs8+NDQqMJEgdjtbw/lQKxbW6Ws=
X-Google-Smtp-Source: APXvYqyBmCq60wRqDN13DYHLpE3BpSEwtVRR+D2yDu1FVab464RRHamv0OXBlql/KPpTX0dNN0j7XsT1oj35CNKNbPI=
X-Received: by 2002:adf:a308:: with SMTP id c8mr14660636wrb.240.1578869364989;
 Sun, 12 Jan 2020 14:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20191216154441.6648-1-fishland@aliyun.com>
In-Reply-To: <20191216154441.6648-1-fishland@aliyun.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 12 Jan 2020 23:49:13 +0100
Message-ID: <CAFLxGvyU=zh23vkYiAGRzyd4LGJodLwRRa1S03THAoSaSL=dGA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix potentially out-of-bounds memory access in ubifs_dump_node
To:     Liu Song <fishland@aliyun.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, liu.song11@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 4:45 PM Liu Song <fishland@aliyun.com> wrote:
>
> From: Liu Song <liu.song11@zte.com.cn>
>
> In =E2=80=9Cubifs_check_node=E2=80=9D, when =E2=80=9Cnode_len + offs> c->=
 leb_size=E2=80=9D, then
> goto label of "out_len". Then, in the following "ubifs_dump_node",
> if inode type is "UBIFS_DATA_NODE", in "print_hex_dump", an
> out-of-bounds access may occur due to the wrong "ch->len".
> We encountered this problem in our environment. If "ch-> len" is
> very large, it may even cause the kernel to crash.
>
> There are three reasons to choose to remove "print_hex_dump".
> 1) As mentioned earlier, the exception "ch-> len" may cause an
> exception in "print_hex_dump";
> 2) Data nodes are often large. When printing data content in
> "print_hex_dump", a large amount of output will bring a high load
> on the system, and may even cause a watchdog reset;
> 3) Even if there is a CRC check error, the stuff of file is difficult
> to identify, and difficult to find the problem from a large amount of
> output. We have already output the LEB and offset of the node. So we
> can take the initiative to view the data of interest, instead of
> printing it directly.

If UBIFS dumps data nodes due an error we are already in deep trouble
and having the content of bad data nodes can be helpful.
This feature helped me more than once to debug issues.

--=20
Thanks,
//richard
