Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D58CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9A42074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX/4s00w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFBTMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:12:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD972C08C5C0;
        Tue,  2 Jun 2020 12:12:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so3520723pfa.12;
        Tue, 02 Jun 2020 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ayHSBL89oADO/PwCYurn7cKsNCUVfJaG7aadkGxIS2M=;
        b=KX/4s00wqsCpu/FgnSBwCGGkA9ZES2I1cX2Cz6SHYRXM3Csbh9r+Xbf3XYEdBSfNKa
         cYG4HS5yuCZxzREyCBhyF8BoDYyKQ05L2YkOKBbRTIjoiLKA/yh8WUxkJmGsNZPdik2S
         05xnJjXoKCPxexIT1bvhAnTSrYl1SG/8LXKPwCewqVffz/yEb46l1HZS4pwI5RQBGeSU
         sF0G9MBJ4S8NQdn3ND0/uOpCF0i+dY/cWE7uQBUy/kaxCz51JRPrM/ivrzWJigFlHCpl
         /+shCXje1venSxmstkRMkkh0Dg81BpKujhFXEj9CiRH3zCOvtFTEvozgYZ95aZwkubCO
         2TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ayHSBL89oADO/PwCYurn7cKsNCUVfJaG7aadkGxIS2M=;
        b=ACoY+UEc/ARejx3uBKc/jZysVO8/AYYEooYSW8nxGqkZj1sBMGPwJSzqmXRzkeRg75
         lDOiNoSUpN78xt3DFUgToYL1BLng+Iz43tZnEqEqF8TsBY9HyNcs0ZPnu677KLtRD06Y
         4s+b3tRrt1mlKCuMkcHHwmwne85PMOwnhPJAIM1IMrfazqtUYecskKAcfhnHFiUrZmiR
         zQHEoYNW8/KpvUhdW9ma3QdJaAqKiiZxIWvMwsJ/kETVxcuA43N5x/Gaavr6TQcOaXvh
         nH1XQE2jn2l+iv+T4ewB/oKiLE+xQXgaNsXeC+5uPAPGaDscfsLQyWSMF6zqKscgEfYk
         YcWw==
X-Gm-Message-State: AOAM531BAjJQRoMdNmGvyk/DsoOyuMIUz2fpz9/u/Gl9Spuo9AudTCqG
        +lfsZQPaH8Jl+oidZqymE+g=
X-Google-Smtp-Source: ABdhPJyl1DytaEO0LmW6Sn3n4PQpue8h/JOjvo0tkcDbfXvyUiQFK1DgetZ2r5pqwnYuig5CAbJBAQ==
X-Received: by 2002:a62:178b:: with SMTP id 133mr26048200pfx.238.1591125158337;
        Tue, 02 Jun 2020 12:12:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12sm3015442pjs.41.2020.06.02.12.12.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 12:12:37 -0700 (PDT)
Date:   Tue, 2 Jun 2020 12:12:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/76] 4.14.183-rc2 review
Message-ID: <20200602191236.GB203031@roeck-us.net>
References: <20200602101857.556161353@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602101857.556161353@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:23:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.183 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 407 pass: 407 fail: 0

Guenter
