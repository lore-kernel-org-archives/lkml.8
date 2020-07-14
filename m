Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CCC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF7A21835
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8RPlGi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGNItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgGNItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:49:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:49:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so4119570wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ilOUjshXCxjQTzuS0UozRdRI9NqrHTWmX92ctNaLA88=;
        b=m8RPlGi0J1Nh0hairX/5K3bldgpDaU68K9AbGbG6xA6UAa1DDCWD6fCR0AUfNFpMVn
         uImdCCAqZXPb1vWJJuWv/f07DvgI4jof37Wk877FhshhwWH5QtAEHxtlbypglxKD4/Zz
         StosouVRmYLsy476qAksBx9J6N9wt3Jw56rCXw+6iCmyI/VaCzb3fSPS25xmTbWJCqOv
         jybMwq+zBUqAOAJGS57JqQUvOtmst6ol53LJIfkMI6F1LeR0TAOZxEXTwGxY3V/6+CnR
         mH6ujEFjDhRjLfUbuGH22gWw5QrwDK4O/KK1jCY8EORxs5FIaqXHx/YwnhX6Lf4S9kl/
         WAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ilOUjshXCxjQTzuS0UozRdRI9NqrHTWmX92ctNaLA88=;
        b=XlulNdmjOofCE09I6G0QGDRlt/SkRAeT8iRvoF2lK+IF8iY8YyP4rF7ulcrqWspl8v
         W4dcbYJhfdKSlhjaaW7PCDCxfnjEY521W9+cPe0SoMbk+huVWxFLVvjThSePVSu9HS+g
         r/ma3hCIjCbZF7HUQ6ZeAdLeKWbCw99QVLrapP+2/xo062bvoa9zu/2Lgm+taDM0DE1e
         xsrep3FNsGMlegnl/asYcx4HZtQm4cEviBG3zyBYe0LyUaQDpwGF9Ko9Gg91mYK/TpKk
         MiTe+ugnL+rGLsdYLaewtkwTQdGSx0xVPbDWRS1s7vCmBvLCm8J1V+wfbYRHIuTCwBV8
         E+7g==
X-Gm-Message-State: AOAM532B28oAjHPij4Wptz+4G4HJFLbNpzcNqrYbcofcPrEvrEQVGGVU
        YQV8anNXS9yZ+Z/PjFEp/1+ktw==
X-Google-Smtp-Source: ABdhPJyoEREPlabEzuRVBXS1Sv7ykAK4/to1qWGQ/eI6JnC4XJgg6glZu+S/nYcpfFWaOxI/hVqrWw==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr3343846wme.102.1594716546678;
        Tue, 14 Jul 2020 01:49:06 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id z8sm3374460wmg.39.2020.07.14.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:49:06 -0700 (PDT)
Date:   Tue, 14 Jul 2020 09:49:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@kernel.org>, Linux GmbH <hare@suse.com>,
        "Leonard N. Zubkoff" <lnz@dandelion.com>
Subject: Re: [PATCH v2 15/24] scsi: myrs: Demote obvious misuse of kerneldoc
 to standard comment blocks
Message-ID: <20200714084904.GK3500@dell>
References: <20200713080001.128044-1-lee.jones@linaro.org>
 <20200713080001.128044-16-lee.jones@linaro.org>
 <270f544a-19ef-cf71-220c-54e349dc6bfc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <270f544a-19ef-cf71-220c-54e349dc6bfc@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Hannes Reinecke wrote:

> On 7/13/20 9:59 AM, Lee Jones wrote:
> > No attempt has been made to document any of the demoted functions here.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/scsi/myrs.c:94: warning: Function parameter or member 'cmd_blk' not described in 'myrs_reset_cmd'
> >  drivers/scsi/myrs.c:105: warning: Function parameter or member 'cs' not described in 'myrs_qcmd'
> >  drivers/scsi/myrs.c:105: warning: Function parameter or member 'cmd_blk' not described in 'myrs_qcmd'
> >  drivers/scsi/myrs.c:130: warning: Function parameter or member 'cs' not described in 'myrs_exec_cmd'
> >  drivers/scsi/myrs.c:130: warning: Function parameter or member 'cmd_blk' not described in 'myrs_exec_cmd'
> >  drivers/scsi/myrs.c:149: warning: Function parameter or member 'cs' not described in 'myrs_report_progress'
> >  drivers/scsi/myrs.c:149: warning: Function parameter or member 'ldev_num' not described in 'myrs_report_progress'
> >  drivers/scsi/myrs.c:149: warning: Function parameter or member 'msg' not described in 'myrs_report_progress'
> >  drivers/scsi/myrs.c:149: warning: Function parameter or member 'blocks' not described in 'myrs_report_progress'
> >  drivers/scsi/myrs.c:149: warning: Function parameter or member 'size' not described in 'myrs_report_progress'
> >  drivers/scsi/myrs.c:160: warning: Function parameter or member 'cs' not described in 'myrs_get_ctlr_info'
> >  drivers/scsi/myrs.c:222: warning: Function parameter or member 'cs' not described in 'myrs_get_ldev_info'
> >  drivers/scsi/myrs.c:222: warning: Function parameter or member 'ldev_num' not described in 'myrs_get_ldev_info'
> >  drivers/scsi/myrs.c:222: warning: Function parameter or member 'ldev_info' not described in 'myrs_get_ldev_info'
> >  drivers/scsi/myrs.c:310: warning: Function parameter or member 'cs' not described in 'myrs_get_pdev_info'
> >  drivers/scsi/myrs.c:310: warning: Function parameter or member 'channel' not described in 'myrs_get_pdev_info'
> >  drivers/scsi/myrs.c:310: warning: Function parameter or member 'target' not described in 'myrs_get_pdev_info'
> >  drivers/scsi/myrs.c:310: warning: Function parameter or member 'lun' not described in 'myrs_get_pdev_info'
> >  drivers/scsi/myrs.c:310: warning: Function parameter or member 'pdev_info' not described in 'myrs_get_pdev_info'
> >  drivers/scsi/myrs.c:353: warning: Function parameter or member 'cs' not described in 'myrs_dev_op'
> >  drivers/scsi/myrs.c:353: warning: Function parameter or member 'opcode' not described in 'myrs_dev_op'
> >  drivers/scsi/myrs.c:353: warning: Function parameter or member 'opdev' not described in 'myrs_dev_op'
> >  drivers/scsi/myrs.c:379: warning: Function parameter or member 'cs' not described in 'myrs_translate_pdev'
> >  drivers/scsi/myrs.c:379: warning: Function parameter or member 'channel' not described in 'myrs_translate_pdev'
> >  drivers/scsi/myrs.c:379: warning: Function parameter or member 'target' not described in 'myrs_translate_pdev'
> >  drivers/scsi/myrs.c:379: warning: Function parameter or member 'lun' not described in 'myrs_translate_pdev'
> >  drivers/scsi/myrs.c:379: warning: Function parameter or member 'devmap' not described in 'myrs_translate_pdev'
> >  drivers/scsi/myrs.c:422: warning: Function parameter or member 'cs' not described in 'myrs_get_event'
> >  drivers/scsi/myrs.c:422: warning: Function parameter or member 'event_num' not described in 'myrs_get_event'
> >  drivers/scsi/myrs.c:422: warning: Function parameter or member 'event_buf' not described in 'myrs_get_event'
> >  drivers/scsi/myrs.c:484: warning: Function parameter or member 'cs' not described in 'myrs_enable_mmio_mbox'
> >  drivers/scsi/myrs.c:484: warning: Function parameter or member 'enable_mbox_fn' not described in 'myrs_enable_mmio_mbox'
> >  drivers/scsi/myrs.c:584: warning: Function parameter or member 'cs' not described in 'myrs_get_config'
> >  drivers/scsi/myrs.c:688: warning: cannot understand function prototype: 'struct '
> >  drivers/scsi/myrs.c:1967: warning: Function parameter or member 'dev' not described in 'myrs_is_raid'
> >  drivers/scsi/myrs.c:1980: warning: Function parameter or member 'dev' not described in 'myrs_get_resync'
> >  drivers/scsi/myrs.c:2005: warning: Function parameter or member 'dev' not described in 'myrs_get_state'
> >  drivers/scsi/myrs.c:2343: warning: bad line:   the Error Status Register when the driver performs the BIOS handshaking.
> >  drivers/scsi/myrs.c:2344: warning: bad line:   It returns true for fatal errors and false otherwise.
> >  drivers/scsi/myrs.c:2349: warning: Function parameter or member 'cs' not described in 'myrs_err_status'
> >  drivers/scsi/myrs.c:2349: warning: Function parameter or member 'status' not described in 'myrs_err_status'
> >  drivers/scsi/myrs.c:2349: warning: Function parameter or member 'parm0' not described in 'myrs_err_status'
> >  drivers/scsi/myrs.c:2349: warning: Function parameter or member 'parm1' not described in 'myrs_err_status'
> > 
> > Cc: Hannes Reinecke <hare@kernel.org>
> > Cc: Linux GmbH <hare@suse.com>
> 
> Please, do fix your mailer/script.
> This is my company e-mail address, but my name is actually the same even
> when working for the company ...

I think it's the file that needs fixing.

If you're adamant that the formatting in the file should be accepted
then perhaps amend get_maintainer.pl instead.

To get those lines, I run:

 ./scripts/get_maintainer.pl --file-emails --git-min-percent 75 -f drivers/scsi/myrs.c

> > Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/scsi/myrs.c | 34 +++++++++++++++++-----------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> > 
> I had been wanting to convert this to proper kernel-doc style, but never
> found the time to actually do it.
> So this will serve for now.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Thanks for all your reviews.  Much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
