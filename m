Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F53C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB6C20720
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pDQjF+l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBCUTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:19:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44285 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgBCUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:19:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so15525781qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=L+boqKbKcGQHWhU/kLnxNJ+iqCrMGC4AneBP/4KWpSY=;
        b=pDQjF+l7/yF9Qv9JBfBZGEywuFBC1ZID02VaidULXZr6lWYTmOcAIBckQwqKEnT153
         ud2Y3JuxGOGx1g6gPPpZzuymTWilHIF+kupZmvq4/OlzUMsnRDH+/+sMKAJxgXw9mjPQ
         8nDWxSxVAVNBPQC9eJJ39BILLDQ9FwGXOKUUP/jUKsIQ+1s4y1rHv+nfDfh3RgXZ3tc0
         Kt53QXbmh+dTzftme1dqa+HyQ6h6QufgkhZhJqNFVDVKLdqHZNA7iV1lpa29FfQMTUGa
         vrypjuyCMSRp0kzkLKddqeT4sStflPC0VODiVUYG594L0dZCxkSXpBoOj4MXKco3y398
         Evzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=L+boqKbKcGQHWhU/kLnxNJ+iqCrMGC4AneBP/4KWpSY=;
        b=GUh0c41hcGeDaWwYJBazA0o3tFy64aZj5iwUtbKq80oZk4VlW63xozQIb8aCvGT/Q7
         GuK32tH9XZspGu/ZGKeQp1ulxyLnjlnmlqMpdfKbZzlLMEFSK0JZEdaVqfwk/WWwYmq+
         ncHYNOZMePUr2MiLju2Gxfe3Rc6UNHTp5/Avd4hLEmyrtHCJmkgyIt4+GzZkxFXq+CgB
         2xpWkHtoyXn89crJoQRzFOjSxefGYIJYu8wFC8H1doRtSEL16CQUum1nJcq3IyKc7xGl
         18k29IdwE+/LrT3sF9JpsPGhRJdCta/5wOS7mD2rWmD9qkWTz0xBHDXNiylhVfabTEsW
         hHag==
X-Gm-Message-State: APjAAAUARlo4ykKMWXo8/GR5jsY8soIAtvJ7d7rpY8prHA4sBJAw3DWl
        en2MtzF2U5SkICu4SMLJIisRmg==
X-Google-Smtp-Source: APXvYqwB3ZakEmQZz7++1OVnTHvJFGDXuohnR4zbkdM+Ni2iSGAvk7FpO3UASgkuy4CYZsYeNxMAlw==
X-Received: by 2002:a05:620a:6b6:: with SMTP id i22mr24157881qkh.301.1580761157010;
        Mon, 03 Feb 2020 12:19:17 -0800 (PST)
Received: from ?IPv6:2600:1000:b048:97ac:a93a:b890:262:8b7b? ([2600:1000:b048:97ac:a93a:b890:262:8b7b])
        by smtp.gmail.com with ESMTPSA id 199sm10041756qkj.47.2020.02.03.12.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 12:19:15 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] skbuff: fix a data race in skb_queue_len()
Date:   Mon, 3 Feb 2020 15:19:13 -0500
Message-Id: <D743FB35-3736-45E9-9DE1-8E81929D67C1@lca.pw>
References: <648d6673-bbd8-6634-0174-f9b77194ecfd@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, elver@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <648d6673-bbd8-6634-0174-f9b77194ecfd@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 3, 2020, at 2:42 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>=20
> We do not want to add READ_ONCE() for all uses of skb_queue_len()
>=20
> This could hide some real bugs, and could generate slightly less
> efficient code in the cases we have the lock held.

Good point. I should have thought about that. How about introducing 2 new he=
lpers.

skb_queue_len_once()
unix_recvq_full_once()

which will have a READ_ONCE() there, and then unix_dgram_sendmsg() could use=
 that instead?=
