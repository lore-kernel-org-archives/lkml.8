Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E43C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C820757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gB9z3S6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbgDBRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:25:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33938 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgDBRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:25:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so4310287otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmdhmlzF1awyNvgI8DSIF40xEnxKcPlPBIva59dgFRc=;
        b=gB9z3S6U8yPzVvzHJqOYA+/pgRoORRtIeBPmqtTNy2Im5pkDobU/hyg0SWw5n/CkZg
         bdv3Epc67zhDaNsJKk94F59sFCCjo5nXJAYHDmPcaVcwA1t3zA/1cjSJKsoukTyEYh4H
         yOhfAxRYkhXROdlOCqT9QDi5hSi7zFg2CAkq0zaJoCHtBBw4YWBvkqR/o8QsKrBiicAB
         YpAQUZwukGF+Mx98hiEqJ1LrqZBuc2Ueqd/LSjU3spfVKTkcq4WBCz+Nd7gqLSI6LK0e
         ZJYRn6opAIP+nz8LUqCdjI4D0m1lF1gObX+zf/VRrH+mj94gU6qFRYtoarRtVsisA8aP
         5UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmdhmlzF1awyNvgI8DSIF40xEnxKcPlPBIva59dgFRc=;
        b=SaFIKeCEZnnyYgFIaSvgVRMqojF9n20o19fxemy8VlQRkT47ZKhv7L7L6hSUh7N4nr
         cZ8NpDW430a4RyhnBkoHE4LsKSQkno0r+YZFGo00wYGItawZ951gaWqJYUKM1yLZWP5z
         Tlw53AelYmXTc9dNrvJd/ze/HlOKPxsas0d7cEB9KnOOFUS1oHqUme+fPTtqFiKlGVSX
         r7eP7/8UseRSr8PF5+ixZFStnGalBz6KoVgj4+e5BFd0TDBSMpAKmb87e7AxTrxCYN1x
         t9JCwtwgruH2qp+nAV6yRZWtSObRKgT1WseVXMHLUwJ4SSkkinUphHQ6CnIM4BA2Rcrg
         tGaQ==
X-Gm-Message-State: AGi0PuYxnjPVp+qXgbXd733mSkQVrLtoI5WGNeR+kgt7YeEMODHkTiXI
        uVUKDp8+z75tJDCL6C8gZsAI50dQ7szF0/XT+J20v2jmZ4E=
X-Google-Smtp-Source: APiQypLanmT1yHgkvL9VMdPGJyPqdbGag32XXaBkghgppBRQanGxtbbuBPenVD5CjGuiuzBeknvhcPnGmgNJSFPJ6gw=
X-Received: by 2002:a9d:344:: with SMTP id 62mr3486852otv.102.1585848316842;
 Thu, 02 Apr 2020 10:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Apr 2020 10:25:05 -0700
Message-ID: <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if CONFIG_MODULES=y?
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 3:17 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> I found an issue after applied the following patches:
> ---
> 64c775f driver core: Rename deferred_probe_timeout and make it global
> 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
> c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
> ---
>
> Before these patches, on my environment [1], some device drivers
> which has iommus property output the following message when probing:
>
> [    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
> [    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
>
> So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.
>
> However, after these patches are applied, since the patches are always waiting for 30 seconds
> for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
> Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
> JFYI, I copied the kernel log to the end of this email.

Hey,
  Terribly sorry for the trouble. So as Robin mentioned I have a patch
to remove the WARN messages, but I'm a bit more concerned about why
after the 30 second delay, the ethernet driver loads:
  [   36.218666] ravb e6800000.ethernet eth0: Base address at
0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
but NFS fails.

Is it just that the 30 second delay is too long and NFS gives up?

Does booting with deferred_probe_timeout=0 work?

thanks
-john
