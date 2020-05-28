Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED01C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83BF2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSs0Frfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbgE1OPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390932AbgE1OPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:15:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D4C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:15:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so28026779wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47OATELzdatA1HggQw3A54kP6MuolUXcSmh78zyfPRA=;
        b=JSs0Frfy4Zpy9TRTpQojoYjtuRJ3DHViQmWtiRbFxhQVKOt+1z5Rohk+YN37hav4l3
         RULlQX+tTLjgBI39buU3w9qzH6eI9DG28rTgs2uVGMLXOB3U53SgaLlbqqZyeyydeB4O
         LdNxgofLdtUzZYMB/nYE0pUDOiOUzIj+n1wRVP/cm79I3aJpCkDB5oK4QOgHJWulI4fH
         aLgN2Irs3NSKEvJC7kERtTTPqj9m9scgRBOmO0En2yDQ62xtbyJUCpkmR1IFYxIZhyB7
         W9IPUWC9io+3zgbtkEiLcHXxy3VCwqCJl+vWY4wYGhPLVVLw00snMYOh/8fVC1x4wVP3
         c0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47OATELzdatA1HggQw3A54kP6MuolUXcSmh78zyfPRA=;
        b=O3zc43Sfo4+dn6TqsQkBJjRqDiR/twWHIvJpZwC+fxbGPi2Lf12riGH17B0haIku1f
         7SE/mi3lBtErSALTNH7AXs5yoo8kk9h88gpyvh+rFURrW+A6o5IzsBppnBklT8/BN2h+
         35GCsUmTxEzxuQpp9U0hCXAKwB4jxST2aVRFS42Mdhfddyrc08e9MZs2c8Q9UFZbJKCh
         U2Y2r0Vj+gkvEFwLCroTsPO11AR21M8Fd5q2mp2puZaRRp9a0ZLzXjh8bvW0UhAZ8BpH
         CYgSKPT6Oist7BD3cF0DK3h+ubrYKjrZMKTqN8kqN10bdytC0W83iNh9wWrbr77QZ4qD
         m2Qg==
X-Gm-Message-State: AOAM532ZjNP349y5wpUayg10Mdn6woPm0gSSG/W0IqEN+R8/d0ZdPFIQ
        e+b48zANfpZbUt70Ej5mJnY=
X-Google-Smtp-Source: ABdhPJyRO0Kiu8RuqwMd9+u4dh+G55xc4yUP8AZCimdZgxNnKU/DdIE8r/D5kk/gQwWgJ0b1zpmNvQ==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr4059264wru.210.1590675304940;
        Thu, 28 May 2020 07:15:04 -0700 (PDT)
Received: from ubuntu-laptop.micron.com ([165.225.203.62])
        by smtp.googlemail.com with ESMTPSA id r11sm6257982wre.25.2020.05.28.07.15.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2020 07:15:04 -0700 (PDT)
Message-ID: <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
Subject: Re: [PATCH v6 0/5] Micron SLC NAND filling block
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com, s.hauer@pengutronix.de,
        boris.brezillon@collabora.com, derosier@gmail.com,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Date:   Thu, 28 May 2020 16:14:52 +0200
In-Reply-To: <20200525121814.31934-1-huobean@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Richard


On Mon, 2020-05-25 at 14:18 +0200, Bean Huo wrote:
> After submission of patch V1 [1] and V2 [2], we stopped its update
> since we get
> stuck in the solution on how to avoid the power-loss issue in case
> power-cut
> hits the block filling. In the v1 and v2, to avoid this issue, we
> always damaged
> page0, page1, this's based on the hypothesis that NAND FS is UBIFS.
> This
> FS-specifical code is unacceptable in the MTD layer. Also, it cannot
> cover all
> NAND based file system. Based on the current discussion, seems that
> re-write all
> first 15 page from page0 is a satisfactory solution.

This patch has overwrite page0~page14, damage EC and VID header boths.
I know this is safe for UBIFS, even fastmap is enabled (you fixed this
in (ubi: fastmap: Correctly handle interrupted erasures in EBA)).
Now, how about jffs2? 


Thanks,
Bean

