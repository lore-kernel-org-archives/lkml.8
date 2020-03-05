Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE50208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GIH9MsCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCEMEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:04:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCEMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:03:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id 6so1263548wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hT7S6vvpnxA0ApcPEejqGxLVzm717a4KSHt7eOw1Bck=;
        b=GIH9MsCPmG16v2K7zrrevmV3g6eLk1wIcKUD9XnRWZuoOJXK1GkdfQGkFYZ928xMmM
         Y3PnJAK/ssHCHqBUqfr96FgMu1N8MTdKO8DxCL5bgs/ODGHWiEnA4ZrWrxCmnB0Qk4kj
         5csGyslb48TLPEaGgGdrIKegAW9qV+4WV2Iu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hT7S6vvpnxA0ApcPEejqGxLVzm717a4KSHt7eOw1Bck=;
        b=hLhOVLgBypDYqaf3Av/STUE/CiAvOcGS3F53v/0bq9vOcon/5NJ9wzYZ4HJn0CmMR8
         GogIfwgzOa9vFX9coYyj7f0r8fjtcGQDSHuhzeTj4bibwv3bM4rjWDtQbr9dqUk6Gd+H
         bbOQiADJ3JltMquX7hRtSWHrUiDUlrTkdX1xNzh6U74B7ZtECqSQnn+yB38Gf+v351hY
         WZjlik3aCRvroRSGUfzFrHfv/H729lqkyr0KXurn8dyLLaupzM/+pt4XzNXKNQ0keRzf
         0fJmOSJPbx7U91mwv51/V6bYySiaGHPDh3eMgskvYKaHbtEnSFFZl6D4zLi/M5nSUKqG
         QxHw==
X-Gm-Message-State: ANhLgQ2jtSMwMhXvwUKwdQTkddb0sdah6lATG1kkrnufo8nWS8q0s2Xm
        T7I+XkwnWNfJtKMg8j1Iw1BiTQ==
X-Google-Smtp-Source: ADFU+vucLtTgYNewten9hKmRyZyvNiBAi0eWwE91eSAbKxv50uEY0RkR+AYp55iwZRNYjSqE2Bq4mg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr9660460wrv.318.1583409836025;
        Thu, 05 Mar 2020 04:03:56 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id b186sm9170588wmb.40.2020.03.05.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:03:54 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-3-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 02/12] skmsg: update saved hooks only once
In-reply-to: <20200304101318.5225-3-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:03:53 +0100
Message-ID: <87ftenypna.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Only update psock->saved_* if psock->sk_proto has not been initialized
> yet. This allows us to get rid of tcp_bpf_reinit_sk_prot.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
