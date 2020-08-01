Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E94AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B6E206F6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkYuhgec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgHALqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgHALqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 07:46:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8CAC06174A;
        Sat,  1 Aug 2020 04:46:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lx9so9003275pjb.2;
        Sat, 01 Aug 2020 04:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqwMdEfXUJjeMpYuVIJT0vSfY1n0L5nS06aKjQVfgw8=;
        b=gkYuhgecj9jw06Z7ftjDxYkoeGW/yyUGv1Z6ZEJRNlImdR2SvO8/Rn7Rn8TmmjD+nG
         xJnUwjJfEEZTK6AGkyWARchEk6fSIwSggPnxrDTDLO6cJ3gK5gEWc+VeXmXWmg/BtNP9
         Za8+1SiDav6/QumX5bX5rCXc2FswTBazPsToR+ndGB6MiCyk8txIyLnrMlr0xNhDIYRl
         8UGJhp/7YdXJteEGRge8k3CSq+n/NWveeiokwYtNqupim092TDkfObb71ehXs1NckJ18
         8GC+PcjCUq+myur3bv4NEIfBMEXkP1VyqunHiOB3iTDQ7kux4FsDXeTmnJLvYZsic26q
         uZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqwMdEfXUJjeMpYuVIJT0vSfY1n0L5nS06aKjQVfgw8=;
        b=MQmLkaz+Tt2yFIueQ/v6cGs7sDHFVKidF1WyUe3eDvjCeow+QWtBPEy2dge17JzPA+
         mC5p4iWVgodfUE8mXFi2gQ9yiZPP7WuLzlx2Mzv2Vw0Vx1lbYfcncG0FMb/I3Fmu8Ke0
         sIz8j0D9FtR/76rNcwLIIKR/uUGdL8bN39+CjJ4UFG/JO8ftU1I1V8xuNMlq7Wr/sE0w
         GFCg++gg8a5Lp1eNpYSaC+E/4jUNGLnenwrRHHSrve+QRZ8Vk5rMOI/e26jAr47Nx74R
         +KA6kj2bPV50RBPDgSCTaFSJE26tcbM4u19vRy7r+SawCoLB8HCn6jzRFbXcTFYR8KuF
         3nWQ==
X-Gm-Message-State: AOAM532mB/A9iEAtlntrLDNgF3mzCxO9+o+gHhfcaa1YR0jVbFwtC0xk
        2HmXSMyKg4nzmyBiJvAvFHrRVJkCmrmkzl+9XAr3QNSM
X-Google-Smtp-Source: ABdhPJxZPnbnEuhSbOVm0PHNhVFTbdDVwSsxfaBBP5Foa802NDOKsHBcXYeXjdoTLAM8Lgoo6by+i9c7SoEH2XHbUeE=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr8564857pjp.228.1596282373694;
 Sat, 01 Aug 2020 04:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <202008011649.b8CEYWIz%lkp@intel.com> <20200801083654.GA31368@144836a6079b>
In-Reply-To: <20200801083654.GA31368@144836a6079b>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 Aug 2020 14:45:57 +0300
Message-ID: <CAHp75VcCa4whJ7ry9uU+14suLbGPvKgRFJku3dC+dPVNzc0d5Q@mail.gmail.com>
Subject: Re: [RFC PATCH linux-next] platform/x86: thinkpad_acpi:
 dev_attr_charge_start_threshold can be static
To:     kernel test robot <lkp@intel.com>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 11:38 AM kernel test robot <lkp@intel.com> wrote:

Thanks and sorry folks, Hulk robot was faster, and TBH their patch
looks much better (proper commit message applied). Perhaps something
LKP should work on?

> Fixes: e33929537b76 ("platform/x86: thinkpad_acpi: use standard charge control attribute names")
> Signed-off-by: kernel test robot <lkp@intel.com>


-- 
With Best Regards,
Andy Shevchenko
