Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9E120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyxAnSS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgGHMYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgGHMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:24:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B1C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:24:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so20774486wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=97VfHsgIp7KhjWa+D1IWNHjJmL249LG9J/M4ICSR0Bw=;
        b=XyxAnSS5mthy0OsfSBahMg7jgXMrn1ZqGVx1kRIGme4YC3McYyORgsqgLWn0oUNkfi
         1yqy2XqmlljOD+fxhwIUEQD+CdwMIm6c3+CMOgE1hX8duVwnl2D25Mfs5yfjdzsohmCG
         fvRdecD5s7lYrtm96BvZYxb6lDHg4T3/R1XU5lePRK07fmR21M+fpXC6dYxV9HutKV84
         7x3/PK94WBT4qRaq95jMZRs7lfkDCfLVxx0QJDj2NfexCIMpsvfse0QCdKsAb05N4BfN
         DOv4E1bR0OFjkGwh1s2gfjSLxbYuYuyiTx4du35ZYbLX5zqyT1uTRZNwCcSWR2uMxfi5
         kxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=97VfHsgIp7KhjWa+D1IWNHjJmL249LG9J/M4ICSR0Bw=;
        b=KvPwYo11uOAa/qkQ70NwfmCh8eYaKFAvHwoRC3h4prYOkeh5/PKk1wchbIczAnhd61
         qe5sR8mftEAD2PpHw0BJJQ25sBkfq6SMeV1Ha0zeQ7PDB811kK1maLTH6ZmBI3pOOfJA
         1Ir61Tk75zaXJCvaRBdwH8XNhkVo6NyZ8M4AcM2aHXYQ7ZaWHHZ3monZDHLLhXFGZh1v
         Jf9AELw2ulJudFfE90QGtZvgZFhrp7yAEGBpwZ0UmpvAC4MgINjrzkDI+X/n23lm0Clg
         O49UzcrlnM29XShp3LFOz+3qbX2BJisVkhZBz0pqU0y5Z1Wa6w1pEqIQfZMslmXvaJQw
         P/8A==
X-Gm-Message-State: AOAM531HghFISG4p0zRmpaSDc7TxwSBNW5nZWn4IoCLG0BqEdn4VY68u
        pu5Qkg06uZ5PQPbpBcZTY/r6DA==
X-Google-Smtp-Source: ABdhPJxvv/c3pOwA7JsoApJ2PsVmDxXKecm2gQ0zz2JR+mQJ6vd5IdR26gTGrIJn6qmdp1Yec4Or3Q==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr57165108wrx.26.1594211041901;
        Wed, 08 Jul 2020 05:24:01 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id a123sm6257963wmd.28.2020.07.08.05.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:24:01 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:23:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 11/30] scsi: libfc: fc_rport: Fix a couple of
 misdocumented function parameters
Message-ID: <20200708122359.GT3500@dell>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
 <20200708120221.3386672-12-lee.jones@linaro.org>
 <SN4PR0401MB3598867C90BF92465D26F1449B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB3598867C90BF92465D26F1449B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Johannes Thumshirn wrote:

> On 08/07/2020 14:04, Lee Jones wrote:
> > @@ -1445,7 +1445,7 @@ static void fc_rport_recv_rtv_req(struct fc_rport_priv *rdata,
> >   * fc_rport_logo_resp() - Handler for logout (LOGO) responses
> >   * @sp:	       The sequence the LOGO was on
> >   * @fp:	       The LOGO response frame
> > - * @lport_arg: The local port
> > + * @rport_arg: The local port
> >   */
> >  static void fc_rport_logo_resp(struct fc_seq *sp, struct fc_frame *fp,
> >  			       void *rdata_arg)
> 
> That doesn't look correct, s/rport_arg/rdata_arg/ and an rport is a remote port not a local port.

That's interesting.  Looks like I fixed this later in the set.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
