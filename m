Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5E4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C9320767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZUVO0Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634869AbgDOG2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634860AbgDOG2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:28:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD1C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:28:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h11so875865plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4JGChkyT9yg17CJiQ62RUBn5YFLQPkb0ZVIdTMs6zXU=;
        b=OZUVO0Waz81uatwwqnokh2zu3vv3udNTjUfSm+D6GCGKAx8ZeHozJfiiOKDL5ljbBU
         E4gsLAYvh87XTk4ra4uuN5F+3/vw2zWIuU2sLmvjZf18G7GYSMPY0r/QTE7F3PHuVdnx
         2VUjGRF227jsX3adUIswGkCddS7bfys7y1VzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4JGChkyT9yg17CJiQ62RUBn5YFLQPkb0ZVIdTMs6zXU=;
        b=BquwRJ4vmRx5xmnmPBkXx1Ei8cMItIJjcijLolk7a2wHnKRJOidRa7fYnOJta1YLpX
         VBxxPD4sq2lsM6vzjP0AAosJ9zOA5QyMCx2y8Th9OfCu2AXyYke0mLgv5L+YAOyDgVgl
         ZATwylauDbiltfcUbhfJ9D+NQmbu6ym7n+PqplP/mPg481YwMh4Nx0Ul9306YJAAYGiS
         Qk8llpL0e4nsVFn54Pz21XNgtG6Ecclox56ZB1lLAWpN0ZRwFkt7M9ax7W4lhSNCgekh
         AqrHRsHBC2Bh0kJ49TmPjAhw3bgHwY6Fx6RDInhoz60qCRvYoV9B7shiORwXFcKa1+3M
         /NHQ==
X-Gm-Message-State: AGi0PuYqzLV57mvc5gz8uvT8CG6B6AELp0PmYS339mju6r7ZbEJPP3wj
        Fvl8gb4nEZgeg2F+DlmOJziKNGW1dTk=
X-Google-Smtp-Source: APiQypJ4zlwwvxPdiqsig/VgQf98Druqy5TnfF7i0/mOTf35b0M0YrHfm8EnQlOk6cFGlEd78c5QjQ==
X-Received: by 2002:a17:90a:c786:: with SMTP id gn6mr4348097pjb.147.1586932128456;
        Tue, 14 Apr 2020 23:28:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ie14sm1174952pjb.34.2020.04.14.23.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:28:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200415062033.66406-1-swboyd@chromium.org>
References: <20200415062033.66406-1-swboyd@chromium.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: Cast sizeof() to int to silence field width warning
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 14 Apr 2020 23:28:47 -0700
Message-ID: <158693212714.105027.8469414247721164540@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-14 23:20:33)
> We pass the result of sizeof() here to tell the printk format specifier
> how many bytes to print. That expects an int though and sizeof() isn't
> that type. Cast to int to silence this warning:
>=20
> drivers/soc/qcom/cmd-db.c: In function 'cmd_db_debugfs_dump':
> drivers/soc/qcom/cmd-db.c:281:30: warning: field width specifier '*' expe=
cts argument of type 'int', but argument 4 has type 'long unsigned int' [-W=
format=3D]
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Also

Fixes: d6815c5c43d4 ("soc: qcom: cmd-db: Add debugfs dumping file")

> ---
>  drivers/soc/qcom/cmd-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 6c308f92a13c..6b5c440c9dc3 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -280,7 +280,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, =
void *p)
>                 ent =3D rsc_to_entry_header(rsc);
>                 for (j =3D 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
>                         seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(ent-=
>addr),
> -                                  sizeof(ent->id), ent->id);
> +                                  (int)sizeof(ent->id), ent->id);
> =20
>                         len =3D le16_to_cpu(ent->len);
>                         if (len) {
