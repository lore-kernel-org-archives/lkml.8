Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1912BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E721F207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqW79A56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgFDPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgFDPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:30:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA1C08C5C0;
        Thu,  4 Jun 2020 08:30:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so1267751pjb.1;
        Thu, 04 Jun 2020 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=05vmOo/sEpxMWFEEii+qy1RpdqnFhqBY0D+z2U4qyKA=;
        b=qqW79A56q2GGzmKpYXMGrh7FM7BaCoPv2cQIRcxRZX35FWfWV6KoJIUGSIQ9SvrlvX
         S8qeA58q0vvqPLTHEbc6dH9dA9c7pydCJ9S2QTSRcX2NYFLyPDvzOtOpuuIwESrTj4uI
         lr3+12ok85R2j4ryJKPQQK2OFJcjlmNGdItyDDgonJU9qz+VrP2myXB9aAdaZBEpnbme
         77TYnFC8+j1rm83692wBWYTeBo6NpALTwv9TWVqQyciCyrQnFX7/8XS56CB1n55av4xo
         fxAgJPLFdKFE7TdOjBpOa0L3iROOVBeADtDrDKq0mJZiiwlQwVuaD9dxhtXUm87wsxny
         acmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=05vmOo/sEpxMWFEEii+qy1RpdqnFhqBY0D+z2U4qyKA=;
        b=saYk5jf87HZE+hQQ6x/SAFGchCjUkwwZE5GUa40a25A+QwKiNxSr6x5xL3pQGRzLOy
         HhILebcmupWoRUHbY9oa5PTC5GF8zFiaF6zeJGckJsK1+16ZnqPgwGmXARKZv25rutlo
         QRupQV6bvrlW076y2gY2z14Vd4flauI5QFWujVNrBGt/e/0LYwanNKvnoz3v8oVLjVDQ
         mJbJtFzXGaNY0skLqr+W3pLuUL/By0WvwqkE/+10x2jy0KF2gFI9xiY6DOuICc3BPNS9
         E2r20REEMr2TKhpF2UiYACauBQ0qyLwkEU1SFs/kiPFX5iI58jg4FZa8igWuGzu2+wRR
         cybQ==
X-Gm-Message-State: AOAM530gCNyYvZnNvfGPUq+F3G1yk94QfBwVP7t4FwVQtEWklNvI573Q
        tH8/00ehyckBUEs0jJACPkc=
X-Google-Smtp-Source: ABdhPJzawl5RAjmhHCgxaSs9Q6RhpN+ZaoU9HI1IIe3V4VgaXcf4xOjfx+bIOMRaqk47vfDMR63eHA==
X-Received: by 2002:a17:90a:e98e:: with SMTP id v14mr7055585pjy.70.1591284646395;
        Thu, 04 Jun 2020 08:30:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm4230538pgl.4.2020.06.04.08.30.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 08:30:45 -0700 (PDT)
Date:   Thu, 4 Jun 2020 08:30:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: bt1-pvt: Define Temp- and Volt-to-N poly as
 maybe-unused
Message-ID: <20200604153043.GA185160@roeck-us.net>
References: <20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru>
 <20200603000753.391-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603000753.391-1-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:07:53AM +0300, Serge Semin wrote:
> Clang-based kernel building with W=1 warns that some static const
> variables are unused:
> 
> drivers/hwmon/bt1-pvt.c:67:30: warning: unused variable 'poly_temp_to_N' [-Wunused-const-variable]
> static const struct pvt_poly poly_temp_to_N = {
>                              ^
> drivers/hwmon/bt1-pvt.c:99:30: warning: unused variable 'poly_volt_to_N' [-Wunused-const-variable]
> static const struct pvt_poly poly_volt_to_N = {
>                              ^
> 
> Indeed these polynomials are utilized only when the PVT sensor alarms are
> enabled. In that case they are used to convert the temperature and
> voltage alarm limits from normal quantities (Volts and degree Celsius) to
> the sensor data representation N = [0, 1023]. Otherwise when alarms are
> disabled the driver only does the detected data conversion to the human
> readable form and doesn't need that polynomials defined. So let's mark the
> Temp-to-N and Volt-to-N polynomials with __maybe_unused attribute.
> 
> Note gcc with W=1 doesn't notice the problem.
> 
> Fixes: 87976ce2825d ("hwmon: Add Baikal-T1 PVT sensor driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>

Applied.

Thanks,
Guenter

> ---
> 
> Link: https://lore.kernel.org/linux-hwmon/20200602091219.24404-1-Sergey.Semin@baikalelectronics.ru
> Changelog v2:
> - Repalce if-defs with __maybe_unused attribute.
> ---
>  drivers/hwmon/bt1-pvt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
> index 1a9772fb1f73..8709b3f54086 100644
> --- a/drivers/hwmon/bt1-pvt.c
> +++ b/drivers/hwmon/bt1-pvt.c
> @@ -64,7 +64,7 @@ static const struct pvt_sensor_info pvt_info[] = {
>   *     48380,
>   * where T = [-48380, 147438] mC and N = [0, 1023].
>   */
> -static const struct pvt_poly poly_temp_to_N = {
> +static const struct pvt_poly __maybe_unused poly_temp_to_N = {
>  	.total_divider = 10000,
>  	.terms = {
>  		{4, 18322, 10000, 10000},
> @@ -96,7 +96,7 @@ static const struct pvt_poly poly_N_to_temp = {
>   * N = (18658e-3*V - 11572) / 10,
>   * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
>   */
> -static const struct pvt_poly poly_volt_to_N = {
> +static const struct pvt_poly __maybe_unused poly_volt_to_N = {
>  	.total_divider = 10,
>  	.terms = {
>  		{1, 18658, 1000, 1},
