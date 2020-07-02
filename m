Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D85520772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dOC6J1Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGBVJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBVJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:09:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8FC08C5C1;
        Thu,  2 Jul 2020 14:09:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e15so25464267edr.2;
        Thu, 02 Jul 2020 14:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EkunRhJM+IkygFCZmaALMwwKbp/kSgWlsm+guHw4JbU=;
        b=dOC6J1VcHKL5h0ZDOdlDfP/efShY2nX4Vy+8HFAKynlK3ugprnrqloghR9FDWGiORY
         A43Ts1yJWRvMTyx0BXYPG4XiGCMToub9kNfstS3LXLqKCBm/JRxgeGJJJ7wlzUSoSY5/
         PpP4CGZaM8HNXIsQrJF3CJCqPqwt2hyG+CDu5oWJ0uFXPkfC8mjF1uJeXtOzLqo+wUzQ
         yBxbIye8KQ7wYm4EqiOnZfP+2R2pv56lkFlt18tQgzbPOGJr+5P6YM7e70+scy3+q0mI
         8VTmx5oUpPRmo/tVjZhYbwufG2hE8HH6EcJb3uZ1hsD3S4HHvw0/PIx8DzISMUYIUtsT
         Unag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EkunRhJM+IkygFCZmaALMwwKbp/kSgWlsm+guHw4JbU=;
        b=D+6seRdzUspY9H2uWAeOPy+BTL3tgDaidx1Ew8xIdUo4aA3Pb7NGO14rwNVrXDh55f
         UDZTvg8HQKBSUOt55hBIzrqD+xUR1mi5B0X/25TLWJvwG55+4oCnyROIn5mbAzVR8D6s
         fL+EmePuFfGB7sssidbh6sYfDDq0VmT/yjkmnhA0cWS/Kpt7fDz8tO8MVZunyPCksOx8
         zhEm1rb739qZ5NAoL3EZGKi4llH24045ZNPCsmebXvtHszgef974Emha1Cy9WdJRIjpc
         bSnLfkSvI20zlVg/QDBYXT0gW1Uwc6g/rdtJ7HftLvjcFALoNG6jX2g6m1vW7QCEPEfo
         x8Gg==
X-Gm-Message-State: AOAM531uiMlxkEWblubxrNQjeatiWwFI6Mvxge8jThWXcQXZmgDlxSnL
        lUEKLk4B3ke/f8hkGf50GsR9iFLd
X-Google-Smtp-Source: ABdhPJyeWSXeYCuVNmTy9igyqXsTXNocb94mp7qBR8VLY897EGH+9Swx9Y4YSmQBYLvePnPP9W8czw==
X-Received: by 2002:a50:b0a1:: with SMTP id j30mr37051783edd.387.1593724182913;
        Thu, 02 Jul 2020 14:09:42 -0700 (PDT)
Received: from ?IPv6:2a02:8070:bb9:bc00::fc? ([2a02:8070:bb9:bc00::fc])
        by smtp.gmail.com with ESMTPSA id p20sm7663314ejy.107.2020.07.02.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 14:09:42 -0700 (PDT)
Message-ID: <7ee7829c08f45f5b6907877e0f3b11320c178867.camel@googlemail.com>
Subject: Re: [PATCH 1/2] regulator: fan53880: Add initial support
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 02 Jul 2020 23:09:41 +0200
In-Reply-To: <20200701180913.GA22871@sirena.org.uk>
References: <20200630185203.22882-1-chf.fritz@googlemail.com>
         <20200630185203.22882-2-chf.fritz@googlemail.com>
         <20200701180913.GA22871@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 19:09 +0100, Mark Brown wrote:
> /mnt/kernel/drivers/regulator/fan53880.c:63:2: note: in expansion of
> macro 'FAN53880_LDO'
>   FAN53880_LDO(1, "VIN12", 2800000),
>   ^~~~~~~~~~~~
> /mnt/kernel/include/linux/regulator/driver.h:47:2: error: field name
> not in record or union initializer
>   .min_sel = _min_sel,     \
>   ^
> 
> most likely due to the conversion introduced in 60ab7f4153b6af46
> (regulator: use linear_ranges helper).  Please rebase against current
> code.

Thanks for the hint, yeah that's it. After picking up a recent linux-
next and adapting it works on current too.

Please let me respin the patches in a v2.

