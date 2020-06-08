Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AC3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFCC20656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFHD6q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:58:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgFHD6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:58:46 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ji8vr-0002AL-Gj
        for linux-kernel@vger.kernel.org; Mon, 08 Jun 2020 03:58:43 +0000
Received: by mail-pg1-f197.google.com with SMTP id r2so12191050pgd.23
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 20:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tj+9pNE+Q2v5clApLNj9Rlp1lFSTcFwVdQZwuoFq8p4=;
        b=K2pfOMuysd4Z4WBR5kB7S065SKuMbEvSOTRHVUkuW3vzE5e/3TxSyMiB1oLVGa/H/Z
         ha5cAcyTSLrscXvQ9v5avBDScVWYDWKCIJtk83IhF5LQZcMEL/tlry/ws1LMuZuD5vjU
         0IcYKzrQAW/6zS1Nz6E1gGkP8zUPMO2/ze8l5bN7t+DBr++DlX+CvLI3iE+cqMNAkPvP
         MldodwlxA7IvklVUPHf5V8xm2PTVy2+aF7LBN1YtmSf50SS189GPZx3rcfiogZ39QS5j
         F/Ag2NjykJxpsU1L8zJekzOZpF40Yt8TmyGdAPuP/u02av09qK41kasxWKKCxfXYXUDs
         S4RQ==
X-Gm-Message-State: AOAM532NwjVKDDr4NYHRhoccb3iLtUiDfU+WgroMdqRIe/QgB6pCGzBt
        tURVCGLWU+TUfCt6owxDQWPxFW+1nyCIX9t19nEptBv3sZ4+6QskAUMgaTfD4dkweBTO3Bw8/tu
        PKQQPd2XhimkmBjZnx8yfrHxP4p7rINw9kJlwe1INLg==
X-Received: by 2002:a05:6a00:1511:: with SMTP id q17mr19946030pfu.16.1591588722147;
        Sun, 07 Jun 2020 20:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt04qdGld5AF7zj0Jzq+hkvSNU6ssr7Qw+vLqRRg4hfD9qrQnlvnpRCvY36cXJq1TuN4pSvw==
X-Received: by 2002:a05:6a00:1511:: with SMTP id q17mr19946019pfu.16.1591588721720;
        Sun, 07 Jun 2020 20:58:41 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id mw5sm15018161pjb.27.2020.06.07.20.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 20:58:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] xhci: Poll for U0 after disabling USB2 LPM
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200520101811.2623-2-kai.heng.feng@canonical.com>
Date:   Mon, 8 Jun 2020 11:58:40 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EF6B47D0-973E-46B7-9194-C58389FFAB35@canonical.com>
References: <20200520101811.2623-1-kai.heng.feng@canonical.com>
 <20200520101811.2623-2-kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 20, 2020, at 18:18, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> USB2 devices with LPM enabled may interrupt the system suspend:
> [  932.510475] usb 1-7: usb suspend, wakeup 0
> [  932.510549] hub 1-0:1.0: hub_suspend
> [  932.510581] usb usb1: bus suspend, wakeup 0
> [  932.510590] xhci_hcd 0000:00:14.0: port 9 not suspended
> [  932.510593] xhci_hcd 0000:00:14.0: port 8 not suspended
> ..
> [  932.520323] xhci_hcd 0000:00:14.0: Port change event, 1-7, id 7, portsc: 0x400e03
> ..
> [  932.591405] PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
> [  932.591414] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -16
> [  932.591418] PM: Device 0000:00:14.0 failed to suspend async: error -16
> 
> During system suspend, USB core will let HC suspends the device if it
> doesn't have remote wakeup enabled and doesn't have any children.
> However, from the log above we can see that the usb 1-7 doesn't get bus
> suspended due to not in U0. After a while the port finished U2 -> U0
> transition, interrupts the suspend process.
> 
> The observation is that after disabling LPM, port doesn't transit to U0
> immediately and can linger in U2. xHCI spec 4.23.5.2 states that the
> maximum exit latency for USB2 LPM should be BESL + 10us. The BESL for
> the affected device is advertised as 400us, which is still not enough
> based on my testing result.
> 
> So let's use the maximum permitted latency, 10000, to poll for U0
> status to solve the issue.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> drivers/usb/host/xhci.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 14181a7ea375..1058f604975b 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4474,6 +4474,9 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
> 			mutex_lock(hcd->bandwidth_mutex);
> 			xhci_change_max_exit_latency(xhci, udev, 0);
> 			mutex_unlock(hcd->bandwidth_mutex);
> +			readl_poll_timeout(ports[port_num]->addr, pm_val,
> +					   (pm_val & PORT_PLS_MASK) == XDEV_U0,
> +					   100, 10000);
> 			return 0;
> 		}
> 	}
> -- 
> 2.17.1
> 

