Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADF7C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8394B24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Ru7BIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgB0Tl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:41:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35827 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgB0Tl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:41:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so365003pfa.2;
        Thu, 27 Feb 2020 11:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/qRYjeiSH0RCb5MgICwLWWZNUGQnFkuzUB/u8uhRsA=;
        b=W/Ru7BIOLV4XOK1Frj0h450Y22FHD4Uov0/7FQfa1uihzASYejb6y8KjMW0NtWu5DN
         FGmMHPgU8OSdh4GtMq+CO1ZGoSUwmSBleexZj5OtbJ5eo6DcBQOMsVv8WKDJyKuUkNu4
         qpBKF3W9c8B7fXJH4UR2ZoZqu0C2UH/Oy7vmaLLw2WiQq7TQRjuoyf8WEW3fXg5Ori1T
         8mlKHeJYGCYmfvR9IannPzAsPVNGazmq/yFcy2PUHcXf6x+ykki9pmMrD1Zz1xzyY43v
         utAbvy8IfiMtA4N72oh9tl6SVG2lKpyB4vXrzPEaz+i8xAE7KPwXPcAHiijBJQvgf/g9
         0TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/qRYjeiSH0RCb5MgICwLWWZNUGQnFkuzUB/u8uhRsA=;
        b=nMEMBGI18sVn8g0oRdtPcwivpDnIxkWp2s7WyoUJLMy8+HlVgaeBBkn8hBfp+FeZA7
         tGw8CevnopB+an+lNSiwTa1D8dhZA0h6JtRowwuYyRxTnBW4cLDXXnqEs7gZDdKV/Q95
         orEYJYOuiInkt5IvQjbbPmkDAWiAFJYuNve/pONO16Bks8uDrF0bmFi6SBgasHRGJlpo
         meiHBajqcS+H7Zn8W19Y2horrAFjCSqdKGkUh7UsCUsHkNLJcsSn5UZdJbomTLW54QEy
         VdfjLIZO0Dq1acU8BunE2CBbGCNEfjwJd28BkoLcD6qztzHXLHi2E0BPpa/GRgGuO5Ve
         oZ7g==
X-Gm-Message-State: APjAAAVCuNiniHyc4U8ol60iVnNGZdmKmXRPo2f8Sp4ooyrqoLBcN1/9
        tEyT2wjwtT+Bd7YZNtrEqpY=
X-Google-Smtp-Source: APXvYqx273e/gHvPykM7JDPBDq2XhKAg/w3etk3YKmJNxdxCyqmPC9PYF3Nk5HyVnEvtHFHIrs/vjA==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr525651pfm.149.1582832488361;
        Thu, 27 Feb 2020 11:41:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm6002206pgt.70.2020.02.27.11.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 11:41:27 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:41:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/97] 4.19.107-stable review
Message-ID: <20200227194127.GD31847@roeck-us.net>
References: <20200227132214.553656188@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:36:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.107 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 407 pass: 407 fail: 0

Guenter
