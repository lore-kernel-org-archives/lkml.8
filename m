Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74057C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FEA2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T3wLGGd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEMcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:32:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCEMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:32:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so6105689wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=XvqoB3YpTGvwS70Yx+o81kC3OP5qwjPAewaCKlcb6hw=;
        b=T3wLGGd4TFmeHvgA1nuM53qFrkJDFyrA1MdY080q3OYGZwSp7Epdjm3D5fCR+9sPzD
         HhKNAmSmWIPWUNohY4rbT/AA4u0fbwHRWxKxdmyiyrqUG5YrupzM39MM6xn/YBtRLH5M
         ZwdLlQoMOkVNKw5IAWUk9hRmklUu9PR2XatJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=XvqoB3YpTGvwS70Yx+o81kC3OP5qwjPAewaCKlcb6hw=;
        b=clxnK4rdsAvu2b8AaE96bfS6hLHyGcDuFQzHdCcFRV0gnNb3yXX8zF5CAYAV+BpP7c
         oGIMek1nNxS7L57rDmJS8QKK3qEcozy/BS8wctU2foT/gJdvGrwFQQFTb4WgqBOjXff4
         HsX7jOkRLQkm70VaZus/f2Luzc9ZPyEbnhM82feoiwIAbA/B+/EIxeOu/UDu9riFmrAD
         oprX6u8J0YQnIHo9wXX7zh5zQrzqW5d0gn/l1h3fFsUAXO1iNjJfWjZGkMrvVJuYbKVf
         QvD4nSP8ypfLBy8RCXrGLMpRJSrTpqBAAvvM1+NFohMOzZidUxrES7HkfOu5jh5Lf6uR
         Y8Jw==
X-Gm-Message-State: ANhLgQ0hdrVXwCl/khhl9srBC3JUbdzZLLHzD+0XtOnoanEmivDCtua+
        slr/Zb5ofPa8MEMa2qwLu6Elag==
X-Google-Smtp-Source: ADFU+vs0s6JDpJz9Ahed3MeuIOLTRos26RvIX28l24f5TQaaBz1cvByfsJgGNQ/pkbU0F2hDoISdNg==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr9174507wmd.76.1583411525674;
        Thu, 05 Mar 2020 04:32:05 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id b186sm9273626wmb.40.2020.03.05.04.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:32:05 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-6-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 05/12] bpf: sockmap: move generic sockmap hooks from BPF TCP
In-reply-to: <20200304101318.5225-6-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:32:04 +0100
Message-ID: <87blpbyocb.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> The init, close and unhash handlers from TCP sockmap are generic,
> and can be reused by UDP sockmap. Move the helpers into the sockmap code
> base and expose them. This requires tcp_bpf_get_proto and tcp_bpf_clone to
> be conditional on BPF_STREAM_PARSER.
>
> The moved functions are unmodified, except that sk_psock_unlink is
> renamed to sock_map_unlink to better match its behaviour.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

To spell out the tcp_bpf_get_proto() and tcp_bpf_clone() dependency on
CONFIG_BPF_STREAM_PARSER - both of these functions access tcp_bpf_prots,
which now hold pointers to sock_map_{unhash,close}. And
sock_map_{unhash,close} get built when CONFIG_BPF_STREAM_PARSER is
enabled.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
