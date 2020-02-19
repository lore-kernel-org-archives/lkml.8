Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2FDC3524E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F1824671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582144630;
	bh=8NYFF4YlCTWY69UMMi0yJb62MRJA7ArQ4xU3etEGdaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Htsl7x2y46Ee0oxCIxU6S5ZWck6y5sf7zleS45nGxou8pzIQVDaKBrMLMI14qpeCg
	 C0NQPDQxLicPs6X16FAGBnMAeNbGISH6zmpx1lHqmOLNaPWSmvQ07yhr2FNuyyLWrL
	 deFSsZ+5vwLW5I1RSOZe26ri17FHnRwUiUOyB1rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBSUhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:37:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47008 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgBSUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:37:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so1451156otb.13;
        Wed, 19 Feb 2020 12:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AqBZPuPGulRkYz04Uc64jE9ynggKm16TfsBQmv6si8=;
        b=CEg+BlVEh9dYIPwKJWs+ttEvRohpkE1HMDS4Q95tY7gIlTz83NwDboDW53LBvE9Sd8
         11edFp88mH5I5WBOhWywxG5L7HYZo0xlAY51bGKs/WyBRbrzLOQ+PlqTOPwHVHBQwJ5P
         Mbnx5abAI6Cq5/FK8qr8kFS95lfg93CbIPLVWJB5L/Q+tnyaJZiMBQ2OKh7taYXv+wfh
         SF/kHRPFDlWXztjFdxAYmwT7JMVBpzYpAzwmSwpmxLroPg45P/HqhkGHKVbWmEtCuYFZ
         VViwe80012V2IiHWIkJsvcgBTPP23Afb+r/Lwk/LeqysBk2s52Y6QHSx8Zax1TMv3ahe
         asRA==
X-Gm-Message-State: APjAAAW88zuMnPsKRIj/F6BJfCjzbrIIgIY9MzM+Isb8NLUQScd4cHNN
        iA+x2qhYaQD+nuX+ir0oWOUVwO7aLQ==
X-Google-Smtp-Source: APXvYqwXHqdPF0eGfWGHZFMcj2qYo0Y8tJNnbLJqbB+BFR7YXs5aR7a2j8huyc4ZAUmLqR7q9DjA/w==
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr21034247otn.262.1582144628599;
        Wed, 19 Feb 2020 12:37:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm282683otq.46.2020.02.19.12.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:37:07 -0800 (PST)
Received: (nullmailer pid 27543 invoked by uid 1000);
        Wed, 19 Feb 2020 20:37:06 -0000
Date:   Wed, 19 Feb 2020 14:37:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200219203706.GA25618@bogus>
References: <cover.1582007379.git.shengjiu.wang@nxp.com>
 <a02af544c73914fe3a5ab2f35eb237ef68ee29e7.1582007379.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02af544c73914fe3a5ab2f35eb237ef68ee29e7.1582007379.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:39:36PM +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt

Bindings are now in DT schema format. See 
Documentation/devicetree/writing-schema.rst.

