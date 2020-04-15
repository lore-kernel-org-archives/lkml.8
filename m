Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E82C206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahiCzMjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634879AbgDOGaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634860AbgDOGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:30:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0950C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:30:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so892234plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yGGn5XTCbWcKi7Iz4ZvzEMH9gkvTDAhtX+3N8PO+tS4=;
        b=ahiCzMjp6V+NwmmzlcNCIGWifnAuzqI1W8lasAUN1ibrkqsrPfuzK6zus4oCOUQnrr
         xLNWIlCaFETTQsgYPvPjKRA6JgQSf2Bn7dwoVnjTCx0Ly4lDyGBdNJAuvKCoWxSAO3fG
         o+9ej/Q9A6H7a8RQ4DNEDAzuKE7MH6smLnMes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yGGn5XTCbWcKi7Iz4ZvzEMH9gkvTDAhtX+3N8PO+tS4=;
        b=ZNu8l3kXh2ODjEUhK9YxserOVJWtRdWg0vCzSY/C16LOiBVoHEqPoVHlqq6nqdiKjk
         LvkFu/fhiylMmbDun7ycgg71lJWVOfTJ1JxnwO14KpHC7OJrDup8hbOmqhSHT0rE354V
         3rqvI2tVA7RiJ4viTs8MhqIDkjcUqmOaafJw9hCS3FhB1/4IYhCNA4CrBe8Qk7YYRuFj
         KOgfn/Y9Lkjm+K7Kud0zfH9C0ufgtFz/2LQYI/zZydnSnGKm4C4m1edxD0fH+QCl/trw
         j2cCjDpsXFqYdDYtXGOGQ7UuML1Gu4kO4XeOQHWRbDYExUj1KBfVREzHBAPzWoF+UWf3
         2rCg==
X-Gm-Message-State: AGi0PuZZDlUFuEkgald8H7aMng6xKltxJMM/+Xv9LvRWq4yA2OXxWQiL
        w3+nODhJPwTfAEJo0wn/rcEhjQ==
X-Google-Smtp-Source: APiQypLoYzi6cQvDYS4SLRHjsOsSYtQ8yGvzT7IocHvn1SRrjJ4FP11zSvpaFPCHG0OzveLcKbK6UQ==
X-Received: by 2002:a17:902:c211:: with SMTP id 17mr3617261pll.152.1586932231411;
        Tue, 14 Apr 2020 23:30:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h6sm10871129pje.37.2020.04.14.23.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:30:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200414215015.GA3820@codeaurora.org>
References: <20200309185704.2491-1-swboyd@chromium.org> <20200414215015.GA3820@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: Add debugfs dumping file
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>
Date:   Tue, 14 Apr 2020 23:30:29 -0700
Message-ID: <158693222998.105027.13298557609451842017@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2020-04-14 14:50:15)
> On Mon, Mar 09 2020 at 12:57 -0600, Stephen Boyd wrote:
> >+              seq_puts(seq, "-------------------------\n");
> >+
> >+              ent =3D rsc_to_entry_header(rsc);
> >+              for (j =3D 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
> >+                      seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(ent-=
>addr),
> 0x%05x is what we would have for a resource address.

Sorry I totally missed this because the mail wasn't trimmed at all and
it was really hard to find the one line that wasn't quoted!

5 vs. 8 sounds OK to me. Send a patch? Or I can do it if you prefer.
