Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3BEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C655C206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGoqOJB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgGHRw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGHRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:52:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4003C061A0B;
        Wed,  8 Jul 2020 10:52:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so1515740pjb.1;
        Wed, 08 Jul 2020 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iTBy9GkFXEz3ueB+YO5lIF8vJWQu4NUuyz+31jVtaU=;
        b=FGoqOJB97ePWbmUbX0i8s6Uyk6b42nRUv98G8mEUpHqDOxJ8b/CiChJFhjRKteua7e
         wqr545QaNiQ/XHAjmHoCP4IEuYIcZvxkDMN2IHPQDSbvd4akGHr3OZvtWq1JvOaSfWvr
         EznH9oHr9drQS+xNoTG7vUW2yg2qPE+Nv4wXIdJ3WoW4CBjJHRzRd/MXaFQkslLRRBSK
         y7xBEn4rk6nGiNtMHprYK8yZ+Ry5+ENXU7ZcJ0ZnPgR5r9jrYu6hFeBk0r5A/LSa6NBr
         Vn2Zb+dZaRO4e5UAohriTOT55bgOvCWgZN/q51DBErNylNvgez+CPQzmh7abpm2ms+pj
         Nh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iTBy9GkFXEz3ueB+YO5lIF8vJWQu4NUuyz+31jVtaU=;
        b=RXPkhl7EZorbc4WadHJDdfkGl57V/W9Xx3vncwHNBC6BqXb30zsXCgR/j1KkPzLJMs
         pu9FlQnf5+J1IwuAGUeS4T8wkWb9ScLxMJ+k09/gKEcH5kbH39wWNTAhiZx64cbUkw2T
         BgbaaE8sx/zPbhJMpKIsJfCzlzmdiQuRCc5OY3U5tBBf29dzuwPFpqtm42vpvNdlctbA
         ywxW+fDyNkLXh9hfeQTt1TsX7SIuZzcGq0AB4tgTvcHFZoAoDVJKBzzv1wD/zy1m+R6r
         99LG+eypLWs8htLp8fx7+Sg3eSuOzaa3/yMJLqGIrxBsgSyKA6IQ018wQB7OZ/vD0mvS
         pivA==
X-Gm-Message-State: AOAM5337IgJNmIO3V2WY7PzuW/DEDSxJYEcuRsq6STJPf0P3PCORWDsv
        5145u4bsjkKhueuwGAIsncnG1J/pW0w=
X-Google-Smtp-Source: ABdhPJyfNhyICJcXmC6zCry4w6DFCr0PaQ5a5Bxga4WYqo1NcpqYLznFfZ91UktIJEKBEl183xy6nQ==
X-Received: by 2002:a17:90a:6acb:: with SMTP id b11mr10671566pjm.71.1594230776633;
        Wed, 08 Jul 2020 10:52:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y27sm432832pgc.56.2020.07.08.10.52.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 10:52:55 -0700 (PDT)
Date:   Wed, 8 Jul 2020 10:52:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/36] 4.19.132-rc1 review
Message-ID: <20200708175254.GD224053@roeck-us.net>
References: <20200707145749.130272978@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707145749.130272978@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:16:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.132 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 420 pass: 420 fail: 0

Guenter
