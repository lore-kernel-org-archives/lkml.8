Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41980C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0885E20658
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c3MZrStM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCEMOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:14:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCEMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:14:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so6023901wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=DtylarLseGTRSTj79YH0pOEE1qvMQn3Ic9k76fdU8z0=;
        b=c3MZrStMy9rXY4LcGnY4z7bThtnCWXwAvEzSdAtXuQb74sFKFp07aFVF8/7ZVrZMM3
         oeGGRd0VZPtEk+yT14fYnnAbe5yEaZqYTVxLhbVWr919FlVWhdQDfHSc7b3o23PQSTiG
         2y+Hd2ru1+0B95UcUfaOEE67OHsMaReKJzR5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DtylarLseGTRSTj79YH0pOEE1qvMQn3Ic9k76fdU8z0=;
        b=mGbYrPgSIMbuVsH71dRBX4yL6++QbBN4WbVu/H/thNLrNGv+rtst1EFOhakqeul8Ad
         CM81MApxB/e3DTSIoiLxCHBZoBfjggAMOhv+EmwEUyEb+pEkI2RNf/+aJtmL+V2Ah8xC
         6OKxnRvyHND2nWQRVPeiViDqmRDfBT1I+KeMnlHOttqlxnPzMzdR1VrEU6LIT58mvWvI
         ghNEupoqV4kzqlkuEpaa6p5G53QpN1Ep9myraT1DbKAYK/VJXCVCnHRyM/pKesRBYWb4
         8CeC1+LZadCFES0ix+DAYCfah1VYSpW76HKsHk9S0r2BchJlLrrcdgssstFnQLIbC5mC
         hJWA==
X-Gm-Message-State: ANhLgQ29OJHZy9p0cLyglotUqAbcmhGv37uiHwbCG+qOU6hUM/I4c1sq
        apQY03YLLG2lKT+4zUU62ZIPgQ==
X-Google-Smtp-Source: ADFU+vvURwIYVL0oQSbipNi4dg8FfZ04v87aaIMVM8dfsGJKU87OR9g3D9Lj8aQBU1gbPm92C1Ythg==
X-Received: by 2002:a05:600c:290e:: with SMTP id i14mr8981129wmd.24.1583410456431;
        Thu, 05 Mar 2020 04:14:16 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id p17sm41438418wre.89.2020.03.05.04.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:14:15 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-5-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/12] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
In-reply-to: <20200304101318.5225-5-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:14:14 +0100
Message-ID: <87d09ryp61.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
> selected. The declaration should therefore be guarded as such.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
