Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2FC35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A74A206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9xTd4sS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBVMSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 07:18:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38032 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBVMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 07:18:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so5875113edr.5;
        Sat, 22 Feb 2020 04:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibnqFr4dRK24xwHtMecmxdVmSWzMyhzhHDK1ela6lEU=;
        b=d9xTd4sSWY1TYfzzhSe3KI6OVLyBGkRs5lwNFvVuT3QoZ4sHepC0hWXwJV7+rMtv2x
         sh5yJdN2Y3vVvrLNWTrhPO+EVZPMTJgF2ezGeO5FpQ1mP6DgUbQNKm/kHaOaeYGriz/v
         1WS47mbW+X6aWEOfr9Epn9ZKPJCmKBLx6u/sQQRBkKIi661+z0qFykzqegzA9g4z9pkl
         phkHg7g+M3IFQl1d2WeAyCKsgF/W+rpKWzC6XCLJbA6rVq+UPc/PgpBnGyjc8pu9pXyL
         cDyetnJTyaaB+op3oUKPi5oZ9SbpuVP0pj4SgYPy49n0DXdziIG0DlPHvS80kal/jTrB
         QQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibnqFr4dRK24xwHtMecmxdVmSWzMyhzhHDK1ela6lEU=;
        b=jSk7ioBUfDDzbCi+sysb/28uDS1oPts1jKsFDPI40h11NX7yHWP4iZCVn8Hieivyxc
         UuMIDMhrNqOqqCRWv6Jv1nHxexXK6ZPrxzMUpQaE3MOJa0zlDcCOlpBo60eY5HB1DqV/
         nE33J4noFp0Q1gx1/gGJLkQsWdgoTLAOOTWbB03ZB0HK2MzKrLERSuCg12N0OiNwSTT9
         C2Hv2I5NJHOXN/cvLvMosUJqJOO5WkMRIVPssy1Oh50s5uxT/vEGzDYqQcfxn+cnHxVv
         PdefDO/+vOkwI2TzFHWEKiCDRMnFndZunKwsjfZDNgVfAonFHhro42RDv7igFGte9tts
         vinA==
X-Gm-Message-State: APjAAAWukI2ZwhRZYmXBOuysus4uQwd36/V0E9Cbpz9CMwBdWaR3I9jp
        jtIk+9oWRLIhra9lvFVUKrPIqqhBgI6xn3oMsJM=
X-Google-Smtp-Source: APXvYqxY14QD+c6G/UaF6S5bknZk8Ka+S+gxKLfniAsY9bBuADLHdsJn0xEgk+rSCfpOai2ZXE7c4J+d6rnmMrafZE0=
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr39461842ejj.184.1582373884875;
 Sat, 22 Feb 2020 04:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20200219151259.14273-6-olteanv@gmail.com> <20200222114136.595-1-michael@walle.cc>
In-Reply-To: <20200222114136.595-1-michael@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sat, 22 Feb 2020 14:17:54 +0200
Message-ID: <CA+h21hrXAFWfjcKfj+QAcQauDqvLS0Vzp9Uvv6ewqxDSF7yRpg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next/devicetree 5/5] arm64: dts: fsl: ls1028a:
 enable switch PHYs on RDB
To:     Michael Walle <michael@walle.cc>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sat, 22 Feb 2020 at 13:41, Michael Walle <michael@walle.cc> wrote:
>
> Hi,
>
> status should be the last property, correct?
>
> -michael

I know of no such convention to exist.

-Vladimir
