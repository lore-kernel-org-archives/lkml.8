Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29877C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE014206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekta0op2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgECSEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 14:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728859AbgECSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 14:04:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60526C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 11:04:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so5869166plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=M1DEISu9MYGPZYesmfl21tqYzrqxGvDQQ/p1wwOg6xI=;
        b=ekta0op2sREg6d8RHUkBhI176t9mMJmbCpsFiWaY2hl47DUtOP+N7HirULms78rK+U
         o4vlI5EYt6kDWBtoPHm6D+3ygxh/TR3RcTKbuCnCsVvBSOm//VjOAz6+uMMPjBw15JKz
         txm33J/efjkpOocmLtRM1WCwOMkFGxR2NNY8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=M1DEISu9MYGPZYesmfl21tqYzrqxGvDQQ/p1wwOg6xI=;
        b=uTXnEw9Eqlq/yUXE23RApUPVgYCstIaGIZNJP+5pVBR9+Jqk7Atu5R1Gf6bFphZTED
         IzNYlayKUYoJ0YcIJiYv57qeqBj5z0TO+ed1BEIry+hkYN/AxLdN3QDlXaSknPr/E87U
         ByamolSUIz6hvAiTaXlvmSSf+3IG8b8rYawACBX/RkC/mQLErUz4KvtboSZ0F7bc1/vB
         /FH0XnWjWkMfTL/W2YXsl0nMUlF6INk6ZgSFY3S1/CvpD+EnJkg4u9Dhf81+9awu8iaT
         mKlPIHnqgxd2I2gp18MyFiBxRg8IPj5unzeQ1S+o36q/JvTffwLgyM3Yt+a7XEAp9TNI
         8GoQ==
X-Gm-Message-State: AGi0Puafrqnka7rMsnMEctLL3KMETonFZshh9HaUA0lvFXegxDS52rGa
        IoZRAu7Ea3O000iUXHgUB7Mwsh1kSSI=
X-Google-Smtp-Source: APiQypK5TBe+UxWnIJGFGcL3mcTwKmQTxYKm07FhCeO3z6x6ax9DhvQKX826bQQm+UZPzX5r9J38sg==
X-Received: by 2002:a17:90a:3767:: with SMTP id u94mr13084184pjb.23.1588529079415;
        Sun, 03 May 2020 11:04:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o190sm6903190pfb.178.2020.05.03.11.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 11:04:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANLsYkzkq=EuKx_=W2jv2TeWpM3P=Pd9NYS18VfG9KCey=2--g@mail.gmail.com>
References: <20200428181010.170568-1-swboyd@chromium.org> <20200428181010.170568-2-swboyd@chromium.org> <20200429180818.GA3062@xps15> <158818506575.117437.11635372928426076937@swboyd.mtv.corp.google.com> <CANLsYkzkq=EuKx_=W2jv2TeWpM3P=Pd9NYS18VfG9KCey=2--g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] coresight: Include required headers in C files
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Sun, 03 May 2020 11:04:37 -0700
Message-ID: <158852907765.11125.7786353455300506998@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mathieu Poirier (2020-04-29 12:24:42)
>=20
> >
> > So please remove slab.h from the two files (but not the other one) when
> > applying. Thanks.
>=20
> You got it.

I looked in next but coresight-cti-platform.c is missing slab.h even
though I included it in my patch. There's a bare kcalloc() call in that
file, so slab.h is required.
