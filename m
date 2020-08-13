Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB4BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8EC2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4FW/VJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMRav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:30:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:30:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so3145844pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=IQWrnc5WTjN5BGhjD79oWFAreGfAyr0fF03GP4y/EJc=;
        b=J4FW/VJ/5Gm/uGxIvsKY0pgjS5GJQD4+qrHZfRsVHK5wdsyB8b8HWq/eKVzJ28VJhk
         XhvfA6PAP6az3ZSC1pCga9JY/wqo314HR4RrxOw2OsGoGnDEA8Z/etubkHBtiCVImxVW
         okPPjPrUdC5Bpklt9WKuuXuMMj0/DAanBshEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=IQWrnc5WTjN5BGhjD79oWFAreGfAyr0fF03GP4y/EJc=;
        b=VyfYBeegoBFpHH1w2XLhMggSB3eylh2pOoZfc0oG0wqJGSQXgHnw2kf/Ei6xhY5YSp
         qHvOL+mtZfeg84zB1WZHcmo+NMkSVSzTUx8psUy7O02dV/RvbAYa++2u8AxbB+jrCEzR
         UMmAR4xmvoL2vF1zk4vxqp/aMJmIbI/zBfBbaPXL8rq4TsUGwJsjJsgcCv0EE/Gi005i
         epCS/fScd4nRnlWm9OT3UW/pVT8xWQ2jjA+03ufr88E8/TANWFoYoIHtq9aVF5948ZZM
         nQI3Ytsn+Qg9zNXfws1jBlT2zbgNzUrhbhMBJ+Mi2OMIM1tmEKXUj1V6nPCdr/+ZjZLh
         iPow==
X-Gm-Message-State: AOAM532zLRch7NZWhUsBqsbz4I0o10ZCOBYk1F9Y282LpXP/5/nUFU7Y
        xy1Sc9g6SeoHsaoO9YI0YiEtgg==
X-Google-Smtp-Source: ABdhPJweW89Ig89uR5/m0KMwV5c4I9rCPAnO8YqfXCB+1jfphuUuhjbDDVIu4WezzSDaq5TVBNp+Rg==
X-Received: by 2002:a63:4859:: with SMTP id x25mr4713141pgk.422.1597339846771;
        Thu, 13 Aug 2020 10:30:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g10sm5563584pjs.20.2020.08.13.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 10:30:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200813080345.1.I85bb28f9ea3fa3bf797ecaf0a5218ced4cfaa6e2@changeid>
References: <20200813080345.1.I85bb28f9ea3fa3bf797ecaf0a5218ced4cfaa6e2@changeid>
Subject: Re: [PATCH] soc: qcom: socinfo: add SC7180 entry to soc_id array
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     saiprakash.ranjan@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Thu, 13 Aug 2020 10:30:44 -0700
Message-ID: <159733984474.33733.17347167062662610672@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-08-13 08:03:52)
> Add an entry for SC7180 SoC.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
