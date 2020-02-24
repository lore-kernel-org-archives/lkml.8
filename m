Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E2C11D27
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544912051A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7gh2BQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBXHzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:55:44 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:42629 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgBXHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:55:43 -0500
Received: by mail-yw1-f50.google.com with SMTP id b81so4815752ywe.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 23:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwDglkCE3KCGCr8mSWguqia//IgT+7ZlD/tzIEgVMjE=;
        b=L7gh2BQs5BCZTVrXeYnBFwr5hScC44bLJ9/knaANW1FDQUreTHdUyhmuYYoWWlP+Ks
         kNUSegeoWwZDuFfEsGcECrGHO8qfVAWLJrRrFCK64h9jULogE374jMfvISfPUBgg7yWc
         MMUDITb019/4bMmnla9ueP+h3mSIsULgVoPmFPJubAEvR0LUUtoat5v6fDR4/1WaKwSN
         qiHBBBrjKxDd7u3I52jcrCnb6ueM++a/AdVPqe836aObvQ/edIr/s9aiv22hENHkZIKy
         rJR6Tm5yoR1fMdhjiVwNJJ8LJzdeVgXunz9V5Ez9fxsD754ZUDNWC47RnOtSLLhPMmep
         yFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwDglkCE3KCGCr8mSWguqia//IgT+7ZlD/tzIEgVMjE=;
        b=txbX7o7CURTpMwTRj/f3Q73CyXUBmr6LLfRysObiOLGr8EJBQM4nOyBzYF13yVIDrR
         2qmrOr/3ANQod99Fd5lkofTaTMDWYSjlQ8hFfi4hK684D/SA9KPna+kFP2jea6CjMx5S
         oMWkTBUcJTtT2865K7WVhituz8do5hOx/WP3h62oC5FBe+CaDU1WDA9Hry71l5hB/4HO
         ZMMBHuAZIfELa4yj4ys5cVZm13eLE3iMP47InHh9ix6CptyNtFAXgmip/HBwVwGMe+rd
         uWcXyr21zbgNIOTIn8qg7lpN8GBW6OYhCSEuJYryQoNItSiY4r9pT1uP+sjHxg7biSa5
         SXAw==
X-Gm-Message-State: APjAAAUOK3FT1JZ/u2+3B3TdZIooml5qggHzfuSppCwfdpEC9qBPFfey
        SNl3h4IiwdNKF5S8INewAvccPn+9240c96Bl8bk/Bg==
X-Google-Smtp-Source: APXvYqwlvVEzzcdlgbN/oopHn9KsTFPn9Uoo6MO2DmmJEHjo/UsaMiXV3MGkskmuRdumOU3RMhS+MxBaZ0NfwTFE03Y=
X-Received: by 2002:a81:3845:: with SMTP id f66mr44395590ywa.220.1582530941173;
 Sun, 23 Feb 2020 23:55:41 -0800 (PST)
MIME-Version: 1.0
References: <CABLYT9ixWZu2NckMg689NdCTO08=-+UOHbALYrQFHCY26Bw91Q@mail.gmail.com>
 <CADVnQyn8t7EiorqHjGQe7wqH6jQy_sgK=M=gieb7JMjWqvbBHw@mail.gmail.com>
 <b390a9ed-84a7-d6ef-0647-107259fbd787@gmail.com> <CABLYT9jCD-FPZkJwsKP4gtgGaA8=P5DVtJkzUhuX9YoA5LLdww@mail.gmail.com>
In-Reply-To: <CABLYT9jCD-FPZkJwsKP4gtgGaA8=P5DVtJkzUhuX9YoA5LLdww@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 23 Feb 2020 23:55:29 -0800
Message-ID: <CANn89i+r0r2WcKf9cGQVCQHFdmWhvVdDOFXVfdS9vkq0BPTjhg@mail.gmail.com>
Subject: Re: warning messages for net/ipv4/tcp_output.c
To:     Vieri Di Paola <vieridipaola@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Neal Cardwell <ncardwell@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:11 PM Vieri Di Paola <vieridipaola@gmail.com> wrote:
>
> On Wed, Feb 12, 2020 at 4:47 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > >> I get a lot of messages regarding net/ipv4/tcp_output.c in syslog.
>
> Hi,
>
> These warning messages were triggered by the Suricata IDS/IPS software
> when used in NFQUEUE "repeat mode".
> I've found a workaround, so I don't know if this issue needs to be addressed.
>

I would contact netfilter team ( netfilter-devel@vger.kernel.org )
since this looks like a netfilter issue.

Thanks.

> Regards,
>
> Vieri
