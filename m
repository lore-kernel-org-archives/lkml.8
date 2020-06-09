Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F64C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2F02072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="z+8b5Aw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgFIOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgFIOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:45:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53B4C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:45:37 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x202so18946299oix.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qjLlhlbq20TF9w4Fo/M8ySKfJ7eojkDP5aGVWyOb9E=;
        b=z+8b5Aw4ReeJD8+ObpGHGXPUhGsTR0gr5SV7FLXc+P6XyTivIvbKYbXn2iGa4306Xy
         xFY5A1sUjgYUM2qSuzyb6/WrbfEeLEIjrD3WFyGO56S6WTB0CYRWbUfgIPqzPtlV1Dz+
         6K0+QjFjDhw/1pCCXZpNi42Y7G8cTigM9qpKj2Yp2zkqnbsEN9RGtlB5EP/3KK20AnSb
         XjZwLcohX2VShXTqRdmqw2AG1mzi1Cfk64FCIP+NRSIspVtr4HWH1ecomZCgqvr8Mu03
         k2P6oYmAHZ7LwqTUF4Rrow3mFI6CffGN4KUzwiq5pmXZQtKlJllUtaSWEkFBspsb3PD2
         XYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qjLlhlbq20TF9w4Fo/M8ySKfJ7eojkDP5aGVWyOb9E=;
        b=OziMsVNDLOM6N6or8vZzsGFV0EyrcntQ6SA3FMvbZmyqQxWvFC+QcznKA2g3EHBcVY
         nc+YWsqqD44AkBPeFwY1hRwJJF939F2tjKg2BI4W7NyQejZrYbrd3s3VEjNSfpDw7hFW
         enx1QciRoGa0xr9VnRLRPCtPsbFrjhQIJmlJi8sGftqOM4nA7hDAwJUUdBL+iAKEUfr4
         uMi+tX4+HW4WPsjSN8EDOsAlVdieGmfRqkTh4VhA5xVb7eZ6dJ/EoV5B1IhrMa+XOfGd
         kB7UQNnVIrHW6mKsezpceO3Qwu2sKpmsHItSuCimGZSqU3YZq0yf9M7mVa4NTQSkZNlC
         sJlQ==
X-Gm-Message-State: AOAM533tbPQHY/559z8DnMce7M0m1G9JDcq+JoDJD+0mslzXcUaeXVYJ
        LiRY6WaaNYK3sI02jPuoz1imMj+J9zh/fgQI9YoemA==
X-Google-Smtp-Source: ABdhPJzQvo0oNgTTh3O9V6qB7+EiOf+sDca48St6UCVl/1HYUyiYmK4ibHrd6RbILNWCIvob0QRF+qZoblwM9pe02js=
X-Received: by 2002:aca:a8c3:: with SMTP id r186mr3699932oie.173.1591713936880;
 Tue, 09 Jun 2020 07:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200503201823.531757-1-robert.marko@sartura.hr>
 <20200503201823.531757-3-robert.marko@sartura.hr> <20200504073914.GQ1375924@vkoul-mobl>
 <CA+HBbNEiB+o4KxonAu4-ra+P11Yb649v6AFaPjFc8JQDQ8T=CA@mail.gmail.com>
In-Reply-To: <CA+HBbNEiB+o4KxonAu4-ra+P11Yb649v6AFaPjFc8JQDQ8T=CA@mail.gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 9 Jun 2020 16:45:25 +0200
Message-ID: <CA+HBbNFsZ-v_2cMhDNGnQXTFaqsjGzB+1rAS3=_CLQhd0N4OKQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] ARM: dts: qcom: ipq4019: add USB devicetree nodes
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
Vinod can you maybe pick this?

It would be great to have nodes in 5.8 along the driver

Thank
Robert

On Fri, May 29, 2020 at 11:36 AM Robert Marko <robert.marko@sartura.hr> wrote:
>
> On Mon, May 4, 2020 at 9:39 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 03-05-20, 22:18, Robert Marko wrote:
> > > From: John Crispin <john@phrozen.org>
> > >
> > > Since we now have driver for the USB PHY, lets add the necessary nodes to DTSI.
> >
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> >
> > Bjorn, I have picked the phy and dt binding, feel free to apply this one
> >
> > Thanks
> > --
> > ~Vinod
>
> Any chance of this landing into 5.7?
> Driver and bindings have been merged, but I don't see DT nodes queued.
>
> Regards,
> Robert
