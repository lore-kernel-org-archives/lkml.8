Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC04C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C982073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9GxqpU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgFAVKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFAVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:10:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F626C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:10:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k19so8369664edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhljfA8dcj+WSORT9UU24bdiAcPkgiL6U3k8O8LuYxk=;
        b=t9GxqpU+A5lPYm4L6N2MEtj3WyrQ5SOVv+0styTmRtIbro1w8EnRBxArHtNvOjK7Hz
         Nxvs2k4uY2N0X7/86l8mIy2QWYMZfHZg5TzEZVXFxoLbX0ryqN9jMsRNzZcosS8MjxWC
         hDNGgOukSN9VwvbEGW25/Y9bMMzj/krvfJF8KvSl2263UnhP4Sp9y74bcKakaUmb+dd9
         bMPFEVSXzirn7K81xz6fX1btpty1IAcS9+jFDUNjwk0thsxrB5aI2BheDeVenOJgIYQk
         qQcszCkRBXABgLg9DdEYijEV7lgClWi+AGP/1Z9e+K9oGV8bwiNmnPn6TwyUoDwg5y0N
         G/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhljfA8dcj+WSORT9UU24bdiAcPkgiL6U3k8O8LuYxk=;
        b=k+1tHomGLUTjnq04s76Eq2USiCYOsH4MGFzM6CIyYdeATGCPcudgnT1POKTu6Xbge1
         Dc1KGT4chvZKy7h9ADUWD64dzicH/MgemlazgFUG3M6A9gNzmeEhseKkmgjP88YETvsp
         GxthQ0j+GdAWwBJTBE2UlSAjONirhvgSsmDSd5B4ko+lN/WhZIRrAYqasLUEowDI3pk5
         o4M1zYi4lspubxm+IrQMuhEnsN5dh8L2yof8U9gHshSbHTvsO0wC4UnnRNacc9lC4XLd
         xY9OmNVkUUDwqs/h4AAnI/0XaSZLWl+KDMifLAS/3uik3Uth6Bqc1fL9i/By0QFwHn/p
         gHPg==
X-Gm-Message-State: AOAM532KqhcYb+wjbYum/0vDXZB3eHcK4VjbaccO5NnHS2abtYiQoWUp
        rAqzo3Bs4ytRHGITDMcDn10=
X-Google-Smtp-Source: ABdhPJwzuc/YU3vAqkri4+4HSwDvptfGsJ0G1JS0/NJ2YvTZL8QPpuVTvj6pYVeRW0rXRThHc+83qg==
X-Received: by 2002:a50:a782:: with SMTP id i2mr23741387edc.33.1591045845072;
        Mon, 01 Jun 2020 14:10:45 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bfcfd.dynamic.kabel-deutschland.de. [95.91.252.253])
        by smtp.googlemail.com with ESMTPSA id l8sm602396ejz.52.2020.06.01.14.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 14:10:44 -0700 (PDT)
Message-ID: <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
Subject: Re: [PATCH v6 0/5] Micron SLC NAND filling block
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com, s.hauer@pengutronix.de,
        boris.brezillon@collabora.com, derosier@gmail.com,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Date:   Mon, 01 Jun 2020 23:10:43 +0200
In-Reply-To: <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
         <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Richard 
would you please help us confirm below question??

Thanks,
Bean

On Thu, 2020-05-28 at 16:14 +0200, Bean Huo wrote:
> hi, Richard
> 
> 
> On Mon, 2020-05-25 at 14:18 +0200, Bean Huo wrote:
> > After submission of patch V1 [1] and V2 [2], we stopped its update
> > since we get
> > stuck in the solution on how to avoid the power-loss issue in case
> > power-cut
> > hits the block filling. In the v1 and v2, to avoid this issue, we
> > always damaged
> > page0, page1, this's based on the hypothesis that NAND FS is UBIFS.
> > This
> > FS-specifical code is unacceptable in the MTD layer. Also, it
> > cannot
> > cover all
> > NAND based file system. Based on the current discussion, seems that
> > re-write all
> > first 15 page from page0 is a satisfactory solution.
> 

> This patch has overwrite page0~page14, damage EC and VID header
> boths.
> I know this is safe for UBIFS, even fastmap is enabled (you fixed
> this in (ubi: fastmap: Correctly handle interrupted erasures in
> EBA)).
> Now, how about jffs2? 
> 
> 
> Thanks,
> Bean
> 

