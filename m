Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDFC3402C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772C22072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igposgGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgBQWUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:20:30 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39615 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgBQWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:20:30 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so110342pjr.4;
        Mon, 17 Feb 2020 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skdQaGpFa3cH4Eu9/LVCuOWnHrP9hFj9QUueAkZTEsQ=;
        b=igposgGnUGnEUjVHfHO8wm3gxLpqW84uz0hRV5bgOWnefuWD4mVbRFVVaCufWeAX60
         oaYh7Ypy/WVrjkFfxAoQK6R1KJwYyPAttXye7cb5yaVxdtMJXeojTu90gcqMaI8dpZ89
         0c5ooXaoB2dyVmYOTib/F7I05erHYzCwJ+64sotcBbXDUbxLi908VJLh+nYhD6kDJMWj
         HhrsSD9s1kRSCAajGBAoFaUVaVw8lxA95JRSECKEiaVR3M0ZOfpB/CfF3zwy8T4Bmcpf
         bwaEy/v1JYxxbZXQ89CbqZGyLKle3aaCe2jZUA2pEdZjlgGBx58zHZWwssQBOcM2mb10
         FTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=skdQaGpFa3cH4Eu9/LVCuOWnHrP9hFj9QUueAkZTEsQ=;
        b=bcYktdkkxpKkO3Dq9aVyl66AnQFwBB7c9Ykrhvzp2ArrLbKMuavec5d5IsYrRkNPFv
         wi1py3pVF6so50ukmGu7KDH4JqN+MFNqvUXjANmtpeHOgSbgPw0dL7xf72brDeWyQIlK
         8BeGMECk4Db6oDiAeUSRbYIQdUGRlY9u+cZqBt0si9w64daABjBAKyLjoKN1r83Z1OGZ
         5OBjrXs4c0z3+g8RB9G9vK27kcA1ID3QGRXNLaDIdzEjnpBWqZ7DE36PMlx55OqrUBL4
         TH5swYD148zk8FzPk1fPVRTc1r8CcZIdLDB7qV2Kg/StwvBgv3oWVv+SQFI955icm2jL
         TA/g==
X-Gm-Message-State: APjAAAUu5zDhj5F/U73eH163K5grc7rZEVVcoQU3Tc9v5QPXKxL5snNn
        4rXDt5tnbX9/TM7faQYz5tw=
X-Google-Smtp-Source: APXvYqzaR9lIwRYl+FFzvcclFTFLhNY1M91Qbi0upECzQfA7WYysIH9DRFVOVgW4ttXhZpsJAdgdYQ==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr1351157pjw.43.1581978029741;
        Mon, 17 Feb 2020 14:20:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4sm449213pgu.75.2020.02.17.14.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2020 14:20:28 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:20:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/hwmon: fix xdpe12284 Sphinx warnings
Message-ID: <20200217222027.GA21389@roeck-us.net>
References: <0094c570-dd4c-dc0e-386d-ea1c39b6a582@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0094c570-dd4c-dc0e-386d-ea1c39b6a582@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 08:44:09PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Sphinx format warnings by adding a blank line.
> 
> Documentation/hwmon/xdpe12284.rst:28: WARNING: Unexpected indentation.
> Documentation/hwmon/xdpe12284.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Vadim Pasternak <vadimp@mellanox.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/xdpe12284.rst |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-56-rc2.orig/Documentation/hwmon/xdpe12284.rst
> +++ lnx-56-rc2/Documentation/hwmon/xdpe12284.rst
> @@ -24,6 +24,7 @@ This driver implements support for Infin
>  dual loop voltage regulators.
>  The family includes XDPE12284 and XDPE12254 devices.
>  The devices from this family complaint with:
> +
>  - Intel VR13 and VR13HC rev 1.3, IMVP8 rev 1.2 and IMPVP9 rev 1.3 DC-DC
>    converter specification.
>  - Intel SVID rev 1.9. protocol.
