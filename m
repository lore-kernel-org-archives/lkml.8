Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DB8206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="E38DqpbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgAJUDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:03:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38786 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgAJUDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:03:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so3371222ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=1Ym1ky3QD6f3IfF+EM/zO4+gog3cH55P6RTJDsna7IQ=;
        b=E38DqpbV3vggOQto0Gi9BjS2Txq4gAHx7whMemoyjXJNP75s1nKgPat2YZRL432Tao
         qYWsDoTkFfl/v8ouvUvcpfEsKsNgoqvLwPPUpzcCUvr1wip+DAocvEVOjgTLKrFRxZHk
         SoGgYf71/qtcoy41LLSYnM/sNCy++UXCF9L6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=1Ym1ky3QD6f3IfF+EM/zO4+gog3cH55P6RTJDsna7IQ=;
        b=HCU3jL50jEtyYJHYjxwXQXx8PqQC+bMxJiMd7Y4/U7M3mu2TRMpB1+bmpfWHCQLCWR
         WKXDkrph8u+3PkAu70QKwat5bUnjjlIRvrD7HiY2OQrDT98wuvpn78TVyVBGoiGDzoJW
         87o3Pp4+ANkME33kTfnsRYQ74GVjR6RGj4VXwPwbw4iqws3N3eVSplN12lNvAI/aimLS
         +U+uj+HUO2rwXdaYHuMghZc3cUlRWv9vPicyQFcwX8XYwpxiqD8j5vOJJLscVUs8nMQP
         +wGa6rPZCZcgIrCWikDuUM+nhWJLIkX+LkDLooeFiq8QnChG2YCZagm0N0Fy0t+cCUrX
         TKzw==
X-Gm-Message-State: APjAAAVCrREWxg4hwJ8L67JkPUZqdjmXwEqRJZUNjMEtbMhQpNHP6TnE
        52lQp0ns44BHts3gCaCOmXpJkA==
X-Google-Smtp-Source: APXvYqx/ej5J4uGDUdnnFlnCCL4JCUBhgAYSWrgCWagdQjKwJQuQLD7tWziH1FplrsmwiLVLAanJcg==
X-Received: by 2002:a05:651c:30a:: with SMTP id a10mr3722167ljp.101.1578686620688;
        Fri, 10 Jan 2020 12:03:40 -0800 (PST)
Received: from localhost ([149.62.204.86])
        by smtp.gmail.com with ESMTPSA id h10sm1438834ljc.39.2020.01.10.12.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:03:40 -0800 (PST)
Date:   Fri, 10 Jan 2020 22:03:37 +0200
In-Reply-To: <20200110.112736.1849382588448237535.davem@davemloft.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com> <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com> <20200110.112736.1849382588448237535.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC net-next Patch 0/3] net: bridge: mrp: Add support for Media Redundancy Protocol(MRP)
To:     David Miller <davem@davemloft.net>
CC:     horatiu.vultur@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
        roopa@cumulusnetworks.com, jakub.kicinski@netronome.com,
        vivien.didelot@gmail.com, andrew@lunn.ch,
        jeffrey.t.kirsher@intel.com, olteanv@gmail.com,
        anirudh.venkataramanan@intel.com, dsahern@gmail.com,
        jiri@mellanox.com, UNGLinuxDriver@microchip.com
From:   nikolay@cumulusnetworks.com
Message-ID: <3CD4F75F-C462-4CF2-B31A-C2E023D3F065@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2020 21:27:36 EET, David Miller <davem@davemloft=2Enet> wrote=
:
>From: Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom>
>Date: Fri, 10 Jan 2020 16:13:36 +0200
>
>> I agree with Stephen here, IMO you have to take note of how STP has
>progressed
>> and that bringing it in the kernel was a mistake, these days mstpd
>has an active
>> community and much better support which is being extended=2E This looks
>best implemented
>> in user-space in my opinion with minimal kernel changes to support
>it=2E You could simply
>> open a packet socket with a filter and work through that, you don't
>need new netlink
>> sockets=2E I'm not familiar with the protocol so can't really be the
>judge of that, if
>> you present a good argument for needing a new netlink socket for
>these packets - then
>> sure, ok=2E
>
>With a userland implementation, what approach do you suggest for
>DSA/switchdev offload
>of this stuff?

Good question, there was no mention of that initially, or I missed it at l=
east=2E=20
There aren't many details about what/how will be offloaded right now=2E
We need more information about what will be offloaded and how it will fit=
=2E=20



l
