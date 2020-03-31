Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D0C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6356F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRpjx01c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgCaPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:42:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32798 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:42:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id c138so851177pfc.0;
        Tue, 31 Mar 2020 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDuAtBeu4SFY4sw3CxQAeDAq4uGk1/P2qv0HzJwEFlU=;
        b=WRpjx01cpOolF5J2y/dAVjyURXCWKzu2jJsCj290P6+4pAov6zJbViFRZ1fzOlUneD
         tH3eXVSUEmKT9lZ5HAqCTaDgYmMfWiHgUIt7WNAhK0+NMDR21ddqZy09BozRY/njfcVX
         oBvdfl/Wf7B9I4dD/v/hmqDhiJVpCBBT39mcvpsqMElY9nScj3/unELgfVxrqKgOsXoy
         X74Yk67wDwl8f2qf27V8zVXeycyuIBQpmwFZuyaRx2yCBfDFGCJfy/DvTB2i95gL5i6y
         TLGsYLK31OnXg2YsRJqIFhPn4TzNgvA/Bv2YBX2nWv75lPEZW97Wlvh3FWjfXX4Q9QrH
         EBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDuAtBeu4SFY4sw3CxQAeDAq4uGk1/P2qv0HzJwEFlU=;
        b=F4pRbquDokJB+Cqep2/5EDPr7q2/BopMq77o3TB6hBBRYaOTQlwtjMajjMZuFMbRRS
         7WD0r2dbkLwRH5etNDRT+C4QMmNaOsOIpxNBUrfGQM86qtikdbq8eWBAiSQ6trAjkhvk
         eHknbDNlMkyuzz2Rkaw6ueBnnSJnxQL+sEQu3f7dBCTs7A8GinOCC1f7GrIbMVfiny1Q
         OWeIqUxkwt2vGeC5KnOmDNnuF/zcZfMOfgmQg379V1wKBE4KpKp1OLq9cn5BD8VZlsuU
         /FTbk1i0I0VFlzOtQTUKdSaGCoPXAtmkqNRJFnufXxVvMND/qAGCBdjrtaE9f5VNlTV/
         w3Tg==
X-Gm-Message-State: ANhLgQ3RscA1gEhZmOPqgV+suljYgbBzitcNzjAoZqWtC/0ArE/6917m
        0wbuQzfTrpK1WC2quuFR6Sc=
X-Google-Smtp-Source: ADFU+vuYuJFEjZbk+8RzKG2Sw2VrFMI+77eghzMHaOXXYjsecX+mY4xs5y+UkncebiilTzlanexRFQ==
X-Received: by 2002:a63:b40d:: with SMTP id s13mr19347404pgf.268.1585669347008;
        Tue, 31 Mar 2020 08:42:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g69sm2183675pje.34.2020.03.31.08.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 08:42:26 -0700 (PDT)
Date:   Tue, 31 Mar 2020 08:42:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kun Yi <kunyi@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, joel@jms.id.au,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux hwmon-next v2 2/3] hwmon: (sbtsi) Add documentation
Message-ID: <20200331154225.GA11562@roeck-us.net>
References: <20200323233354.239365-1-kunyi@google.com>
 <20200323233354.239365-3-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323233354.239365-3-kunyi@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:33:53PM -0700, Kun Yi wrote:
> Document the SB-TSI sensor interface driver.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>
> Change-Id: I4b086a124d1d94a516386b0d2ff1cd7180b1dac1
> ---
>  Documentation/hwmon/sbtsi_temp.rst | 40 ++++++++++++++++++++++++++++++

The new file also needs to be added to Documentation/hwmon/index.rst.

Guenter
