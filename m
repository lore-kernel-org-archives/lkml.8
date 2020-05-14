Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7873C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D8D206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9LrfOjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgENCDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgENCDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:03:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE0C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:03:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f15so570178plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+Hy6KD9Nm/Qwl13ykTv+/eNrz6cvZq6NKKJKymwmJU0=;
        b=V9LrfOjlTeekn/bLRW4LWH6a9yCcqFigmv2EMGXqmrH58Xy7+l3jx1JvBJqrkAWg0E
         NAylfXmzwU9Beq3qXEvjLvQasP+9pBMzMQ5ONlY/fOREfUOo3MaCZoENlQDe1F5snUN4
         DqDqq3XyObV+DVObDb4dzY5LKba6GnL/J6gyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+Hy6KD9Nm/Qwl13ykTv+/eNrz6cvZq6NKKJKymwmJU0=;
        b=ExV7dNFBZmy1bWgJIZxuwmSNESgZvKmreJfDmmiZ9HvvILvajO/jgTtVmBBMcmTBMo
         8Fa/Z8hKDi7OMuW2yV3eAdT+X+7dwSnM6MPv/N9Yt1vb1at/WDHAtBb/8Gg2dBGoZyKl
         AwJNPO9he9TYrBEH3ZLHcJIJc2CCDfO+m3uMrmkWYb0a9uNLE7chkb0zVZRvW2jJSG97
         NI7ymmTQKCQVAaAZ7sHGbh+CWpwwry2HMC9I7+OSoBuxfMvIDRBiQIvC06EblFKG5Cv8
         wDYJnHvlB4STuIu4hwXL1wIR4o9eYG8WmdLdI5iGgECzMydpPFskWVywBMzX9pMp+zop
         AIhA==
X-Gm-Message-State: AOAM5303s68boLFta7LKLcTQsLn3olzB8poGjGPtD4JlFgzeuk1vdsMD
        39hNi8PHKrvFgvDuOLcVZvHQAQ==
X-Google-Smtp-Source: ABdhPJyDZxeGFxcpqljfUPCzcdVkPYpzexD1KXBEYWxGrAW0le/qPFxdtT/oXasMhDAH41fgSaT3Iw==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr1904826plo.306.1589421814061;
        Wed, 13 May 2020 19:03:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d35sm813740pgd.29.2020.05.13.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 19:03:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1588863647-17240-1-git-send-email-akashast@codeaurora.org>
References: <1588863647-17240-1-git-send-email-akashast@codeaurora.org>
Subject: Re: [PATCH V6 0/3] Convert QUP bindings to YAML and add ICC, pin swap doc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org, mka@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Date:   Wed, 13 May 2020 19:03:32 -0700
Message-ID: <158942181222.215346.11981864062704009851@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akash Asthana (2020-05-07 08:00:44)
> Changes in V6:
>  - As per Rob's suggestion moved pin swap documentation from QUP to
>    serial.yaml file[PATCH V6 3/3].
>=20
> Changes in V4:
>  - Add interconnect binding patch.
>  - Add UART pin swap binding patch.
>=20
> Akash Asthana (3):
>   dt-bindings: geni-se: Convert QUP geni-se bindings to YAML
>   dt-bindings: geni-se: Add interconnect binding for GENI QUP
>   dt-bindings: serial: Add binding for UART pin swap
>=20

Who do you intend to pick up these patches? Rob or Greg? I suppose if
it's all in bindings then maybe Rob can pick them up.
