Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F558C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B357206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590700686;
	bh=yWtZYaVXyItxGwd1Sran/IDZjEWuVjnafMJXToUbLAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RmfhbvAezluvt1YjhnNdbciGfDCJXmv9aXMLdQNjNfqFZnaRy/xwRtwqOL4q1u4Mf
	 bpq6cjMhaE7+G4L2HPZIpApjM9DU+qrAc5VuNRfhXKPVqKjDsABdlHxQFUa1rW6AST
	 z+cZMDnNOoVx5fDQCHlnM9bFjQLcsRkTuNzFV/iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436522AbgE1VSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:18:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43889 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436512AbgE1VR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:17:58 -0400
Received: by mail-io1-f67.google.com with SMTP id h10so22339iob.10;
        Thu, 28 May 2020 14:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v91yPCdHctgz0ohSCsD9yZNDuIS5ieVbnmtfs1+Nr8A=;
        b=fvfmQAiw0z927Sh0WbKKqyAxOzo7LJ5Vk5lHnSEsHJAQRn7WC2zAYbakOtXn1FyXTZ
         sPrrfxUZAzK9Ph/wOVdfCqP49GBlBK8TqZxx2rDQrG5rl6eWBDqhH5VzfVASqVER7ltf
         ka8rP8L3DveA16ECylxzm4HeJZ/FuoM7Tp/RHrRs4zFwwWAltS3+y83Gh4v7tVD2fDBm
         YRm3ofCDbtRLhodzh8tSX4UM6ximzTOEN77Gqn7bjikVRvBxvk2K1juMjQZB0odk+XhB
         Knns3X8SeOr9uo+ULWN5vXv/mX2/WP4/z/CTr1oXIjbF92l4l5cwEyAR4SXwTywB1Zyz
         Edug==
X-Gm-Message-State: AOAM530inNlHJUmm7A1PwsqjmmN8jHdFoIoqbqXuLSpc4pGhNgrDmMft
        4tWMUHIYc4Q7T4lhLgwTXA==
X-Google-Smtp-Source: ABdhPJxmnYG0SfP1hghvgB6hSIzDb/O4xJbcG4wBUzwbDodnFez4tsFdXWWkYF8bUcZNBk/xN+0pIg==
X-Received: by 2002:a02:c959:: with SMTP id u25mr4276095jao.46.1590700676192;
        Thu, 28 May 2020 14:17:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r68sm3757333ilb.37.2020.05.28.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:17:55 -0700 (PDT)
Received: (nullmailer pid 702383 invoked by uid 1000);
        Thu, 28 May 2020 21:17:53 -0000
Date:   Thu, 28 May 2020 15:17:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     cristian.ciocaltea@gmail.com, andre.przywara@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 08/10] dt-bindings: mmc: owl: add compatible string
 actions, s700-mmc
Message-ID: <20200528211753.GA702332@bogus>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
 <1589912368-480-9-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589912368-480-9-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 23:49:26 +0530, Amit Singh Tomar wrote:
> The commit adds a new SoC specific compatible string "actions,s700-mmc"
> in combination with more generic string "actions,owl-mmc".
> 
> Placement order of these strings should abide by the principle of
> "from most specific to most general".
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> 	* Newly added patch in v2.
> ---
>  Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
