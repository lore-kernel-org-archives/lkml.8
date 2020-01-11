Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D32C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE652082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwKbw/ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgAKA2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:28:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32845 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgAKA2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:28:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so3741256otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJNkeTlQeivzybUuWcx9iwSzhzlDjNiYUt081VfoN4c=;
        b=TwKbw/maTje9O+6K+AaSChQ3qI7lnU05ARSs0EJm+ULMqILrCJLwsvhBP7NhMsDYVW
         Sy+DSLyCZwJr/9LoAfM/h+x6S+FrcD/7ASrj5IVeb8j6lE0mlxL2Hj8ajX9gV9mm5ZC8
         H9dB/o9QJQlpmb8VeCy1owDzjedi0JBlbAag2P6wvvmbzTC+zWK618sI9T0Ip6obAU61
         fqPrK3D+C3bQowSmWKnZyGThkNiBpLN3Z9vkbSEhZ/7mG6FKhJOaNmH3cJ8Masbu962F
         AmtS6Ns7Tn2J87fZDOcddZkZzcdTBA5E28OjaKb7qkCFG76BKUnNZSvm22nTKpEsAout
         y/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJNkeTlQeivzybUuWcx9iwSzhzlDjNiYUt081VfoN4c=;
        b=tuL8CcBm1TeF/F4hMG4XFDp1eHyxaJno7WGCsFOKfgUx3CwFD3BWCe6/qvX9Om3qPO
         iboUXP/0U1tm25oSaQ8awOT578J7zK8YRnUWWat9GitD1C7q6z6K/ktPu3fTqI2NO1+J
         tF/EWARu8YpDzah7QOOeN244H8L8gNDQKDz8gS2erlrtGcya2gryHoU1OmVcB/NYzDTx
         NcFNWbf62Qo/X3Qnd3CXvHhwd4IusTyuwTIvGpL9Rd5Hr3zFDmq0y+Xr2K1ApdLC4nkk
         6vzO/ip5eHQ9yUmV1qziVe9+/fO1673j1M4depaKt/M6j0wKtVIaUF9TonzKBWDUkJmR
         j+pw==
X-Gm-Message-State: APjAAAXm6bEsfg8C4YvEuIEl/U0embRI3TJhRkqlbGPoGI+spHCsaqUz
        2vQoVck9TDog76HjBH2jgM5aBn5JqTEIuT3+kXs/HA==
X-Google-Smtp-Source: APXvYqzix9yfkezMicGVnwOPqgQD9fq0U9kpLygPZIeiqIZ0LYEG/OhqYmMoZ1F9dWJUX+jVXmOmR4gPatuKT+srtok=
X-Received: by 2002:a9d:7c8a:: with SMTP id q10mr4622088otn.124.1578702513230;
 Fri, 10 Jan 2020 16:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20200109202659.752357-1-guro@fb.com> <20200109202659.752357-6-guro@fb.com>
In-Reply-To: <20200109202659.752357-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jan 2020 16:28:22 -0800
Message-ID: <CALvZod7DGkXkzUosRqCDrEVKpfA89sxrURBqYpWk5Eqeskb_9w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: memcg/slab: cache page number in memcg_(un)charge_slab()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> There are many places in memcg_charge_slab() and memcg_uncharge_slab()
> which are calculating the number of pages to charge, css references to
> grab etc depending on the order of the slab page.
>
> Let's simplify the code by calculating it once and caching in the
> local variable.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
