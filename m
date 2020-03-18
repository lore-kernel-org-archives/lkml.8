Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19785C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB3C20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EUoZTb0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCRRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:24:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43628 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCRRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:24:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8so11462941plt.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=FjWwh8LO5KXjOVLWH8k5j8wZ6Ak2lErqrO6W1eN8/UY=;
        b=EUoZTb0MRZa6UglrqgLn1tMNjQlLSMxH8zEFEAuFDVSCVlz0pkAuCnOsOLlat/f4s7
         5Mx9ni1VXdejqYP/1jX0bqN5fxdlijMQI06zwNeuIfpx4PkDVWEL/3DLGJ3X+qGUQEHc
         fYnZot3k5fWZ5tPg9rsalw+uUxKaO4pWjwCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=FjWwh8LO5KXjOVLWH8k5j8wZ6Ak2lErqrO6W1eN8/UY=;
        b=Ihcnd3F53ceF6PKzlP9/Vyr7TzIU3tWBNMrkI6+i3rO6CfU/WQddlaQrSjEso+iDZd
         UEej9T7M8dxP9JWtLcR0FyeK9bkQASInheOTYBi8tBslzgtuuI+rsajqp9xs9H1W/fFQ
         Kq5mVgfKUd9FUtzacqmT0klZkpyjvEzKAAybChjDWuLCkkFVBJ3umv6OpBt6ldj/q6rm
         gBREHZWQIP2qaVkdbHpKK7nPjXyGsOSd/eyTn3op8D2FKai+kOWKophkPEoqaMKftic8
         K1UHu75tXMO3faZjrmIsI79EdsuAkaZRMuNcsyu8E8rH2eh6hoQ1FBYxF4x0/xam+Rgr
         T4vw==
X-Gm-Message-State: ANhLgQ01sMKTz+vELFIq98d2heGIU2bzaJQoEVnRCQSd5zj3s2+oTrhr
        Tttmaz3048PPpo6vYRmGJOIAfg==
X-Google-Smtp-Source: ADFU+vu3fODPJ39ECRURXTPSbPdrHu6AK7pdBYqoOgXlEtTlfqbqUn60Ytai6Fr1MV4kDF25BLERSQ==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr4435900plp.251.1584552262019;
        Wed, 18 Mar 2020 10:24:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x70sm6619101pgd.37.2020.03.18.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:24:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cd0f3d35ca0fc2944fd97e030a28318ff82dd5c1.1584516925.git.amit.kucheria@linaro.org>
References: <cd0f3d35ca0fc2944fd97e030a28318ff82dd5c1.1584516925.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: cpus: Add kryo468 compatible
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibis@codeaurora.org
Date:   Wed, 18 Mar 2020 10:24:20 -0700
Message-ID: <158455226052.152100.7707912714966412244@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-03-18 02:08:16)
> Kryo468 is found in sc7180, so add it to the list of cpu compatibles
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
