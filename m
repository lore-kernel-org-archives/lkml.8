Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52458C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EB92073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HMJ+lHeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCEMKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:10:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39958 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgCEMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:10:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id e26so5459298wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=KBXCSNE6peE5+CeIlF7Ibk2Tx9p083hyIskUpmp4ugo=;
        b=HMJ+lHeo2umbYbq6oXwH22EWNZT3pfIKsXfc3R1w2M7q/3FKgVcphERbRC1YmGOjc+
         FTOtTT95mKeRMFgnIO/3zuoGHzkS3IUcj5MNhI8jzkSk2zkBhLeBE05AAMH332Y/xxDT
         Rbb5T/ItFsjC9E5Pq6G4aiyTheYLk2JqOmXDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=KBXCSNE6peE5+CeIlF7Ibk2Tx9p083hyIskUpmp4ugo=;
        b=Cdd4yZNPluJSqw7kVefJaQnnMizouD0qZdVI10kpIjzikwGn3KP/YOqznCAVrHAmQe
         1/zUDICoX16vWiOcatkxh6pWLq3KyBfkkYmQTUkhrCRCLN6TKw0WgRa9ujcgl/a1zHNi
         6WEZYVfyDwjXS5X5hrUr1Dtoy4/xnO2kr4ju5A82geEmDMlfUL7Kf8E4HorCB8MScAV4
         NkOmnAJp90S4jGYKPeKL8mk8oIec6wYzgkg41xaC2Zx4r4eFxSJ9TYWsuqStkRwp8d9s
         gHXQqdfCOIeRIpv8Y8Hms1heXT0meJA5dHNncS/IsLFf+pu7Dambn3Xvy+97ekZOIcm2
         pLrA==
X-Gm-Message-State: ANhLgQ0y+bAKyFqMZAN8pxUKpci5SEAItvb4UCy1YY9Cw3R2V7Vi3UNT
        GUt5zuehKKBmFpqmgWH66/R2Jg==
X-Google-Smtp-Source: ADFU+vve3Cp34TjAaj76w49rGzR8ApG72pFtUpRPvbSnRiWaCN++WdPMrApJQ0hUIg+avKsK0gvzTQ==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr9545345wml.118.1583410227949;
        Thu, 05 Mar 2020 04:10:27 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id o27sm46387012wro.27.2020.03.05.04.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:10:27 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-4-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 03/12] bpf: tcp: move assertions into tcp_bpf_get_proto
In-reply-to: <20200304101318.5225-4-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:10:26 +0100
Message-ID: <87eeu7ypcd.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> We need to ensure that sk->sk_prot uses certain callbacks, so that
> code that directly calls e.g. tcp_sendmsg in certain corner cases
> works. To avoid spurious asserts, we must to do this only if
> sk_psock_update_proto has not yet been called. The same invariants
> apply for tcp_bpf_check_v6_needs_rebuild, so move the call as well.
>
> Doing so allows us to merge tcp_bpf_init and tcp_bpf_reinit.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
