Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A402063A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VonCr0fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEFUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgEFUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:21:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:21:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so3559909qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dP0vYcPCDUEKnKfl0vHiCDY86loQr8nEpkrsHZbwj6g=;
        b=VonCr0fGB1+y/bvwpzdwb6tlmzk0QS05EVczOa/kV3OvK8g7q0rtYJ5zFCe8VhKQ1G
         HepFpIHT6cqima00FuncJxoUu9p6HLfnipb+MIhz2LWOP7P1l+WEmjNc5mX8lygad7do
         p7U2izZjbSqcb32r0keVsef6EgFRjks+kQzdlGwXPjGIjm8QVtues7ejadl1pe6SvH57
         QTpXhcnCHUrY+fb06Uxw+1ul3nXXlbzZzq4cdhFortgwVUc+16Ud9df4ZTO/RTlNE78f
         As2Cl+3LNiND/AJDG+uzMK2OAWtbzo7Z0Pvyx3GvTXxrs9MLIWPi0aRIbTpVZvLIgE4V
         SG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dP0vYcPCDUEKnKfl0vHiCDY86loQr8nEpkrsHZbwj6g=;
        b=EcoBj7lcxpPxvV0hXvhnVQj7uuCfYm4NApRo7hHnN/pRky0At6J0IZElGPoNvtS78+
         XxmARoQXI/5Ios2H0Y+4fqRz0JuXy6mYHYOr86MuMp4gEinQYPIjPbP0JMLY/AfXXgwk
         zKjOJfQhmjwEjeEG4JHalBqqwuCCwPCxUxXfxEzqz8reZG61gYO9hFn4nBc5iNmqy2QK
         2TiuIuhWdjbgS+XvtGiWF9d9ZTFy4f2JxlvDsL4IMd6Cl1qJv3F6CkZTGvTBEgd0RyVa
         dzsRbZ/UJyK1AD+N+65ZYFDu5viBb6jpJRm85GZbKCxz7nDV2OjLGOTq1Fj5ZLl2xW02
         Wz3w==
X-Gm-Message-State: AGi0PubFWfv/cwQck0NPSZ4Kh87qFzYGJYkyTC7yirQZ+uMdOueaMCkE
        0ehJYhl1QmqhrhqvKoHOOEvf7A==
X-Google-Smtp-Source: APiQypJ0aJDZ7xSpZJ+xrLLXz/GH6rX6oZHzJBstremmsGm4OFxhBV/QEHujuy5bcPQ70phY+kkGJg==
X-Received: by 2002:ae9:c301:: with SMTP id n1mr10721718qkg.300.1588796468704;
        Wed, 06 May 2020 13:21:08 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m12sm2434113qtu.42.2020.05.06.13.21.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 13:21:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: linux-next boot error: WARNING: suspicious RCU usage in
 ipmr_get_table
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200507061635.449f9495@canb.auug.org.au>
Date:   Wed, 6 May 2020 16:21:05 -0400
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Amol Grover <frextrite@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        syzbot <syzbot+1519f497f2f9f08183c6@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D570330-8E3E-4596-AD9B-21CE6A86F146@lca.pw>
References: <000000000000df9a9805a455e07b@google.com>
 <CACT4Y+YnjK+kq0pfb5fe-q1bqe2T1jq_mvKHf--Z80Z3wkyK1Q@mail.gmail.com>
 <34558B83-103E-4205-8D3D-534978D5A498@lca.pw>
 <20200507061635.449f9495@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 6, 2020, at 4:16 PM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi Qian,
>=20
> On Tue, 28 Apr 2020 09:56:59 -0400 Qian Cai <cai@lca.pw> wrote:
>>=20
>>> On Apr 28, 2020, at 4:57 AM, Dmitry Vyukov <dvyukov@google.com> =
wrote: =20
>>>> net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!! =20
>>=20
>> =
https://lore.kernel.org/netdev/20200222063835.14328-2-frextrite@gmail.com/=

>>=20
>> Never been picked up for a few months due to some reasons. You could =
probably
>> need to convince David, Paul, Steven or Linus to unblock the bot or =
carry patches
>> on your own?
>=20
> Did you resubmit the patch series as Dave Miller asked you to (now =
that
> net-next is based on v5.7-rc1+)?

Actually, it was Amol not me who submit the patch, so let him to answer =
that.=
