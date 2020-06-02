Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252E620678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="L5EPPNuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFBJzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:55:38 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C6DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 02:55:38 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k18so10220596ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+2qftdfGzvqFPSmH85T6+Wlrzo4v4AkH7We72qGJ2eU=;
        b=L5EPPNuHxm+R/ngrL7D/bDzm3jmI1xC3ugAs/xTro4ziY/ln+VksSDvLj07BXsJlPJ
         QEPbyHM3n/O7ty52fObri7ykLRUuozKTCN2tl3yO4uZXR/S3OS16z+oO87Ys3UhtbHJv
         q8X53AR1So3Vcqr+asssBUYXNUWKyMj3vQlW/dK8FVb2LCqkWPeQrz4wO7Ud0OZAM7c/
         JZm8lcJyKmuc0ju4+p6+XUM6xvs6Vz2GtkJ7LBtrx1O7OHxXvDSR5fHTLswMM1bfOur8
         a6zCCwTJ5yfY6h6E687BMFRK8iXGpQwVU7m3D+Bc1LG77pfGtHCIr0Z0MCctvPbLng4z
         jr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+2qftdfGzvqFPSmH85T6+Wlrzo4v4AkH7We72qGJ2eU=;
        b=I8UI81kbOwInmQ11A4EVFUommx9AqFITYe3taPy9cdl9YTWg3j5WEjznLJRYEzO03j
         T4CtxmfUf0Qh1ERq8bqeBhMtXWdRdRLCqI00HuaB9hRPAo9aZ9LNNpEFpUFSddjExGAe
         ZJIzlgXk4SMG7MATwdALPKO62qYdBn7QIjQgKdi+QV0+xdjIQMY7yUuVHvhsZQHM0SQv
         lUoyakIo39ov+OhMGZYNoemsvOAllupBjTwqfpil+fq8Bkh6zWZaahaCvEMsgCkI+VpI
         nSLV1rV3C3x8xxbBdYmlKD090uoklg2PMYa3GVBVLG+PGVsEYVNk/UFvpINJW3EUU0TL
         70ng==
X-Gm-Message-State: AOAM531vqOy5aDMECa7+thCrecUq0VtlENKZwMWIUj1QgyRObCW76C+6
        4FMf8iGZ5qbCw4S589VJ66J/94PwqaDrxIAcAPkzMw==
X-Google-Smtp-Source: ABdhPJz/sNHTbROYRhioqzwB9NACNHROQYmM/8M/yaBo1Mh6x/rcwCj0ypBt17Yn74Em1cI0O5ED8T3Tr3MtqWgPB44=
X-Received: by 2002:a05:6638:209:: with SMTP id e9mr25205965jaq.48.1591091737258;
 Tue, 02 Jun 2020 02:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200525154633.GB22403@atlantis> <20200530123912.GA7476@arkam>
In-Reply-To: <20200530123912.GA7476@arkam>
From:   Christophe Gouault <christophe.gouault@6wind.com>
Date:   Tue, 2 Jun 2020 11:55:26 +0200
Message-ID: <CADdy8HodW1HLvO-36T0uiXji11km83ZDhYgEAavD9EVz+wCq8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xfrm: introduce oseq-may-wrap flag
To:     =?UTF-8?Q?Petr_Van=C4=9Bk?= <pv@excello.cz>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 30 mai 2020 =C3=A0 14:39, Petr Van=C4=9Bk <pv@excello.cz> a =C3=A9c=
rit :
>
> RFC 4303 in section 3.3.3 suggests to disable anti-replay for manually
> distributed ICVs in which case the sender does not need to monitor or
> reset the counter. However, the sender still increments the counter and
> when it reaches the maximum value, the counter rolls over back to zero.
>
> This patch introduces new extra_flag XFRM_SA_XFLAG_OSEQ_MAY_WRAP which
> allows sequence number to cycle in outbound packets if set. This flag is
> used only in legacy and bmp code, because esn should not be negotiated
> if anti-replay is disabled (see note in 3.3.3 section).
> (...)

Hi Petr,

Thank you for taking my comment into account.
This new patch looks good to me.

Acked-by: Christophe Gouault <christophe.gouault@6wind.com>

Regards,
Christophe
