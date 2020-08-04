Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452FD2065C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4UavkhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgHDOfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHDOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:34:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:34:20 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y18so25923647ilp.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Mz7Dz4HhN27ky7XInjg78tahh1Tb1kaHJSAvyuhPZI=;
        b=i4UavkhNSo6QPSaRE6hxSLJ+6F/G4lelA0CiGp6bzKeEamYkxGdo6G8aSdhcGOknSp
         uSeehMryIFLQ5/PIVFsLEqG0whteXirWnqr+iobjI5jXiKjc9NrLfvjtIzN91su38GN7
         olOEZsjcLwR/KmjJpRx50bJd22OXG7STLBGX7xSwF1qV+fhvBDs/YKKRfbimFfuryCjo
         g8v3A7eCk+EzfiiAccNp67TYeYs5OQ16gEXyTYt60Fojyz7b6VZjBBziTGGrQU8lNS1g
         /UBJjy+AeEPaxczip54KE84qJz1JHuHP/3ck1Z/mUxsMLp1tiWkDsUxAG/hWi0usSIW6
         B56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Mz7Dz4HhN27ky7XInjg78tahh1Tb1kaHJSAvyuhPZI=;
        b=ZWFSmRAsIdrmvHYO4YjWR4/BMd1zgFhhMum45clRbO+tGQPfcUmPmmpOYBypJvJlcX
         9z/N0uyC1KQqjZa0TxL5y3WrgFlilXyxnzIFQ8kHM1sf9DN+qbgu9QYn1phkX3JWlYEd
         L5eXjme7iiYXTcnsbzC3uTIdmxLRq1KJE9cVryABmhlnHOFnlylZv1Hjgazs7QpaSToZ
         i5GDVL3pv/cnVwRvNZXKgf+swKwfGUMaKi7xq+tmWOIGDGoO/+ZB+Qx/5XbNczXFMSB6
         5i9jijFqH8HkICP4b/cOL/0yy7r/R1LwGrI27TQ2rbt8A5rKug1xRU3zhPB0268r7S0e
         dP1A==
X-Gm-Message-State: AOAM531mjdUp6ApWzJjfx/W3TV3DFDjxG3hyyWVz+ZCJui6G1bx1irQZ
        h1u5g9G0SZxAdmwUsCxjF03W/ymovCyyJBVj6mkuIQ==
X-Google-Smtp-Source: ABdhPJzvAOv2+6wj7DYgW/bjoRT1xIlwrACuCpPpw1/wcu+H/Ta7pklvxHWABPSeHi1fkpXgHfcXMfo58Lf9XiTcPz0=
X-Received: by 2002:a92:d781:: with SMTP id d1mr4625475iln.68.1596551659736;
 Tue, 04 Aug 2020 07:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <1596541698-18938-1-git-send-email-linmiaohe@huawei.com>
In-Reply-To: <1596541698-18938-1-git-send-email-linmiaohe@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 4 Aug 2020 07:34:07 -0700
Message-ID: <CANn89iK_NVBWwT4QNrb3EpahG3zOQS-Dh68Qdhrm2_xAs7Yu=Q@mail.gmail.com>
Subject: Re: [PATCH] net: Fix potential out of bound write in skb_try_coalesce()
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Florian Westphal <fw@strlen.de>, martin.varghese@nokia.com,
        Willem de Bruijn <willemb@google.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Paolo Abeni <pabeni@redhat.com>, shmulik@metanetworks.com,
        kyk.segfault@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 4:46 AM linmiaohe <linmiaohe@huawei.com> wrote:
>
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> The head_frag of skb would occupy one extra skb_frag_t. Take it into
> account or out of bound write to skb frags may happen.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Please share a stack trace if this was a real bug spotted in the wild.

I do not believe this patch is correct.

if (A + B >= MAX)   is equivalent to  if (A + B + 1 > MAX)

Note how the other condition (when there is no bytes in skb header) is coded :

if (A + B > MAX) return false;

In anycase, please always provide a Fixes: tag for any bug fix.

Thanks.
