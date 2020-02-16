Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D90C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 10:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0760E2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 10:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzXIMCAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBPKeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 05:34:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726020AbgBPKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 05:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581849240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AyZPiWK74GL/snEzHEB39Hj1J71bF2CTXG08laECY4o=;
        b=MzXIMCAnMzfnQxGkyJGISLw2w/BP/xcLR2PEybUSGP4f5fBrr8VhEMaIYKCY8NgvU3FPXd
        0tQkpWYKuJrklRroByX5nqCkRGzXYonDrZthh528/v6FVvCk8mq2IVgAJcDww8xkld8b5o
        DH8/WbnFVqKfayRY1GCJWV5jLDARq7o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-fxZy2fR_NzOBxa1KYwWkgg-1; Sun, 16 Feb 2020 05:33:59 -0500
X-MC-Unique: fxZy2fR_NzOBxa1KYwWkgg-1
Received: by mail-lf1-f71.google.com with SMTP id a11so1425357lff.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 02:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AyZPiWK74GL/snEzHEB39Hj1J71bF2CTXG08laECY4o=;
        b=NKyEStUuSFYkDIM4kIu1XlU94VhhSbGh6aBRKtFLUnsF7VrKsWEgf3rYvOu11NW07B
         D8YBrCSiKzarbG+tIFgsTBMnswgRgOWKznmNIbVHWe4Q5YAhgw5YEujUYDozFFy5FU8+
         JVnQIYe3HLmVwPDNbwj4y4t3xaDQ68zqsdP+HIPAcT0LA+zsUYF6curw08PbrMTg/3Qn
         vNoOfDSYTFZFDSqpoBaFrvcj7YouF1Pr4oZPI/ahnwn0+eSn9E7qLQohCBj6YAUODdkJ
         sCkFNKAwClPa7llGrix/Cuek5EXmliTc+R/VpxLj+mcCihGO6vUR0KHjwGW8MLIH0F3Z
         n5LQ==
X-Gm-Message-State: APjAAAWe5WxMnwsVw3x67kN6cHU6QvbVyqMzjvMbFxEANQJOY0T2xEyA
        hVr4hajhXyyrRwdiNllsoV1R4b+VGUM43hlK/Ua03bVtnWZ16uM+niVcewTn8QsEUPYlrT0Yx/P
        9KlSNv+BkjZgOsZYTZNszpUyR
X-Received: by 2002:ac2:5979:: with SMTP id h25mr5823545lfp.203.1581849237863;
        Sun, 16 Feb 2020 02:33:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5CGpNlEjzA8D5rxS5gBw73IyHetdr4xNVSJIqqTnMYikH1e1wBtykq/V+h6jiwZNsqfmBaA==
X-Received: by 2002:ac2:5979:: with SMTP id h25mr5823536lfp.203.1581849237634;
        Sun, 16 Feb 2020 02:33:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a12sm6454240ljk.48.2020.02.16.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 02:33:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DED0E180371; Sun, 16 Feb 2020 11:33:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org
Cc:     jonathan.lemon@gmail.com, lorenzo@kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: page_pool: API cleanup and comments
In-Reply-To: <20200216094056.8078-1-ilias.apalodimas@linaro.org>
References: <20200216094056.8078-1-ilias.apalodimas@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 16 Feb 2020 11:33:55 +0100
Message-ID: <87k14mbz3g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

> Functions starting with __ usually indicate those which are exported,
> but should not be called directly. Update some of those declared in the
> API and make it more readable.
>
> page_pool_unmap_page() and page_pool_release_page() were doing
> exactly the same thing. Keep the page_pool_release_page() variant
> and export it in order to show up on perf logs.
> Finally rename __page_pool_put_page() to page_pool_put_page() since we
> can now directly call it from drivers and rename the existing
> page_pool_put_page() to page_pool_put_full_page() since they do the same
> thing but the latter is trying to sync the full DMA area.
>
> Also update netsec, mvneta and stmmac drivers which use those functions.
>
> Suggested-by: Jonathan Lemon <jonathan.lemon@gmail.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks for the house cleaning :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

