Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E46C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE92077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SLk1pebG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgCYReu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:34:50 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41287 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:34:49 -0400
Received: by mail-qv1-f66.google.com with SMTP id o7so1486855qvq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Yi5HT0gIMU1vXoOcsaUkgeprWNpD7T8tR8cpKS9kJTk=;
        b=SLk1pebGcLYeZ4z/jd6Fqh1mraqZbisWYOTgqwiA5nLWQUaeYs7xUhpQRw+6W11/Hu
         MrORLS95iFFGSRc/yEb/ns1zlod6UnpB5l4z0azg2eiIpg3WKa/yDjVuLsPWkWpGeg52
         tOlgKuoSPSayanlhLPewETKDhOLWvDFYt53WzVCNcwwMRtns6kZVip3OIAGlrBIBnfCt
         2tM82vWYGCpWCv6X5zk8lZgG8TTGMVLjMDGZG8DuyFWnyz9Ot/3WgromPZxnGJ0YT/eL
         BCX0epCrTOGn6RJFODaZQwBmD3tkMuWwOFnQwaxpJbqHb3RdwGYtwDT0DsX/MMgAUvVp
         gJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Yi5HT0gIMU1vXoOcsaUkgeprWNpD7T8tR8cpKS9kJTk=;
        b=ktTdoEv0txm3FOm6uSArkrAXBtGjP5AZxfpZvc6PsADQkP3NSmCzWb7Qb1+9EqDh8G
         v+E4W2VFNSflNC6JrGgdkT7zlBVTMtHhjqE67URyqWdgqBqruGnhH5TKgw7UTiJ+cO6b
         U5W/E2UptQpszoQo4G8VcRQui3XBgj/D3nWsys3/Kq/KTrftafyGrQnD25gHaqivgT1q
         2/FfrKrQsL1CatT8vvAcUrbUcwjE7fbdZLfdtvY5OCrkFR6V0z7absABp+0OM6ApjmbQ
         jb/YFeFZ67GatB8+dH717x1Ixq/DMINz2L1HP6RiNOpmDbt9WbBj2fc1fLBZROSo4H1k
         mDlg==
X-Gm-Message-State: ANhLgQ0Ky50qY/OvYyWOXnPTQ9KdxLFjh1JMppO5POP1Ua43eotg0hp9
        BI165UCpu2Fm7qIowSfXLXlYBA==
X-Google-Smtp-Source: ADFU+vvSTm3iJZG8SeK5DwIXubRWFkjx6qZHORcGN9/Uw+XHKMovA4wLWTp/xZfcBXIPrNG0XpH9HA==
X-Received: by 2002:a05:6214:aa2:: with SMTP id ew2mr4279653qvb.123.1585157687498;
        Wed, 25 Mar 2020 10:34:47 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u25sm11933305qkj.71.2020.03.25.10.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 10:34:46 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ipv4: fix a RCU-list lock in fib_triestat_seq_show
Date:   Wed, 25 Mar 2020 13:34:46 -0400
Message-Id: <92C7474D-4592-44BF-B0ED-26253196511E@lca.pw>
References: <5e2ed86a-23bc-d3e5-05ad-4e7ed147539c@gmail.com>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5e2ed86a-23bc-d3e5-05ad-4e7ed147539c@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2020, at 12:13 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:=

>=20
> I would prefer :
>=20
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index ff0c24371e3309b3068980f46d1ed743337d2a3e..4b98ffb27136d3b43f179d6b1b=
42fe84586acc06 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -2581,6 +2581,7 @@ static int fib_triestat_seq_show(struct seq_file *se=
q, void *v)
>                struct hlist_head *head =3D &net->ipv4.fib_table_hash[h];
>                struct fib_table *tb;
>=20
> +               rcu_read_lock();
>                hlist_for_each_entry_rcu(tb, head, tb_hlist) {
>                        struct trie *t =3D (struct trie *) tb->tb_data;
>                        struct trie_stat stat;
> @@ -2596,6 +2597,7 @@ static int fib_triestat_seq_show(struct seq_file *se=
q, void *v)
>                        trie_show_usage(seq, t->stats);
> #endif
>                }
> +               rcu_read_unlock();
>        }
>=20
>        return 0;

I have no strong opinion either way. My initial thought was to save 255 extr=
a lock/unlock with a single lock/unlock, but I am not sure how time-consumin=
g for each iteration of the outer loop could be. If it could take a bit too l=
ong, it does make a lot of sense to reduce the critical section.=
