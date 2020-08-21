Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9D9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8020732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0gyOliY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHUHUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHUHTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:19:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE222C061385;
        Fri, 21 Aug 2020 00:19:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so482131plb.12;
        Fri, 21 Aug 2020 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ToFeweCF4QEpNtbMUOZZ3hTuXD1Vza7sE5bC5UlfQn8=;
        b=Q0gyOliYC1Hl/9OIBYcPQRCsfr85jJpFGwjo4NLbW+ZXJ7ecn3uAhErhu6dGNh9och
         PKeIIwVZkmVq6+vfwySBslfth31MIWSk2vVhNt2YPd6FeenH+04VxW0EU4ngwVpMSqwI
         9PJ29+gE9sMb+DnznCZbXBF/QLQiXp2MbHRsQjD1KgeblY6kX3KR7wnuH9VHUTYbaHZg
         qOoEzUjPot/8DoGkZNDNbF3/Y3t8ERGgS94iOX3ExGj5cpQ27iritPK0m+uuux7HegFy
         3fTMQZoSq/mXfjfVSPSrrJefy+XJb6++2hlAyPzVyiH2jfJ9dJ8O3xae+H1ZWD3GrEKB
         0beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ToFeweCF4QEpNtbMUOZZ3hTuXD1Vza7sE5bC5UlfQn8=;
        b=Czx1mQokrr0Bt/Oy0Fa814DH3uULkn2NMm6Bu/l35vM+CvjI9O7UuiYKsnO1sGURhh
         nHez8o9p6oW1R8g8cskDWmd9+3O6akpqAmtuvAD8bXc9Wrq06GMis0C1iikudVIm7x/1
         8xhFuiUoex8TgrmTNcU2E3s60NmcMb1uEuup2bGBUPt+Cijfv/zQp4CS/J7mryhjeU00
         70FsrOXsfT58DT3WMTa6sCWIOqEeyP3rfJWYyhGe0WufXh8wW1NEQEv2XJTIvQg41tCp
         O8FfXPGE9D10PQL4vbxIetT03x1pfHmL/nx+gsVFCXro2TusHz/x5EWs0hQk2Ho6YEHf
         oxsg==
X-Gm-Message-State: AOAM533t4fR6wpfjj+TbygJ7I8Gt2YPf8b3/qeSRNNkwggRNcvwCPMXB
        /MlLVEx4JAdiRqcusbl6g74=
X-Google-Smtp-Source: ABdhPJxUOkJcKhXdRHc95o5EBPHtGYO4oYqb9z/UtARj0vOot1dG2cKwPh+Wg2N5VG9AFifzDhJAZA==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr1423558pjb.226.1597994383047;
        Fri, 21 Aug 2020 00:19:43 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c20sm958965pjv.31.2020.08.21.00.19.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 00:19:42 -0700 (PDT)
Date:   Fri, 21 Aug 2020 00:19:28 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl-asoc-card: add support for TLV320AIC32x4
 codec
Message-ID: <20200821071928.GA19890@Asurada-Nvidia>
References: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
 <20200821071153.7317-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821071153.7317-2-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:11:53AM +0200, Matthias Schiffer wrote:
> The TLV320AIC32x4 is commonly used on TQ-Systems starterkit mainboards
> for i.MX-based SoMs (i.MX6Q/DL, i.MX6UL, i.MX7) and LS1021A.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
