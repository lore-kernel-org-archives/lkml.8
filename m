Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF448C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E302077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjmeoWUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbgDAJA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:00:56 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35037 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDAJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:00:56 -0400
Received: by mail-pj1-f67.google.com with SMTP id g9so2421056pjp.0;
        Wed, 01 Apr 2020 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G5w9RBvrR3WV0wIE+sZQB1JGP6d9WKUVbo/9PkL3ClU=;
        b=sjmeoWULrkH1tiyyfW9jHoKfBl3e7nyRSF1aUIblVFaUN/mu296kgU21YgdIGWfn+h
         zdURn18aS4+snbifdkA1s8BDLF2XTBAIZiLLvnZzpJ7Z/R/5ZPGja9hFa9g/lFBdu6u1
         h+D5feCaKVjJtUQWO+hmHyqgbmlwfb9+PWujHtTL1phLMdPyxe8xvOpLGayNk8KKHKBt
         zynsSQExMsahWUIXTBddC8Zele2NgjqgiirumN9kWYEoaDFCrwjOSdab1kDdwjlN3qop
         vnG8sC7/w9Lu5S3owEeowz43YC4rYgr6lpvyvSUakiOEb0XDaDVBwV/EFKJbOTucUzRu
         Wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G5w9RBvrR3WV0wIE+sZQB1JGP6d9WKUVbo/9PkL3ClU=;
        b=T2pMXv8+wYPZSWwmHEBRfK/fAX1ArJ1R5qAdPOn0k1qcgKlvOldTxPda41BuptM7Bk
         o30m9l2u12GSaed3lvWk7iFsnklBiiRbAFovJnv6ZKKK0X+X/V09oamh+/lI/chTvOpg
         ee7j6V2ZbFph/F+d06cq4vGBPnKJnbPTEdD7DNWdmnBO0c6f8YDAlZKy7VRhby+8rmH2
         vT2ket/XST8Gpi2k+r092yBJqwGAMYBt9FrEDFVa2acnJLbhe8xlHWvhde6Ej1g3uYdS
         tUBzYkwlonhoWqsH/vH0hyoloaRd7ppq+FZgUy/ccFECU87a050whfoJN/rEEfAZxxcq
         brUQ==
X-Gm-Message-State: AGi0PubT4b/ymNpSypGU6/aeXQJ8TAhXI8FcO6ogFZ8OJPECALie6QQC
        ENwa/IkyZiQ1ZTfZ35MgShM=
X-Google-Smtp-Source: APiQypIG0HKQpeV9kSQbddQPBmsyGFCl3XNlZOs5/znCA1arlAiyTU9vFRvbsaVa5Utw0gmcOea2XA==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr3684476pjb.149.1585731654177;
        Wed, 01 Apr 2020 02:00:54 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g11sm1064804pjs.17.2020.04.01.02.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 02:00:54 -0700 (PDT)
Date:   Wed, 1 Apr 2020 02:00:50 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] ASoC: fsl_asrc: rename asrc_priv to asrc
Message-ID: <20200401090050.GA7202@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <4a808f376c297f91da0caff9d0f73efb6f152e72.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a808f376c297f91da0caff9d0f73efb6f152e72.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:45:34PM +0800, Shengjiu Wang wrote:
> In order to move common structure to fsl_asrc_common.h
> we change the name of asrc_priv to asrc, the asrc_priv
> will be used by new struct fsl_asrc_priv.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
