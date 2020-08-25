Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CDC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F60B20639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598321801;
	bh=scwGphPCjzFspkwof4FVot0GgrXNXEHuwnyRgS8bDhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Czdq+mCsBk2fi7pAfd/d5xvgkFWG2c/VBdcH5Czytc07lqauO4eC2yIxd4fs9QcXe
	 hMrTGPk9QXW0VwqjrO+YdR8/jEZNF2qUbAvWWdf7+J56iuKYGHe9t+rd+S/8c9lX+U
	 snEMBmt0VrYYYSw5X8A8JSozdtSl4tET/GgqQAss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHYCQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:16:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37341 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHYCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:16:38 -0400
Received: by mail-il1-f196.google.com with SMTP id v2so9131449ilq.4;
        Mon, 24 Aug 2020 19:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D70MBmv/w34G/CqYdHez+DLPaNFBleLhALN3HVop59Q=;
        b=ClNVW3jaGiXAJ1xAVeo5CYmMdZ4C+eP5OcejfO6oJafJr1kPMaYuPgbzPGSMjOv1EA
         NiNEv3gVmWBU4fcoD5mZVT0YejbupUmhfZbip+mL3t9uyUtY20SAgLlAICadbzxoO+HV
         hqNyjj3sp5lG9/LzQZkkB2rZKwASwhQK5L4fYtmkAAfe946xEYoJT3tSil1PcTxvSKSC
         hePeJKZK/Odi9+eElhDr4UTQBUNqUfpKhqzHUZEFuqaYVWCmOSAaQHm3C+lGA8IThOxg
         B18Li+xN8O5ZKWxK0LLIEP7fQ16imYYD4zi03wxQhqu9HXCqSbldxvDz0n8IZddFTYcz
         SSSA==
X-Gm-Message-State: AOAM530kTRCGJvV0TtLCyYLHhunob1dLtRI3BL4qBor4Oxl4PNOOqDra
        JepNWqbC+kzBKpvSX+r3Jg==
X-Google-Smtp-Source: ABdhPJyPK1Ko0mPm3l/WvrtEs/pnlNv63VwjLW2XYzlB/ERGqCi2eaEGU42EFeFXSodspa51hEUUlA==
X-Received: by 2002:a92:d782:: with SMTP id d2mr7992163iln.167.1598321797329;
        Mon, 24 Aug 2020 19:16:37 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s8sm7665868iow.11.2020.08.24.19.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:16:36 -0700 (PDT)
Received: (nullmailer pid 3800742 invoked by uid 1000);
        Tue, 25 Aug 2020 02:16:34 -0000
Date:   Mon, 24 Aug 2020 20:16:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     s.hauer@pengutronix.de, j.neuschaefer@gmx.net,
        sebastien.szymanski@armadeus.com, letux-kernel@openphoenux.org,
        linux-arm-kernel@lists.infradead.org, Anson.Huang@nxp.com,
        leoyang.li@nxp.com, linux-imx@nxp.com, marcel.ziswiler@toradex.com,
        rjones@gateworks.com, festevam@gmail.com, kernel@pengutronix.de,
        shawnguo@kernel.org, robh+dt@kernel.org, michael@walle.cc,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add compatible string for
 Tolino Shine 2 HD
Message-ID: <20200825021634.GA3800690@bogus>
References: <20200815193336.21598-1-andreas@kemnade.info>
 <20200815193336.21598-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815193336.21598-2-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 21:33:35 +0200, Andreas Kemnade wrote:
> This adds a compatible string for the Tolino Shine 2 HD eBook reader.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
