Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F92C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D2D20776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDbN5uiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgEXN6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgEXN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 09:58:25 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84EC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 06:58:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id be9so13013349edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y9GFlVX6iZi5TB3ykNza+0McOKgu7mipE2JC0Ij8tgI=;
        b=GDbN5uiv98WI7qD4CkOILF84Ff7vggJNTOzZtuDulUsKY8F/3GUND9cJlcJ4WjorpH
         ArISA8XM/CpU4HCwCO7Za7k3gYp/Lvcl8rnwEyDbncYWaRpAWrJjGiYgnjNrw3vA5gWo
         qrdcUoF0bfGDdPJ+G3e9Qk0YFuJjPLOpveb8Y5pgB1anVgTO2c7TA7igN1bcfGnNEbeb
         tQ7dwC7o1MCKLKXFXnYXS6UpJ8cGJon2O0z1JwtGhsxRm0xa3yD5m+M8bPaNssFaBIfL
         dDgRaMD7o4NfXUSpTMOZKnOWW0Qd21O78DhPPMSdirUNwgvZ2j1oHqp0HGICLiUOZWVf
         GZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y9GFlVX6iZi5TB3ykNza+0McOKgu7mipE2JC0Ij8tgI=;
        b=j9FBd41lZDnHV1pcR23XDepSzQATC1nHsdlDE5qjqGLAQ+wli0O/zZeHNw+sDx5cHo
         R08x4tdBFFkVdU5xsDoJzV5mR5GlEdErEnulX2neQztO842LYaWoDGhZOIk3dJvsgvW1
         qs6mlXuts18UgIocWGh8GydF+hXA0+SWNi3W30LQEcj/EqN8MSXi5dEMCPIvIBaf43nd
         dTIDHVXtydlUx5gQxeyLd0U3Wf882ZCe8ehHAmvhwT0yRFPmPNrbZB5NIg6MpgeFARum
         cs4eb5rP4Z2FM9NnBa45bmaEWe2RNSSvd4JLcVhLM+Id9iBMLVdutIaGdhOOP7szXk0k
         z89A==
X-Gm-Message-State: AOAM533raK210qKPVrDoEW/MNrLxBgCkuHtueiMXY4sY0V36Lv7bdz6Z
        /LUF1nJu75Nnta8HVeowg2iKCpex
X-Google-Smtp-Source: ABdhPJy9dth36uK4+dZC8N+VYdLVpodxucDjb8UNAu7TaDNEKm/3OOUzkTpPHCqczJgr/N7obYsfYw==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr10720505edq.304.1590328702474;
        Sun, 24 May 2020 06:58:22 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:ed3c:ef0e:6f3d:f78f])
        by smtp.gmail.com with ESMTPSA id s19sm13371877eja.91.2020.05.24.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 06:58:21 -0700 (PDT)
Date:   Sun, 24 May 2020 15:58:20 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     GAURAV PATHAK <gauravpathak129@gmail.com>
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] Removing ununsed variable int lo, hi, int data and int i
 from comedi/drivers/dt2814.c.
Message-ID: <20200524135820.snuv3bffhctwndme@ltop.local>
References: <20200524113613.GA19734@xebrium.com>
 <20200524121044.fzpm6hkqrrpa2yhc@ltop.local>
 <20200524124919.GA6889@xebrium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524124919.GA6889@xebrium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 06:19:22PM +0530, GAURAV PATHAK wrote:
> Thanks a lot for your reply.
> I am trying to run sparse on drivers/staging directory,
> but I am not getting any useful warnings.
> Steps that I did:
> 
> - Referred https://www.kernel.org/doc/man-pages/linux-next.html to get
> linux-next latest tag next-20200522.
> - After that executed following commands:
> 	- make mrproper; make clean; make distclean
> 	- make defconfig
> 	- make menuconfig (Enabled all Staging Drivers with M)
> 	- make modules_prepare
> 	- make C=1 M=drivers/staging (Also tried individual directories
> 	  inside staging directory e.g. make C=1 M=drivers/staging/comedi/drivers)
> 
> I am not getting any warning, I have attached the output in text format.
> 
> Any pointers for finding warning using sparse in drivers/staging
> directory will be helpful. I really appretiate your guidance in this
> regard.

Well it seems that most staging drivers have no sparse warnings at all.
I only see somes in the following staging drivers:
	drivers/staging/isdn/
	drivers/staging/kpc2000/
	drivers/staging/uwb/
	drivers/staging/vc04_services/
	drivers/staging/wfx/
	drivers/staging/wusbcore/

Your commands seems to be good but I would advice you to use 'C=2'
instead of 'C=1' in order for sparse to effectively run on each
input file even when the corresponding .o file already exists.

The simplest to use is:
	- make allmodconfig
	- make -j8 drivers/staging/
This will just compile all the files without running sparse.
So all warnings will be from the compiler.
The you can run:
	- make C=2 drivers/staging/
which will only run sparse (and will thus be much faster).
 
Best regards,
-- Luc
