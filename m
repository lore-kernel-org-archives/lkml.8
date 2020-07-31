Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1DCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008B621744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596234627;
	bh=AfkuINZNwTVEFqxQaW6sJ0upSg18twoFRjmaXnH7rFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DAm/3h0TkcfEQs1Fu+rA83TkXiHoX2SFVNPGu15UVY6W/gGSeIiGkb2bx9Lz96Gsp
	 yMOTlpKN+PyHwR4w4ouHF6e1RumwGWUVRQhXg6G1tGRyI1IDAsJeQ9HQarr++k+iVh
	 PLt0JgVSDaZmJQbmQUAENRPLW4VfWBjE8w7h3f1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgGaWaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:30:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35897 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGaWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:30:24 -0400
Received: by mail-il1-f195.google.com with SMTP id z3so16389992ilh.3;
        Fri, 31 Jul 2020 15:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2maazcGZ5EmPVyaTxV1kqSQWG44Ku8XCmrKZS9b/6sw=;
        b=UqICUlaEnL/MxF6L1U1FBBq2XQXt8mhxWckDIHoeBPSENlV1UOTx7xRex0xh/4X9cq
         RWOoesAohj6AegXTMJv8O09dtFdaiuZb0rkKZXe5s0cvCFVVflVW0pksSqi9uxWfaRRE
         KNz3/e7m+0TiAt98pLDCyXw4Kt3mFyAQgcG59rYdIai71ZdzxCAHpZVRhDi8sliz80CN
         P00K0udm84ouf/UtCvGQl3jSIKcMQTuwwbLhkvR4A0KRC312iPESUTFuErUvsQ5o9eRV
         BqLg3XXhd7qyHUUQ8ZmWXWkRkfqF8cISd0NCAlmMb1vmSma/pgeFHXGAwVGJn9fhXBwz
         SJ1Q==
X-Gm-Message-State: AOAM5332IztImBXBEkE+agk4JsJqLO2BHJVOGwOXpc+TpufQoHbWfiBb
        Ycm5b5PLdzk0dYvJD7sVOOC13gSvhw==
X-Google-Smtp-Source: ABdhPJweVA/kIb9N17voplqDVaSgdP6Uo167HAzEoZY7A1QACN/CL+32OjS4NIvJD0JGn11TfvLrAQ==
X-Received: by 2002:a92:5bd8:: with SMTP id c85mr5466714ilg.35.1596234623651;
        Fri, 31 Jul 2020 15:30:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l16sm5507830ilj.78.2020.07.31.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:30:23 -0700 (PDT)
Received: (nullmailer pid 922882 invoked by uid 1000);
        Fri, 31 Jul 2020 22:30:22 -0000
Date:   Fri, 31 Jul 2020 16:30:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, han.xu@nxp.com, vigneshr@ti.com,
        devicetree@vger.kernel.org, Linux-imx@nxp.com, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, u.kleine-koenig@pengutronix.de,
        richard@nod.at, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/2] dt-bindings: mtd: Convert gpmi nand to json-schema
Message-ID: <20200731223022.GA922797@bogus>
References: <1596113004-15548-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596113004-15548-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 20:43:23 +0800, Anson Huang wrote:
> Convert the gpmi nand controller binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/mtd/gpmi-nand.txt          |  75 -------------
>  .../devicetree/bindings/mtd/gpmi-nand.yaml         | 118 +++++++++++++++++++++
>  2 files changed, 118 insertions(+), 75 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> 

Applied, thanks!
