Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4095C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DE520716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692949;
	bh=/KvwqAUSHWzgBWBZkg0o5e4o2nzy6/qz61tCsI3y8dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=evqw4Jpo96uhle4751j9SI3/E2ecIUsb0NpfgGYwvmic8zEoq4oIgG4zKafScwAEu
	 Mn/k5QSnfQPW6reZXiFRuXX73EWOucSQC/ZGWeN0F9T1JuqBwWTOTzaCljPmW+rLin
	 BOM8qCzebsKCEq/wFQbGFyVBZiXiptUaVLByUbNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbgHQTfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:35:47 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37259 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbgHQTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:35:39 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so15570268ilh.4;
        Mon, 17 Aug 2020 12:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iAgp3OtOJ2V/PDJ3pq372B1DRl70fIx00JIpk/BWygU=;
        b=WD83jij1Rbas2aoH26bst4Wd2IAZsamOy69COePEP242UJVeliasG91aV7xS3fMGP7
         zo0EoAACW4gJMuGLQzG8bVBwVR75yBOePYP0SdltQxjm0HZkGHZR8aOSkPGvxKNa47Ov
         67WYEd3wShUexT/2jx7D0To8LCDs2sv6/L36akxJOoPvrKhGD258NT9JrZt539EEvH8c
         F4V/SNEdalpsxdxOU9aJFXJN6IuS9lE4g91WF7jYaKUWy4eXK0xZqs5EALbR8Li1TPMj
         VuEkuMB3qYv/moOZrGCJKKnlGpZQ/4/zcBSl97xhiHoBFpoDEX349nnSYl9XZYGaegQk
         z12g==
X-Gm-Message-State: AOAM530uBiw0LBvTLOCtcWudQw+5XmKkSmjJA6DAU44h66T4K+AAA6Hl
        n9rK+N2iCKHFwhrM9tbbfw==
X-Google-Smtp-Source: ABdhPJwXOJDDDq8HeKQf/PZk3gaBEkSGQVXO8CPg+FvLgAC1GUzXTU3b3o6z9o/yPeoBt4dX6qCiJw==
X-Received: by 2002:a92:d4cc:: with SMTP id o12mr14429800ilm.90.1597692938320;
        Mon, 17 Aug 2020 12:35:38 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f132sm9555787ioa.45.2020.08.17.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:35:37 -0700 (PDT)
Received: (nullmailer pid 1415017 invoked by uid 1000);
        Mon, 17 Aug 2020 19:35:35 -0000
Date:   Mon, 17 Aug 2020 13:35:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3] dt-bindings: at25: convert the binding document to
 yaml
Message-ID: <20200817193535.GA1414886@bogus>
References: <20200812200602.GA2612803@bogus>
 <20200813085959.15946-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813085959.15946-1-ceggers@arri.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 10:59:59 +0200, Christian Eggers wrote:
> Convert the binding document for at25 EEPROMs from txt to yaml.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> On Wednesday, 12 August 2020, 22:06:02 CEST, Rob Herring wrote:
> > > +This file has been moved to at25.yaml.
> >
> > We only do this to save updating a bunch of references and there aren't
> > any, so just remove the file.
> file removed.
> 
> > I'd just fix it up, but this wouldn't apply for me on Linus' current
> > master. Please rebase and resend (You can want til rc1 if you want
> > because that's what I'll ultimately apply it too).
> This was my fault. I forgot to revert my previous patch ("dt-bindings: at25: fix
> syntax error in example code"). So v2 was created from a wrong base.
> 
> I'll be unavailable until August, 23.
> 
> regards
> Christian
> 
>  .../devicetree/bindings/eeprom/at25.txt       |  45 ------
>  .../devicetree/bindings/eeprom/at25.yaml      | 129 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/eeprom/at25.txt
>  create mode 100644 Documentation/devicetree/bindings/eeprom/at25.yaml
> 

Applied, thanks!
