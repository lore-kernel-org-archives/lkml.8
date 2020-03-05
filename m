Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32B7208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f6PmxY+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCEMyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:54:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35786 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEMyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:54:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so5629411wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UithumxeWzYgScx9rLpMyD2GJqEdo81auVSNbfn9oiY=;
        b=f6PmxY+OolwFWG6Qlwyz2Vw3Fx3A+kmQsoP2kyPGcXtEWvliRhBV5iONwsB4PRtoHu
         HvtCtJiLV+XvTInlE90TtwWIowBizogvXcRXTobxU9eLqYTvBiNAsfyp4qIXeCRp7xR0
         LGoYy8e9/mmZW1JFe/3FVRueKfq8NbiHwb5Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UithumxeWzYgScx9rLpMyD2GJqEdo81auVSNbfn9oiY=;
        b=JNDl0zH/70dFXTMM+V48UXj+wBOgekjsv+DqMhgtBjiHT6sLhKy3tjg4af4KO1LiAj
         Yiz7KZtZyCHoARje6MqPZNFjM7oxmrLi3D7X8wAMi/OBu7TJWuOpY76kv7F6sWkaoCwC
         98hYZgK6b8OvbrUDU8oEokiU74V5Vz02kEeGOZQ8nTwHd+mAvAd150ypJ7lowdGhOB5o
         8tthSP0yDpLumHPKkSxZfk+p7ZBIrDGeOZJlKKvCqlqsofc634ZThoD2GmmIFUfznRZK
         b4knm2IZeIi70147FQHGFHulZGVSALE2U/SIXABHMEwKdwYKqs0p+6WGJjih/eEzC5h0
         2T3Q==
X-Gm-Message-State: ANhLgQ1mjw6K6L9Tw4dReRsKPAGHJOR40SRswdy9CjsBwEY/lB1ZvSFK
        1pdFvFwu/kkpJxGjp09el4eP6A==
X-Google-Smtp-Source: ADFU+vtVxwix/QuB6JjhX0awb1vybd4BvpFB+lIY68z69hOr/TCDPZBDyFJM31X5dKcZBJjdP0iwtw==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr9227427wmc.71.1583412841132;
        Thu, 05 Mar 2020 04:54:01 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id i18sm41145017wrv.30.2020.03.05.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:54:00 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-10-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 09/12] selftests: bpf: don't listen() on UDP sockets
In-reply-to: <20200304101318.5225-10-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:53:59 +0100
Message-ID: <878skfynbs.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Most tests for TCP sockmap can be adapted to UDP sockmap if the
> listen call is skipped. Rename listen_loopback, etc. to socket_loopback
> and skip listen() for SOCK_DGRAM.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

FWIW, Go has net.ListenUDP so I don't think it would be very confusing
to leave the helper name as is.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
