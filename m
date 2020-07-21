Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD58C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254BB2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgrGhm+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgGULwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgGULwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:52:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD433C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:52:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so20813833wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YZopNL5/8ANY4qnCt9+wKywvq9+QBDbxQFIaGJPGSkU=;
        b=TgrGhm+v1Mg3jVuL3BVaIhy8BL4lZKWs1CJ5bFyF8NCqc/f9wNyORftQhIAIS+awPP
         lXfjUjWffFMBQ2bsP4cZY1Kvkw1IR7iTvP/AeVPsgUtQPuf/ew4WV66IVqGxg59czy1/
         0hK9NHIXNYTuW0pWAP/TbkSXMR7X1C+GnBPEeK5VP1a06mrAejxwDn7uvoHrW5qMXraU
         VM/Xx8uECxzqCY48+v4TYcTNadfgAyqfTTPPZXZpBR8Ty4ZeeetMqIq3iRLUZ1P/eT2i
         +/YN/KGYQ+p6Cv2VDBkyV0d4+mhKQMWnvCkYPI75nGeG2dpPF3ImzwWb8hq4rZiOYjiN
         etyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YZopNL5/8ANY4qnCt9+wKywvq9+QBDbxQFIaGJPGSkU=;
        b=OGxPzWrZ4uX5srRhFxavN38jL8v5Mh/p4IaUzx7LlhUhe0OsQAfO4lpiUEeUzkpvyM
         i95wh34orAiSkIOD18foXbmqcr4JYvbRCvFgEuJUt3dtd3rwiATnDzMSHFPzFvqlqQZM
         +Bd59J/snh4N89vdfqs3Vbzlyqz4kHx26KMAkzYa2t++kPVrndyG1I8PUSzoP5br5xeq
         4yytS06SELO4CGGsuuWNJXpoPlzUm/ieAawrBZo5gDI943v4YW7gVIn3O/6QXtH+OiSA
         XXq4I43Q3sOId8rqpWkElz3+d7z93tM6GGhLmUep2xAdHIL3YzlXbPOnIg8b/Ag1HU1C
         2v6Q==
X-Gm-Message-State: AOAM531OI+K482yBq/XgaGPcclz3IlkRgdUXhfDHB4LeYbS1o4ot0C9K
        uUGXTroNhQX79xN6L8qujm5Pww==
X-Google-Smtp-Source: ABdhPJzkuMo6BVRg+eIcLsNrunYrL7MrNDfMCxb56XFQ8NXNkSdiOirXEPWIr6xsfVjqdIMtGKLThA==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr13034598wrq.238.1595332368446;
        Tue, 21 Jul 2020 04:52:48 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id s203sm3250315wms.32.2020.07.21.04.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:52:47 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:52:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
Message-ID: <20200721115246.GE621928@dell>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
 <20200715093209.3165641-2-lee.jones@linaro.org>
 <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com>
 <87blk9p5ia.fsf@kernel.org>
 <5862f649-8058-7e39-cb43-2a4b09303333@synopsys.com>
 <875zahp0i0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zahp0i0.fsf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020, Felipe Balbi wrote:

> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
> 
> > Hi Felipe,
> >
> > On 7/21/2020 1:43 PM, Felipe Balbi wrote:
> >> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
> >> 
> >>> On 7/15/2020 1:32 PM, Lee Jones wrote:
> >>>> The value obtained from GINTSTS2 should be masked with the GINTMSK2
> >>>> value.  Looks like this has been broken since
> >>>> dwc2_gadget_wkup_alert_handler() was added back in 2018.
> >>>>
> >>>> Also fixes the following W=1 warning:
> >>>>
> >>>>    drivers/usb/dwc2/gadget.c: In function ‘dwc2_gadget_wkup_alert_handler’:
> >>>>    drivers/usb/dwc2/gadget.c:259:6: warning: variable ‘gintmsk2’ set but not used [-Wunused-but-set-variable]
> >>>>    259 | u32 gintmsk2;
> >>>>    | ^~~~~~~~
> >>>>
> >>>> Cc: Minas Harutyunyan <hminas@synopsys.com>
> >>>> Cc: Ben Dooks <ben@simtec.co.uk>
> >>>> Fixes: 187c5298a1229 ("usb: dwc2: gadget: Add handler for WkupAlert interrupt")
> >>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>>
> >>> Acked-by: Minas Harutyunyan <hminas@synopsys.com>
> >> 
> >> Should I apply the entire series or only 1/8?
> >> 
> > In this series only 2 patches are related to dwc2, which I'm already Acked:
> >
> > [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
> > [PATCH v2 2/8] usb: dwc2: gadget: Avoid pointless read of EP control 
> > register
> >
> > I can't acked other patches from this series, because they are not 
> > related to dwc2.
> 
> heh, I saw that after sending the email, sorry :-)

Also, all patches are already in -next, courtesy of Greg.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
