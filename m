Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E93C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AFE206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSRN2jOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFZVVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:21:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E2C03E979;
        Fri, 26 Jun 2020 14:21:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so5485200pgc.5;
        Fri, 26 Jun 2020 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zKO0HF618ZHvLKGIwJNOq5Dl9WwME35XliCSQ1Uc5Ro=;
        b=CSRN2jOn4g0YRarsVgt4RWGUl40iKy1BDylDXh4amhYCihwzANY+M48aV0pvxFyxzV
         miyKNHZq60jSOZkqHqVLq6iMFA4OCmu/yVAZ/TpQ0FK5rN2/ynnbumNicgcaRK7G6gpM
         KXxkiTa+WKx7CGdncYX+VbFJ3z68SDQKaV4WMBUeittBAYlPN+YOPPPugDXYN5IEzBe4
         pIfSjBHFZpOIRr0QBa44b8ytsvht7FPoqNIik5Sb7/Y6gN01lpIceUbP4+vP5pC6KY/y
         Lh9OH+pZAGSxeQaI848EYTmKO7fIaByOyMrPWkO5ddxYzHA8VqHysNJiLeekZUy+q8pQ
         WO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zKO0HF618ZHvLKGIwJNOq5Dl9WwME35XliCSQ1Uc5Ro=;
        b=V4vA6MhEFypRwycFj31nDg8lwv2MxuRjtWADymGhnwgYzFYqlV2BZNRKPDMmMNqPgC
         LrOreLGklT4sBwV5RXvcRX5+Wb6nzrzP5lNYh7kZAee6merBS01JkNndhu2Z23hGSvjB
         T098odmcXvLkGf38GxHZ3dYV/R7KTwg4IKgxRKZDe/uTzoz4l8Fd9iiKRvdAPiXVphO1
         ZDwcHJicVSXBluKxHsL6tWhPV30tRHTloYsn1fjc+VSfxM1p9un5f+0R6sm7nGJCTJo3
         +VSEMQS54xsZy+iRev2TX/0ETfvg57dlq/XdjA/pxKjNvRgrS/5ruaD7awhUTgwi056X
         EZEw==
X-Gm-Message-State: AOAM5332dCAvJbceS7oGqOo+yTGGazh0qSwgSHte5kPkO22yBbSa4l3y
        HNdxURDPE7U4MGgdOckRX5E=
X-Google-Smtp-Source: ABdhPJzixwu5xAFDCZEZc11/c1jGK/QvttplfhOdsg6t+UXwn5MqDPN+ctnD9WJO0MAdiMSX5vS0CA==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr636309pgb.15.1593206513519;
        Fri, 26 Jun 2020 14:21:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id oc6sm13741216pjb.43.2020.06.26.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:21:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: bcm: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 14:21:51 -0700
Message-Id: <20200626212151.12654-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626080646.4300-1-krzk@kernel.org>
References: <20200626080646.4300-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 10:06:46 +0200, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Fix dtschema validator warnings like:
>     l2-cache@22000: $nodename:0:
>         'l2-cache@22000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to devicetree/next, thanks!
--
Florian
