Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00906C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81A72076A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="se96Gfa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCQNgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:36:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34210 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgCQNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:36:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so25675584wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=C5UUMlB1vuVsFqD+amvxd3LJdmlP7Psxf6b/ICw2yeE=;
        b=se96Gfa2PabhLjXbMk3DF/dsiXpQcRoXaNnO0MF+OIOP+6Ga54A4maQX31UU5r4vPU
         5/hGqPTpnRLR8DecY2Pg23NZ1/yWDIJoZWfsSry8XsID7ZcqDz1R9QAiNgSTrPlRbaqx
         Kx5W9cykjsWagYxQgEhiKtKMvH2zCyN6USHJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=C5UUMlB1vuVsFqD+amvxd3LJdmlP7Psxf6b/ICw2yeE=;
        b=arxiaQfUj92u8zvbX1hA+ve1RAtZ3Ngwf22qUB/FFwDpkR+otqJedT9Z7RPDsos3qW
         YZYxhi2e5UvH2UOnPyabF4o6JHPgRYums8n0pKkJ/3YjY0VBvwWqJj0+MxOANgN/Q1d+
         zV/tiAg1btptkgX6aN/TreU4FlQCOvQCp1RyCWD5ehKLU1zE5l8LrG58JVbMH6g1ZtRf
         sChtcbd7PPLjgWBcg/ut5zjUfu7D3DhuiFCQuZdf365fL2BMzo/1cGjgXzzYHZDTXCXR
         +N2uSa+Ck92nlZB/tnFAj2itB3Jm763Ndm2CEy+reGsJYV4Gl4Nd7IIlx68Z6lmkgawz
         OVsg==
X-Gm-Message-State: ANhLgQ2VbK2GQN7ZJitdZP+HUC73M4z8tbKuMkCxJyFTpsNTJVWL+Qvi
        pC9wfMffPClsud8v3XgzLWQ51BjUZLIuJ4Ie
X-Google-Smtp-Source: ADFU+vt2hjTZMVdUwDmhSalbO2esCViQhgfOwq7UWI9SwWOAqbVu4rfpvcU688VZVd1B1aN3n2pb0g==
X-Received: by 2002:a5d:522c:: with SMTP id i12mr5953325wra.176.1584452200128;
        Tue, 17 Mar 2020 06:36:40 -0700 (PDT)
Received: from ub1910 ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id k5sm3743373wmj.18.2020.03.17.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:36:39 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:36:38 +0000
From:   Paul Barker <pbarker@konsulko.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Message-ID: <20200317133638.5951a743@ub1910>
In-Reply-To: <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
        <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 14:32:27 +0200
Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:

> PWM can have a normal polarity and a reverted one. The reverted polarity
> value is defined.
> Define the PWM_POLARITY_NORMAL to be used further.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

s/reverted/inverted/

-- 
Paul Barker
Konsulko Group
