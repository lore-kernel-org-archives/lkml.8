Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2A720760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gaLhUKP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgFHEaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgFHEaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:30:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F8C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 21:30:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j32so13664583qte.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bZmtb3aLVU5KBGiqZAaqclMmQhVOzE13zZD4uF6ANrY=;
        b=gaLhUKP8dFKwFLkiRjCjiuudl522MbjPdmUimfzDCN3xnE1XdHEG6E0esOcvPDeQ9W
         Do49PqQzw0fpkjLZtP3c84sxg7kHFlVatQT5APvfHMJ/VS/jKh7khzHCcUqjjaEf5QyK
         /ASt7MgK0qf4GaCCsRWS1ge6qGcCncJuVDZvfD/xUdaESyjFAWj5umOGjBW/spz+TVFy
         UkIGyTDnnEJjGLRu/cdmVbxYcKSgR/HU3gKvvtwoURh00dxiyFSlOOXJwrgxcFOPPoJj
         evNkW/2eiAPgLD+z64pWm8y3enKoeBiR+Cm9B8kg9uNAf38m12IPO8IMRO46Yv6eqYzN
         upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bZmtb3aLVU5KBGiqZAaqclMmQhVOzE13zZD4uF6ANrY=;
        b=KyHCMs3++TjA3mn+tyaugZ+zDVgAvmCPImc9sqvVmwRqMlkL23wLmcF97Z0PfqZgWe
         UHhPsaMlq9UxsrHHyhJ+hMlZ86JAqmRTLexOVAiqlJkyL7c5vAj5kwQyJcCagpTdrsPC
         y3WGPMo7ysvjBTJnRJOE/GWUuDhOZX+7GYvyLKkia28e7hsz8/0BfZe/rOangiP7Ua7Z
         tRwgq2Oky1BRWu/HBrdBpidvW3xDr8SLz7fL1nXn3VKqfI/q79bHZYqXMgtNVP0fZNsW
         AQNECn3WXMMQn83ady/xskClnaIinOl9lvhwZi5AZIrkkskAOLQN4Q6ty/evwYNHJ1kl
         56vQ==
X-Gm-Message-State: AOAM533MwI5YeGVU2/9PQC9glQ3sloBjcaqmXgBTkK7GG8g7OTP+7X8W
        jUtIP8ArYLBaFwsYgfRqCOtdvQ==
X-Google-Smtp-Source: ABdhPJxRJE6Dl9jcPCtME9UeFyPzJdE0BYbCiwXVxxXS+YuRUIFTS2CzbpJT/kxkF6tJMislX6p2iQ==
X-Received: by 2002:ac8:688a:: with SMTP id m10mr14265007qtq.254.1591590618119;
        Sun, 07 Jun 2020 21:30:18 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u7sm6256233qkb.7.2020.06.07.21.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 21:30:17 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] drm/rcar-du: DRM_RCAR_WRITEBACK depends on DRM
Date:   Mon, 8 Jun 2020 00:30:16 -0400
Message-Id: <1DA4E5B7-BB3A-476B-B09A-24EC89583C3D@lca.pw>
References: <20200608031622.GQ22208@pendragon.ideasonboard.com>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200608031622.GQ22208@pendragon.ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 7, 2020, at 11:16 PM, Laurent Pinchart <laurent.pinchart@ideasonboa=
rd.com> wrote:
>=20
> I forgot to mention, I think the subject line should be
>=20
> drm/rcar-du: Make DRM_RCAR_WRITEBACK depend on DRM_RCAR_DU
>=20
> Could you please let me know if you're OK with these two small changes ?

Yes, I am fine with those.=
