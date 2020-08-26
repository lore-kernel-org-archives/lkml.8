Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C211FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C09022B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwnETgSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHZOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgHZOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:49:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so2104095wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlHQ8Az4X+OXt8rWimlu1goopYYA5EA/qvBB3JCyfdg=;
        b=lwnETgSXquCg53wSGs57FfgzjFIH9x7QEYxj1lV5CrLA+6qrIm183OdyZ3jq4g7oan
         v9KRI6rRZ+A9NYutgN6eirrX8OlQ1F7CoYknbxVGlH6nCfpiKEicKSUan5khWKoAEiqr
         BIA5WtkGXwpdwbwI1mhY0U4fTIZ0bDCTC0TVKKehfirgF8PbTmBd/oDudpJ+PuGJALcg
         fS+15qsgRBdI1GU2qqOJ/CtQ9FJFLyavjKOjRIFlhylXxexzpeauBrgAwLWLgETdtmN/
         1kyE93Rb+AkKs7ic4w7j1dOpm+O2HhlbMmSxWkQ6KrAeU07W0OHyteoK+nHJ5oOOhVdW
         vWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SlHQ8Az4X+OXt8rWimlu1goopYYA5EA/qvBB3JCyfdg=;
        b=XH38ONzV+IXx15oinh4BFJxlL1yFKi2F7ngVdCuD3Gjp48tjDwys2g5N+0+3TEcbD2
         is70V1C18mfB+kL1vcs1x0u0gBGeVhfYoeEjVbcujml7etSrOmGSjLxgYm83KbnxDBLn
         GR/Kvr/gnaEQCRKYUaIUcNFvi6QZoQt6gBTcsuUFKU6VcgYIYmqPJcZaJKtOdLi3ZW8C
         Q4NI1QM5dNk/+/NTcQe1mlwatpuNJIfVsyyz6uGdNZs4GxbT5uI4wiysqr48vrBY70gv
         zlcDvJcSFbDFs1XuCOnX7JueBBm3rBr9Zpq51aasrEr3yZ8Cl2NcAVVwKHBY0n3lxhks
         X2Bg==
X-Gm-Message-State: AOAM531ee9O0hPIHBRMpGqEcVBDM5VHaM0rBJlsEmwxXdt10k2JHJmHM
        MdU4aXawjBRGZwet/zePDOw=
X-Google-Smtp-Source: ABdhPJwBUApTlFpqNaRUx9QxdWDWI8wvmrSZp3BwsWJB9K1KVCP1Jih1BV3ZucOPWIL59GuHwxdD1g==
X-Received: by 2002:a5d:4050:: with SMTP id w16mr2762387wrp.412.1598453360741;
        Wed, 26 Aug 2020 07:49:20 -0700 (PDT)
Received: from metal ([154.123.216.233])
        by smtp.gmail.com with ESMTPSA id y11sm196689wrl.44.2020.08.26.07.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:49:20 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:49:15 +0300
From:   "David K. Kahurani" <k.kahurani@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     admin@rapidseedbox.com, gichini.ngaruiya@gmail.com
Subject: Re: [PATCH 5.7 00/15] 5.7.19-rc1 review
Message-ID: <20200826144915.GD16589@metal>
References: <20200826114849.295321031@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826114849.295321031@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:02:28PM +0200, Greg Kroah-Hartman wrote:
> -------------------
> Note, ok, this is really going to be the final 5.7.y kernel release.  I
> mean it this time....
> -------------------

Hello,

This is probably not very relevant but let me just bring this up here since your manner of posting mail on the list seems to differ quite a bit from what most people on the list are doing.

From my understanding, an email regarding to a certain patch or kernel issue should be sent to a list and not to a maintainer. This is however not the habit that people are in, though but instead, most people will send the email to the maintainers, then cc a few probably random mailing lists. This leads to emails flooding on the mailing list and consequently, beats the purpose of one ever having sent the mail to a list because lists will get increasingly difficult to follow.

Is it just me who has made this observation? From your mail, it clearly looks and seems like you are following the above. Not following the above could make it very hard for a new kernel developer to pick up working on the kernel.

Sincerely,
David Kiarie

> 
> This is the start of the stable review cycle for the 5.7.19 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Aug 2020 11:48:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 5.7.19-rc1
> 
> Max Filippov <jcmvbkbc@gmail.com>
>     binfmt_flat: revert "binfmt_flat: don't offset the data start"
> 
> Michael Ellerman <mpe@ellerman.id.au>
>     powerpc/64s: Don't init FSCR_DSCR in __init_FSCR()
> 
> Maxim Mikityanskiy <maximmi@mellanox.com>
>     ethtool: Don't omit the netlink reply if no features were changed
> 
> Maxim Mikityanskiy <maximmi@mellanox.com>
>     ethtool: Account for hw_features in netlink interface
> 
> Maxim Mikityanskiy <maximmi@mellanox.com>
>     ethtool: Fix preserving of wanted feature bits in netlink interface
> 
> Shay Agroskin <shayagr@amazon.com>
>     net: ena: Make missed_tx stat incremental
> 
> Cong Wang <xiyou.wangcong@gmail.com>
>     tipc: fix uninit skb->data in tipc_nl_compat_dumpit()
> 
> Xin Long <lucien.xin@gmail.com>
>     tipc: call rcu_read_lock() in tipc_aead_encrypt_done()
> 
> Peilin Ye <yepeilin.cs@gmail.com>
>     net/smc: Prevent kernel-infoleak in __smc_diag_dump()
> 
> David Laight <David.Laight@ACULAB.COM>
>     net: sctp: Fix negotiation of the number of data streams.
> 
> Alaa Hleihel <alaa@mellanox.com>
>     net/sched: act_ct: Fix skb double-free in tcf_ct_handle_fragments() error flow
> 
> Necip Fazil Yildiran <necip@google.com>
>     net: qrtr: fix usage of idr in port assignment to socket
> 
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>     net: nexthop: don't allow empty NHA_GROUP
> 
> Miaohe Lin <linmiaohe@huawei.com>
>     net: Fix potential wrong skb->protocol in skb_vlan_untag()
> 
> Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
>     gre6: Fix reception with IP6_TNL_F_RCV_DSCP_COPY
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                     |  4 ++--
>  arch/powerpc/kernel/cpu_setup_power.S        |  2 +-
>  drivers/net/ethernet/amazon/ena/ena_netdev.c |  5 ++++-
>  fs/binfmt_flat.c                             | 20 ++++++++++++--------
>  net/core/skbuff.c                            |  4 ++--
>  net/ethtool/features.c                       | 19 ++++++++++---------
>  net/ipv4/nexthop.c                           |  5 ++++-
>  net/ipv6/ip6_tunnel.c                        | 10 +++++++++-
>  net/qrtr/qrtr.c                              | 20 +++++++++++---------
>  net/sched/act_ct.c                           |  2 +-
>  net/sctp/stream.c                            |  6 ++++--
>  net/smc/smc_diag.c                           | 16 +++++++++-------
>  net/tipc/crypto.c                            |  2 ++
>  net/tipc/netlink_compat.c                    | 12 +++++++++++-
>  14 files changed, 82 insertions(+), 45 deletions(-)
> 
> 
