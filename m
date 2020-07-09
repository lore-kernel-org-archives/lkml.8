Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A05206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="WiAQr+CW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgGIJgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:36:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB9C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:36:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so1286274edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eygZbTdlFFJ71jCLfCgJ+FFK+a7qNbIVolSlOz1F8GM=;
        b=WiAQr+CWI7AR7BcmGBUGWjPFNscJqLLdx51nc0bGW2Zjlly/I7bVYJKiNQ5FIK42gQ
         ztKZ39/kOKalWkN6N32n9+XcKyY2/UZpc0fDuRm0PCCb/Qq39LkHNF83Q1ad+4KSpgiV
         LTgltQyaJIT9ryfmqIqBqoTOuXUkDuBlRZqCb4KIGN39bAlxO6AKe1pry724NX4dMW6E
         Thw3IS52wTv26/tNSpIZ2OhuwOSW2kWMybtNxYwUWn+l1g1ADjvnStvay3TcV2Q2XIJY
         genZjiQMJwXx7fw8+JQ5Xk/LKkC57jVNSW8/UQ/LfFzmgNF9SBYB6Z7JaKK9wrAlePEW
         xRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eygZbTdlFFJ71jCLfCgJ+FFK+a7qNbIVolSlOz1F8GM=;
        b=Igsp3P4Cy2Y0XQ0kTHX67j1HpmHS1u4SjhHqPqkQbkD1no4eRT6vLp4KwRWwGv7jq1
         Ggg6NzEetrPMN4MA5Ybvaxoj0toRBYMXt8K0qkwQCdMAjjArhsIdpnJBDivNmzTLQTRH
         9RmjoikLrS4+MOBUZk1NGATcPMYJnTpStamlt1hAJC+KKy/1djtj9frEvXD8PVHouiOc
         EmfZQ8Xno+YXTjJ6NKF3YEntlbcE3aWtQ5AOY70sZ25BH7AY127P1GlVR+ZMlnKBSf9R
         IFIR7SaDn1qU+TdZRwGm9jgIuWEnVM8oTUDunS9VtJbP4pcyM/zlsaEocEXJjMil82Vk
         Y/qg==
X-Gm-Message-State: AOAM530B9xlqDOntP1JXuMgUpKrS1oxLYU45aC6uVzfpw5HUTnbF8iOg
        vUO1W/+95sW5UmkiEHNCc3VDqsiLCR4G8sCktIDs8A==
X-Google-Smtp-Source: ABdhPJyBTmJWVm+jeRh/T397jZe1feymToc3uhaSUxFBG3KtVFCrNLA1lCw6fQ/UuGQVOizKlaB8ldlMBCqSg811i6s=
X-Received: by 2002:a05:6402:14c1:: with SMTP id f1mr73921180edx.342.1594287389229;
 Thu, 09 Jul 2020 02:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200708134613.131555-1-bsz@semihalf.com>
In-Reply-To: <20200708134613.131555-1-bsz@semihalf.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 9 Jul 2020 11:36:18 +0200
Message-ID: <CABLO=+kwtYKdEHNsYS13+=LgFZ3L7Snym-aBthxe=vOsjiPTbg@mail.gmail.com>
Subject: Re: [PATCH] thermal/int340x_thermal: Prevent page fault on
 .set_mode() op
To:     Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pandruvada Srinivas <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Alex Levin <levinale@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui, Matthew,

I think this regression should be corrected still in the 5.8 release
cycle. It may cause kernel panic if .set_mode() is called before
current_uuid_store(), and from what I see both operations can be
triggered from sysfs. What I'm not 100% sure about is if we should
apply the above fix, or rather revert the driver to its default
behaviour of using uuid=0 if it wasn't set from userspace (this is how
it was before Matthew's commit). What do you think?

Best regards,
Bartosz


On Wed, Jul 8, 2020 at 3:46 PM Bartosz Szczepanek <bsz@semihalf.com> wrote:
>
> Starting from commit "thermal/int340x_thermal: Don't require IDSP to
> exist", priv->current_uuid_index is initialized to -1. This value may
> be passed to int3400_thermal_run_osc() from int3400_thermal_set_mode,
> contributing to page fault when accessing int3400_thermal_uuids array
> at index -1.
>
> This commit adds a check on uuid value to int3400_thermal_run_osc.
>
> Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0b3a62655843..12448ccd27f1 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -216,11 +216,16 @@ static int int3400_thermal_run_osc(acpi_handle handle,
>         acpi_status status;
>         int result = 0;
>         struct acpi_osc_context context = {
> -               .uuid_str = int3400_thermal_uuids[uuid],
> +               .uuid_str = NULL,
>                 .rev = 1,
>                 .cap.length = 8,
>         };
>
> +       if (uuid < 0 || uuid >= INT3400_THERMAL_MAXIMUM_UUID)
> +               return -EINVAL;
> +
> +       context.uuid_str = int3400_thermal_uuids[uuid];
> +
>         buf[OSC_QUERY_DWORD] = 0;
>         buf[OSC_SUPPORT_DWORD] = enable;
>
> --
> 2.17.1
>
