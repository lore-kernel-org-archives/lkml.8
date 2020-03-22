Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A7C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41662072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObkEALEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCVEuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 00:50:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34449 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVEuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 00:50:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so5352032pgn.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fw7idJmuM/UMJ8Ze42mgQHANiFZYpnBY7OB3z1c8mkE=;
        b=ObkEALEuMPnaX+qZotFV5IEfFHzYpbijpfW7g7fuZDvwumlr0am4+8R93yFLcSc0tj
         m3jzdfuHuv2nwC6MWAFBhYhLh/ap6j8H4d0eV+svLawEAgjjNYzqTi/feNkNJ1TOeaWs
         T0rw8fyhed0hfaTnbcWnXfrN8wYjGLZ7pti96oCM9rFVW1jzFvM2cj/nzUPREaYFthk4
         w9Ffw2ipzoHf+MRHH8EOqEoowFrIobbagf+01JppCpZ2ckR+c83wr6mVA5/ZC7bLqNon
         MuOz2KMsVt9InFpkRVlv0fc96/GtcTBBqfmhBb2/2R9yVJ82XIfmJmp+8e3+a6pIYXJT
         XKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fw7idJmuM/UMJ8Ze42mgQHANiFZYpnBY7OB3z1c8mkE=;
        b=GdPe/dgSbB7JPdcFuwbJOIBYk4Nu1JJHdB+nkQ9gwhnyrCCIF3A0VI0W2N9ro6ZCEf
         99wgW0cae3Rkhmyxvwai+tvSxFUdjYc6RKXSAh3p3lwTR419w08zXVlh/1Qc5REDzcg+
         C20XmHs/OKWC/kwzdFlGv6Z61T4U0t7Ilm5xF7083VrLx3UHDTZLLe9D6lUGGa5bnglv
         fXYQcVEBfAJW2WAR72AlvAvpVEDVOvM39rFUtzx2tjdSoBKKN8Uynz05zwEBg1etfzRR
         JSEEsiJ6Sf9pCvqGTDNEj7otcbiWDZir6jddQHwiw0QlnSxoSfqWNGh7oghTKd8CEJ41
         kJLw==
X-Gm-Message-State: ANhLgQ0ib8Ui50p28bMG11Er0pX3OzKqnfFqLZRyku7ss0H7S5QTnJj+
        HGN2qhLUf0rfy90yd7J2tTuHQW1lfQ==
X-Google-Smtp-Source: ADFU+vvDVs2I/LbHWUJQ4k/S2KAgwBeDLUq4hu6QT+o0LyCmxlbOu7JWHBsV2Ob5MbbH15RERI/R8w==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr867362pgm.219.1584852601080;
        Sat, 21 Mar 2020 21:50:01 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6183:f34d:9904:5c2b:1f14:a384])
        by smtp.gmail.com with ESMTPSA id k189sm8984584pgc.24.2020.03.21.21.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 21:50:00 -0700 (PDT)
Date:   Sun, 22 Mar 2020 10:19:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hemant Kumar <hemantk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH -next/-mmotm] bus/mhi: fix printk format for size_t
Message-ID: <20200322044952.GA17141@Mani-XPS-13-9360>
References: <c4852a82-cdb9-6318-70a4-96ccb4ba5af2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4852a82-cdb9-6318-70a4-96ccb4ba5af2@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 09:17:52PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warning by using %z for size_t modifier:
> 
> ../drivers/bus/mhi/core/boot.c: In function ‘mhi_rddm_prepare’:
> ../drivers/bus/mhi/core/boot.c:55:15: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘size_t {aka unsigned int}’ [-Wformat=]
>   dev_dbg(dev, "Address: %p and len: 0x%lx sequence: %u\n",
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Hemant Kumar <hemantk@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
> ---
> Found in mmotm, but in its linux-next.patch file.
> 
>  drivers/bus/mhi/core/boot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- mmotm-2020-0321-1517.orig/drivers/bus/mhi/core/boot.c
> +++ mmotm-2020-0321-1517/drivers/bus/mhi/core/boot.c
> @@ -52,7 +52,7 @@ void mhi_rddm_prepare(struct mhi_control
>  			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
>  			    sequence_id);
>  
> -	dev_dbg(dev, "Address: %p and len: 0x%lx sequence: %u\n",
> +	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
>  		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
>  }
>  
> 
